class Backoffice::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  layout 'backoffice'
  
  def index
    @categories = Category.all
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
end
