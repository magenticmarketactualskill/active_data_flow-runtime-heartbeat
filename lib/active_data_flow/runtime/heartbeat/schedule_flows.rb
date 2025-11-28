# frozen_string_literal: true

module ActiveDataFlow
  module Runtime
    module Heartbeat
      class ScheduleFlows
        def self.execute
          new.execute
        end

        def initialize
          @data_flow_runs = data_flow_run
        end

        def execute
          Rails.logger.info "[ActiveDataFlow::Runtime::Heartbeat::ScheduleFlows] Starting schedule"
          DataFlowRun.create_pending_for_data_flow(@data_flow)
          flows = DataFlow.due_to_run
          triggered_count = 0

          flows.each do |flow|
            FlowExecutor.execute(flow)
            triggered_count += 1
          rescue => e
            Rails.logger.error("Flow execution failed: #{e.message}")
            # Continue with next flow
          end
        end
      end
    end
  end
end
