require 'hmrc_moss/supply'

module HMRCMOSS
  class UKSupply < Supply

    def initialize(country, attributes = {})
      attributes[:country] = country
      super(attributes)
    end

    class DSL
      def initialize(moss_return)
        @moss_return = moss_return
      end

      def line(*args)
        @moss_return.supplies_from_uk << UKSupply.new(*args)
      end
    end

  end
end
