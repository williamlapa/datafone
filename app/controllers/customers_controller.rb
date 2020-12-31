class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.all

    # the `geocoded` scope filters only customers with coordinates (latitude & longitude)

    @markers = @customers.geocoded.map do |customer|
      {
        lat: customer.latitude,
        lng: customer.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { customer: customer }),
        image_url: helpers.asset_url('condominio.jpg')
      }
    end

    @customers = if params[:query].present?
                   Customer.search_by_name_zone_and_address(params[:query])
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
    @customer = Customer.new(customer_params)
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
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :address, :value, :customer_since, :customer_final, :zone, :photo)
  end
end
