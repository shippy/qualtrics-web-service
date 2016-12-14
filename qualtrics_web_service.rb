require 'sinatra'
require 'pry' if development?

# Accepted: URI query format
get '/' do
  URI.encode_www_form(returnVals)
end

# Accepted: JSON
get '/json' do
  require 'json'
  returnVals.to_json
end

# Accepted: XML (with root element and XML declaration)
get '/xml' do
  require 'xmlsimple'

  returnString = '<?xml version="1.0" encoding="UTF-8"?>'
  returnString << XmlSimple.xml_out(returnVals, 'AttrPrefix' => true)
  returnString
end

# Accepted: XML (root element, no XML declaration)
get '/xml_undeclared' do
  require 'xmlsimple'
  XmlSimple.xml_out(returnVals, 'AttrPrefix' => true)
end

# Accepted: RSS (qua XML - no special treatment)
get '/rss' do
  feed = makeFeed('rss2.0')
  return feed.to_s
end

# Rejected: Values separated with linebreaks rather than ampersands
get '/failing/newlines' do
  returnString = ''
  returnVals.each do |key, value|
    returnString << "#{key}=#{value}\n"
  end
  returnString
end

# Rejected: Malformed XML without root element
get '/failing/xml_rootless' do
  require 'xmlsimple'
  XmlSimple.xml_out(returnVals, 'AttrPrefix' => true, 'RootName' => nil)
end

helpers do
  # Hash of information the web service wishes to return
  def returnVals
    {things: :have, changed: :for, me: :but, thats: :okay}
  end

  # Helper for feed-making (can be called with any value available in
  # `RSS::Maker.versions`).
  # Returns RSS object, which responds to `puts` or `to_s`.
  def makeFeed(version)
    require 'rss'
    rss = RSS::Maker.make(version) do |maker|
      maker.channel.author = "sim_pod"
      maker.channel.updated = Time.now.to_s
      maker.channel.link = "http://localhost/"
      maker.channel.description = "Testing the format that Qualtrics will accept"
      maker.channel.title = "Output for Qualtrics"
      maker.channel.id = rand(10000)

      returnVals.each do |key, value|
        maker.items.new_item do |item|
          item.id = rand(10000)
          item.title = key
          item.description = value
          item.updated = Time.now.to_s
        end
      end
    end
    return rss
  end
end
