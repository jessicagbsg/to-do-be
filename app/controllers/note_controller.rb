class NoteController < ApplicationController
  def index
    @notes = Note.all.where(deleted_at: nil)

    if @notes.empty?
      return render json: { message: "No notes found" }
    end

    render json: @notes, include: :todos
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      return render json: @note
    end

    render json: { error: "Unable to create note" }
  end

  def update
    @note = Note.find(params[:id])

    if @note.deleted_at.nil? && @note.update(note_params)
      return render json: @note
    end

    render json: { error: "Unable to update note" }
  end

  def destroy
    @note = Note.find(params[:id])

    if @note
      @note.update(deleted_at: Time.now)
      return render json: { message: "Note deleted successfully" }
    end

    render json: { error: "Unable to delete note" }, status: :unprocessable_entity
  end

  private

  def note_params
    params.require(:note).permit(:title, :deleted_at)
  end
end
