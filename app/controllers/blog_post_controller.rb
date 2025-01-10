class BlogPostController < ApplicationController
  # Applicaiton controller is an action controller.
  # It handles the incoming requests from a user and processes the necessary logic based on the request and then decides which view to render or data to return.
  before_action :set_blog_post, only: [ :show, :edit, :update, :delete ]
  before_action :set_all_blog_post, only: [ :index, :home ]

  def index
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def create
    create_params = params.require(:blog_post).permit(:title, :body)
    @blog_post = BlogPost.new(create_params)
    if @blog_post.save
      redirect_to blog_post_path(@blog_post)
    else
      render :new
    end
  end

  def delete
    @blog_post.destroy
    redirect_to blog_posts_path
  end

  def update
      update_params = params.require(:blog_post).permit(:title, :body)
      if @blog_post.update(update_params)
        redirect_to blog_post_path(@blog_post)
      else
        render :edit
      end
    end

  def home
      render :index
      # It's rendering the same template as the index method therefore I wont have to create another html.erb template for it
    end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue
    redirect_to root_path
    # the rescue exception is there to "redirect" the error and instead of getting an error message that wont be able to find a post it redirects to the root_path/ home page
  end

  def set_all_blog_post
    @blog_post = BlogPost.all
  end
end
