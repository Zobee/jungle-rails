class Admin::SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      redirect_to [:admin, :sales], notice: 'New sale created!'
    else
      render :new
    end
  end

  private
  def sale_params
    params.require(:category).permit(:name, :percent_off, :starts_on, :ends_on)
  end
end
