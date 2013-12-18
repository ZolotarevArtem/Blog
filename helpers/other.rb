module Other

  def title
    "#{@title}" if @title
  end

  def pretty_date(time)
   time.strftime("%d %b %Y")
  end

end
