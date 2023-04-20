- dashboard: third
  title: third
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: xFi90DDQCj3oaSinTr8Pon
  elements:
  - title: FIRST
    name: FIRST
    model: foramtion
    explore: vin_data
    type: looker_column
    fields: [vin_data.brand, vin_data.fueltype, vin_data.count]
    filters: {}
    sorts: [vin_data.count desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: vin_data.count, id: vin_data.count,
            name: Vin Data Count}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 29, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    series_types: {}
    series_colors:
      vin_data.count: "#1A73E8"
    reference_lines: [{reference_type: line, line_value: max, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000"}, {reference_type: line, line_value: mean, range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: center, color: "#12B5CB", value_format: ''}, {reference_type: line,
        line_value: min, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000"}]
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    listen:
      Brand: vin_data.brand
    row: 0
    col: 0
    width: 24
    height: 12
  - title: SECOND
    name: SECOND
    model: foramtion
    explore: vin_data
    type: looker_grid
    fields: [vin_data.brand, vin_data.fueltype, vin_data.count, vin_data.invoice_month]
    pivots: [vin_data.invoice_month]
    fill_fields: [vin_data.invoice_month]
    filters:
      vin_data.invoice_month: '2019'
    sorts: [vin_data.invoice_month, vin_data.count desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_pivots: {}
    listen:
      Brand: vin_data.brand
    row: 12
    col: 0
    width: 8
    height: 6
  - title: THIRD
    name: THIRD
    model: foramtion
    explore: vin_data
    type: looker_pie
    fields: [vin_data.count, vin_data.fuel_type]
    filters: {}
    sorts: [vin_data.count desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    inner_radius: 0
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 1
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_null_points: true
    interpolation: linear
    listen:
      Brand: vin_data.brand
    row: 12
    col: 8
    width: 8
    height: 6
  filters:
  - name: Brand
    title: Brand
    type: field_filter
    default_value: RENAULT
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: foramtion
    explore: vin_data
    listens_to_filters: []
    field: vin_data.brand
