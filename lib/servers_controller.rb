# encoding: utf-8
require 'json'
require_relative 'validator'
require_relative 'api_controller'
require_relative 'ec2'

# Returns server information
class ServersController < ApiController
  def initialize
    super
    @servers = index['servers']
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

  def halo_ips
    @servers.map { |e| e['connecting_ip_address'] }
  end

  def ec2_servers
    options = [{ name: 'instance-state-name', values: ['running'] }]
    EC2.client.describe_instances(filters: options)
  end

  def build_ec2_data
    @servers.each do |srv|
      next if srv.key? 'aws_ec2'
      ec2_data = srv['server_label'].match(/(^\d+)_(i.+)/) unless srv['server_label'].nil?
      if ec2_data
        srv['aws_ec2'] = {
          'ec2_account_id' => ec2_data[1],
          'ec2_instance_id' => ec2_data[2]
        }
      end

      build_aws_data(ec2_servers, srv, halo_ips)
    end

    @servers
  end

  def build_aws_data(ec2_index, halo_server, ips)
    ec2_index['reservations'].each do |reservation|
      reservation['instances'].each do |instance|
        interface = instance.network_interfaces.detect { |e| e.owner_id }
        next if interface.nil?
        if ips.include? instance.public_ip_address
          halo_server['aws_ec2'] = {
            'ec2_account_id' => interface.owner_id,
            'ec2_instance_id' => instance.instance_id
          }
        end
      end
    end
  end

  def filtered_servers(account_id)
    build_ec2_data.select! { |srv| srv['aws_ec2']['ec2_account_id'].eql? account_id.to_s }
  end
end
