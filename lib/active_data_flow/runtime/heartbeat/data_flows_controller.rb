# frozen_string_literal: true

module ActiveDataFlow
  module Runtime
    module Heartbeat
      class DataFlowsController < ActionController::Base

        def heartbeat
          Rails.logger.info "[ActiveDataFlow::Runtime::Heartbeat::DataFlowsController.heartbeat] called"
          ScheduleFlows.execute()
        end

      end
    end
  end
end
