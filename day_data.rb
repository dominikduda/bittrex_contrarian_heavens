class DayData
  attr_reader :close, :date

  def initialize(date:, close:)
    @date = date
    @close = close
  end

  def usd_price(btc_price)
    close * (btc_price || 0)
  end

  def date_formatted
    date.strftime('%Y-%m-%d')
  end
end
