defmodule Snappy.Votes.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snappy.Accounts.User
  alias Snappy.Votes.Poll
  alias Snappy.Votes.Image
  
  schema "images" do
	  field :url, :string
	  field :alt, :string
	  field :caption, :string

	  belongs_to :user, User
	  belongs_to :poll, Poll

	  timestamps()
	end

	def changeset(%Image{} = image, attrs) do
	  image
	  |> cast(attrs, [:url, :alt, :caption, :user_id, :poll_id])
	  |> validate_required([:url, :user_id, :poll_id])
	end
end