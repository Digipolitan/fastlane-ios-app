module Fastlane
  module Actions
    module SharedValues
    end

    class UpdatePilotInfoAction < Action
      def self.run(params)
        pilot_info = other_action.get_pilot_info()
        pilot_info.delete("skip")
        if params[:skip_pilot] != true
          key = nil
          loop do
            pilot_info.each { |key, value|
              UI.message("#{key} => #{value}")
            }
            break if key == nil and !UI.confirm("Would you like to update a pilot info key ?")
            key = UI.input("What pilot info key would you like to update ?")
            if pilot_info.key?(key)
              pilot_info[key] = UI.input("New value for '#{key}'")
            end
            break if !UI.confirm("Would you like to update another key ?")
          end
        end
        pilot_info["skip"] = params[:skip_pilot]
        File.open("fastlane/metadata/pilot_info.json", "w") { |file|
          file.puts(pilot_info.to_json)
        }
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Update pilot info used by pilot tool"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :skip_pilot,
                                       env_name: "SKIP_PILOT",
                                       description: "Do not publish beta",
                                       is_string: false,
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
