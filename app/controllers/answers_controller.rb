class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new

  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if @answer.save
      redirect_to question_path(@question)
      flash[:notice] = "Answer submitted successfully"
    else
      flash[:notice] = "Please answer in at least 50 characters"
      render :new
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
