class CourseItemsController < ApplicationController
  before_action :find_course_item, only: [:edit, :update, :destroy]

  def new
    @item = CourseItem.new(course_id: params[:course_id])
  end

  def edit
  end

  def create
    @item = CourseItem.new(course_item_params)
    if @item.save
      flash[:notice] = 'New item was successfully created'
      redirect_to course_path(@item.course)
    else
      render :new
    end
  end

  def update
    @item.update(course_item_params)
    flash[:notice] = 'Item was successfully updated'
    redirect_to course_path(@item.course)
  end

  def destroy
    @item.delete
    flash[:notice] = 'Item was successfully deleted'
    redirect_to course_path(params[:course_id])
  end

  protected

  def find_course_item
    @item = CourseItem.includes(:course).find(params[:id])
  end

  def course_item_params
    params.permit(:course_id).
      merge(params.require(:course_item).permit(:name, :description, :url, :type))
  end
end
