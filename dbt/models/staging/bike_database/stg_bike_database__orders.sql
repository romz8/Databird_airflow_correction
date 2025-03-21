select order_id, 
  customer_id,
  order_status,
  order_date,
  required_date,
  case when shipped_date = 'NULL' THEN null else shipped_date end as shipped_date,
  store_id,
  staff_id
from {{ source('bike_database', 'orders') }}