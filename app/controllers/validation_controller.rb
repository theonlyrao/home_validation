class ValidationController < ApplicationController

  def new
    @validation = Validation.new
    @home = Home.new
  end
  
end
