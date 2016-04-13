- view: order_items
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: inventory_item_id
    type: number
    # hidden: true
    sql: ${TABLE}.inventory_item_id

  - dimension: order_id
    type: number
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension_group: returned
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.returned_at

  - dimension: sale_price
    type: number
    sql: ${TABLE}.sale_price
    
  - dimension: gross_margin
    type: number
    sql: ${sale_price} - ${inventory_items.cost}

  - dimension: item_gross_margin_percentage
    type: number
    sql: 100.0 * ${gross_margin}/NULLIF(${sale_price}, 0)

  - dimension: item_gross_margin_percentage_tier
    type: tier
    sql: ${item_gross_margin_percentage}
    tiers: [0,10,20,30,40,50,60,70,80,90]  

  - measure: count
    type: count
    drill_fields: detail*
    
  - measure: total_gross_margin
    type: sum
    sql: ${gross_margin}
    value_format_name: usd
    drill_fields: detail*

  - measure: total_sale_price
    type: sum
    sql: ${sale_price}
    value_format_name: usd
    drill_fields: detail*

  
  - measure: average_sale_price
    type: average
    sql: ${sale_price}
    value_format_name: usd

  - measure: average_gross_margin
    type: average
    sql: ${gross_margin}
    value_format_name: usd
    
    
  sets:
    detail:
      - orders.created_date
      - id
      - orders.id
      - users.name
      - users.history
     

