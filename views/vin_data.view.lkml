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

  dimension: dealer_name_no_space {
    type: string
    sql: REPLACE(${dealer_name}, " ", "_");;

  }

  dimension: engine {
    type: string
    sql: ${TABLE}.engine ;;
  }

  dimension: fuel_type {
    type: string
    sql: ${TABLE}.fuel_type ;;
  }

  dimension: fuel_type_english {
    type: string
    sql: CASE
      when fuel_type = 'DIESEL'  then 'gasoil'
      when fuel_type = "ELECTRIC"  then 'Electrique'
      when fuel_type = 'PETROL'  then 'Essence'
      when fuel_type = 'PETROL CNGGAZ'  then 'GAZ'
      when fuel_type = 'PETROL LPG'  then 'GAZ'
      END;;

  #CONCAT(Campaign, " , " , Campaign Code)
    }
    dimension: concatModelVersion {
      type: string
      sql: CONCAT(${model}, "-",${version});;
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
    datatype: datetime
    sql: ${TABLE}.invoice_date ;;

  }
  dimension: New_date {
    type: date
  sql: ${invoice_date} ;;
  html: {{ rendered_value | date: "%A %d %b %y" }} ;;
  }
  dimension: marginal_profit {
    type: number
    sql: ${TABLE}.marginal_profit ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }



dimension_group: order_date {
  type: time
  group_label: "Order_Date_String_to_Date"
  timeframes: [
    date,
    day_of_week,
    month,
    week,
    year
  ]
  datatype: date
}

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: difference_date {
    type: number
    sql: date_diff( ${invoice_date}, ${order_date_date},day) ;;
  }

  dimension: logo {
    sql: ${brand} ;;
    html:
    {% if value == "RENAULT" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" height="170" width="255"/>
    {% elsif value == "ALPINE" %}
    <img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" height="170" width="255"/>
    {% elsif value == "DACIA"%}
    <img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" height="170" width="255"/>

    {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [dealer_name]
  }
  measure: countDistint {
    type: count_distinct
    sql: ${model} ;;
  }

  measure: min_catalogue_price {
    type: min
    value_format: "0.0€"
    sql: ${catalogue_price} ;;
  }
  measure: max_catalogue_price {
    type: max
    value_format: "0.0€"
    sql: ${catalogue_price} ;;
  }
  measure: average_catalogue_price {
    type: average
    value_format: "0.0€"
    sql: ${catalogue_price} ;;
  }

  measure: min_difference_date {
    type: min
    sql: ${difference_date} ;;
  }

  measure: max_difference_date {
    type: max
    sql: ${difference_date} ;;
    html:
      {% if value > 300 %}
       <span style="color:red;">{{ rendered_value }}</span>
      {% endif %};;

  }
  measure: avg_difference_date {
    type: average
    sql: ${difference_date} ;;
    html:
    {% if value < 100 %}
    <span style="color:green;">{{ rendered_value }}</span>
    {% endif %};;
  }






}
