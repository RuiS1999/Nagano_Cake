class CreateOrderGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :order_goods do |t|

      t.timestamps

      t.integer   :order_id,          null: false
      t.integer   :item_id,           null: false
      t.integer   :amount,            null: false
      t.integer   :price_in,          null: false
      t.integer   :making_status,     null: false, default: 0

    end
  end
end
