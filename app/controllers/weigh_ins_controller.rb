class WeighInsController < ApplicationController
  def index
  end

  def new
    @weigh_in = WeighIn.new(user: current_user)
  end

  def create
    @weigh_in = current_user.weigh_ins.create(weigh_in_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def weigh_in_params
    # Manda um erro 400 se o param nao estiver presente
    params.require(:weigh_in).permit(:weight_g, :measured_at)
  end
end
