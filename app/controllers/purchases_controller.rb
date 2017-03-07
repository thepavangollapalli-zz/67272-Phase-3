class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all.paginate(:page => params[:page]).per_page(10)
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current

    if @purchase.save
      flash[:notice] = "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}."
      redirect_to purchases_path
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:item_id, :quantity, :date)
    end
end
