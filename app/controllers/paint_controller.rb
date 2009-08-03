class PaintController < ApplicationController

layout "standard"

  def index

  end  

#----------------------2008---------------------------
  def yr2008
    render :partial => "menu_yr2008"
  end
  
  def encounter
    render :partial => "encounter_thumb"
  end
  
  def encounter_detail
    render :partial => "encounter_show"
  end
    
  def yr2007
  end
  
  def yr2006
  end    
  

end
