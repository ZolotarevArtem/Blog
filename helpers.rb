require "digest/md5"
helpers do
  
    def title
      "#{@title}" if @title
    end

    def pretty_date(time)
     time.strftime("%d %b %Y")
    end

     def hash_password(password)
      Digest::MD5.hexdigest(password)
    end

end
