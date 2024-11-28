require "test_helper"

class TodoServiceTest < Minitest::Test
  def setup
    puts "Creating Todos..."
    @note = FactoryBot.create(:note, title: "First Note")

    @todo1 = FactoryBot.create(:todo, title: "First Todo", done: true, note_id: @note.id)
    @todo2 = FactoryBot.create(:todo, title: "Deleted Todo", done: true, note_id: @note.id, deleted_at: Time.now)
    @todo3 = FactoryBot.create(:todo, title: "Second Todo", done: false, note_id: @note.id)
  end

  def teardown
    Todo.delete_all
    Note.delete_all
  end

  def test_fetch_all
    todos = TodoService.fetch_all(note_id: @note.id)
    assert_equal 2, todos.count, "Expected 2 todos to be fetched for the note."
  end

  def test_fetch_all_with_done
    done_todos = TodoService.fetch_all(note_id: @note.id, done: true)
    assert_equal 1, done_todos.count, "Expected only done todos to be fetched."

    not_done_todos = TodoService.fetch_all(note_id: @note.id, done: false)
    assert_equal 1, not_done_todos.count, "Expected only not-done todos to be fetched."
  end

  def test_create
    attributes = { title: "New Todo", done: false }
    todo = TodoService.create(@note, attributes)
    assert todo.persisted?
  end

  def test_update
    attributes = { title: "Updated Todo", done: false }
    TodoService.update(@todo1, attributes)
    assert_equal "Updated Todo", @todo1.reload.title
  end

  def test_soft_delete
    todo = FactoryBot.create(:todo)
    assert_nil todo.deleted_at, "Expected `deleted_at` to be nil initially."

    TodoService.soft_delete(todo)
    assert todo.reload.deleted_at, "Expected `deleted_at` to be set after soft delete."
  end
end
