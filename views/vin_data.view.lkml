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



}
