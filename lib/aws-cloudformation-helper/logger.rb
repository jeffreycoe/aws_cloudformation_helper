module AWS
  module CloudFormation
    class Helper
      class Logger
        def error(msg)
          STDERR.puts msg
        end

        def info(msg)
          puts msg
        end
      end
    end
  end
end
