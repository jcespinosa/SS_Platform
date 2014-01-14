module UsersHelper
  def find_user(id)
    if is_number?(id)
      User.find(params[:id])
    else
      User.find_by(username: params[:id])
    end
  end

  def is_number?(val)
    val.to_f.to_s == val.to_s || val.to_i.to_s == val.to_s
  end
end
