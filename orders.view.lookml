- view: orders
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month, month_num, year, day_of_week_index, hour_of_day, minute5]
    sql: ${TABLE}.created_at

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: user_id
    type: number
    # hidden: true
    sql: ${TABLE}.user_id
    html: |
     {% if subtraction._value > 1.1  %}
     <div style="text-align:center; background-color:red;">{{ rendered_value }}</div>
     {% endif %}

  - measure: count
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]

  - dimension: subtraction
    type: number
    sql: 5-3
  
  
