# frozen_string_literal: true

module Resolvers
  module Todos
    class FetchAll < BaseResolver
      type [ Types::TodoType ], null: false

      description "Fetch all todos"

      argument :done, Boolean, required: false
      argument :note_id, ID, required: true

      def resolve(note_id:, done: nil)
        TodoService.fetch_all(note_id: note_id, done: done).order(created_at: :asc)
      end
    end
  end
end
