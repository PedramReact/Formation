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
  dimension: dealer_name_new {
    type: string
    sql: REPLACE(${dealer_name}, ' ', '_') ;;
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
  dimension: order_date_formating {
    type: date
    sql: ${invoice_date} ;;
    html:{{rendered_value| date:'%A %d %b %y'}}  ;;

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
  type: date
  sql:  ${TABLE}.order_date   ;;
}
  dimension_group: order_date_to_date {
    type: time
    timeframes: [
      date,
      day_of_week,
      month,
      week,
      year
    ]
    datatype: date
    sql: ${order_date} ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
  dimension: name_replace {
    type: string
    case: {
      when: {
        sql: ${fuel_type}="DIESEL" ;;
        label: "GASIOL"
      }
      when: {
        sql: ${fuel_type}="ELECTRIC" ;;
        label: "Electrique"
      }
      when: {
        sql: ${fuel_type}="PETROL" ;;
        label: "Essence"
      }
      when: {
        sql: ${fuel_type}="PETROL CNGGAZ" ;;
        label: "GAZ"
      }
      when: {
        sql: ${fuel_type}="PETROL LPG" ;;
        label: "GAZ"
      }


    }
  }

  dimension: concatenated {
  type: string
  sql: CONCAT(${model}, ' ', ${version}) ;;
}
 dimension: Diff {
  type:number
  sql: date_diff(${invoice_date},${order_date},day) ;;
 }
  dimension: brand_logo {
    type: string
    sql: CASE
         WHEN ${brand} = 'ALPINE' THEN 'https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg'
         WHEN ${brand} = 'DACIA' THEN 'https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg'
         WHEN ${brand} = 'RENAULT' THEN 'https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg'

       END;;
    html: <img src="{{ value }}" style="width: 200px;"/>;;
  }




  measure: count {
    type: count
    drill_fields: [dealer_name]
  }
  measure: count_of_model {
    type: count_distinct
    sql: ${TABLE}.model;;
}
   measure: min_catalogue_price {
    type: min
    value_format: "0.0 €"
    sql: ${catalogue_price} ;;
  }

  measure: max_catalogue_price {
    type: max
    value_format: "0.0 €"
    sql: ${catalogue_price};;
  }
  measure: agv_catalogue_price {
    type: average
    value_format: "0.0 €"
    sql: ${catalogue_price} ;;
  }

  measure: min_diff {
    type: min
    sql: ${Diff} ;;
  }

  measure: max_diff {
    type: max
    sql: ${Diff};;
    html: {% if value > 300.00 %}
    <p style="color: white; background-color: ##FF0000">{{ rendered_value }}</p>{% endif %};;
  }


  measure: avg_diff {
    type: average
    sql: ${Diff} ;;
    html: {% if value < 100 %}
    <span style="color:green;">{{ rendered_value }}</span> {% endif %};;
  }
  }
