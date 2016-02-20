class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :type

  def initialize(description, options={})
    @type = "event"
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end
  def details
    format_description(@description, @type) + "event dates: " + format_date(@start_date,@end_date)
  end
end
