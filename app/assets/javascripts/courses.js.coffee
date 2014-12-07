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
        updateProgress 1

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
        updateProgress(-1)

  # pass +1, -1
  updateProgress = (change) ->
    [$learnt, $total, $percents] = [$('.learnt'), $('.total'), $('.percents')]
    learnt = parseInt $learnt.text(), 10
    total = parseInt $total.text(), 10
    percents = parseInt $percents.css('width'), 10
    if $learnt.length && $total.length && $percents.length
      newValue = learnt + change
      $learnt.text newValue
      $percents.css('width', "#{Math.min(newValue / total * 100, 100)}%")

  $('.mark-as-learnt').on 'click', markAsLearnt
  $('.mark-as-unlearnt').on 'click', markAsUnlearnt