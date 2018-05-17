defmodule SnappyWeb.Api.PollView do
  use SnappyWeb, :view

  def render("index.json", %{polls: polls}) do
    %{
      polls: Enum.map(polls, fn poll ->
      	%{
			    id: poll.id,
			    title: poll.title,
			    description: poll.description
	  		}
      end)
    }
  end

  def render("show.json", %{poll: poll}) do
    %{
      poll: %{
		    id: poll.id,
		    title: poll.title,
		    description: poll.description,
		    options: render_options(poll.options),
	      image: render_image(poll.image)
	  	}
    }
  end

	def render_options(nil), do: []
  def render_options(options) do
    options
    |> Enum.map(fn(o) -> Map.take(o, [:title, :votes]) end)
  end

  def render_image(nil), do: nil
  def render_image(image) do
    %{
      url: image.url,
      alt: image.alt,
      caption: image.caption
    }
  end
end