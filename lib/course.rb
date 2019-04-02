#start by examining the site we will be scraping
#it looks like each course has a title, a schedule, and a description.
#us this to define the class

class Course
  attr_accessor :title, :schedule, :description

  @@all = [] #class variable that will store all Course instances

  def initialize #everytie an instance of the class is initialized, we should push it into the @@all class variable
    @@all << self
  end

  def self.all #returns to @@all array
    @@all
  end

  def self.reset_all
    @@all.clear
  end
end
