- view: users
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: age
    type: number
    sql: ${TABLE}.age
    
  - dimension: age_tier
    type: tier
    style: integer
    sql: ${age}
    tiers: [0,10,20,30,40,50,60,70,80]    

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    hidden: true
    type: string
    sql: ${TABLE}.first_name

  - dimension: gender
    type: string
    sql: ${TABLE}.gender

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.last_name
    
  - dimension: name
    sql: CONCAT(${first_name},' ',${last_name})
    
  - dimension: history
    sql: ${TABLE}.id
    html: |
      <a href="/explore/thelook/orders?fields=orders.detail*&f[users.id]={{ value }}">Orders</a>
      | <a href="/explore/thelook/order_items?fields=order_items.detail*&f[users.id]={{ value }}">Items</a>    

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: zip
    type: number
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - id
    - last_name
    - first_name
    - events.count
    - orders.count
    - user_data.count

