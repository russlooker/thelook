- view: inventory_items
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: cost
    type: number
    sql: ${TABLE}.cost

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: product_id
    type: number
    hidden: true
    sql: ${TABLE}.product_id

  - dimension_group: sold
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.sold_at
    
  - dimension: is_sold  
    type: yesno
    sql: ${sold_raw} is not null
    
  - dimension: days_in_inventory
    type: number
    sql: DATEDIFF(coalesce(${sold_date},curdate()), ${created_date})

  - dimension: days_in_inventory_tier
    type: tier
    sql: ${days_in_inventory}
    tiers: [0,5,10,20,40,80,160,365]    

  - measure: count
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
    
  - measure: sold_count
    type: count
    drill_fields: detail
    filters:
      is_sold: Yes

  - measure: percent_sold
    type: number
    sql: 100.0 * ${sold_count}/${count}

  - measure: total_cost
    type: sum
    sql: ${cost}

  - measure: average_cost
    type: average
    sql: ${cost}

  - measure: average_days_in_inventory
    type: average
    sql: ${days_in_inventory}    

