class FarmerMailer < ApplicationMailer
  def broadcast_email(customer,farmer,subject,body)
    @farmer = farmer
    @body = body
    mail(to: customer.email, subject: subject)
  end
end
