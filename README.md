# AWS::CloudFormation::Helper
[![Build Status](https://travis-ci.org/jeffreycoe/aws_cloudformation_helper.svg?branch=master)](https://travis-ci.org/jeffreycoe/aws_cloudformation_helper)
[![GitHub](https://img.shields.io/github/license/jeffreycoe/aws_cloudformation_helper)](https://github.com/jeffreycoe/aws_cloudformation_helper/blob/master/LICENSE.txt)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/aws/cloudformation/helper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aws_cloudformation_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws_cloudformation_helper

## Usage

```json
{
  "RequestType": "Create",
  "ResponseURL": "http://pre-signed-S3-url-for-response",
  "StackId": "arn:aws:cloudformation:us-east-1:123456789012:stack/MyStack/guid",
  "RequestId": "unique id for this create request",
  "ResourceType": "Custom::TestResource",
  "LogicalResourceId": "MyTestResource",
  "ResourceProperties": {
    "StackName": "MyStack",
    "List": [
      "1",
      "2",
      "3"
    ]
  }
}
```

```ruby
require 'aws_cloudformation_helper'

def create
  # Add code to handle CloudFormation Create event
end

def delete
  # Add code to handle CloudFormation Delete event
end

def update
  # Add code to handle CloudFormation Update event
end

def lambda_handler(event:, context:)
  # Initializes CloudFormation Helper library
  @cfn_helper = AWS::CloudFormation::Helper.new(self, event, context)
  # @cfn_helper.log_level = :debug
  # @cfn_helper.logger.debug('Debug message')
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aws_cloudformation_helper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
