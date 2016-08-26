class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :edit, :update, :destroy]

  # GET /widgets
  # GET /widgets.json
  def index
    # This one demonstrates standard usage.
    @widgets = Widget.all
    paginate @widgets
  end

  def index2
    # This one shows that it works great as long as you render using the expected template
    @widgets = Widget.all
    paginate @widgets, template: 'widgets/index2'
  end

  def index3
    # This one shows that it looks for index3 template even though you specified index2
    @widgets = Widget.all
    paginate @widgets, template: 'widgets/index2'
  end

  def index4
    # This one shows that it ignores the template altogether when you use the json: option (which I am confident is just Rails' behavior, but is scary because people might use this as an attempted fix for the index3 problem and not notice they are exposing more information than they intended)
    @widgets = Widget.all
    paginate json: @widgets, template: 'widgets/index2'
  end

  def index5
    # This one shows that rails will use the template you specified without pagination
    @widgets = Widget.all
    render template: 'widgets/index2'
  end



  # GET /widgets/1
  # GET /widgets/1.json
  def show
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    @widget = Widget.new(widget_params)

    respond_to do |format|
      if @widget.save
        format.html { redirect_to @widget, notice: 'Widget was successfully created.' }
        format.json { render :show, status: :created, location: @widget }
      else
        format.html { render :new }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    respond_to do |format|
      if @widget.update(widget_params)
        format.html { redirect_to @widget, notice: 'Widget was successfully updated.' }
        format.json { render :show, status: :ok, location: @widget }
      else
        format.html { render :edit }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget.destroy
    respond_to do |format|
      format.html { redirect_to widgets_url, notice: 'Widget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit(:name)
    end
end
