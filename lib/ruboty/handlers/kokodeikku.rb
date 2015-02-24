require "ikku"
require "ruboty"

module Ruboty
  module Handlers
    class Kokodeikku < Base
      env 'KOKODEIKKU_CHANNEL', "if specified, kokodeikku will be enabled only on the specified channels (separated by comma)", optional: true

      PREFIX = "ここで一句 "

      on(
        //,
        all: true,
        description: "ここで一句",
        name: "kokodeikku",
      )

      def kokodeikku(message)
        return if channels && !channels.include?(message.to)

        if message.from != robot.name && !message.body.start_with?(PREFIX) && (song = reviewer.find(message.body))
          message.reply("#{PREFIX}#{song.phrases.map(&:join).join(' ')}")
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

      def reviewer
        @reviewer ||= Ikku::Reviewer.new
      end
    end
  end
end
