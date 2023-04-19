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

  dimension: dealer_name_mod {
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

  dimension: type_de_carburant {
    type: string
    case : {
      when: {
        sql:${fuel_type} = "DIESEL"  ;;
    label:"Gasoil"

    }

  when: {
    sql:${fuel_type}= "ELECTRIC"  ;;
    label:"Electrique"
  }
  when: {
    sql:${fuel_type} = "PETROL"  ;;
    label:"Essence"
  }
  when: {
    sql:${fuel_type} = "PETROL CNGGAZ" OR ${fuel_type} = "PETROL LPG"  ;;
    label:"GAZ"
  }
  else : "Other"
  }
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

  #dimension: Model {
  #  type: string
  #  sql: ${TABLE}.Model ;;
  #}

  measure: count {
    type: count
    drill_fields: [dealer_name]
  }

  measure: count_of_model {
    type: count_distinct
    sql: ${model} ;;
  }
}
