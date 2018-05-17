defmodule SnappyWeb.PollController do
	use SnappyWeb, :controller 
	alias Snappy.Votes
	alias Snappy.ChatCache

	plug Snappy.Plugs.RequireAuth when action in [:new, :create]

	def index(conn, params) do
		%{"page" => page, "per_page" => per_page} = normalize_paging_params(params)
    polls = Votes.list_most_recent_polls_with_extra(page, per_page)
    opts = paging_options(polls, page, per_page)
    render conn, "index.html", polls: Enum.take(polls, per_page), opts: opts
	end

	def show(conn, %{"id" => id}) do
		poll = Votes.get_poll!(id)
		render conn, "show.html", poll: poll
	end

	def new(conn, _params) do
   	poll = Votes.new_poll()
   	render conn, "new.html", poll: poll
 	end

 	def create(conn, %{"poll" => params, "image_data" => image_data}) do
 		params = Map.put(params, "user_id", conn.assigns.user.id)
	  split_options = String.split(params["poll_options"], ",")

	  with {:ok, _poll} <- Votes.create_poll_with_options(params, split_options, image_data) do
	    conn
	    |> put_flash(:info, "Poll created successfully!")
	    |> redirect(to: poll_path(conn, :index))
	  end
 	end

	def vote(conn, %{"id" => id}) do
	  voter_ip = conn.remote_ip
	  |> Tuple.to_list()
	  |> Enum.join(".")
	  with {:ok, option} <- Votes.vote_on_option(id, voter_ip) do
	    conn
	    |> put_flash(:info, "Placed a vote for #{option.title}!")
	    |> redirect(to: poll_path(conn, :index))
	  else
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> redirect(to: poll_path(conn, :index))
    end
	end

	def history(conn, _params) do
    render conn, "history.html", logs: ChatCache.lookup()
  end

  ## Private methods
  defp paging_params(%{"page" => page, "per_page" => per_page}) do
    page = case is_binary(page) do
      true -> String.to_integer(page)
      _ -> page
    end
    per_page = case is_binary(per_page) do
      true -> String.to_integer(per_page)
      _ -> per_page
    end
   	
    %{"page" => page, "per_page" => per_page}
  end

  defp paging_options(polls, page, per_page) do
    %{
      include_next_page: (Enum.count(polls) > per_page),
      include_prev_page: (page > 1),
      page: page,
      per_page: per_page
    }
  end

  defp normalize_paging_params(params) do
    %{"page" => 1, "per_page" => 25}
    |> Map.merge(params)
    |> paging_params()
  end
end