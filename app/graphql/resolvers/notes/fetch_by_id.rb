# frozen_string_literal: true

module Resolvers
  module Notes
    class FetchById < BaseResolver
      type Types::NoteType, null: true

      description "Fetch a note by ID"

      argument :id, ID, required: true

      def resolve(id:)
        NoteService.find_by_id(id)
      end
    end
  end
end