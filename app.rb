require 'chronic'
require 'colorize'
require 'highline'
# Find a third gem of your choice and add it to your project
require 'date'
require 'optparse'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

#parsing options from CLI

$options = {interactive: false}

OptionParser.new do |opts|
  opts.banner = "Usage: app.rb --interactive"

  opts.on("--interactive","Run interactive mode") do |v|
      $options[:interactive] = true
  end
end.parse!

if(!$options[:interactive])
  list = UdaciList.new(title: "Julia's Stuff")
  list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
  list.add("todo", "Sweep floors", due: "2016-01-30")
  list.add("todo", "Buy groceries", priority: "high")
  list.add("event", "Birthday Party", start_date: "2016-05-08")
  list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
  list.add("link", "https://github.com", site_name: "GitHub Homepage")
  list.all
  list.delete(3)
  list.all

  # SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
  # --------------------------------------------------
  new_list = UdaciList.new # Should create a list called "Untitled List"
  new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
  new_list.add("todo", "Go dancing", due: "in 2 hours")
  new_list.add("todo", "Buy groceries", priority: "high")
  new_list.add("event", "Birthday Party", start_date: "May 31")
  new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
  new_list.add("event", "Life happens")
  new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
  new_list.add("link", "http://ruby-doc.org")

  # SHOULD RETURN ERROR MESSAGES
  # ----------------------------
  # new_list.add("image", "http://ruby-doc.org") # Throws InvalidItemType error
  # new_list.delete(9) # Throws an IndexExceedsListSize error
  # new_list.add("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

  # DISPLAY UNTITLED LIST
  # ---------------------
  new_list.all

  # DEMO FILTER BY ITEM TYPE
  # ------------------------
  new_list.filter("event")

  #DEMO NEW FEATURE of changing Priority
  new_list.change_priority(1,"high")
  #DEMO of deleting multiple item
  new_list.delete(6,7,8)
  #Buying food for dog item priority changes from medium to high
  #The links and the life happens event are removed
  new_list.all

else
  # NEW FEATURE WITH GEM
  # -----------
  cli = HighLine.new
  mylist = nil
  exit = false
  while !exit
    cli.choose do |menu|
      menu.prompt = "Please choose an action (create add delete print exit)"
      menu.choice(:create) {
        title = cli.ask("What is the tile of your list?")
        title.chomp!
        title.empty?  ? mylist = UdaciList.new : mylist = UdaciList.new(title: title)
      }
      menu.choice(:add){
        if(mylist.nil?)
          cli.say("Please create a list first")
        else
          type = cli.ask("Choose a type (todo, event, link)")
          if(type == "todo")
            description = cli.ask("Enter description:")
            due_date = cli.ask("Enter due date i.e 10/11/16 or in 2 weeks:")
            priority = cli.ask("Enter the priority (low medium high): ")
            mylist.add(type,description,due:due_date,priority: priority)
          elsif (type == "event")
            description = cli.ask("Enter description:")
            start_date = cli.ask("Start date:")
            start_date.chomp!
            end_date = cli.ask("End date:")
            end_date.chomp!
            mylist.add(type,description,start_date: start_date,end_date: end_date)
          elsif (type == "link")
            link = cli.ask("Enter the link")
            site_name = cli.ask("Enter the site name:")
            mylist.add(type,link,site_name: site_name)
          end
        end
      }
      menu.choice(:delete){
        if(!mylist.nil?)
          puts
          mylist.all
          index = cli.ask("Please specify an index", Integer)
          mylist.delete(index)
        end
      }
      menu.choice(:print){
        if(!mylist.nil?)
          puts
          mylist.all
          puts
        end
      }
      menu.choice(:exit){
        exit = true
      }
    end

  end

end
