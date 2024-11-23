class AddNoteToTodos < ActiveRecord::Migration[7.2]
  def change
    add_reference :todos, :note, null: false, foreign_key: true
  end
end
