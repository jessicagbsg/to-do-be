# frozen_string_literal: true

module Mutations
  module Notes
    class Create < BaseMutation
      argument :title, String, required: true

      field :note, Types::NoteType, null: true
      field :errors, [String], null: false

      def resolve(title:)
        note = Note.new(title: title)
        if note.save
          { note: note, errors: [] }
        else
          { note: nil, errors: note.errors.full_messages }
        end
      end
    end
  end
end