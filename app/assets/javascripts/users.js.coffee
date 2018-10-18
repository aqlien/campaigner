$(document).on 'ready turbolinks:load', ->
  $(".hidden").hide()
  $('#pronoun-select').on 'change', (e) ->
    e.preventDefault();
    $this = $(this)
    customPronounSection = $('#custom-pronoun-div')
    customPronounInput = $('#pronoun-custom')
    selectedText = $this.children('option:selected').text()
    if selectedText == 'Other'
      customPronounSection.show()
    else
      customPronounInput.val('')
      customPronounSection.hide()
