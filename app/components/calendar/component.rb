module Calendar
  class Component < ApplicationComponent
    def each_viewable_day
      6.days.ago.to_date.upto(Date.current) do |day_offset|
        yield(day_offset)
      end
    end
  end
end
