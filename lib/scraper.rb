require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb' # we are requiring our Course class file so our scraper can use it to make new courses

# responsible for using nokogiri to scrape the relevant data
# Responsible for taking that data and using it to instantiate instances of the Course class.

class Scraper

  def get_page
    # get the HTML from the webpage
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    #NOTE! we broke up the rest of the function into the other methods
    #iterate over the collection of nokogiri elements we want to pull information from. the post class stores course information
    # doc.css('.post').each do |post|
    #   course = Course.new #instantiate a new course on each iteration
    #   course.title = post.css('h2').text #doc.css('.post').css("h2").text
    #   course.schedule = post.css('.date').text #doc.css('.post').css(".date").text
    #   course.description = post.css('p').text #doc.css('.post').css("p").text
    # end
  end

  def get_courses #grabs all the HTML elements that contain a Course
    #returns a collection of nokogiri XML elements, each describing a course
    self.get_page.css('.post')
  end

  def make_courses #instantiates Course objects
    #iterate over the collection of nokogiri elements we want to pull information from. the post class stores course information
    #gives each course the correct title, schedule and description attribute
    self.get_courses.each do |post|
      course = Course.new #instantiate a new course on each iteration
      course.title = post.css('h2').text #doc.css('.post').css("h2").text
      course.schedule = post.css('.date').text #doc.css('.post').css(".date").text
      course.description = post.css('p').text #doc.css('.post').css("p").text
    end
  end


  def print_courses
    self.make_courses # calls make_courses
    Course.all.each do |course| #iterates over all of the courses, and puts out a list of the course offerings
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end

Scraper.new.print_courses # need to call the get page method to hit the pry, run with ruby lib/scraper.rb
