require 'cucumber/ast/scenario_outline'

module PrettyFace
  module Formatter
    module ViewHelper

      def start_time
        @tests_started.strftime("%a %B %-d, %Y at %H:%M:%S")
      end

      def step_count
        @step_mother.steps.length
      end

      def scenario_count
        @step_mother.scenarios.length
      end

      def total_duration
        @duration
      end

      def step_average_duration(features)
        scenarios = features.collect { |feature| feature.scenarios }
        steps = scenarios.flatten.collect { |scenario| scenario.steps }
        durations = steps.flatten.collect { |step| step.duration }
        format_duration get_average_from_float_array durations
      end

      def scenario_average_duration(features)
        scenarios = features.collect { |feature| feature.scenarios }
        durations = scenarios.flatten.collect { |scenario| scenario.duration }
        format_duration get_average_from_float_array durations
      end

      def scenarios_summary_for(status)
        summary_percent(@step_mother.scenarios(status).length, scenario_count)
      end

      def steps_summary_for(status)
        summary_percent(@step_mother.steps(status).length, step_count)
      end

      def failed_scenario?(scenario)
        scenario.status == :failed
      end


      private

      def get_average_from_float_array(arr)
        arr.reduce(:+).to_f / arr.size
      end

      def summary_percent(number, total)
        percent = (number.to_f / total) * 100
        "#{number} <span class=\"percentage\">(#{'%.1f' % percent}%)</span>"
      end
    end
  end
end
