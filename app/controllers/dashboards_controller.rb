class DashboardsController < ApplicationController
  layout "application"

  def show
    @weigh_ins = current_user.weigh_ins.order(measured_at: :desc)
  end
end
