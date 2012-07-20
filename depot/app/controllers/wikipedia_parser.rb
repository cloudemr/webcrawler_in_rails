require 'net/http'
require 'uri'
require 'json'

class WikiPediaParser

  attr_accessor :wikipedia_base_url,:wikipedia_final_url

  def initialize
    @wikipedia_base_url = "http://en.wikipedia.org/wiki/"
    puts "reached here"
  end

  def self.get_http_response(url_location)

    escaped_url = URI.escape(url_location)
    url = URI.parse(escaped_url)

    if url.query != nil
      response = Net::HTTP.get_response(url)
      raise "Response was not 200, response was #{response.code}" if response.code != "200"
    else
      raise "Invalid Url - #{url}"
    end

    return response.body

  end

  def self.get_wikipedia_response(query)
    puts "query"
    @wikipedia_final_url = @wikipedia_base_url + query
    puts "Final Url : #{@wikipedia_final_url}"
    return get_http_response(@wikipedia_final_url)
  end



end
