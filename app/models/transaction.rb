class Transaction < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  #remove transaction creation from controller
  def self.send_money sender_id, receiver_id, amount
    Transaction.create(sender_id: sender_id, receiver_id: receiver_id, amount: amount)
  end
end
