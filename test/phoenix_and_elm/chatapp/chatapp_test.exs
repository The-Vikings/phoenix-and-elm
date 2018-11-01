defmodule PhoenixAndElm.ChatappTest do
  use PhoenixAndElm.DataCase

  alias PhoenixAndElm.Chatapp

  describe "chatrooms" do
    alias PhoenixAndElm.Chatapp.Chatroom

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def chatroom_fixture(attrs \\ %{}) do
      {:ok, chatroom} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatapp.create_chatroom()

      chatroom
    end

    test "list_chatrooms/0 returns all chatrooms" do
      chatroom = chatroom_fixture()
      assert Chatapp.list_chatrooms() == [chatroom]
    end

    test "get_chatroom!/1 returns the chatroom with given id" do
      chatroom = chatroom_fixture()
      assert Chatapp.get_chatroom!(chatroom.id) == chatroom
    end

    test "create_chatroom/1 with valid data creates a chatroom" do
      assert {:ok, %Chatroom{} = chatroom} = Chatapp.create_chatroom(@valid_attrs)
      assert chatroom.name == "some name"
    end

    test "create_chatroom/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatapp.create_chatroom(@invalid_attrs)
    end

    test "update_chatroom/2 with valid data updates the chatroom" do
      chatroom = chatroom_fixture()
      assert {:ok, chatroom} = Chatapp.update_chatroom(chatroom, @update_attrs)
      assert %Chatroom{} = chatroom
      assert chatroom.name == "some updated name"
    end

    test "update_chatroom/2 with invalid data returns error changeset" do
      chatroom = chatroom_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatapp.update_chatroom(chatroom, @invalid_attrs)
      assert chatroom == Chatapp.get_chatroom!(chatroom.id)
    end

    test "delete_chatroom/1 deletes the chatroom" do
      chatroom = chatroom_fixture()
      assert {:ok, %Chatroom{}} = Chatapp.delete_chatroom(chatroom)
      assert_raise Ecto.NoResultsError, fn -> Chatapp.get_chatroom!(chatroom.id) end
    end

    test "change_chatroom/1 returns a chatroom changeset" do
      chatroom = chatroom_fixture()
      assert %Ecto.Changeset{} = Chatapp.change_chatroom(chatroom)
    end
  end
end
