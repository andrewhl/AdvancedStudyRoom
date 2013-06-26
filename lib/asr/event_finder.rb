module ASR

  class EventFinder

    def self.find(args)
      tags = args[:tags]
      handles = args[:handles]
      date = args[:date]

      # that has an eventtag in tags
      event_tag = EventTag.where('LOWER(phrase) IN ?', tags).first
      return nil unless event_tag

      regs = Registration.joins(:account, :event).where(
        'LOWER(accounts.handle) IN ? AND registrations.event_id = ? AND events.starts_at <= ? AND events.ends_at >= ?',
        handles, event_id, date, date )

      regs.count == handles.size ? event_tag.event : nil

      # TODO: this prevents using the same tag for multiple league months
      # TODO: refactor this so that the tags are scoped to an EventPeriod

    end
  end
end

