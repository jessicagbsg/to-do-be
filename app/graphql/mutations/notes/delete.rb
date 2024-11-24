# frozen_string_literal: true

module Mutations
  module Notes
    class Delete < BaseMutation
      argument :id, ID, required: true

      field :note, Types::NoteType, null: true
      field :errors, [ String ], null: false

      def resolve(id:)
        note = Note.find_by(id: id)

        if note.nil?
          return { note: nil, errors: [ "Note not found" ] }
        end

        if note.update(deleted_at: Time.now)
          { note: note, errors: [] }
        else
          { note: nil, errors: note.errors.full_messages }
        end
      end
    end
  end
end
