require 'sinatra'
require 'sinatra/config_file'
require 'pry' if development?

get '/' do
  returnVals = { things: :have, changed: :for, me: :but, thats: :okay}
  URI.encode_www_form(returnVals)
end
