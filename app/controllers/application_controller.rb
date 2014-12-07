class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def tags
    @tags = Tag.includes(:courses).all.sort_by { |t| t.courses.size }
  end
end
