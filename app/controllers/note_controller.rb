class NoteController < ApplicationController
  def index
    @notes = NoteService.fetch_all

    if @notes.empty?
      return render json: { message: "No notes found" }
    end

    render json: @notes, include: :todos
  end

  def create
    @note = NoteService.create(note_params)

    if @note.persisted?
      return render json: @note
    end

    render json: { error: "Unable to create note" }
  end

  def update
    @note = NoteService.find_by_id(params[:id])

    if @note&.deleted_at.nil? && NoteService.update(@note, note_params)
      return render json: @note
    end

    render json: { error: "Unable to update note" }
  end

  def destroy
    @note = NoteService.find_by_id(params[:id])

    if @note && NoteService.soft_delete(@note)
      return render json: { message: "Note deleted successfully" }
    end

    render json: { error: "Unable to delete note" }, status: :unprocessable_entity
  end

  private

  def note_params
    params.require(:note).permit(:title, :deleted_at)
  end
end