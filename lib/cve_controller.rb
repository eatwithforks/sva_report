# encoding: utf-8
require 'json'
require_relative 'api_controller'
require_relative 'validator'
require_relative 'configs'

class CveController < ApiController
  def initialize
    super
    @cache = []
  end

  def cves(server)
    cves = []
    server['scan']['findings'].each do |finding|
      finding['cve_entries'].each { |cve| cves << cve['cve_entry'] }
    end

    cves
  end

  def cve_info(cve)
    resp = @api.get("v1/cve_details/#{cve}")
    Validate.response(resp, 200)

    data = JSON.parse(resp)
    Validate.has_content(data)

    data
  end

  def cve_url(cve)
    "#{Config['cve_url']}#{cve}"
  end

  def cvss_severity(cvss_score)
    case cvss_score
    when cvss_score..4.0
      'Low'
    when 7.0..cvss_score
      'High'
    else
      'Medium'
    end
  end

  def cve_cache(cve)
    found = @cache.detect { |mem| mem['CVE'].eql? cve }
    return found if found

    info = cve_info(cve)
    @cache << info
    info
  end

  def build_whitelisted(server, vulns)
    result = []
    vulns['scan']['findings'].each do |f|
      next if f['status'].eql? 'good'
      f['cve_entries'].each do |cve|
        result << {
          accountID: server['aws_ec2']['ec2_account_id'],
          instanceID: server['aws_ec2']['ec2_instance_id'],
          hostName: server['hostname'],
          packageName: f['package_name'],
          packageVersion: f['package_version'],
          rating: cvss_severity(cve['cvss_score']),
          cveNumber: cve['cve_entry'],
          description: cve_cache(cve['cve_entry'])['summary'],
          cveLink: cve_url(cve['cve_entry']),
          scanTime: vulns['scan']['created_at']
        }
      end
    end

    result
  end
end