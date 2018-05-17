defmodule Snappy.Plugs.RequireAuth do
	import Plug.Conn 
	import Phoenix.Controller

	alias SnappyWeb.Router.Helpers

	def init(_params) do
	end

	def call(conn, _params) do
		if conn.assigns[:user] do
			conn
		else
			conn
			|> put_flash(:error, "You must be login to perform this.")
			|> redirect(to: Helpers.poll_path(conn, :index))
			|> halt
		end
	end
end