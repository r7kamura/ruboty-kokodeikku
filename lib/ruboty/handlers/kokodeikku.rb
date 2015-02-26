require "ikku"
require "ruboty"

module Ruboty
  module Handlers
    class Kokodeikku < Base
      env 'KOKODEIKKU_CHANNEL', "if specified, kokodeikku will be enabled only on the specified channels (separated by comma)", optional: true

      DEFAULT_PREFIX = "ここで一句"

      env :KOKODEIKKU_PREFIX, 'Pass optional prefix message (default: ここで一句)', optional: true
      env :KOKODEIKKU_RULE, 'Pass optional song rule (default: "5,7,5")', optional: true

      on(
        //,
        all: true,
        description: "ここで一句",
        name: "kokodeikku",
      )

      def kokodeikku(message)
        return if channels && !channels.include?(message.to)

        if message.from != robot.name && !message.body.start_with?("#{prefix} ") && (song = reviewer.find(message.body))
          message.reply("#{prefix} #{song.phrases.map(&:join).join(' ')}")
        end
      end

      private

      def channels
        if ENV['KOKODEIKKU_CHANNEL']
          @channels ||= ENV['KOKODEIKKU_CHANNEL'].split(',')
        else
          nil
        end
      end

      def prefix
        ENV["KOKODEIKKU_PREFIX"] || DEFAULT_PREFIX
      end

      def reviewer
        @reviewer ||= Ikku::Reviewer.new(rule: rule)
      end

      def rule
        if ENV["KOKODEIKKU_RULE"]
          ENV["KOKODEIKKU_RULE"].split(",").map(&:to_i)
        end
      end
    end
  end
end
