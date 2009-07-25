class AdminController < ApplicationController
  
  before_filter :authorize
  
  # active_scaffold :product
end
