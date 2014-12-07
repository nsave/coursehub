$ ->
  markAsLearnt = (event) ->
    $checkbox = $(event.target)
    course = $checkbox.data 'course'
    item = $checkbox.data 'item'
    if course && item
      $.ajax("/courses/#{course}/items/#{item}/learn", { type: 'PUT' })
      .done ->
        $checkbox.removeClass('glyphicon-unchecked')
        .addClass('glyphicon-check')
        .off('click')
        .on('click', markAsUnlearnt)

  markAsUnlearnt = (event) ->
    $checkbox = $(event.target)
    course = $checkbox.data 'course'
    item = $checkbox.data 'item'
    if course && item
      $.ajax("/courses/#{course}/items/#{item}/unlearn", { type: 'PUT' })
      .done ->
        $checkbox.removeClass('glyphicon-check')
        .addClass('glyphicon-unchecked')
        .off('click')
        .on('click', markAsLearnt)

  $('.mark-as-learnt').on 'click', markAsLearnt
  $('.mark-as-unlearnt').on 'click', markAsUnlearnt