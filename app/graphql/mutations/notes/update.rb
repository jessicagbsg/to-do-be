# frozen_string_literal: true

module Mutations
  module Notes
    class Update < BaseMutation
      argument :title, String, required: true

      field :note, Types::NoteType, null: true
      field :errors, [String], null: false

      def resolve(title:)
        note = Note.find_by(id: id)
        if note.update(title: title)
          { note: note }
        else
          { note: nil, errors: note.errors.full_messages }
        end
      end
    end
  end
end