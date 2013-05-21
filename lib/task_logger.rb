require 'logger'

class TaskLogger < Logger
  include ActionView::Helpers::DateHelper

  DIV_LENGTH = 80

  def initialize(*args)
    @started_at = Time.now
    super(*args)
  end

  def started(title = nil)
    @started_at = Time.now
    wl "\n\n"
    wl divider
    self.title(title) if title.present?
    wl "Started: #{@started_at}"
    wl
  end

  def ended
    wl
    wl "Ended: #{Time.now}"
    wl "Elapsed: #{time_ago_in_words(@started_at, true)}"
    wl divider + "\n"
  end

  def title(title)
    side_len = (DIV_LENGTH - title.size - 6) / 2
    side = '=' * side_len
    title_msg = "#{side}   #{title}   #{side}"
    wl title_msg
    diff = DIV_LENGTH - title_msg.size
    wl('=' * diff) if diff > 0
  end

  def divider
    '#' * DIV_LENGTH
  end

  def w(message)
    self << message
  end

  def wl(message = '')
    self << "#{message}\n"
  end

  def exception(exc)
    wl "\n"
    self.error exc.message
    self.error exc.backtrace.join("\n")
  end

end