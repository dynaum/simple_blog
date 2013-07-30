module Aiur
  module Logger
    extend ActiveSupport::Concern

    module ClassMethods
      def notify_events
        define_hooks [:create, :update, :destroy], :after do |action|
          lambda { send_message(action) }
        end
      end

      def define_hooks(actions, filter)
        actions.each do |action|
          set_callback action, filter, yield(action)
        end
      end
    end

    private

    def send_message(action)
      service.add({
        class:     self.class.name,
        action:    action,
        timestamp: updated_at
      }.to_json)
    end

    def service
      AiurClient
    end
  end
end
