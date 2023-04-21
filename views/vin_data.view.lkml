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

  dimension_group: order_date_string_to_date{
    type: time
    timeframes: [
      date,
      day_of_week,
      week,
      month,
      year
    ]
    convert_tz: no
    datatype: date
    sql:${order_date} ;;


  }
  dimension: date_formatted {
    group_label: "Date"
    label: "Date"
    sql: ${invoice_date};;
    html: {{ rendered_value | date: "%A %d %h %y" }};;
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
  measure: min_catalogue_price{
    type:  min
    sql: ${catalogue_price};;
    value_format:"0.0€"
  }
  measure: max_catalogue_price{
    type:  max
    sql: ${catalogue_price};;
    value_format:"0.0€"
  }
  measure: avg_catalogue_price{
    type:  average
    sql: ${catalogue_price};;
    value_format:"0.0€"
  }

  dimension: type_de_carburant{
    sql: case
          when  ${TABLE}.fuel_type='DIESEL'then "Gasoil"
          when  ${TABLE}.fuel_type='ELECTRIC'then "Electrique"
          when  ${TABLE}.fuel_type='PETROL'then "Essance"
          when  ${TABLE}.fuel_type='PETROL CNGGAZ' or  ${TABLE}.fuel_type='PETROL LPG' then "GAZ"
          else "inconuu"
          end
          ;;

  }




  dimension: type_de_carburantLookml{
    case :{
      when:{
        sql: ${TABLE}.fuel_type='DIESEL';;
        label: "Gasoil"
      }
      when:{
        sql: ${TABLE}.fuel_type='ELECTRIC';;
        label: "Electrique"
      }
      when:{
        sql: ${TABLE}.fuel_type='PETROL';;
        label: "Essance"
      }

      when:{
        sql: ${TABLE}.fuel_type='PETROL CNGGAZ' or ${TABLE}.fuel_type='PETROL LPG'  ;;
        label: "GAZ"
      }


    }

  }




  dimension: Concat_Model_Version {
    type: string
    sql: concat(${model},'-',${version}) ;;
    drill_fields: [brand, model, version, catalogue_price]
  }

  dimension: Brand_Logo {
    type: string
    sql: ${brand};;
    html:
              {%  if brand._value == "ALPINE" %}
              <img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" height="170" width="255">
              {% elsif  brand._value == "DACIA" %}
              <img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" height="170" width="255">
              {% elsif brand._value == "RENAULT" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" height="170" width="255">
              {%  endif %} ;;
  }

  measure: datedif{
    sql:date_diff(${vin_data.invoice_date},${vin_data.order_date_string_to_date_date},day) ;;
  }

  measure: countModel {
    type: count_distinct
    sql: ${model} ;;
  }

  dimension: dealerNameModifier {
    type: string
    sql:  replace(${dealer_name}," ", "_");;


  }









}
