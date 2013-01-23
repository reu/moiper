module Moiper
  module NotificationControllerHelper
    def moip_notification(data = params, &block)
      notification = Notification.new(data)
      yield notification if block_given?
      notification
    end
  end
end
