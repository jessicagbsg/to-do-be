class NoteService
  def self.fetch_all(title: nil)
    if title.present?
      fetch_all_by_title(title)
    else
      Note.where(deleted_at: nil)
    end
  end

  def self.find_by_id(id)
    Note.find_by(id: id, deleted_at: nil)
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

  private

  def self.fetch_all_by_title(title)
    Note.where(deleted_at: nil).where("title ILIKE ?", "%#{title}%")
  end
end
