class QuestionsController < ApplicationController
  def index
    @questions = Question.order(updated_at: :desc)
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
      redirect_to @question, notice: "Question asked successfully"
    else
      render :new, notice: "Please fill out the form correctly"
    end
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
