defmodule Snappy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snappy.Accounts.{User, Encryption}

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :provider, :string
    field :token, :string
    has_many :polls, Snappy.Votes.Poll
    has_many :images, Snappy.Votes.Image
    
    ## Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def common_auth_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> downcase_email
    |> encrypt_password
  end

  def social_auth_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :provider, :token])
    |> validate_required([:token, :email, :username])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
