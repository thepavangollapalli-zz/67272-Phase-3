class ItemPricesController < ApplicationController
  before_action :set_item_price, only: [:show, :edit, :update, :destroy]

  # GET /item_prices
  # GET /item_prices.json
  def index
    @active_items = Item.active
    @item_prices = ItemPrice.chronological.all #paginate(page: params[:page]).per_page(10)
  end

  # GET /item_prices/1
  # GET /item_prices/1.json
  def show
  end

  # GET /item_prices/new
  def new
    @item_price = ItemPrice.new
  end

  # GET /item_prices/1/edit
  def edit
  end

  # POST /item_prices
  # POST /item_prices.json
  def create
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.current
    if @item_price.save
        @item = @item_price.item
        flash[:notice] = "Changed the price of #{@item.name}."
        redirect_to item_path(@item)
    else
        render action: 'new'
    end
  end

  # PATCH/PUT /item_prices/1
  # PATCH/PUT /item_prices/1.json
  def update
  end

  # DELETE /item_prices/1
  # DELETE /item_prices/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_price
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_price_params
      params.require(:item_price).permit(:item_id, :price)
    end
end
