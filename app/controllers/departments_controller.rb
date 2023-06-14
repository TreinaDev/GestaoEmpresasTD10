class DepartmentsController < ApplicationController
  def new
    @companies = Company.all
    @department = Department.new
  end
  
end