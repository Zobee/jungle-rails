class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order)
    @order = order
    @url  = 'http://example.com/login'
    mail(to: @order.email, subject: `Order ##{@order.id}: Thank You For Your Order!`)
  end
end
