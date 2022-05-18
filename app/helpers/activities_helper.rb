module ActivitiesHelper
  def total_steps
    Activity::STEPS.count
  end

  def current_step_index
    Activity::STEPS.index(@activity.current_step)
  end

  def form_submit_button_text
    @activity.last_step? ? 'Save' : 'Next'
  end
end
