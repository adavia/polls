defmodule SnappyWeb.SessionController do
  use SnappyWeb, :controller

  plug Ueberauth
  plug Snappy.Plugs.IsAuth when action in [:new, :create]

  alias Snappy.Repo
  alias Snappy.Accounts.{Auth, User}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Auth.login(session_params, Repo) do
      {:ok, user} ->
        conn
        |> put_session(:user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user_params = %{
      token: auth.credentials.token, 
      username: auth.info.nickname, 
      email: auth.info.email, 
      provider: provider
    }

    changeset = User.social_auth_changeset(%User{}, user_params)
    auth_provider(conn, changeset)
  end

  defp auth_provider(conn, changeset) do
    case Auth.social_auth(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back to Discuss!")
        |> put_session(:user, user.id)
        |> redirect(to: poll_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Something went wrong during the login process.")
        |> redirect(to: poll_path(conn, :index))
    end
  end
end