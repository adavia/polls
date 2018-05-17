defmodule Snappy.Plugs.SetAuth do
	import Plug.Conn
	import Phoenix.Controller

	alias Snappy.Accounts
	alias SnappyWeb.Router.Helpers

	def init(_params) do
	end

	def call(conn, _params) do
		user_id = get_session(conn, :user)
		cond do
		  user = user_id && Accounts.get_user!(user_id) ->
		  	assign(conn, :user, user)
		  true -> 
		  	assign(conn, :user, nil)
		end
	end
end