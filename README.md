# Halo Vulnerability Report

Version: *1.0*
<br />
Author: *CloudPassage Integrations*

This Ruby script checks an Amazon Web Services (AWS) account for servers sva vulnerabilities.

## Requirements and Dependencies

* The Ruby interpreter >= 2.2.2 must be installed on the machine that executes the script.

## Usage

### Installation

1. Install the CloudPassage API Gem
```
    gem install cloudpassage-0.3.0.gem
```

Place the values inside of configs/portal.yml. The key_id and secret_key can be found from the Halo portal under Site Admin -> Api keys.

```
    key_id:
    secret_key:
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
