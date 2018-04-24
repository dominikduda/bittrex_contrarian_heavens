class Bittrex
  GET_TICKS_URL = 'https://bittrex.com/Api/v2.0/pub/market/GetTicks'.freeze

  def btc_usd_daily_data
    get_data('USDT-BTC')
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
