module User_error

  def user_errors_check(user,field_sym)
    if user!=nil
      if user.errors.[](field_sym).empty?
        "has-success"
      else
        "has-error"
      end
    else
      ""
    end
  end

end
