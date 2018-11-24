defmodule PhoenixAndElmWeb.RoomChannel do
  use PhoenixAndElmWeb, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end
  @expected_fields ~w(
    entity abstract
  )

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    spawn(fn -> automatic_query(payload) end)
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def automatic_query(payload) do
    message = get_in(payload, ["message"])
    url = "https://api.duckduckgo.com/?q=" <> message <> "&format=json&pretty=1?t=ABriefStudentProject"
    #url = "https://api.duckduckgo.com/?q=DuckDuckGo&format=json&pretty=1"
    response = HTTPoison.get!(url).body
    |> Poison.decode!
    |> get_in(["RelatedTopics"])
    |> List.first
    |> get_in(["Text"])

    IO.inspect response
    IO.inspect payload
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
