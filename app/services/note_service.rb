class NoteService
  def self.fetch_all
    Note.where(deleted_at: nil)
  end

  def self.find_by_id(id)
    Note.find_by(i: idd)
  end

  def self.create(attributes)
    Note.create(attributes)
  end

  def self.update(note, attributes)
    note.update(attributes)
  end

  def self.soft_delete(note)
    note.update(deleted_at: Time.now)
  end
end