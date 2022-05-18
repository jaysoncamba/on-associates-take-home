class Activity < ApplicationRecord
  attr_writer :current_step

  STEP_MAP = {
    basic_info: %i[name],
    address: %i[address],
    duration: %i[starts_at ends_at]
  }
  STEPS = STEP_MAP.keys

  STEP_MAP.each do |step, attributes|
    validates_presence_of *attributes, if: lambda { |obj| obj.current_step == step }
  end

  def current_step
    @current_step ||= STEPS.first
  end

  def next_step
    self.current_step = STEPS[STEPS.index(current_step)+1]
  end

  def previous_step
    self.current_step = STEPS[STEPS.index(current_step)-1]
  end

  def first_step?
    current_step == STEPS.first
  end

  def last_step?
    current_step == STEPS.last
  end

  def all_valid?
    STEPS.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
