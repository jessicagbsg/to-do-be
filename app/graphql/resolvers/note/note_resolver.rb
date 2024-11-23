# frozen_string_literal: true

module Resolvers
  class NoteResolver
    def self.all_notes
      Note.all
    end

    def self.find_note(id)
      Note.find_by(id: id)
    end
  end
end