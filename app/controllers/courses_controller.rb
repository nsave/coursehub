class CoursesController < ApplicationController
  def index
    @courses = Course.all
    render json: @courses.to_json
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    render json: 'ok'
  end

  def edit
    @course = Course.find(params[:id])
    render json: @course.to_json
  end

  def update
    Course.find(params[:id]).update(course_params)
    render json: 'ok'
  end

  def delete
    Course.find(params[:id]).delete
    render json: 'ok'
  end

  protected

  def course_params
    params[:course].permit(:name, :description, :user_id, :parent_id)
  end
end
