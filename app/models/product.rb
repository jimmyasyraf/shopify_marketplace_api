class Product < ApplicationRecord
  money_column :price, currency: 'CAD'
end
