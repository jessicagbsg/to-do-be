# frozen_string_literal: true

module Mutations
  module Todos
    class Update < BaseMutation
      argument :title, String, required: true
      argument :done, Boolean, required: false
      argument :deleted_at, GraphQL::Types::ISO8601DateTime, required: false

      field :todo, Types::TodoType, null: true
      field :errors, [String], null: false

      def resolve(title:, done: false, deleted_at: nil)
        todo = Todo.find_by(id: id)
        if todo.update(title: title, done: done, deleted_at: deleted_at)
          { todo: todo, errors: [] }
        else
          { todo: nil, errors: todo.errors.full_messages }
        end
      end
    end
  end
end