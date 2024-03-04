class CategoriesController < ApplicationController
  def index
    @categories = Category.where(user: current_user)
  end

  def new
    @category = new_category
  end

  def create
    @category = current_user.categories.new(category_params)
    respond_to do |format|
      format.html do
        if @category.save
          delete_new_category_session
          # redirect to index
          redirect_to root_path, notice: 'A new category was successfully added.'
        else
          # error message
          flash[:alert] = @category.errors.full_messages.first
          session[:new_category] = @category
          # render new
          redirect_back_or_to(new_category_path)
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def new_category
    return current_user.categories.new if session[:new_category].nil?

    session_params = session[:new_category].filter do |key|
      %w[name icon].include? key
    end

    current_user.categories.new(session_params)
  end

  def delete_new_category_session
    session.delete(:new_category) if session[:new_category]
  end
end
