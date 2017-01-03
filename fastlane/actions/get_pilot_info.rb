module Fastlane
  module Actions
    module SharedValues
    end

    class GetPilotInfoAction < Action
      def self.run(params)
        pilot_info_path = ""
        if File.exist?("fastlane")
          pilot_info_path += "fastlane/"
        end
        pilot_info_path += "metadata/pilot_info.json"
        pilot_info = nil
        if File.exist?(pilot_info_path)
          if data = File.read(pilot_info_path)
            pilot_info = JSON.parse(data)
          end
        end
        if pilot_info == nil
          pilot_info = {
            "beta_app_description" => "Your beta app description",
            "beta_app_feedback_email" => "feedback@beta.com",
            "changelog" => "New build with fastlane",
            "skip" => true
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

      def self.authors
        ["bbriatte"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
