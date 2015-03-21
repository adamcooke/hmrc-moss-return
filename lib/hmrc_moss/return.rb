require 'hmrc_moss/uk_supply'
require 'hmrc_moss/non_uk_supply'

module HMRCMOSS
  class Return

    def initialize(period)
      @period = period
    end

    def period
      @period
    end

    def supplies_from_uk(&block)
      if block_given?
        dsl = HMRCMOSS::UKSupply::DSL.new(self)
        dsl.instance_eval(&block)
        supplies_from_uk
      else
        @supplies_from_uk ||= []
      end
    end

    def supplies_from_outside_uk(&block)
      if block_given?
        dsl = HMRCMOSS::NonUKSupply::DSL.new(self)
        dsl.instance_eval(&block)
        supplies_from_outside_uk
      else
        @supplies_from_outside_uk ||= []
      end
    end

    def ods_file
      require 'hmrc_moss/ods_file'
      ODSFile.new(self)
    end

  end
end
