defmodule PhoenixAndElmWeb.ChatroomControllerTest do
  use PhoenixAndElmWeb.ConnCase

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.Chatroom

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:chatroom) do
    {:ok, chatroom} = Chatapp.create_chatroom(@create_attrs)
    chatroom
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chatrooms", %{conn: conn} do
      conn = get conn, chatroom_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chatroom" do
    test "renders chatroom when data is valid", %{conn: conn} do
      conn = post conn, chatroom_path(conn, :create), chatroom: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, chatroom_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, chatroom_path(conn, :create), chatroom: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chatroom" do
    setup [:create_chatroom]

    test "renders chatroom when data is valid", %{conn: conn, chatroom: %Chatroom{id: id} = chatroom} do
      conn = put conn, chatroom_path(conn, :update, chatroom), chatroom: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, chatroom_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, chatroom: chatroom} do
      conn = put conn, chatroom_path(conn, :update, chatroom), chatroom: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chatroom" do
    setup [:create_chatroom]

    test "deletes chosen chatroom", %{conn: conn, chatroom: chatroom} do
      conn = delete conn, chatroom_path(conn, :delete, chatroom)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, chatroom_path(conn, :show, chatroom)
      end
    end
  end

  defp create_chatroom(_) do
    chatroom = fixture(:chatroom)
    {:ok, chatroom: chatroom}
  end
end
