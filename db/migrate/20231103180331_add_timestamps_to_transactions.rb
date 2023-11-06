class AddTimestampsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :transactions, null: false, default: -> { 'CURRENT_TIMESTAMP'}
  end
end
