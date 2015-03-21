module HMRCMOSS
  class Supply

    def initialize(attributes = {})
      @attributes = attributes
    end

    def country
      @attributes[:country]
    end

    def rate_type
      @attributes[:rate_type]
    end

    def rate
      @attributes[:rate]
    end

    def total_sales
      @attributes[:total_sales]
    end

    def vat_due
      @attributes[:vat_due]
    end

    def valid?
      !!(country && rate_type && rate && total_sales && vat_due)
    end

  end
end
