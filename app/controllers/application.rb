
class ApplicationController < ActionController::Base
  layout 'standard'
  
  def index
    @time = Time.new
  end
end
