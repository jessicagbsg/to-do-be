class TodoService
  def self.fetch_all(note_id: nil, done: nil)
    todos = Todo.where(deleted_at: nil)
    todos = todos.where(note_id: note_id) if note_id
    todos = todos.where(done: done) unless done.nil?
    todos
  end

  def self.create(note, attributes)
    note.todos.create(attributes)
  end

  def self.update(todo, attributes)
    todo.update(attributes)
  end

  def self.soft_delete(todo)
    todo.update(deleted_at: Time.now)
  end
end
