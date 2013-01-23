require "spec_helper"
require "moiper/notification_controller_helper"

describe Moiper::NotificationControllerHelper do
  class DummyController
    include Moiper::NotificationControllerHelper

    def params
      {}
    end
  end

  describe "#moip_notification" do
    it "yields a Moip::Notification object" do
      controller = DummyController.new

      controller.moip_notification do |notification|
        notification.should be_kind_of Moiper::Notification
      end
    end

    it "allows custom params option" do
      controller = DummyController.new
      params = {}
      Moiper::Notification.should_receive(:new).with(params)
      controller.moip_notification(params)
    end
  end
end
