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

  dimension: Dealername{
    type: string
    # Appliquer la fonction replace() pour remplacer l'espace par "-"
    sql: replace(${dealer_name}, ' ', '-') ;;
  }

  dimension: TypeDeCarburant{
    type: string
    case: {
      when: {
        sql: ${TABLE}.fuel_type = 'DIESEL';;
        label: "Diesel"
      }
      when: {
        sql: ${TABLE}.fuel_type = 'ELECTRIC';;
        label: "Electrique"
      }

      when: {
        sql: ${TABLE}.fuel_type = 'PETROL';;
        label: "Essence"
      }

      when: {
        sql: ${TABLE}.fuel_type = 'PETROL CNGGAZ';;
        label: "Gaz"

      }

      when: {
        sql: ${TABLE}.fuel_type = 'PETROL LPG';;
        label: "Gaz"
      }
      else: ""
    }
  }



  measure: countmodel {
    type: count_distinct
    sql: ${model} ;;
  }

  dimension: Brand_Logo {
    type: string
    sql: ${brand};;
    html:
    {% if brand._value == "ALPINE" %}
<img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" height="170" width="255">
 {% elsif brand._value == "DACIA" %}
<img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" height="170" width="255">
{% elsif brand._value == "RENAULT" %}
<img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" height="170" width="255">
{% endif %} ;;

  }
}
