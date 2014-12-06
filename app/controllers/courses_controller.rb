class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = 'New course was successfully created'
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @course.update(course_params)
    redirect_to course_path(params[:id])
  end

  def destroy
    @course.delete
    redirect_to courses_path
  end

  protected

  def course_params
    params.require(:course).permit(:name, :description, :duration)
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
