class TodoController < ApplicationController
  before_action :set_note, only: [:create]

  def index
    @todos = Todo.all.where(deleted_at: nil)

    if @todos.empty?
      return render json: { message: "No todos found" }
    end
    
    if params[:done]
      @todos = @todos.where(done: params[:done])
    end

    render json: @todos
  end

  def create
    @todo = @note.todos.build(todo_params)
    @todo.note_id = @note.id 
  
    if @todo.save
      return render json: @todo, status: :created
    end
    
    render json: { error: @todo.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    @todo = Todo.find(params[:id])
   
    if @todo.deleted_at.nil? && @todo.update(todo_params)
      return render json: @todo
    end

    render json: { error: "Unable to update todo" }
  end

  def destroy
    @todo = Todo.find(params[:id])
  
    if @todo
      @todo.update(deleted_at: Time.now)
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
    params.require(:todo).permit(:title, :done, :deleted_at)
  end
end
