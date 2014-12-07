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

  likeOrUnlikeCourse = (e) ->
    $btn = $(e.target)
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