defmodule Snappy.Accounts.Auth do
  alias Snappy.Accounts.{Encryption, User}
  alias Snappy.Repo

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    if user do
      if user.password_hash do
        case authenticate(user, params["password"]) do
          true  -> {:ok, user}
          _     -> {:error, "Incorrect password"}
        end
      else
        {:error, "User has been authenticated with a different provider"}
      end
    else
      {:error, "This email account does not exists"}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Encryption.validate_password(password, user.password_hash)
    end
  end

  def social_auth(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end

  ## Helper functions for view
  def current_user(conn) do
    conn.assigns.user
  end

  def logged_in?(conn), do: !!current_user(conn)
end