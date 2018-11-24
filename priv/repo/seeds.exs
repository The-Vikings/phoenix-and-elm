# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixAndElm.Repo.insert!(%PhoenixAndElm.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule PhoenixAndElm.Seeds do
  def random_number(from, to) do
    value =
      from..to
      |> Enum.take_random(1)
      |> Enum.at(0)

    if value < 10 do
      "0#{value}"
    else
      to_string(value)
    end
  end
end

alias PhoenixAndElm.{Repo, Seeds}
alias PhoenixAndElm.Chatapp.Chatroom
alias PhoenixAndElm.Chatapp.Question
alias PhoenixAndElm.Chatapp.Reply
alias PhoenixAndElm.Accounts.User
alias PhoenixAndElm.Chatapp.Vote
Repo.delete_all(Reply)
Repo.delete_all(Vote)
Repo.delete_all(Question)
Repo.delete_all(User)
Repo.delete_all(Chatroom)

Repo.insert! %Chatroom{
  name: "CS447",
  id: 1
}

Repo.insert! %Chatroom{
  name: "CS408",
  id: 2
}

Repo.insert! %User{
  id: 1,
  name: "Test user 1",
  chatroom_id: 1
}

Repo.insert! %User{
  id: 2,
  name: "Test user 2",
  chatroom_id: 1
}

Repo.insert! %Question{
  id: 1,
  body: "Test question?",
  user_id: 1,
  chatroom_id: 1
}

Repo.insert! %Question{
  id: 2,
  body: "Another test question?",
  user_id: 1,
  chatroom_id: 1
}

#Repo.insert! %Question{
#  body: "A test question from another user?",
#  user_id: 2
#}

#Repo.insert! %Reply{
#  body: "A reply to the first question, by user 2",
#  user_id: 2,
#  question_id: 1
#}

#Repo.insert! %Reply{
#  body: "A reply to the second question, by user 2",
#  user_id: 2,
#  question_id: 2
#}

#Repo.insert! %Vote{
#  value: "1",
#  user_id: 2,
#  question_id: 1
#}

