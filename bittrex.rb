class Bittrex
  GET_TICKS_URL = 'https://bittrex.com/Api/v2.0/pub/market/GetTicks'.freeze

  def daily_data(market_name)
    get_data(market_name)
  end

  private

  def get_data(market_name, interval = 'day')
    HTTParty.get(
      GET_TICKS_URL,
      query: {
        marketName: market_name,
        tickInterval: interval
      }
    ).parsed_response
  end
end
