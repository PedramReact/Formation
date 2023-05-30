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

  dimension: model {
    type:  string
    sql: ${TABLE}.model ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: order_date{
    type: string
    sql: ${TABLE}.order_date ;;
  }

dimension: invoice_date {
  type: string
  sql: ${TABLE}.invoice_date  ;;
}


  #Formation Looker

# Mise en place d'un count unique
  measure: UniqueModel {
    type: count_distinct
    sql: ${model} ;;
  }

# Mise en place d'une fonction de remplacement
  measure: Dealer_Name_Modifier {
    type: string
    sql: replace(${dealer_name},' ','-') ;;
  }

# Mise en place d'une colonne avec condition
  dimension: Type_Fuel{
  type: string
  sql: CASE
          WHEN ${fuel_type} = 'DIESEL' THEN 'GASOIL'
          WHEN ${fuel_type} = 'ELECTRIC' THEN 'ELECTRIQUE'
          WHEN ${fuel_type} = 'PETROL' THEN 'ESSENCE'
          WHEN ${fuel_type} = 'PETROL CNGGAZ' THEN 'GAZ'
          WHEN ${fuel_type} = 'PETROL LPG' THEN 'GAZ'
          ELSE 'OTHER'
        END;;
}

# Mise en place d'une concaténation
  dimension: ModelConcat {
    type: string
    sql: concat(${model},"--", ${version}) ;;
  }

# Mise en place d'une dimension group avec la granularité (date, jour de la semaine, semaine, mois, années)
# "Day_of_week" montre le 1er jours de la semaine
  dimension_group: granularite_order_date{
    type: time
    timeframes: [date ,day_of_week, week, month, year]
    sql: ${order_date} ;;
  }

# Modification du format de la date 2023-05-25 vers mercredi 25 Mai 2023
dimension: format_invoice_date {
  type: string
  group_label: "Modification de format"
  description: "Modification du format de la date 2023-05-25 vers mercredi 25 Mai 2023"
  sql: format_date('%A %e %b %Y', ${invoice_date}.) ;;
}

# Mise en place de la valeur max de la colonne catalogue_price
measure: max_catalogue_price {
  type:  max
  sql: ${catalogue_price} ;;
  value_format: "0.0€"
  group_label: "Valeur catalogue"
  description: "Mise en place de la valeur max de la colonne catalogue_price"
}

# Mise en place de la valeur min de la colonne catalogue_price
  measure: min_catalogue_price {
    type:  min
    sql: ${catalogue_price} ;;
    value_format: "0.0€"
    group_label: "Valeur catalogue"
  }

# Mise en place de la valeur moyenne de la colonne catalogue_price
  measure: average_catalogue_price {
    type:  average
    sql: ${catalogue_price} ;;
    value_format: "0.0€"
    group_label: "Valeur catalogue"
  }

# Mise en place de la différence de date entre order_date & invoice_date
  dimension: diff_order_invoice_date {
    type: number
    sql: DATE_DIFF(${invoice_date} ,${order_date},day) ;;
  }

  measure: min_diff_order_invoice_date {
    type:  min
    sql: ${diff_order_invoice_date} ;;
    group_label: "Invoice_Date"
  }

  measure: max_diff_order_invoice_date {
    type:  max
    sql: ${diff_order_invoice_date} ;;
    group_label: "Invoice_Date"
    html: {% if value > 300 %}
    <span style="color:red;"> {{rendered_value}}</span>
    {% endif %};;
  }

  measure: average_diff_order_invoice_date {
    type:  average
    group_label: "Invoice_Date"
    sql: ${diff_order_invoice_date} ;;
    html: {% if value < 100 %}
    <span style="color:green;"> {{rendered_value}}</span>
    {% endif %};;
  }

# Mise en place d'une dimension qui affiche le logo brand (about user choice)
dimension:  user_choice_brand{
  type: string
  sql:  CASE
        WHEN ${brand} = 'ALPINE' THEN 'https://fr.wikipedia.org/wiki/Alpine_%28automobile%29#/media/Fichier:Alpine.svg'
        WHEN ${brand} = 'DACIA'   THEN 'https://motorsactu.com/wp-content/uploads/2021/06/NOUVEAU-LOGO-DACIA.jpg'
        WHEN ${brand} = 'RENAULT' THEN 'https://logo-marque.com/wp-content/uploads/2021/04/Renault-Logo-2021-present.jpg'
        END;;
}

}
