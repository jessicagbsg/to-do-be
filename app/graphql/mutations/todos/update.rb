# frozen_string_literal: true

module Mutations
  module Todos
    class Update < BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :done, Boolean, required: false

      field :todo, Types::TodoType, null: true
      field :errors, [ String ], null: false

      def resolve(id:, title: nil, done: nil)
        todo = Todo.find_by(id: id)

        if todo.nil?
          return { todo: nil, errors: [ "Todo not found" ] }
        end

        update_params = { title: title, done: done }.compact

        if todo.update(update_params)
          { todo: todo, errors: [] }
        else
          { todo: nil, errors: todo.errors.full_messages }
        end
      end
    end
  end
end
