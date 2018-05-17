defmodule SnappyWeb.Api.PollController do
  use SnappyWeb, :controller

  alias Snappy.Votes

  def index(conn, _params) do
    polls = Votes.list_most_recent_polls_with_extra()
    render(conn, "index.json", polls: polls)
  end

  def show(conn, %{"id" => id}) do
		poll = Votes.get_poll!(id)
		render conn, "show.json", poll: poll
	end
end