# frozen_string_literal: true

module Types
  class TodosMutationType < Types::BaseObject
    field :create_todo, mutation: Mutations::Todos::CreateTodo
    field :update_todo, mutation: Mutations::Todos::UpdateTodo
  end
end