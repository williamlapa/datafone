class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.all

    # the `geocoded` scope filters only customers with coordinates (latitude & longitude)

    # @markers = @customers.geocoded.map do |customer|
    #   {
    #     lat: customer.latitude,
    #     lng: customer.longitude,
    #     infoWindow: render_to_string(partial: 'customers_details', locals: { customer: customer }),
    #     image_url: helpers.asset_url('customer.png')
    #   }
    # end

    @customers = if params[:query].present?
                   customer.search_by_name_and_size_price(params[:query])
                 else
                   Customer.all
                 end
  end

  def show; end

  def new
    @customer = Customer.new
    @request = Request.new
  end

  def edit; end

  def create
    @customer = customer.new(customer_params)
    @customer.user_id = current_user.id

    if @customer.save
      redirect_to customer_path(@customer), notice: 'customer was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'customer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
  end

  private

  def set_customer
    @customer = customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :address, :price_per_day, :size, :available, :description, :photo)
  end
end
