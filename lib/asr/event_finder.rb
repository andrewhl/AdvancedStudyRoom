module ASR

  class EventFinder

    def self.find(args)
      defaults = { ignore_case: true, date: Time.now, tags: [] }
      opts = defaults.merge(args)

      ignore_case = opts[:ignore_case]
      date = opts[:date]
      tags = opts[:tags].collect(&:downcase)
      handles = args[:handles] || []

      event_tag = EventTag.where('LOWER(phrase) IN (?)', tags).first
      return nil unless event_tag

      handle_query = 'accounts.handle'
      if ignore_case
        handle_query = 'LOWER(accounts.handle)'
        handles = handles.collect(&:downcase)
      end

      regs = Registration.joins(:account, :event).where(
        "#{handle_query} IN (?) AND registrations.event_id = ?
         AND DATE(events.starts_at) <= DATE(?) AND DATE(events.ends_at) >= DATE(?)",
        handles, event_tag.event_id, date, date)

      # TODO: this prevents using the same tag for multiple league months
      # TODO: refactor this so that the tags are scoped to an EventPeriod
      regs.count == handles.size ? event_tag.event : nil
    end

  end
end

