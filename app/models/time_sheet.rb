class TimeSheet < ActiveRecord::Base
  belongs_to :user

  def formatted_clock_in
    format_hour(clock_in)
  end

  def formatted_clock_out
    format_hour(clock_out)
  end

  def get_total_minutes
    if total_minutes.nil?
      tmp_clock_out = clock_out.nil? ? Time.parse(Time.now.strftime('%Y-%m-%d %H:%M:00') + ' UTC') : clock_out
      tmp_total_minutes = (tmp_clock_out - clock_in) / 60
      tmp_total_minutes = tmp_total_minutes.round
    else
      tmp_total_minutes = total_minutes
    end
    tmp_total_minutes
  end

  def total_work_time
    tmp_total_minutes = get_total_minutes

    format_total_work_time(tmp_total_minutes)
  end

  def is_note_editable
    is_editable = true
    if clock_out?
      days = (Time.now - clock_out).to_i / 1.day
      is_editable = (days == 0) # Only allow edit when is the same day
    end
    is_editable
  end

  def self.find_for_today
    TimeSheet.where('clock_in >= ?', Time.now.beginning_of_day)
  end

  private
    def format_hour(work_hour)
      work_hour.nil? ? I18n.t('time_sheets.in_progress') : work_hour.strftime('%H:%M')
    end

    def format_total_work_time(minutes)
      minutes = minutes % 60
      hours = (minutes / 60) % 60

      formatted_total_work_time = (hours > 0) ? ("#{hours} " + I18n.t('time_sheets.hours') + ' ') : ''
      formatted_total_work_time + "#{minutes} " + I18n.t('time_sheets.minutes')
    end
end
