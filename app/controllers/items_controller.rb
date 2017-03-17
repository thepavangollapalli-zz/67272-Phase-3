class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @boards = Item.for_category("boards").active
    @pieces = Item.for_category("pieces").active
    @clocks = Item.for_category("clocks").active
    @supplies = Item.for_category("supplies").active
    @inactive_items = Item.inactive
    @items = Item.active.alphabetical.all #paginate(:page => params[:page]).per_page(10)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    # @current_price = @item.item_prices.current.to_a
    @price_history = @item.item_prices.map{|p| p}.sort
    @similar_items = Item.for_category(@item.category).active.to_a.delete_if {|i| i.name == @item.name}
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = "Successfully created #{@item.name}."
      redirect_to item_path(@item)
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "Successfully updated #{@item.name}."
      redirect_to @item
    else
      render action: 'edit'
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    flash[:notice] = "Successfully removed #{@item.name} from the system."
    redirect_to items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :color, :category, :weight, :inventory_level, :reorder_level, :active)
    end
end
