module ApplicationHelper

  # removeing all model related quires from the views 
  # these methods are acting as middleware between models and views
  def get_avaiblable_money
    current_user.get_available_money
  end

  def get_user_email id
    if id == nil
      'Paytm User'
    else
      User.where(id: id).first.email
    end
  end

  def get_transaction_color id
    if current_user.id == id
      'text-success'
    else
      'text-danger'
    end
  end
end
