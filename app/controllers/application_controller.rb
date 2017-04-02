class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_reader
    if user_signed_in?
      set_book
      @exist_reader = Reader.where("user_id = ? AND book_id = ?", current_user.id, @book.id).take
    end
  end

  def set_future_reader
    if user_signed_in?
      set_book
      @fut_reader = FutureReader.where("user_id = ? AND book_id = ?", current_user.id, @book.id).take
    end
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      flash[:alert] = "You must be logged in to do that."
      redirect_to new_user_session_path
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = "Only admins have access to this action."
      redirect_to users_path
    end
  end


end
