module Fastlane
  module Actions
    module SharedValues
    end

    class UpdateAgeRatingsAction < Action
      def self.run(params)
        age_ratings = other_action.get_age_ratings()
        ratings = ["none", "minor", "major"]
        key = nil
        loop do
          age_ratings.each { |key, value|
            UI.message("#{key} => #{value}")
          }
          break if key == nil and !UI.confirm("Would you like to update an age ratings key ?")
          key = UI.input("What age rating key would you like to update ?")
          if age_ratings.key?(key)
            value = UI.select("Choose a rating value", ratings)
            if i = ratings.index(value)
              age_ratings[key] = i
            end
          end
          break if !UI.confirm("Would you like to update another key ?")
        end
        if !Dir.exist?("fastlane/metadata")
          Dir.mkdir("fastlane/metadata")
        end
        File.open("fastlane/metadata/age_ratings.json", "w") { |file|
          file.puts(age_ratings.to_json)
        }
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Update age ratings info used by deliver"
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
