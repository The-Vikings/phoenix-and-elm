defmodule PhoenixAndElmWeb.AutoAnswerControllerTest do
  use PhoenixAndElmWeb.ConnCase

  alias PhoenixAndElm.Chatapp
  alias PhoenixAndElm.Chatapp.AutoAnswer

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  def fixture(:auto_answer) do
    {:ok, auto_answer} = Chatapp.create_auto_answer(@create_attrs)
    auto_answer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all autoanswers", %{conn: conn} do
      conn = get conn, auto_answer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create auto_answer" do
    test "renders auto_answer when data is valid", %{conn: conn} do
      conn = post conn, auto_answer_path(conn, :create), auto_answer: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, auto_answer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, auto_answer_path(conn, :create), auto_answer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update auto_answer" do
    setup [:create_auto_answer]

    test "renders auto_answer when data is valid", %{conn: conn, auto_answer: %AutoAnswer{id: id} = auto_answer} do
      conn = put conn, auto_answer_path(conn, :update, auto_answer), auto_answer: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, auto_answer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body"}
    end

    test "renders errors when data is invalid", %{conn: conn, auto_answer: auto_answer} do
      conn = put conn, auto_answer_path(conn, :update, auto_answer), auto_answer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete auto_answer" do
    setup [:create_auto_answer]

    test "deletes chosen auto_answer", %{conn: conn, auto_answer: auto_answer} do
      conn = delete conn, auto_answer_path(conn, :delete, auto_answer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, auto_answer_path(conn, :show, auto_answer)
      end
    end
  end

  defp create_auto_answer(_) do
    auto_answer = fixture(:auto_answer)
    {:ok, auto_answer: auto_answer}
  end
end
