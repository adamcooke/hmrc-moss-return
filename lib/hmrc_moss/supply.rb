module HMRCMOSS
  class Supply

    def initialize(attributes = {})
      @attributes = attributes
    end

    def country
      @attributes[:country].to_s
    end

    def rate_type
      @attributes[:rate_type].to_s
    end

    def rate
      numeric_value(@attributes[:rate].to_f)
    end

    def total_sales
      numeric_value(@attributes[:total_sales])
    end

    def vat_due
      numeric_value(@attributes[:vat_due])
    end

    private

    def numeric_value(value)
      "%.2f" % value.to_f
    end

  end
end
