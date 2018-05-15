class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sender_transactions, class_name: "Transaction", foreign_key: "sender_id"
  has_many :recevied_transactions, class_name: "Transaction", foreign_key: "receiver_id"
  after_save :add_money

  #removing bussiness logic from the controller 

  #used to seed the money for the new user
  def add_money
    Transaction.create(sender_id: nil, receiver_id: self.id, amount: 10000)
  end

  #get avaible money that can be transfered by current_user
  def get_available_money
    self.recevied_transactions.sum(:amount) - self.sender_transactions.sum(:amount)  
    # binding.pry
  end

  # can user send x amount of money 
  def amount_sendable sending_amount
    amount_available = self.get_available_money
    if amount_available > sending_amount.to_i 
      true
    else
      false
    end
  end
end
