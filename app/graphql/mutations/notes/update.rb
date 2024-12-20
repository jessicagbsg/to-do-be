# frozen_string_literal: true

module Mutations
  module Notes
    class Update < BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: true

      field :note, Types::NoteType, null: true
      field :errors, [ String ], null: false

      def resolve(id:, title:)
        note = Note.find_by(id: id, deleted_at: nil)

        if note.nil?
          return { note: nil, errors: [ "Note not found" ] }
        end

        if note.update(title: title)
          { note: note, errors: [] }
        else
          { note: nil, errors: note.errors.full_messages }
        end
      end
    end
  end
end
