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

  likeOrUnlikeCourse = (e) ->
    $btn = $(e.target).closest('.like-button')
    $likes = $btn.find('.likes-value')
    is_liked = $btn.hasClass('active')
    url = window.location + (if is_liked then '/unlike' else '/like')
    $.ajax(url, { type: 'PUT' })
      .done (res) ->
        if(res.result == 'ok')
          $likes.text(res.likes)
          $btn.toggleClass('active')
        true


  $('.mark-as-learnt').on 'click', markAsLearnt
  $('.mark-as-unlearnt').on 'click', markAsUnlearnt
  $('button.like-button').on 'click', likeOrUnlikeCourse
