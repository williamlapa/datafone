class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]

  def index
    if current_user.role == 'adm'
      @requests = if params[:query].present?
                    Request.includes(:user).search_by_name_zone_and_address(params[:query])
                  else
                    Request.all.includes(:user).order('created_at DESC')
                  end
    else
      @requests = if params[:query].present?
                    Request.includes(:user).search_by_name_zone_and_address(params[:query]).where(user_id: current_user)
                  else
                    Request.includes(:user).where(user_id: current_user)
                  end
    end
  end

  def show
    @user = @request.user
  end

  def new
    @request = Request.new
  end

  def edit; end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    @request.status = 'Em análise'
    if @request.save
      redirect_to requests_path, notice: 'Chamado criado com sucesso!'
    else
      render 'new'
    end
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: 'Chamdo atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_url
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:motivation, :status, :itens, :employee_name, :employee_mobile, :description, :role, :initial_date, :final_date, :photo)
  end
end
