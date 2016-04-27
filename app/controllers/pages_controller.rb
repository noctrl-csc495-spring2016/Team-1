class PagesController < ApplicationController
  # /
    def index
        render 'pages/index.html.erb'
    end
    # /home
  def home1
    render 'pages/home/home1.html'
  end
      # /
  def home2
    render 'pages/home/home2.html'
  end
      # /
  def home3
    render 'pages/home/home3.html'
  end
  
  # /about
  def about
  end
  
  # /admin/admin1
  def admin1
    render 'pages/admin/admin1.html'
  end
  
  # /admin/admin2
  def admin2
    render 'pages/admin/admin2.html'
  end
  
  # /admin/admin3
  def admin3
    render 'pages/admin/admin3.html'
  end
  
  # /reports/report1
  def report1
    render 'pages/reports/report1.html'
  end
  
  # /reports/report2
  def report2
    render 'pages/reports/report2.html'
  end
  
  # /reports/report3
  def report3
    render 'pages/reports/report3.html'
  end
  
  # /schedule/schedule1
  def schedule1
    render 'pages/schedule/schedule1.html'
  end
  
  # /schedule/schedule2
  def schedule2
    render 'pages/schedule/schedule2.html'
  end
  
  # /schedule/schedule3
  def schedule3
    render 'pages/schedule/schedule3.html'
  end
  
  # /template
  def template
  end
end