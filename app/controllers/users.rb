class Users < Application
  # provides :xml, :yaml, :js
  
  def index
    @users = User.all
    display @users
  end
  
  def login
    if user = User.first(:username => params[:username])
      session[:user_id] = user.id
      redirect(request.referer || url(:home))
    else
      redirect(url(:home), :message => "Unable to login, could not find the user specified.")
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect(request.referer || url(:home), :message => 'Logged out!')
  end
  
  def show
    @user = User.get(params[:id])
    raise NotFound unless @user
    display @user
  end
  
  def new
    only_provides :html
    @user = User.new
    render
  end
  
  def edit
    only_provides :html
    @user = User.get(params[:id])
    raise NotFound unless @user
    render
  end
  
  def create
    raise BadRequest, "No params passed to create a new object, check your new action view!" if params[:user].nil?
    @user = User.new(params[:user])
    if @user.save
      redirect url(:user, @user)
    else
      render :new
    end
  end
  
  def update
    @user = User.get(params[:id])
    raise NotFound unless @user
    if @user.update_attributes(params[:user]) || !@user.dirty?
      redirect url(:user, @user)
    else
      raise BadRequest
    end
  end
  
  def destroy
    @user = User.get(params[:id])
    raise NotFound unless @user
    if @user.destroy
      redirect url(:users)
    else
      raise BadRequest
    end
  end
  
end # Users
