view: schema_migrations {
  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }

  measure: count {
    type: count
    drill_fields: [filename]
  }
}
