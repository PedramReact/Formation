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

  measure: min_catalogue_price {
    type: min
    sql: ${TABLE}.catalogue_price ;;
  }

  measure: max_catalogue_price {
      type: max
      sql: ${TABLE}.catalogue_price ;;
    }

  measure: avg_catalogue_price {
      type: average
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

  # Modifier la colonne Dealer par lookml pour avoir « - »
  # à la place de «   » par les deux solution Lookml et custom fields.

  dimension: dealer_name_underscore {
    type: string
    sql: replace(${dealer_name}, " ", "_") ;;
  }

  dimension: engine {
    type: string
    sql: ${TABLE}.engine ;;
  }

  dimension: fuel_type {
    type: string
    sql: ${TABLE}.fuel_type ;;
  }

  # Création d’une nouvel colonne base sur Fuel Type et remplacer :
  # DIESEL par Gasoil
  # ELECTRIC par Electrique
  # PETROL par Essence
  # PETROL CNGGAZ et PETROL LPG par GAZ

  dimension: fuel_type_new {
    type: string
    case: {
      when: {
        sql: ${fuel_type} = "DIESEL" ;;
        label: "Gasoil"
      }
      when: {
        sql: ${fuel_type} = "ELECTRIC" ;;
        label: "Electrique"
      }
      when: {
        sql: ${fuel_type} = "PETROL" ;;
        label: "Essence"
      }
      when: {
        sql: ${fuel_type} = "PETROL CNGGAZ" ;;
        label: "Gaz"
      }
      when: {
        sql: ${fuel_type} = "PETROL LPG" ;;
        label: "Gaz"
      }
      # possibly more when statements
      else: "TBDF"
    }
  }

  #Concaténation de colonne model avec version par
  # les deux solution de lookml et custom fields

  dimension: model_version {
    type:  string
    sql:  concat(${model},"-", ${version}) ;;
  }

# Modifier la colonne invoice_date
# pour pouvoir afficher sous le forme suivent:

  dimension_group: invoice_2 {
    hidden:  yes
    type: time
    sql: ${invoice_date} ;;
    html:{{ rendered_value | date: "%A, %B %e, %Y" }};;
  }

  dimension_group: invoice {
    type: time
    group_label: "Invoice Date"
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

  dimension: order_date_old {
    type: string
    sql:  ${TABLE}.order_date   ;;
  }

  dimension_group: order_date {
    type: time
    group_label: "Order Date"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: yes
    datatype: date
    sql: ${TABLE}.order_date ;;
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

  measure: count_distinct_model {
    type: count_distinct
    sql: ${model};;
  }

  # Nombre de jour entre Order_Date et Invoice_Date

  dimension: diff_date_order_invoice {
    type:  number
    sql: date_diff(${invoice_date}, ${order_date_date}, DAY) ;;
  }

  # Min Nombre de jour entre Order_Date et Invoice_Date

  measure: min_diff_date_order_invoice {
    type: min
    sql:  ${diff_date_order_invoice} ;;
  }

  # Max Nombre de jour entre Order_Date et Invoice_Date

  measure: max_diff_date_order_invoice {
    type: max
    sql:  ${diff_date_order_invoice} ;;
    html:
      {% if value > 300 %}
      <font color="darkred">{{ rendered_value }}</font>
      {% else %}
      {{ rendered_value }}
      {% endif %} ;;
  }

  # Moyenne Nombre de jour entre Order_Date et Invoice_Date

  measure: avg_diff_date_order_invoice {
    type: average
    sql:  ${diff_date_order_invoice} ;;
    html:
      {% if value < 100 %}
      <font color="darkgreen">{{ rendered_value }}</font>
      {% else %}
      {{ rendered_value }}
      {% endif %} ;;
  }

  # Créer une dimension dans lookml qui affiche logo
  # de brand par rapport le choix d’utilisateur

  dimension: logo {
    type: string
    sql:  ${brand} ;;
    html:
    {% if brand._value == "ALPINE" %}
    <img src="https://www.retro-laser.com/wp-content/uploads/2021/12/2021-12-13-at-08-17-16.jpg" width="100" height="100"/>
    {% elsif brand._value == "DACIA" %}
    <img src="https://upload.wikimedia.org/wikipedia/fr/4/4d/Logo_Dacia.svg" width="100" height="100"/>
    {% elsif brand._value == "RENAULT" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Renault_2009_logo.svg" width="100" height="100"/>
    {% else %}
    {{ rendered_value }}
    {% endif %};;

  }

}
