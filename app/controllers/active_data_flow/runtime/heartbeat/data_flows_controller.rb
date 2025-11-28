# frozen_string_literal: true

module ActiveDataFlow
  module Runtime
    module Heartbeat
      class DataFlowsController < ActionController::Base

        def heartbeat_event
          Rails.logger.info "[ActiveDataFlow::Runtime::Heartbeat::DataFlowsController.heartbeat] called"
          
          ScheduleFlows.create.each_flow_due_to_run do |flow|
            FlowExecutor.execute(flow)
          end

          rescue => e
            Rails.logger.error("ActiveDataFlow::Runtime::Heartbeat.heartbeat failed: #{e.message}")
          end
        end

      end
    end
  end
end
