require 'hmrc_moss/supply'

module HMRCMOSS
  class NonUKSupply < Supply

    def initialize(vat_number, country, attributes = {})
      attributes[:vat_number] = vat_number
      attributes[:country] = country
      super(attributes)
    end

    def vat_number
      @attributes[:vat_number]
    end

    class DSL
      def initialize(moss_return)
        @moss_return = moss_return
      end

      def line(*args)
        @moss_return.supplies_from_outside_uk << NonUKSupply.new(*args)
      end
    end

  end
end
