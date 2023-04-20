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

  dimension: DealerNameModifier {
    type: string
    sql: replace(${dealer_name}," ", "_") ;;
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

  dimension: Type_de_carburant  {
    type: string
    case: {
      when: {
        sql:  ${fuel_type} = 'DIESEL' ;;
        label: "Gasoil"
      }
      when: {
        sql:  ${fuel_type} = 'ELECTRIC' ;;
        label: "Electrique"
      }
      when: {
        sql:  ${fuel_type} = 'PETROL' ;;
        label: "Essence"
      }
      when: {
        sql:  ${fuel_type} = 'PETROL CNGGAZ' or ${fuel_type} = 'PETROL LPG';;
        label: "GAZ"
      }
      else: "Other"
    }
  }

  dimension: Concat_Model_Version {
    type: string
    sql:concat(${model},"_",${version});;
  }

  dimension_group: Order_Date_String_to_Date {
    type: time
    timeframes: [date, day_of_week, week,month, year]
    datatype: date
    sql: ${order_date};;
  }

  dimension: invoice_date2 { #Le type change pour devenir au format string via le format_date
    type: string
    sql:format_date("%A %d %b %y",${invoice_date});;
  }

  dimension: invoice_date3 {  #Le type reste le même que la dimension ${invoice_date}
    sql: ${invoice_date} ;;
    html: {{ rendered_value | date: "%A %d %b %y" }} ;;
  }

  dimension: diff_date {
    type: number
    sql: DATE_DIFF(${invoice_date}, ${order_date}, DAY);;
  }

  dimension: brand_choice_user {
    type: string
    sql: ${brand};;
    html: {% if brand._value == "ALPINE" %}
    <img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" height="170" width="255">
    {% elsif brand._value == "RENAULT" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" height="170" width="255"
    {% elsif brand._value == "DACIA" %}
    <img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" height="170" width="255" >
    {% endif %} ;;
  }

  measure: diff_date_max {
    type: max
    sql: ${diff_date};;
  }

  measure: diff_date_min {
    type: min
    sql: ${diff_date};;
  }

  measure: diff_date_average {
    type: average
    sql: ${diff_date};;
  }

  measure: catalogue_price_max {
    type: max
    sql: ${catalogue_price};;
    value_format: "0.0€"
  }

  measure: catalogue_price_min {
    type: min
    sql: ${catalogue_price};;
    value_format: "0.0€"
  }

  measure: catalogue_price_average {
    type: average
    sql: ${catalogue_price};;
    value_format: "0.0€"
  }

  measure: count {
    type: count
    drill_fields: [dealer_name]
  }

  measure: CountModel{
    type:  count_distinct
    sql: ${model} ;;
  }
}
