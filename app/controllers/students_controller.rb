class StudentsController < ApplicationController

  before_action :set_student, only: [:destroy, :edit, :update]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      flash[:notice] = 'Student created'
      redirect_to students_path
    else
      flash.now[:alert] = 'A problem occured'
      render :new
    end
  end

  def edit; end

  def update
    if @student.update_attributes(student_params)
      flash[:notice] = 'Student updated'
      redirect_to students_path
    else
      flash.now[:alert] = 'A problem occured'
      render :edit
    end
  end

  def destroy
    if @student.destroy
      flash[:notice] = 'Student destroyed'
      redirect_to students_path
    else
      flash[:alert] = 'A problem occured'
      redirect_to students_path
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :lastname, :birthdate)
  end
end