class NotificationService
  def self.notify(recipient:, actor:, notifiable:, notification_key:)
    Notification.create!(
      recipient: recipient,
      actor: actor,
      notifiable: notifiable,
      notification_key: notification_key,
      read: false
    )
  end
end
