class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_AUTH_USER"], password: ENV["HTTP_AUTH_PW"]
  def show
    @num_products = Product.count
    @num_products_in_stock = Product.where("quantity >?", 0).count
    @num_total_products = Product.sum("quantity")
    @num_categories = Category.count
  end
end
