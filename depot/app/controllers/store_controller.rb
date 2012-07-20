require 'net/http'
require 'uri'
require 'json'

class StoreController < ApplicationController
 
  def index
    @query = params["query"]
    if @query != nil
      redirect_to "/store/show?query=#{@query}"
    end
  end

  def show
    @query = params["query"]
    puts "Query #{@query}"
    @response = get_wikipedia_response(@query)
    if @response != nil
      @json_hash = get_json_hash(@response)
    else
      @json_hash = {"status" => "Multiple Redirections"}
    end
  end

  def get_json_hash(response)
    json_response = JSON.parse(response)
    final_json = {}
    final_json["query"] = json_response["query"]["normalized"][0]["from"]
    final_json["transformed_query"] = json_response["query"]["normalized"][0]["to"]
    final_json["pages"] = json_response["query"]["pages"]

    final_json
  end

  def get_http_response(url_location)

    escaped_url = URI.escape(url_location)
    url = URI.parse(escaped_url)
    puts "Url Query : #{url}"
    response = Net::HTTP.get_response(url)
    raise "Response was not 200, response was #{response.code}" if response.code != "200"

    return response.body

  end

  def get_wikipedia_response(query)
    @wikipedia_base_url = "http://en.wikipedia.org/w/api.php?format=json&action=query&rvprop=content&prop=revisions&titles="
    @wikipedia_final_url = @wikipedia_base_url + query
    puts "Final Url : #{@wikipedia_final_url}"
    return get_http_response(@wikipedia_final_url)
  end



end
