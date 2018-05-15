# controller to handle all transactions
class TransactionsController < ApplicationController
  
  #forcing user to be logged in for access transactions
  before_action :authenticate_user!
  
  #to show all transactions of a user
  def index
    @transactions = Transaction.where("(sender_id = ? or receiver_id = ?)", current_user.id, current_user.id)
  end

  #create a transaction
  def create
    if !params[:amount].nil? and !params[:receiver_id].nil?
      if current_user.amount_sendable params[:amount]
        Transaction.send_money(current_user.id, params[:receiver_id], params[:amount])
        flash[:success] = "Amount Sent"
        redirect_to '/transactions'
      else
        flash[:error] = 'Not Enough Money'
        redirect_to '/home/index'
      end
    else
      
      flash[:error] = 'please try again'
      redirect_to '/home/index'
    end
  end
end
