
class ApplicationController < ActionController::Base
  
  def index
    @time = Time.new
  end
end
