# frozen_string_literal: true

module Resolvers
  module Notes
    class FetchAll < BaseResolver
      type [Types::NoteType], null: false

      description "Fetch all notes"

      def resolve
        NoteService.fetch_all
      end
    end
  end
end