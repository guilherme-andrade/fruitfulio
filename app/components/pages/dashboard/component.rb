module Pages
  module Dashboard
    class Component < ApplicationComponent
      def current_day
        @current_day ||= Date.today
      end
    end
  end
end
