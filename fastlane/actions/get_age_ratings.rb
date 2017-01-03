module Fastlane
  module Actions
    module SharedValues
    end

    class GetAgeRatingsAction < Action
      def self.run(params)
        age_ratings_path = "fastlane/metadata/age_ratings.json"
        age_ratings = nil
        if File.exist?(age_ratings_path)
          if data = File.read(age_ratings_path)
            age_ratings = JSON.parse(data)
          end
        end
        if age_ratings == nil
          age_ratings = {
            "CARTOON_FANTASY_VIOLENCE" => 0,
            "REALISTIC_VIOLENCE" => 0,
            "PROLONGED_GRAPHIC_SADISTIC_REALISTIC_VIOLENCE"=> 0,
            "PROFANITY_CRUDE_HUMOR"=> 0,
            "MATURE_SUGGESTIVE"=> 0,
            "HORROR"=> 0,
            "MEDICAL_TREATMENT_INFO" => 0,
            "ALCOHOL_TOBACCO_DRUGS"=> 0,
            "GAMBLING"=> 0,
            "SEXUAL_CONTENT_NUDITY"=> 0,
            "GRAPHIC_SEXUAL_CONTENT_NUDITY"=> 0,
            "UNRESTRICTED_WEB_ACCESS"=> 0,
            "GAMBLING_CONTESTS"=> 0
          }
        end
        return age_ratings
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves age ratings info used by deliver"
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
