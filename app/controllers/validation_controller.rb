class ValidationController < ApplicationController

  def new
    @validation = Validation.new
  end
  
end
