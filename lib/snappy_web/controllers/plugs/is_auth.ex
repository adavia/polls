defmodule Snappy.Plugs.IsAuth do
	import Plug.Conn 
	import Phoenix.Controller

	alias SnappyWeb.Router.Helpers

	def init(_params) do
	end

	def call(conn, _params) do
		if conn.assigns[:user] do
			conn
			|> redirect(to: Helpers.poll_path(conn, :index))
			|> halt
		else
			conn
		end
	end
end