require 'zip'

module HMRCMOSS
  class ODSFile

    def initialize(moss_return)
      @moss_return = moss_return
    end

    def content
      @template_content ||= Zip::File.open(self.class.path_to_template) { |z| z.read('content.xml') }
    end

    def add_return_data
      content.gsub!("{{uk:period}}", @moss_return.period)
      content.gsub!("{{f:period}}", @moss_return.period)
      (1..150).each do |i|
        return_line = @moss_return.supplies_from_uk[i - 1]
        content.gsub! "{{uk:taxsupp}}", "Yes" if return_line
        content.gsub! "{{uk:state:#{i}}}",        return_line ? return_line.country.to_s        : ''
        content.gsub! "{{uk:ratetype:#{i}}}",     return_line ? return_line.rate_type.to_s      : ''
        content.gsub! "{{uk:rate:#{i}}}",         return_line ? return_line.rate.to_s           : ''
        content.gsub! "{{uk:value:#{i}}}",        return_line ? return_line.total_sales.to_s    : ''
        content.gsub! "{{uk:amount:#{i}}}",       return_line ? return_line.vat_due.to_s        : ''
        content.gsub! "{{uk:taxsupp}}", "No"

        return_line = @moss_return.supplies_from_outside_uk[i - 1]
        content.gsub! "{{f:taxsupp}}", "Yes" if return_line
        content.gsub! "{{f:number:#{i}}}",       return_line ? return_line.vat_number.to_s     : ''
        content.gsub! "{{f:state:#{i}}}",        return_line ? return_line.country.to_s        : ''
        content.gsub! "{{f:ratetype:#{i}}}",     return_line ? return_line.rate_type.to_s      : ''
        content.gsub! "{{f:rate:#{i}}}",         return_line ? return_line.rate.to_s           : ''
        content.gsub! "{{f:value:#{i}}}",        return_line ? return_line.total_sales.to_s    : ''
        content.gsub! "{{f:amount:#{i}}}",       return_line ? return_line.vat_due.to_s        : ''
        content.gsub! "{{f:taxsupp}}", "No"
      end
    end

    def create_ods_file(path)
      FileUtils.cp(self.class.path_to_template, path)
      Zip::File.open(path) do |zip|
        zip.get_output_stream('content.xml') do |io|
          io.write(content)
        end
      end
    end

    def save(path)
      add_return_data
      create_ods_file(path)
    end

    def self.path_to_template
      File.expand_path(File.join('..', '..', '..', 'template.ods'), __FILE__)
    end

  end
end
