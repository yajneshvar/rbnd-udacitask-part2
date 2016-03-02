class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    opts = {title:"Untitled List"}
    options = opts.merge(options)
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if(type == "todo")
      @items.push TodoItem.new(description, options)
    elsif (type == "event")
      @items.push EventItem.new(description, options)
    elsif (type == "link")
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "Item entered is invalid"
    end
  end
  def delete(*indices)
    indices.sort!
    length = @items.length
    index = indices.pop
    while (index != nil)
      if(index > length)
        raise UdaciListErrors::IndexExceedsListSize, "Index is out of bound"
      end
      @items.delete_at(index - 1)
      index = indices.pop
    end
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details} "
    end
  end
  def filter(type)
    puts "-" * type.length
    puts type.upcase
    puts "-" * type.length
    num = 0
    @items.each do |item|
      if(item.type == type)
        num += 1
        puts "#{num} #{item.details} "
      end
    end
  end
  def changePriority(index,priority)
    if(index > @items.length)
      raise UdaciListErrors::IndexExceedsListSize, "Index is out of bound"
    end
    todo = @items[index-1];
    puts todo.class
    if(todo.class === TodoItem)
      raise UdaciListErrors::InvalidItemType, "Item is not a todo item"
    end

    todo.changePriority(priority);

  end
end
