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

  describe "questions" do
    alias PhoenixAndElm.Chatapp.Question

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatapp.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Chatapp.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Chatapp.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Chatapp.create_question(@valid_attrs)
      assert question.body == "some body"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatapp.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, question} = Chatapp.update_question(question, @update_attrs)
      assert %Question{} = question
      assert question.body == "some updated body"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatapp.update_question(question, @invalid_attrs)
      assert question == Chatapp.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Chatapp.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Chatapp.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Chatapp.change_question(question)
    end
  end

  describe "replies" do
    alias PhoenixAndElm.Chatapp.Reply

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def reply_fixture(attrs \\ %{}) do
      {:ok, reply} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatapp.create_reply()

      reply
    end

    test "list_replies/0 returns all replies" do
      reply = reply_fixture()
      assert Chatapp.list_replies() == [reply]
    end

    test "get_reply!/1 returns the reply with given id" do
      reply = reply_fixture()
      assert Chatapp.get_reply!(reply.id) == reply
    end

    test "create_reply/1 with valid data creates a reply" do
      assert {:ok, %Reply{} = reply} = Chatapp.create_reply(@valid_attrs)
      assert reply.body == "some body"
    end

    test "create_reply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatapp.create_reply(@invalid_attrs)
    end

    test "update_reply/2 with valid data updates the reply" do
      reply = reply_fixture()
      assert {:ok, reply} = Chatapp.update_reply(reply, @update_attrs)
      assert %Reply{} = reply
      assert reply.body == "some updated body"
    end

    test "update_reply/2 with invalid data returns error changeset" do
      reply = reply_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatapp.update_reply(reply, @invalid_attrs)
      assert reply == Chatapp.get_reply!(reply.id)
    end

    test "delete_reply/1 deletes the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{}} = Chatapp.delete_reply(reply)
      assert_raise Ecto.NoResultsError, fn -> Chatapp.get_reply!(reply.id) end
    end

    test "change_reply/1 returns a reply changeset" do
      reply = reply_fixture()
      assert %Ecto.Changeset{} = Chatapp.change_reply(reply)
    end
  end

  describe "votes" do
    alias PhoenixAndElm.Chatapp.Vote

    @valid_attrs %{value: "some value"}
    @update_attrs %{value: "some updated value"}
    @invalid_attrs %{value: nil}

    def vote_fixture(attrs \\ %{}) do
      {:ok, vote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatapp.create_vote()

      vote
    end

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Chatapp.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Chatapp.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      assert {:ok, %Vote{} = vote} = Chatapp.create_vote(@valid_attrs)
      assert vote.value == "some value"
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatapp.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      assert {:ok, vote} = Chatapp.update_vote(vote, @update_attrs)
      assert %Vote{} = vote
      assert vote.value == "some updated value"
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatapp.update_vote(vote, @invalid_attrs)
      assert vote == Chatapp.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Chatapp.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Chatapp.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Chatapp.change_vote(vote)
    end
  end
end
