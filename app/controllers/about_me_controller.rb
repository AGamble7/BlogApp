class AboutMeController < ApplicationController
  # Applicaiton controller is an action controller.
  # It handles the incoming requests from a user and processes the necessary logic based on the request and then decides which view to render or data to return.

  def index
    @about_me
  end

  def home
    @blog_post = BlogPost.all
    render :index
  end
end
