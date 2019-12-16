require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end # if
    end # Course
  end # print_courses

  def get_page
    url = "http://learn-co-curriculum.github.io/site-for-scraping/courses"
    html = open(url)
    Nokogiri::HTML(html)
  end

  def get_courses
    get_page.css(".posts-holder")
  end

  def make_courses
    courses = get_courses
    titles = courses.css("h2")
    descriptions = courses.css("p")
    schedules = courses.css(".date")

    courses.each_with_index{ |course, i|
      c = Course.new
      c.title = titles[i]
      c.description = descriptions[i]
      c.schedule = schedules[i]
    }
    binding.pry
  end

end # Scraper
