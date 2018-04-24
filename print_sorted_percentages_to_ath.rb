class PrintSortedPercentagesToAth
  def initialize
    @markets_and_usd_aths = {}
    @markets_and_percentages_to_aths = {}
  end

  def call
    find_ust_aths
    calculate_percentages_to_aths
    print_sorted_data
  end

  private

  attr_reader :markets_and_usd_aths, :markets_and_percentages_to_aths

  def print_sorted_data
    @markets_and_percentages_to_aths.
      sort_by { |_, percentage_to_ath| percentage_to_ath }.
      reverse.
      each do |market_name, percentage_to_ath|
        market_name_formatted = market_name.sub('BTC', 'USD')
        market_name_formatted = market_name_formatted.ljust(8, ' ')
        puts "#{market_name_formatted}\thas\t#{percentage_to_ath.to_f.round(2)}%\t\tto ATH"
      end
  end

  def calculate_percentages_to_aths
    total_market_count = markets_and_usd_aths.count
    puts "\tCALCULATING PERCENTAGES TO ATHS - STEP 3/3"
    markets_and_usd_aths.each_with_index do |(market_name, usd_ath), i|
      puts "Calculating percentage to ATH for #{market_name} (#{i + 1} out of #{total_market_count})"
      current_price_in_btc = Bittrex.new.current_price(market_name)
      puts 'CALCULATION FAILED' unless current_price_in_btc
      current_price = current_btc_price * current_price_in_btc
      increase = usd_ath - current_price
      markets_and_percentages_to_aths[market_name] = increase / current_price * 100
    end
  end

  def find_ust_aths
    markets_count = all_btc_markets_daily_data.count
    puts "\tFINDING USD ATHS - STEP 2/3"
    all_btc_markets_daily_data.each_with_index do |market_data, i|
      market_usd_ath = 0
      puts "Finding USD ath for #{market_data.name} (#{i + 1} out of #{markets_count})"
      market_data.all_daily_data.each do |day_data|
        btc_day_data = usdt_btc_data.all_daily_data.find do |usdt_btc_day_data|
                         usdt_btc_day_data.date_formatted == day_data.date_formatted
                       end
        day_usd_price = day_data.usd_price(btc_day_data&.close)
        market_usd_ath = day_usd_price if day_usd_price > market_usd_ath
      end
      markets_and_usd_aths[market_data.name] = market_usd_ath
    end
  end

  def all_btc_markets_daily_data
    return @all_btc_markets_daily_data if @all_btc_markets_daily_data
    markets_count = bittrex_btc_markets.count
    puts "\tFETCHING DATA (#{markets_count} BTC markets found) - STEP 1/3"
    @all_btc_markets_daily_data =
      Bittrex.new.btc_markets_index.each_with_index.map do |market, i|
        puts "Fetching data for #{market['MarketName']} (#{i + 1} out of #{markets_count})"
        market_data = MarketData.new(market['MarketName'])
        market_data.all_daily_data
        market_data
      end
  end

  def bittrex_btc_markets
    @bittrex_btc_markets ||= Bittrex.new.btc_markets_index
  end

  def current_btc_price
    @current_btc_price ||= Bittrex.new.current_price('USDT-BTC')
  end

  def usdt_btc_data
    return @usdt_btc_data if @usdt_btc_data
    @usdt_btc_data = MarketData.new('USDT-BTC')
    @usdt_btc_data.all_daily_data
    @usdt_btc_data
  end
end
