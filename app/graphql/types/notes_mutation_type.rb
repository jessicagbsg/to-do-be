# frozen_string_literal: true

module Types
  class NotesMutationType < Types::BaseObject
    field :create_note, mutation: Mutations::Notes::CreateNote
    field :update_note, mutation: Mutations::Notes::UpdateNote
  end
end
