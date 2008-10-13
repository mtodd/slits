class Slices < Application
  provides :json
  
  def index
    @slices = Slice.all
    display @slices
  end
  
  def show
    @slice = Slice.get(params[:id])
    raise NotFound unless @slice
    display @slice
  end
  
  def new
    raise NotImplementedError.new("Slices are discovered via GitHub.")
    only_provides :html
    @slice = Slice.new
    render
  end
  
  def create
    raise NotImplementedError.new("Slices are discovered via GitHub.")
    raise BadRequest, "No params passed to create a new object, check your new action view!" if params[:slice].nil?
    @slice = Slice.new(params[:slice])
    if @slice.save
      redirect url(:slice, @slice)
    else
      render :new
    end
  end
  
  def edit
    only_provides :html
    @slice = Slice.get(params[:id])
    raise NotFound unless @slice
    render
  end
  
  def update
    @slice = Slice.get(params[:id])
    raise NotFound unless @slice
    if @slice.update_attributes(params[:slice]) || !@slice.dirty?
      redirect url(:slice, @slice)
    else
      raise BadRequest
    end
  end
  
  def destroy
    raise NotImplementedError.new("Slices are deleted when no longer found on GitHub.")
    @slice = Slice.get(params[:id])
    raise NotFound unless @slice
    if @slice.destroy
      redirect url(:slices)
    else
      raise BadRequest
    end
  end
  
end # Slices
