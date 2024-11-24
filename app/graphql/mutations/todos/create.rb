# frozen_string_literal: true

module Mutations
  module Todos
    class Create < BaseMutation
      argument :title, String, required: true
      argument :done, Boolean, required: false
      argument :note_id, ID, required: true

      field :todo, Types::TodoType, null: true
      field :errors, [ String ], null: false

      def resolve(title:, done: false, note_id:)
        note = Note.find(note_id)
        todo = note.todos.create(title: title, done: done)
        if todo.persisted?
          { todo: todo, errors: [] }
        else
          { todo: nil, errors: todo.errors.full_messages }
        end
      end
    end
  end
end
