class HomeController < ApplicationController
  def index
    @active_companies = Company.where(active: true)
  end
end
