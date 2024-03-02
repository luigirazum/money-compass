class ScreensController < ApplicationController
  def splash
    redirect_to categories_path if user_signed_in?
  end
end
