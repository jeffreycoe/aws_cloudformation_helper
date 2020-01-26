# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AWS::CloudFormation::Helper::Logger do
  let(:log) { ::StringIO.new }
  let(:error_log) { ::StringIO.new }
  let(:logger) { AWS::CloudFormation::Helper::Logger.new(nil, log, error_log) }

  it 'has default log level set to info' do
    expect(logger.log_level).to be :info
  end

  it 'responds to error' do
    expect(logger).to respond_to(:error).with(1).argument
  end

  it 'responds to info' do
    expect(logger).to respond_to(:info).with(1).argument
  end

  it 'responds to debug' do
    expect(logger).to respond_to(:debug).with(1).argument
  end

  it 'responds to warn' do
    expect(logger).to respond_to(:warn).with(1).argument
  end

  it 'logs error messages to stderr' do
    logger.error('err_msg')
    error_log.rewind
    expect(error_log.read).to include('ERROR -- : err_msg')
  end

  it 'logs info messages to stdout' do
    logger.info('info_msg')
    log.rewind
    expect(log.read).to include('INFO -- : info_msg')
  end

  it 'logs debug messages to stdout' do
    logger.log_level = :debug
    logger.debug('debug_msg')
    log.rewind
    expect(log.read).to include('DEBUG -- : debug_msg')
  end

  it 'logs warn messages to stdout' do
    logger.warn('warn_msg')
    log.rewind
    expect(log.read).to include('WARN -- : warn_msg')
  end
end
