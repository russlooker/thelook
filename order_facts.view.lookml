- view: order_facts
  derived_table:
    sql: |
      SELECT 
                order_items.order_id AS order_id
              , COUNT(*) AS items_in_order
              , SUM(sale_price) AS order_amount
              , SUM(inventory_items.cost) AS order_cost
              , (SELECT COUNT(*)
                  FROM orders o
                  WHERE o.id < orders.id
                  AND o.user_id=orders.user_id) + 1
                   AS order_sequence_number
            FROM order_items AS order_items
            LEFT JOIN orders ON order_items.order_id = orders.id
            LEFT JOIN inventory_items AS inventory_items
              ON order_items.inventory_item_id = inventory_items.id
            GROUP BY 1
            


  fields:


  - dimension: order_id
    primary_key: true
    type: number
    sql: ${TABLE}.order_id

  - dimension: items_in_order
    type: number
    sql: ${TABLE}.items_in_order

  - dimension: order_amount
    type: number
    sql: ${TABLE}.order_amount
    value_format_name: usd

  - dimension: order_cost
    type: number
    sql: ${TABLE}.order_cost
    value_format_name: usd
    
  - dimension: order_profit
    type: number
    sql: ${order_amount} - ${order_cost}
    value_format_name: usd
    
  - dimension: order_sequence_number
    type: number
    sql: ${TABLE}.order_sequence_number
    
  - dimension: is_first_purchase
    type: yesno
    sql: ${order_sequence_number} = 1    
    
  - measure: average_order_profit
    type: avg
    sql: ${order_profit}
    value_format_name: usd
    
  - measure: total_order_profit
    type: sum
    sql: ${order_profit}
    value_format_name: usd    
    
  - measure: first_purchase_count
    type: count
    drill_fields: detail*
    filters:
      is_first_purchase: yes    

  sets:
    detail:
      - order_id
      - items_in_order
      - order_amount
      - order_cost

