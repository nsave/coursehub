class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    Course.find(params[:id]).update(course_params)
    redirect_to course_path(params[:id])
  end

  def delete
    Course.find(params[:id]).delete
    redirect_to courses_path
  end

  protected

  def course_params
    params[:course].permit(:name, :description, :user_id, :parent_id)
  end
end
