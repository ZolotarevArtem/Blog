module Helper
include Rack::Utils

  alias_method :h, :escape_html

  def title
    "#{@title}" if @title
  end

  def pretty_date(time)
   time.strftime("%d %b %Y")
  end

end
