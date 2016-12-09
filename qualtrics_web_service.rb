require 'sinatra'
require 'sinatra/config_file'
require 'pry' if development?

# Test that Qualtrics recognizes URI query format for web service return values
get '/' do
  returnVals = { things: :have, changed: :for, me: :but, thats: :okay}
  URI.encode_www_form(returnVals)
end

# Check the maximum length of a URI that Qualtrics will store
get '/:values' do
  "length=" + params[:values].to_s.length
end
