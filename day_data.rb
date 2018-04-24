class DayData
  # attr_reader :close, :date, :previous_day_data, :high
  attr_reader :close, :date

  # def initialize(date:, close:, previous_day_data:)
  def initialize(date:, close:)
    @date = date
    @close = close
    # @previous_day_data = previous_day_data
  end

  def date_formatted
    date.strftime('%Y-%m-%d')
  end

  # def ema_50
  #   @ema_50 ||= if all_previous_records.count < 50
  #                 nil
  #               elsif all_previous_records.count == 50
  #                 all_previous_records.map(&:close).inject(&:+) / 50
  #               else
  #                 k = 2.0 / (50 + 1)
  #                 close * k + previous_day_data.ema_50 * (1 - k)
  #               end
  # end

  # private

  # def all_previous_records
  #   return @all_previous_records if @all_previous_records
  #   @all_previous_records = []
  #   record = previous_day_data
  #   until record.nil?
  #     @all_previous_records.push(record)
  #     record = record.previous_day_data
  #   end
  #   @all_previous_records
  # end
end
