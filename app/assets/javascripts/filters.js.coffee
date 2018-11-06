$(document).on 'turbolinks:load', ->
  column_data = $("#user-filter").find("thead tr:first th").toArray().map (element) ->
    {data: $(element).data('key')}

  column_data.forEach (column_definition) ->
    if column_definition['data'] == 'name'
      column_definition['orderDataType'] = 'name-list'

  $("#user-filter").dataTable( {
    ajax: $("#user-filter").data('source'),
    sAjaxDataProp: "data",
    autoWidth: false,
    columns: column_data,
    pageLength: 50,
    searching: true,
    
    initComplete: ->
      $(this).setupUserColumns()
      this.api().setupSearchFields()
      columns_to_show = this.api().columns($('.base_column, .outreach_column, .tag_column'))
      this.api().columns().visible(false, false)
      columns_to_show.visible(true, false)

    drawCallback: ->
      $(this).redrawUsersColumns()
  } )

#sort name column by last name. Names are assumed to be separated by spaces, and the final section of the string is considered the last name.
$.fn.dataTable.ext.order['name-list'] = ( settings, col ) ->
  this.api().column( col, {order:'index'} ).nodes().map ( td, i ) ->
    ($(td).text().trim().match(/\S*$/) || [])[0]

# Setting up search fields requires the table to have a footer
# or a second header row with the id '#column_input'
$.fn.dataTable.Api.register('setupSearchFields', ->
  api = this
  api.columns($('.text_searchable')).eq(0).each (colIndex) ->
    title = $(this.column(colIndex).header()).text().replace(/\W/, '').toLowerCase();
    tableID = $(api.table().node()).attr('id')
    input = $('<input/>', {
      id: 'search_'+tableID+'_'+colIndex.toString(),
      class: "form-control input-sm datatable-search",
      type: "text",
      placeholder: "Search",
      style: "width: 100%;"
    })
    input.css("height", "31px")
    input.on 'click', (e) ->
      # Prevent clicking on the search field from also triggering column ordering
      e.stopPropagation();
    input.on('keyup change', ->
      api.column( colIndex ).search(this.value).draw();
    );
    $(this.column(colIndex).footer()).html(input)
    $('#column_input th').eq($(this.column(colIndex).header()).index()).html(input)

  api.columns($('.select_searchable')).eq(0).each (colIndex) ->
    title = $(this.column(colIndex).header()).text().replace(/\W/, '').toLowerCase();
    tableID = $(api.table().node()).attr('id')
    input = $('<select/>',{
      id: 'search_'+tableID+'_'+colIndex.toString(),
      class: "form-control input-sm",
      style: "width: 100%;"
    })
    input.css("height", "31px")
    input.append("<option value=''>(All)</option>")
    input.append("<option value='^.+$'>(Any)</option>")
    input.append("<option value='^$'>(Blank)</option>")
    input.on 'click', (e) ->
      # Prevent clicking on the search field from also triggering column ordering
      e.stopPropagation();
    input.on('change', () ->
      val = $(this).val()
      if val != ''
        val = "^" + val + "$"
      api.column( colIndex ).search(val, true, false).draw();
    );
    $(this.column(colIndex).footer()).html(input)
    $('#column_input th').eq($(this.column(colIndex).header()).index()).html(input)
    this.column(colIndex).data().unique().sort().each (d, j) ->
      if d
        $('#search_'+tableID+'_'+colIndex.toString()).append('<option value="'+d+'">'+d+'</option>')

  api.columns($('.multi_select_searchable')).eq(0).each (colIndex) ->
    title = $(this.column(colIndex).header()).text().replace(/\W/, '').toLowerCase();
    tableID = $(api.table().node()).attr('id')
    input = $('<select/>',{
      id: 'search_'+tableID+'_'+colIndex.toString(),
      class: "form-control input-sm",
      style: "width: 100%;"
    })
    input.attr('multiple', true)
    input.append("<option value='^.+$'>(Any)</option>")
    input.append("<option value='^$'>(Blank)</option>")
    input.on 'click', (e) ->
      # Prevent clicking on the search field from also triggering column ordering
      e.stopPropagation();
    input.on('change', () ->
      val = $(this).val()
      regex = regexifyMultiSelect(val)
      api.column( colIndex ).search(regex, true, false).draw();
    );
    $(this.column(colIndex).footer()).html(input)
    $('#column_input th').eq($(this.column(colIndex).header()).index()).html(input)

    unprocessed_options_list = this.column(colIndex).data().unique()
    processed_options_list = []
    unprocessed_options_list.sort().each (d, j) ->
      if d && d not in processed_options_list
        option_sublist = d.split('; ');
        option_sublist.forEach (d, j) ->
          if d && d not in processed_options_list
            processed_options_list.push d
    processed_options_list.sort().forEach (d, j) ->
      if d
        $('#search_'+tableID+'_'+colIndex.toString()).append('<option value="'+d+'">'+d+'</option>')

    input.multiselect({
      includeSelectAllOption: true
      selectAllText: "(All)"
      selectAllValue: ""
      buttonWidth: "120px"
      buttonText: (options, select) ->
        if options.length == 0
          "(All)"
        else if options.length > 1
          options.length + " selected"
        else
          labels = []
          options.each ->
            if $(this).attr('label') != undefined
              labels.push $(this).attr('label')
            else
              labels.push $(this).html()
            return
          labels.join(', ') + ''
    })
)

regexifyMultiSelect = (valueArray) ->
  console.log(valueArray)
  if valueArray == null
    ".*"
  else if valueArray.indexOf("") != -1
    ".*"
  else if valueArray.indexOf("^$") != -1 && valueArray.length > 1
    valueArray.splice(valueArray.indexOf("^$"), 1)
    counter = 1
    last = valueArray.length
    regex = "^$|("
    for v in valueArray
      v = v.replace(/[.?*+^$[\]\\(){}|-]/g, "\\$&")
      if counter < last
        regex = regex.concat(v + ".*") # use .* to match all and | to match any
      else
        regex = regex.concat(v + ")")
      counter++
    regex
  else if valueArray.indexOf("^$") != -1
    "^$"
  else if valueArray.indexOf("^.+$") != -1
    "^.+$"
  else
    counter = 1
    last = valueArray.length
    # regex = "^(" # Only match from start of line
    regex = "("
    for v in valueArray
      v = v.replace(/[.?*+^$[\]\\(){}|-]/g, "\\$&")
      if counter < last
        regex = regex.concat(v + ".*") # use .* to match all and | to match any
      else
        # regex = regex.concat(v + ")$") # Only match to end of line
        regex = regex.concat(v + ")")
      counter++
    regex


# Checkboxes for table rows
$.fn.extend
  setupUserColumns: ->
    tableHandle = this.DataTable()
    convertDatabaseIdsToCheckboxes(tableHandle)
    addUserDataAttributesToTrs(tableHandle)
    addSearchableClasses(tableHandle)
    hideColumns(tableHandle)

  selectDatatableCheckboxes: ->
    return @each () ->
      $this = $(this)
      $this.on 'click', (e) ->
        tableHandle = $($this.data('select-table')).DataTable()
        targets = $($this.data('select-checkboxes'), tableHandle.$('tr', { "filter": "applied" }))
        if $this.prop("checked") == true
          targets.prop('checked', true)
        else
          targets.prop('checked', false)

  selectedRowIds: ->
    $this = $(this)
    tableHandle = $this.DataTable()
    checkedRowInputs = $('input.select-row-checkbox:checked', tableHandle.$('tr', { "filter": "applied" }))
    return (item.value for item in checkedRowInputs.serializeArray())

  sendSelectedIDs: ->
    return @each () ->
      $this = $(this)
      $table = $($this.data("table-ids"))
      if ($table)
        $this.on 'click', (e) ->
          e.preventDefault();
        $this.on 'ajax:beforeSend', (event, jqXHR, settings) ->
          selected_ids = $table.selectedRowIds()
          if settings.url.match(/\?.*$/)
            settings.url = settings.url + '&selected_ids=' + selected_ids
          else
            settings.url = settings.url + '?selected_ids=' + selected_ids

  submitWithSelectedIDs: ->
    return @each () ->
      $this = $(this)
      $this.on 'click', (e) ->
        e.preventDefault()
        $link = $(this)
        $table = $($link.data("ids-selected"))
        if ($table)
          selected_ids = $table.selectedRowIds()
          $.ajax
            url:  $link.attr("href"),
            dataType: 'json',
            data: { selected_ids: selected_ids },
            type: 'POST',
            success: (response) ->
              window.location.reload()

  redrawUsersColumns: ->
    tableHandle = this.DataTable()
    hideColumns(tableHandle)

addSearchableClasses = (table) ->
  $.each table.columns().nodes(), (index) ->
    if index > 1
      columnType = $(table.column(index).header()).data('column-type')
      dataType = $(table.column(index).header()).data('data-type')
      $(this).addClass(columnType)
      $(this).addClass(dataType)

addUserDataAttributesToTrs = (table) ->
  $.each table.rows().nodes(), ->
    $(this).attr('data-user-id', $(this).children().eq(0).data('database-id'))

convertDatabaseIdsToCheckboxes = (table) ->
  input = $("<input type='checkbox'/>").addClass('select-row-checkbox').attr('name', 'user_ids[]')
  table.columns(0).nodes().to$().addClass('base_column')
  $.each table.column(0).nodes(), ->
    element = $(this)
    value = element.text()
    input.val(value)
    element.attr('data-database-id', value).html(input.clone())

hideColumns = (table) ->
  allColumns = table.columns().indexes()
  for c in allColumns
    if $(table.column(c).header()).data('permitted') is undefined
      table.column(c).visible(false)

$(document).on 'ready turbolinks:load', ->
  # Use checkboxes for selections and links to submit
  $("input[data-select-checkboxes]").selectDatatableCheckboxes()
  $("a[data-table-ids]").sendSelectedIDs()
  $("a[data-ids-selected]").submitWithSelectedIDs()

  # Use buttons to toggle visibility of DataTable columns by column class
  $('a[data-toggle-table]').on 'click', (e) ->
    e.preventDefault();
    $this = $(this)
    $this.tab('show')
    $table = $( $this.data("toggle-table") )
    tableHandle = $table.DataTable()
    tableHandle.columns().visible(false, false)
    tableHandle.columns($this.data("toggle-show")).visible(true, false)
    tableHandle.columns.adjust().draw( false )
