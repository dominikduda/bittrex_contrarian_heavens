class Bittrex
  GET_TICKS_URL = 'https://bittrex.com/Api/v2.0/pub/market/GetTicks'.freeze
  GET_MARKETS_URL = 'https://bittrex.com/api/v1.1/public/getmarkets'.freeze
  GET_CURRENT_PRICE_URL = 'https://bittrex.com/api/v1.1/public/getticker'.freeze

  def current_price(market_name)
    get(
      GET_CURRENT_PRICE_URL,
      market: market_name
    )['result']['Last']
  end

  def daily_data(market_name)
    get_data(market_name)
  end

  def btc_markets_index
    get(GET_MARKETS_URL)['result'].select { |market| market['BaseCurrency'] == 'BTC' }
  end

  private

  def get_data(market_name, interval = 'day')
    get(
      GET_TICKS_URL,
      marketName: market_name,
      tickInterval: interval
    )
  end

  def get(url, query = {})
    HTTParty.get(
      url,
      query: query
    ).parsed_response
  end
end
