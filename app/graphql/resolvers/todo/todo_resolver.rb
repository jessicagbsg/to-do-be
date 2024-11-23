# frozen_string_literal: true

module Resolvers
  class TodoResolver
    def self.all_todos
      Todo.all
    end

    def self.find_todo(id)
      Todo.find_by(id: id)
    end
  end
end