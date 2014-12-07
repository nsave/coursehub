class CourseItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course_item, only: [:edit, :update, :destroy, :learn, :unlearn]
  before_action :ensure_user_access, except: [:learn, :unlearn]

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
    if @item.update(course_item_params)
      flash[:notice] = 'Course item was successfully updated'
      redirect_to course_path(@item.course)
    else
      render :edit
    end
  end

  def destroy
    @item.delete
    flash[:notice] = 'Item was successfully deleted'
    redirect_to course_path(params[:course_id])
  end

  def learn
    @item.course.progress_for_user(current_user).learn(@item)
    head 200
  end

  def unlearn
    @item.course.progress_for_user(current_user).unlearn(@item)
    head 200
  end

  protected

  def find_course_item
    @item = CourseItem.includes(:course).find(params[:id])
  end

  def ensure_user_access
    course = @item ? @item.course : Course.find(params[:course_id])
    unless course && course.user_id == current_user.id
      flash[:alert] = 'Fork this course to edit items'
      redirect_to(:back)
    end
  end

  def course_item_params
    params.permit(:course_id).
      merge(params.require(:course_item).permit(:name, :description, :url, :type, :duration))
  end
end
