require 'optparse'

class Options
  class << self
    def val
      options = {}
      OptionParser.new do |opts|
        opts.on('--aws_account ARG', 'aws account id') do |e|
          options[:aws_id] = e
        end
      end.parse!

      raise 'Missing --aws_account parameter' if options[:aws_id].nil?

      options
    end
  end
end
