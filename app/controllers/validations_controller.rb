class ValidationsController < ApplicationController

  def show
    @validation = Validation.find(params[:id])
  end  
  
end
