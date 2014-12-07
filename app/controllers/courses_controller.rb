class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :find_course, only: [:show, :edit, :update, :destroy, :enroll]
  before_action :ensure_user_access, only: [:edit, :update, :destroy]

  def index
    @title = 'Latest courses on CourseHub'
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
      @course.tags = course_tags
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
    @course.tags = course_tags
    redirect_to course_path(params[:id])
  end

  def destroy
    @course.delete
    redirect_to courses_path
  end

  def own
    @title = 'My own courses'
    @courses = current_user.courses
    render :index
  end

  def learning
    @title = 'Your course dashboard'
    @courses = []
    render :index
  end

  def enroll
    current_user.enroll(@course)
    flash[:notice] = "You've successfully enrolled in this course"
    redirect_to course_path(@course)
  end

  def filter
    tag = Tag.where(name: params[:tag]).first
    @courses = tag && tag.courses || []
    render :index
  end

  protected

  def course_params
    params.require(:course).permit(:name, :description, :duration).
      merge(user: current_user)
  end

  def course_tags
    params[:course][:tags_names].strip.split(/\s+/)
  end

  def ensure_user_access
    unless @course && @course.user_id == current_user.id
      flash[:alert] = 'You can not edit this course'
      redirect_to(:back)
    end
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
