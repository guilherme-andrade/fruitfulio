# frozen_string_literal: true

class Layouts::Dashboard::Component < ApplicationComponent
  renders_one :navigation, Navigation::Default::Component
end
