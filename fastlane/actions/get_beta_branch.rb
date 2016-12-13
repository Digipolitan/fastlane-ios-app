module Fastlane
  module Actions
    module SharedValues
      BETA_BRANCH_NAME = :BETA_BRANCH_NAME
    end

    class GetBetaBranchAction < Action
      def self.run(params)
        beta_branch = nil
        begin
          beta_branch = Actions.sh("git config --get fastlane.branch.beta", log: false).strip()
        rescue
          beta_branch = UI.input("Branch name for beta releases: [beta] ")
          if beta_branch.length == 0
            beta_branch = "beta"
          end
          Actions.sh("git config fastlane.branch.beta #{beta_branch}", log: false)
        end
        Actions.lane_context[SharedValues::BETA_BRANCH_NAME] = beta_branch
        return beta_branch
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Retrieves or creates the beta branch name"
      end

      def self.output
        [
          ['BETA_BRANCH_NAME', 'The beta branch name']
        ]
      end

      def self.return_value
        "The beta branch name"
      end

      def self.authors
        ["bbriatte"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.category
        :source_control
      end

      def self.example_code
        [
          'get_beta_branch'
        ]
      end
    end
  end
end
