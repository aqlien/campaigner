$ ->
  $("#user-filter").dataTable( {
    "pageLength": 50
    "searching": true
    initComplete: ->
      this.api().setupSearchFields()
  } )


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
    this.column(colIndex).data().unique().sort().each (d, j) ->
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
  if valueArray.indexOf("") != -1
    ".*"
  else if valueArray.indexOf("^$") != -1 && valueArray.length > 1
    valueArray.splice(valueArray.indexOf("^$"), 1)
    counter = 1
    last = valueArray.length
    regex = "^$|^("
    for v in valueArray
      v = v.replace(/[.?*+^$[\]\\(){}|-]/g, "\\$&")
      if counter < last
        regex = regex.concat(v + "|")
      else
        regex = regex.concat(v + ")$")
      counter++
    regex
  else if valueArray.indexOf("^$") != -1
    "^$"
  else
    counter = 1
    last = valueArray.length
    regex = "^("
    for v in valueArray
      v = v.replace(/[.?*+^$[\]\\(){}|-]/g, "\\$&")
      if counter < last
        regex = regex.concat(v + "|")
      else
        regex = regex.concat(v + ")$")
      counter++
    regex
