class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    if(options[:priority])
      check_priority(options[:priority])
    end
    @priority = options[:priority]
  end

  def details
    format_description(@description,@type) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end

  def change_priority(priority)
    @priority = priority
  end

  private

  def check_priority(priority)
    priority_list = {"high" => 0, "medium" => 0, "low" => 0};
    if(!priority_list.has_key?(priority))
      raise UdaciListErrors::InvalidPriorityValue, "Priority value is invalid"
    end
    return true
  end
end
