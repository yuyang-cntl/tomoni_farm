class FarmerBroadcastService
  def initialize(farmer, subject:, body:, template: nil)
    @farmer = farmer
    @subject = subject
    @body = body
    @template = template
  end

  def call
    recipient_ids = []

    @farmer.followers.find_each do |customer|
      FarmerMailer.broadcast_email(customer, @farmer, @subject, @body).deliver_later
      recipient_ids << customer.id
    end

    BroadcastLog.create!(
      farmer: @farmer,
      email_template: @template,
      subject: @subject,
      body: @body,
      recipient_ids: recipient_ids,
      sent_at: Time.current
    )
  end
end