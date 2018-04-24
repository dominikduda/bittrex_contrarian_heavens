require 'pry'
require 'httparty'
require_relative 'bittrex'
require_relative 'market_data'
require_relative 'day_data'

p MarketData.new('BTC-GEO').all_daily_data.last.close.to_f
p MarketData.new('BTC-GEO').all_daily_data.last.date_formatted
