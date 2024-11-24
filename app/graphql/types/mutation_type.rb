# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_note, mutation: Mutations::Notes::Create
    field :update_note, mutation: Mutations::Notes::Update

    field :create_todo, mutation: Mutations::Todos::Create
    field :update_todo, mutation: Mutations::Todos::Update
  end
end
