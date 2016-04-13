- view: products
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: brand
    type: string
    sql: ${TABLE}.brand

  - dimension: category
    alias: [category_name]
    type: string
    sql: ${TABLE}.category

  - dimension: department
    alias: [department_name]
    type: string
    sql: ${TABLE}.department

  - dimension: item_name
    type: string
    sql: ${TABLE}.item_name

  - dimension: rank
    type: number
    sql: ${TABLE}.rank

  - dimension: retail_price
    type: number
    sql: ${TABLE}.retail_price

  - dimension: sku
    type: string
    sql: ${TABLE}.sku
    
  - dimension: image_file
    sql: (concat('http://www.looker.com/_content/docs/99-hidden/images/image_',${id},'.png'))

  - dimension: product_image
    sql: ${image_file}
    html: <img src="{{ value }}" width="100" height="100"/>    

  - measure: count
    type: count
    drill_fields: [id, item_name, inventory_items.count]

