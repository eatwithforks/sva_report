# encoding: utf-8
require 'json'
require_relative 'validator'
require_relative 'api_controller'

# Returns server information
class ServersController < ApiController
  def initialize
    super
  end

  def index(filters = nil)
    @api.get_paginated("v1/servers?#{filters}")
  end

  def show(agent_id)
    resp = @api.get("v1/servers/#{agent_id}")
    Validate.response(resp, 200)

    data = JSON.parse(resp)
    Validate.has_content(data)

    data
  end

  def build_ec2_data
    servers = index['servers']
    servers.each do |e|
      next if e.key? 'aws_ec2'
      ec2_data = e['server_label'].match(/(^\d+)_(i.+)/) unless e['server_label'].nil?
      if ec2_data
        e['aws_ec2'] = { 'ec2_account_id' => ec2_data[1], 'ec2_instance_id' => ec2_data[2] }
      end
    end

    servers
  end

  def ec2_servers(account_id)
    servers = build_ec2_data.select! { |srv| srv.key? 'aws_ec2' }
    servers.select! { |srv| srv['aws_ec2']['ec2_account_id'].eql? account_id.to_s }
  end
end
