module Moiper
  module NotificationControllerHelper
    # Helper method to abstract how to create a notification during the Moip's
    # NASP request.
    #
    # @see http://labs.moip.com.br/referencia/nasp/ Moip's NASP documentation
    #
    # @param data [Hash] controller parameters
    # @yieldparam [Notification] notification update from Moip
    # @return [Notification]
    #
    # @example Usage inside a Rails controller
    #   class OrdersController < ApplicationController
    #     include Moiper::NotificationControllerHelper
    #
    #     def confirm
    #       moip_notification do |notification|
    #         # Here you can update your database with updated information.
    #         # Ex:
    #         @order = Order.find_by_unique_identifier(notification.id)
    #         @order.update_attribute :status, notification.payment_status
    #         @order.save
    #
    #         # Moip will recognize the request as successfully if the statuses
    #         # are 200, 201, 202, 203, 204, 205, 206 or 207.
    #         head 200
    #       end
    #     end
    #   end
    def moip_notification(data = params, &block)
      notification = Notification.new(data)
      yield notification if block_given?
      notification
    end
  end
end
