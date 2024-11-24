# frozen_string_literal: true

module Mutations
  module Todos
    class Delete < BaseMutation
      argument :id, ID, required: true

      field :todo, Types::TodoType, null: true
      field :errors, [String], null: false

      def resolve(id:)
        todo = Todo.find_by(id: id)
      
        if todo.nil?
          return { todo: nil, errors: ["Todo not found"] }
        end
      
        if todo.update(deleted_at: Time.now)
          { todo: todo, errors: [] }
        else
          { todo: nil, errors: todo.errors.full_messages }
        end
      end
    end
  end
end