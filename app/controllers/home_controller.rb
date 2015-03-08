class HomeController < ApplicationController

  caches_action :index
  caches_action :contact
  def index
  end

  def contact
  end
end
