class ContractDetail < ActiveRecord::Base
  belongs_to :contract
  belongs_to :product

  def self.search_details(contract_id)
    if contract_id
      where('contract_id = ? and pending > 0',contract_id)
    else
      all
    end
  end
  
end
