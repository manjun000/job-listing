class Account::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_jobs = current_user.favorite_jobs.order("id DESC")
  end
end
