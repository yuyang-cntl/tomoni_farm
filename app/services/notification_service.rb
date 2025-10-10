class NotificationService
  def self.notify(recipient:, actor:, notifiable:)
    Notification.create!(
      recipient: recipient,
      actor: actor,
      notifiable: notifiable,
      read: false
    )
  end
end
