class PostsController < ApplicationController

  before_action :current_post

  def current_post
    if params[:id]
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :likes, :blogger_id, :destination_id)
  end

  def check_for_errors(post, create_or_update)
    if post.valid?
      post.save
      redirect_to post_path(post)
    else
      flash[:notice] = "Couldn't #{create_or_update} Post. "

      post.errors.messages.each do |k, v|
        flash[:notice] << "#{k.capitalize} #{v[0]}. "
      end

      if create_or_update == "create"
        redirect_to new_post_path
      else
        redirect_to edit_post_path(post)
      end
    end
  end

  def index
    @posts = Post.all
  end

  def new
    @bloggers = Blogger.all
    @destinations = Destination.all
  end

  def create
    @post = Post.new(post_params)
    @post.likes = 0
    check_for_errors(@post, "create")
  end

  def show
    if params[:like_button]
      @post.add_like
    end
  end

  def edit
    @bloggers = Blogger.all
    @destinations = Destination.all
  end

  def update
    @post.assign_attributes(post_params)
    check_for_errors(@post, "update")
  end

end





# {"controller"=>"posts", "action"=>"show", "id"=>"1"} permitted: false>
