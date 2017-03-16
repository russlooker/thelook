view: user_order_facts {
  derived_table: {
    sql: SELECT
        user_id
        , COUNT(DISTINCT order_id) AS lifetime_orders
        , SUM(sale_price) AS lifetime_revenue
        , MIN(NULLIF(created_at,0)) AS first_order
        , MAX(NULLIF(created_at,0)) AS latest_order
      FROM order_items
      LEFT JOIN orders ON order_items.order_id = orders.id
      GROUP BY user_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: repeat_customer {
    description: "Lifetime Count of Orders > 1"
    type: yesno
    sql: ${lifetime_orders} > 1 ;;
  }

  dimension: lifetime_orders_tier {
    type: tier
    tiers: [
      0,
      1,
      2,
      3,
      5,
      10
    ]
    sql: ${lifetime_orders} ;;
    style: integer
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: lifetime_revenue_tier {
    type: tier
    tiers: [
      0,
      25,
      50,
      100,
      200,
      500,
      1000
    ]
    sql: ${lifetime_revenue} ;;
    style: integer
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_order ;;
  }

  set: detail {
    fields: [user_id, lifetime_orders, lifetime_revenue]
  }
}
