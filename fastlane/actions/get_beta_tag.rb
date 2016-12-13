module Fastlane
  module Actions
    module SharedValues
      BETA_TAG_NAME = :BETA_TAG_NAME
    end

    class GetBetaTagAction < Action
      def self.run(params)
        prefix_versiontag = nil
        begin
          prefix_versiontag = Actions.sh("git config --get gitflow.prefix.versiontag", log: false).strip()
        rescue
          Actions.user_error! "Git flow not initialized"
        end
        version = params[:version]
        build_number = params[:build_number]
        beta_tag_name = "#{prefix_versiontag}#{version}-beta#{build_number}"
        Actions.lane_context[SharedValues::BETA_TAG_NAME] = beta_tag_name
        return beta_tag_name
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves the beta tag name"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :version,
                                       description: "The beta version value",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :build_number,
                                       description: "The build number",
                                       optional: false)
        ]
      end

      def self.output
        [
          ['BETA_TAG_NAME', 'The beta tag name']
        ]
      end

      def self.return_value
        "The beta tag name"
      end

      def self.authors
        ["bbriate"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.category
        :source_control
      end

      def self.example_code
        [
          'get_beta_tag(
            version: "1.0.5",
            build_number: "88"
          )'
        ]
      end
    end
  end
end
