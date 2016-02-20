class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    priority_list = {"high" => 0, "medium" => 0, "low" => 0};
    if(options[:priority] && !priority_list.has_key?(options[:priority] ))
      raise UdaciListErrors::InvalidPriorityValue, "Priority value is invalid"
    end
    @priority = options[:priority]
  end

  def details
    format_description(@description,@type) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
end
