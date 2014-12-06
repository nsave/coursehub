class CourseItemsController < ApplicationController
  def index
    items = course.course_items
    render json: items.to_json
  end

  def new
    @item = CourseItem.new
  end

  def create
    CourseItem.create(course_item_params)
    render json: 'ok'
  end

  def edit
    @item = CourseItem.find(params[:id])
    render json: @item.to_json
  end

  def update
    CourseItem.find(params[:id]).update(course_item_params)
    render json: 'ok'
  end

  def delete
    CourseItem.find(params[:id]).delete
    render json: 'ok'
  end

  protected

  def course
    Course.find(params[:course_id])
  end

  def course_item_params
    params[:course_item].permit(:name, :description, :user_id, :url, :type)
  end
end
