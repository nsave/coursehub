class CourseItemsController < ApplicationController
  def index
    @items = course.course_items
  end

  def new
    @item = CourseItem.new
  end

  def create
    CourseItem.create(course_item_params)
    redirect_to course_path(params[:course_id])
  end

  def edit
    @item = CourseItem.find(params[:id])
  end

  def update
    CourseItem.find(params[:id]).update(course_item_params)
    redirect_to course_item_course_path(params[:course_id], params[:id])
  end

  def delete
    CourseItem.find(params[:id]).delete
    redirect_to course_path(params[:course_id])
  end

  protected

  def course
    Course.find(params[:course_id])
  end

  def course_item_params
    params[:course_item].permit(:name, :description, :user_id, :url, :type)
  end
end
