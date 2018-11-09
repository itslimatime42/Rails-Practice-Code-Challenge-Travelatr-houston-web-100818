class BloggersController < ApplicationController

  before_action :current_blogger

  def current_blogger
    if params[:id]
      @blogger = Blogger.find(params[:id])
    else
      @blogger = Blogger.new
    end
  end

  def blogger_params
    params.require(:blogger).permit(:name, :bio, :age)
  end

  def index
    @bloggers = Blogger.all
  end

  def create
    @blogger = Blogger.new(blogger_params)
    if @blogger.valid?
      @blogger.save
      redirect_to blogger_path(@blogger)
    else
      flash[:notice] = "Couldn't create Blogger. "
      @blogger.errors.messages.each do |k, v|
        flash[:notice] << "#{k.capitalize} #{v[0]}. "
      end
      redirect_to new_blogger_path
    end
  end

end
