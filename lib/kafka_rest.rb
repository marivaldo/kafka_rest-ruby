require 'kafka_rest/version'

module KafkaRest
  Error = Class.new(StandardError)
  InvalidContentType = Class.new(Error)
  InvalidResponse = Class.new(Error)
  UnauthorizedRequest = Class.new(Error)

  class ResponseError < Error
    attr_reader :code

    def initialize(code, message)
      @code = code
      super("#{message} (error code #{code})")
    end
  end

  def self.logger
    KafkaRest::Logging::logger
  end

  def self.logger=(log)
    KafkaRest::Logging::logger = log
  end

  RESPONSE_ERROR_CODES = {
    40401 => (TopicNotFound         = Class.new(KafkaRest::ResponseError)),
    40402 => (PartitionNotFound     = Class.new(KafkaRest::ResponseError)),
    422   => (UnprocessableEntity   = Class.new(KafkaRest::ResponseError)),
    50001 => (ZookeeperError        = Class.new(KafkaRest::ResponseError)),
    50002 => (KafkaError            = Class.new(KafkaRest::ResponseError)),
    50003 => (RetriableKafkaError   = Class.new(KafkaRest::ResponseError)),
    50101 => (SSLEndpointError      = Class.new(KafkaRest::ResponseError)),
  }
end

require 'kafka_rest/logging'
require 'kafka_rest/schema'
require 'kafka_rest/brokers'
require 'kafka_rest/client'
require 'kafka_rest/consumers'
require 'kafka_rest/producer'
require 'kafka_rest/topics'
require 'kafka_rest/partitions'
require 'kafka_rest/message'
