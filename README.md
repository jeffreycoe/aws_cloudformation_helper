# aws_cloudformation_helper
[![Build Status](https://travis-ci.org/jeffreycoe/aws_cloudformation_helper.svg?branch=master)](https://travis-ci.org/jeffreycoe/aws_cloudformation_helper)
[![GitHub](https://img.shields.io/github/license/jeffreycoe/aws_cloudformation_helper)](https://github.com/jeffreycoe/aws_cloudformation_helper/blob/master/LICENSE.txt)

This Ruby gem is to assist with the development of custom resources for CloudFormation using the Ruby runtime.

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

Install this gem into your Lambda environment using bundle install or by bundling this gem in a Lambda layer.

Once the Ruby gem is installed, use the code template below for the main Lambda function to begin:
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

  # Add additional initialization code here

  # Executes the event method
  @cfn_helper.event.execute
end
```

Sample CloudFormation JSON create event data:
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jeffreycoe/aws_cloudformation_helper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
