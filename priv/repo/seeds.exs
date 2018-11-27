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


# Don't delete dummy data
########################################
chatroom1 = Repo.insert! %Chatroom{
  name: "Dummy room",
}

user1 = Repo.insert! %User{
  name: "Dummy user",
  chatroom_id: chatroom1.id
}

question1 = Repo.insert! %Question{
  body: "Dummy question?",
  user_id: user1.id,
  chatroom_id: chatroom1.id
}

Repo.insert! %Reply{
  body: "A dummy reply to the dummy question, by user 1",
  user_id: user1.id,
  question_id: question1.id
}

Repo.insert! %Vote{
  value: 1,
  user_id: user1.id,
  question_id: question1.id
}
########################################
"""
Repo.insert! %Chatroom{
  name: "CS408",
}

Repo.insert! %User{
  name: "Test user 2",
  chatroom_id: 1
}

Repo.insert! %Question{
  body: "The first test question?",
  user_id: 1,
  chatroom_id: 1
}

Repo.insert! %Reply{
  body: "A reply to the first test question, by user 2",
  user_id: 1,
  question_id: 1
}

Repo.insert! %Vote {
  value: 1,
  user_id: 1,
  question_id: 1
}

"""

