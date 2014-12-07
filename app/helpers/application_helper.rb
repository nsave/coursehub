module ApplicationHelper
  def alert_box(content, options = {})
    options[:type] ||= 'info'
    render partial: 'shared/alert_box', locals: {content: content}.merge!(options)
  end

  def modal_window(id, title, body, button = nil)
    render partial: 'shared/modal',
           locals: {id: id, title: title, body: body, button: button}
  end
end
