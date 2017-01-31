# Halo Vulnerability Report

Version: *1.0*
<br />
Author: *CloudPassage Integrations*

This Ruby script checks an Amazon Web Services (AWS) account for servers sva vulnerabilities.

##Requirements and Dependencies

* The Ruby interpreter must be installed on the machine that executes the script.
* Ruby intepreter version must be >= 2.2.2

##Usage

###*Installation*


### Prerequisites for installing Ruby For Linux OSes

RPM Based
```
yum groupinstall 'Development Tools'
```

Upgrade Ruby on Ubuntu/Debian
```
apt-get install build-essential
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install ruby2.2 ruby2.2-dev
```

Install the gem bundler
```
    gem install bundler
```
Install the required ruby gems using bundler.
```
    bundle install
```
If bundle install didn't install aws-sdk gem correctly, install the gem manually by
```
    gem install aws-sdk
```

Install the CloudPassage API Gem
```
    gem install cloudpassage-0.3.0.gem
```

Then update the "providers" Hash with your specific Cloud Provider, credential_path and regions where you have servers deployed. Place the values inside of configs/portal.yml. 
AWS region codes can be referenced here: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html

```
    key_id: 
    secret_key: 
    aws_key_id: 
    aws_secret_key: 
    aws_region:
    api_hostname : https://api.cloudpassage.com
    cve_url: https://cve.mitre.org/cgi-bin/cvename.cgi?name=
```
### Run
A CSV report will be produced and stored in the reports directory for servers based on an aws account id.

```
    ruby halo_vulnerability_report.rb --aws_account=
```

## License

Copyright (c) 2017, CloudPassage, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the CloudPassage, Inc. nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL CLOUDPASSAGE, INC. BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED ANDON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
