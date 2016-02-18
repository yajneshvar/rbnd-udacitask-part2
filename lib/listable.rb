module Listable
  # Listable methods go here
  def format_description(description)
  "#{description}".ljust(30)
  end

  def format_date(*dates)
    if (dates.count == 0)
       return
    end
    if (dates.count > 2)
        return ""
    elsif (dates.count == 2)
       date = dates[0].strftime("%D") if dates[0]
       date << " -- " + dates[1].strftime("%D") if dates[1]
    else
      date = dates[0] ? dates[0].strftime("%D") : "No due date"
    end
    return date
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

end
