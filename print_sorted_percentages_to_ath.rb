class PrintSortedPercentagesToAth
  def call
  end

  private

  def usdt_btc_daily_data
    return @usdt_btc_daily_data if @usdt_btc_daily_data
    @usdt_btc_daily_data = MarketData.new('USDT-BTC')
    @usdt_btc_daily_data.all_daily_data
  end
end
