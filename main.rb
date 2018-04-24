require 'pry'
require 'httparty'
require_relative 'bittrex'
require_relative 'market_data'
require_relative 'poloniex'
require_relative 'day_data'
require_relative 'print_sorted_percentages_to_ath'

PrintSortedPercentagesToAth.new.call
