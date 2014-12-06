class MainController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
  end

  def app
  end

end