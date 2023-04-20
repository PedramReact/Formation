view: vin_data {
  sql_table_name: `REACT_DEV_DATA.Vin_Data`
    ;;

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: catalogue_price {
    type: number
    sql: ${TABLE}.catalogue_price ;;
  }

  dimension: client_discount {
    type: number
    sql: ${TABLE}.client_discount ;;
  }

  dimension: dealer_name {
    type: string
    sql: ${TABLE}.dealer_name ;;
  }

  dimension: engine {
    type: string
    sql: ${TABLE}.engine ;;
  }

  dimension: fuel_type {
    type: string
    sql: ${TABLE}.fuel_type ;;
  }

  dimension_group: invoice {
    type: time
    group_label: "Date"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.invoice_date ;;
  }

  dimension: marginal_profit {
    type: number
    sql: ${TABLE}.marginal_profit ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }



  dimension: order_date {
    type: string
    sql:  ${TABLE}.order_date   ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  measure: count {
    type: count
    drill_fields: [dealer_name]
  }
  measure: count_sessions {
    type: count_distinct
    sql: ${model} ;;
  }
  dimension: dealer_n {
    type: string
    sql: replace(${TABLE}.dealer_name, ' ', '_') ;;
  }

  dimension: fueltype {

    sql: CASE
         WHEN fuel_type = 'DIESEL' THEN 'Gasoil'
         WHEN fuel_type = 'ELECTRIC' THEN 'Electrique'
         WHEN fuel_type = 'PETROL' THEN 'essence'
         WHEN fuel_type = 'PETROL CNGGAZ' THEN 'Gaz'
         WHEN fuel_type = 'PETROL LPG' THEN 'Gaz'
         ELSE fuel_type
         END ;;
    type: string
  }

  measure: count_by_brand {
    type: count_distinct
    sql: ${TABLE}.brand ;;
    drill_fields: [model, fuel_type, order_date]
  }


  dimension: model_version {
    type: string
    sql: CONCAT(${TABLE}.model, '-', ${TABLE}.version) ;;
  }

  measure: diff_jour {
    type: number
    sql: DATE_DIFF(${invoice_date},${order_date}, DAY);;
  }





  dimension: state_flag_image {
    type: string
    sql: ${brand} ;;
    html:
              {% if brand._value == "ALPINE" %}
              <img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" height="170" width="255">
              {% elsif brand._value == "DACIA" %}
              <img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" height="170" width="255">
              {% elsif brand._value == "RENAULT" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" height="170" width="255">
              {% endif %} ;;
  }

  measure: Min_diff_jour {
    type: number
    sql: min(${diff_jour});;
  }

  measure: Max_diff_jour {
    type: max
    sql: ${diff_jour};;

    html: {% if value > 300 %}<p style="color: white; background-color: ##FF0000">{{ rendered_value }}</p>{% endif %};;
  }

  measure: AVG_diff_jour {
    type: average
    sql: ${diff_jour};;
    html: {% if value < 100 %}<p style="color:green">{{ rendered_value }} </p>{% endif %};;
  }





}
