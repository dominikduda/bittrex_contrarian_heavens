class MarketData
  attr_reader :name
  attr_accessor :usd_ath_date

  def initialize(name)
    @name = name
  end

  def all_daily_data
    return @all_daily_data if @all_daily_data
    @all_daily_data = get_all_time_daily_data
                        .map do |day_data|
                          DayData.new(
                            date: Time.parse(day_data['T']),
                            close: BigDecimal(day_data['C'].to_s),
                          )
                        end
                        .sort_by { |day_data| day_data.date }
  end

  private

  def get_all_time_daily_data
    if name == 'USDT_BTC'
      Poloniex.btc_usd_data.map do |daily_data_hash|
        {
          'T' => Time.at(daily_data_hash['date']),
          'C' => daily_data_hash['close']
        }
      end
    else
      Bittrex.new.daily_data(name)['result']
    end
  end
end
