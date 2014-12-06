module ApplicationHelper
  def alert_box(content, options = {})
    options[:type] ||= 'info'
    render partial: 'shared/alert_box', locals: {content: content}.merge!(options)
  end
end
