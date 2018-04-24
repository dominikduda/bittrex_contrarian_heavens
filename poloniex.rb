class Poloniex
  def btc_usd_data
    get(
      'command' => 'returnChartData',
      'currencyPair' => 'USDT_BTC',
      'start' => '0',
      'end' => '9999999999999999999999',
      'period' => '86400'
    )
  end

  private

  def get(params)
    url = "https://poloniex.com/public?"
    params.each do |k, v|
      url.concat("#{k}=#{v}&")
    end
    HTTParty.get(url).parsed_response
  end
end
