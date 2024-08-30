# QuickRequest
`QuickRequest` is a lightweight Ruby gem designed to simplify making HTTP and HTTPS requests. It abstracts the complexities of crafting requests by providing a simple, fluent API using the Builder pattern. You can create GET, POST, PUT, and DELETE requests, add query parameters, set headers, and send request bodies easily.

## Installation

To use the QuickRequest gem, add to your `Gemfile`:
```ruby
gem 'quick_request', '~> 1.0.0'
```

Or you can execute:
```ruby
gem install quick_request
```

Obs: Ruby 3 is required

## Basic Usage

Here's a step-by-step guide on how to use the QuickRequest gem.

1. Creating a Request Builder

First, you need to create a `Builder` object. This object allows you to configure your HTTP request.

```ruby
request = QuickRequest::Builder.new(method: :get, url: 'https://api.example.com/data', use_ssl: true)

request = QuickRequest::Builder.new(url: 'http://localhost:3001')
```

* `method`: The HTTP method to use (`:get`, `:post`, `:put` or `:delete`). The default is `:get`
* `url`: The URL to send the request to.
* `use_ssl`: Whether to use SSL for the request (default: `false`).


2. Adding Query Parameters

You can add query parameters to the request using the `query_params` method. This method takes a hash of key-value pairs.

```ruby
request.query_params({ key1: 'value1', key2: 'value2' })
```

This will append the query parameters to the URL.

3. Adding a Request Body

For POST and PUT requests, you may want to send data in the request `body`. You can do this with the body method.

```ruby
request.body({ param1: 'value1', param2: 'value2' })
```

4. Setting Headers

You can set custom headers for the request using the `headers method. This method takes a hash where the keys are header names, and the values are the corresponding header values.

```ruby
request.headers({ 'Content-Type' => 'application/json', 'Authorization' => 'Bearer token' })
```

5. Sending the Request

Once you've configured the request, you can send it using the `send` method. This will return the response body.

```ruby
response_body = request.send
```

## Let's see an examples

Here's a full example of making a POST request with headers, query parameters, and a body:

```ruby
require 'quick_request'

request = QuickRequest::Builder.new(method: :post, url: 'https://api.example.com/submit', use_ssl: true)
            .query_params({ search: 'ruby' })
            .headers({ 'Content-Type' => 'application/json', 'Authorization' => 'Bearer token' })
            .body({ name: 'John', age: 30 })

response_body = request.send
puts response_body

# > "foo response from api..."
```

## Error Handling

Currently, the gem raises a generic error if an unsupported HTTP method is used. More sophisticated error handling can be added by wrapping the `send` method call in a `begin-rescue` block.

## Are you a Rubyst ?

So, if you want to collaborate with this project, your help is alwals welcome. You can open issues and create a PR here. So, go ahead!