# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # todo queries
    field :todos, [Types::TodoType], null: false do
      description "Retrieve all todos"
    end

    field :todo, Types::TodoType, null: true do
      description "Retrieve a specific todo by ID"
      argument :id, ID, required: true
    end

    def todos
      Todo.all
    end

    def todo(id:)
      Todo.find_by(id: id)
    end

    # note queries
    field :notes, [Types::NoteType], null: false do
      description "Retrieve all notes"
    end

    field :note, Types::NoteType, null: true do
      description "Retrieve a specific note by ID"
      argument :id, ID, required: true
    end

    def notes
      Note.all
    end

    def note(id:)
      Note.find_by(id: id)
    end
  end
end
