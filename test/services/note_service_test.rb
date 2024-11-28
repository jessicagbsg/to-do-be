require "test_helper"

class NoteServiceTest < Minitest::Test
  def setup
    puts "Creating Notes..."
    @note1 = FactoryBot.create(:note, title: "First Note")
    @note2 = FactoryBot.create(:note, title: "Second Note", deleted_at: Time.now)
    @note3 = FactoryBot.create(:note, title: "Another Note")
  end

  def teardown
    Note.delete_all
  end

  def test_fetch_all
    notes = NoteService.fetch_all
    assert_equal 2, notes.count, "Expected 2 active notes to be fetched."
  end

  def test_fetch_all_with_title
    notes_with_title = NoteService.fetch_all(title: "Note")
    assert_equal 2, notes_with_title.count, "Expected 2 notes with 'Note' in the title."
  end

  def test_find_by_id
    note = NoteService.find_by_id(@note1.id)
    assert_equal @note1.id, note.id, "Expected to find the correct note by ID."
  end

  def test_create
    attributes = { title: "New Note", deleted_at: nil }
    note = NoteService.create(attributes)
    assert note.persisted?, "Expected the note to be created and persisted."
    assert_equal "New Note", note.title, "Expected the note title to match the attributes."
  end

  def test_update
    attributes = { title: "Updated Title" }
    NoteService.update(@note1, attributes)
    assert_equal "Updated Title", @note1.reload.title, "Expected the note title to be updated."
  end

  def test_soft_delete
    assert_nil @note1.deleted_at, "Expected `deleted_at` to be nil initially."

    NoteService.soft_delete(@note1)
    assert @note1.reload.deleted_at, "Expected `deleted_at` to be set after soft delete."
  end
end
