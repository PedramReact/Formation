- dashboard: first_try
  title: First_try
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: Jfs3sUuiebIAW32XW3uYRd
  elements:
  - title: First_try
    name: First_try
    model: foramtion
    explore: vin_data
    type: looker_column
    fields: [vin_data.brand, vin_data.count, vin_data.fueltype]
    filters: {}
    sorts: [vin_data.count desc]
    limit: 500
    column_limit: 50
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: vin_data.count, id: vin_data.count,
            name: Vin Data}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 58, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    label_value_format: ''
    show_dropoff: false
    defaults_version: 1
    listen:
      Brand: vin_data.brand
    row: 0
    col: 0
    width: 24
    height: 12
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
