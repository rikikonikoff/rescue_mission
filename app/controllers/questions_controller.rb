class QuestionsController < ApplicationController
  def index
    @questions = Question.order(updated_at: :desc)
    flash[:notice] = ""
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(:updated_at)
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
      flash[:notice] = "Question asked successfully"
    else
      flash[:notice] = "Please fill out the form correctly"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
      flash[:notice] = "Question edited successfully"
    else
      render :edit
      flash[:notice] = "Please fill out the form correctly"
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.answers.destroy_all
    @question.destroy
    flash[:notice] = "Question Deleted"
    redirect_to questions_path
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
