class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job

  def create
    if Favorite.create(job: @job, user: current_user)
      redirect_to :back
    else
      redirect_to :back, notice: "Something went wrong ...favorite failed"
    end
  end

  def destroy
    Favorite.where(job: @job, user: current_user).first.destroy
    redirect_to :back
  end

  private
  def set_job
    @job = Job.find(params[:job_id] || params[:id])
  end
end
