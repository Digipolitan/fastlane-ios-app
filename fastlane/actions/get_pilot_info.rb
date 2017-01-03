module Fastlane
  module Actions
    module SharedValues
    end

    class GetPilotInfoAction < Action
      def self.run(params)
        pilot_info_path = "fastlane/metadata/pilot_info.json"
        pilot_info = nil
        if File.exists?(pilot_info_path)
          if data = File.read(pilot_info_path)
            pilot_info = JSON.parse(data)
          end
        end
        if pilot_info == nil
          pilot_info = {
            "beta_app_description": "Your beta app description",
            "beta_app_feedback_email": "feedback@beta.com",
            "changelog": "New build with fastlane",
            "skip": true
          }
        end
        return pilot_info
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Get pilot info used by pilot tool"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :skip_pilot,
                                       env_name: "SKIP_PILOT",
                                       description: "Do not publish beta",
                                       is_string: false,
                                       optional: true,
                                       default_value: false)
        ]
      end

      def self.authors
        ["bbriatte"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
