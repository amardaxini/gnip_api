# GnipApi

Ruby Wrapper of Gnip API

## Installation

Add this line to your application's Gemfile:

    gem 'gnip_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gnip_api

## Usage

### Configuration

    GnipApi.configure do |config|
      config.user_name = "jparekh@idyllic-software.com"
      config.password = "idyllic"
    end

### Search
    search = GnipApi::Search.new("https://search.gnip.com/accounts/ACCOUNT_NAME/search/prod.json")
    search.search({:query=>"rails",:publisher=>"twitter",:maxResults=>10,"fromDate=><yyyymmddhhmm>,:toDate=><yyyymmddhhmm>})
    search.search({:query=>"in_reply_to_status_id:id OR in_reply_to_status_id:id",:publisher=>"twitter",:maxResults=>10,"fromDate=><yyyymmddhhmm>,:toDate=><yyyymmddhhmm>}
    search.pase_response

### Count Search Tweet    
    search = GnipApi::Search.new("https://search.gnip.com/accounts/ACCOUNT_NAME/search/prod/counts.json")
    search.count_tweets({:query=>"rails",:publisher=>"twitter",:bucket=>day)
    search.parse_response

### Rehydration
    tweet = GnipApi::Rehydration.new("https://rehydration.gnip.com/accounts/<ACCOUNT_NAME>/publishers/<PUBLISHER>/rehydration/activities.json")
    # ["111","222"] is an array of tweet ids 
    tweet.get_tweets(["111","222"])

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
