require 'pry'
require 'httparty'
require_relative 'bittrex'

pp Bittrex.new.btc_usd_daily_data
