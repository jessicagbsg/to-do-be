# frozen_string_literal: true

module Resolvers
  module Notes
    class FetchAll < BaseResolver
      type [ Types::NoteType ], null: false

      description "Fetch all notes"

      argument :title, String, required: false

      def resolve(title: nil)
        NoteService.fetch_all(title: title).order(created_at: :asc)
      end
    end
  end
end
