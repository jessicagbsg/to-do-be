class TodoController < ApplicationController
  before_action :set_note, only: [ :create ]

  def index
    @todos = TodoService.fetch_all(note_id: params[:note_id], done: params[:done])

    if @todos.empty?
      return render json: { message: "No todos found" }
    end

    render json: @todos
  end

  def create
    @todo = TodoService.create(@note, todo_params)

    if @todo.persisted?
      return render json: @todo, status: :created
    end

    render json: { error: @todo.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.deleted_at.nil? && TodoService.update(@todo, todo_params)
      return render json: @todo
    end

    render json: { error: "Unable to update todo" }
  end

  def destroy
    @todo = Todo.find(params[:id])

    if @todo && TodoService.soft_delete(@todo)
      return render json: { message: "Todo deleted successfully" }
    end

    render json: { error: "Unable to delete todo" }, status: :unprocessable_entity
  end

  private

  def set_note
    @note = Note.find(params[:note_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Note not found" }, status: :not_found
  end

  def todo_params
    params.require(:todo).permit(:title, :done)
  end
end
