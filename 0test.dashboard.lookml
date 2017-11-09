- dashboard: bby_campaign
  title: "Best Buy Campaign Report"
  title: Best Buy
  layout: grid
  tile_size: 100
  height: 100
  show_applied_filters: true
  refresh: 6 hours
  auto_run: true

  rows:
    - elements: [best_buy_table]
      height: 800
    - elements: [reconciliation_text_bby]
      height: 300


  embed_style:
    show_title: false
    show_filters_bar: true
    background_color: "white"
    tile_background_color: "white"

  filters:
    - name: campaign_status
      title: 'Status'
      type: field_filter
      explore: order_items
      field: order_items.id
      default_value: "Live"

    - name: platform
      title: 'Platform'
      type: field_filter
      explore: order_items
      field: order_items.id


  elements:
  - name: best_buy_table
    title: Campaign Performance
    type: table
    height: 10
    width: 14
    model: socialcode
    explore: client_bestbuy_cross_platform_stats
    filters:
      client_bestbuy_cross_platform_stats.brand_id: '4158'
    dimensions: [client_bestbuy_initiative.starcom_campaign_name,
                client_bestbuy_cross_platform_stats.platform,
                client_bestbuy_initiative.campaign_final,
                client_bestbuy_initiative.campaign_status,
                client_bestbuy_initiative.start_date_date,
                client_bestbuy_initiative.end_date_date]

    measures: [client_bestbuy_initiative.pct_campaign_completes,
              client_bestbuy_cross_platform_stats.pct_delivered_impressions,
              client_bestbuy_cross_platform_stats.pct_delivered_budget,
              client_bestbuy_initiative.planned_cpm,
              client_bestbuy_cross_platform_stats.cpm,
              client_bestbuy_cross_platform_stats.pct_cpm_spent,
              client_bestbuy_cross_platform_stats.pct_cpa_spent,
              client_bestbuy_initiative.planned_ctr,
              client_bestbuy_cross_platform_stats.ctr,
              client_bestbuy_initiative.planned_er,
              client_bestbuy_cross_platform_stats.engagement_rate,
              client_bestbuy_initiative.total_media_spend,
              client_bestbuy_cross_platform_stats.total_spend,
              client_bestbuy_cross_platform_stats.remaining_spend,
              client_bestbuy_initiative.total_planned_impressions,
              client_bestbuy_cross_platform_stats.total_impressions,
              client_bestbuy_cross_platform_stats.impressions_left,
              client_bestbuy_cross_platform_stats.total_link_clicks,
              client_bestbuy_cross_platform_stats.total_page_engagement,
              client_bestbuy_initiative.days_campaign_ends_in]

    sorts: [client_bestbuy_initiative.starcom_campaign_name,
                client_bestbuy_cross_platform_stats.platform,
                client_bestbuy_initiative.campaign_final,
                client_bestbuy_initiative.campaign_status,
                client_bestbuy_initiative.start_date_date,
                client_bestbuy_initiative.end_date_date]
    listen:
          campaign_status: client_bestbuy_initiative.campaign_status
          platform: client_bestbuy_cross_platform_stats.platform

    limit: '5000'
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    limit_displayed_rows: false

  - name: reconciliation_text_bby
    title_text: 'Report Notes'
    body_text: '1 - Facebook, Instagram, Twitter, Pinterest and Snapchat data may take up to four days after the reported date to reconcile. Reports include data up through yesterday.

    2 - We present Facebook, Instagram, Twitter and Snapchat data in the timezone connected to the advertising account. Pinterest data is in UTC'


    type: text
