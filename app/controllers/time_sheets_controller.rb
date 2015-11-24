class TimeSheetsController < ApplicationController
  layout 'admin', except: [:view_note]
  before_action :require_user

  def index
    @time_sheet = TimeSheet.where({user_id: current_user.id, clock_out: nil}).last
    if @time_sheet.nil?
      @time_sheet = TimeSheet.new
    end

    @time_sheets = TimeSheet.find_for_today
    @formatted_total_work_time = format_total_work_time(total_minutes(@time_sheets))
  end

  def log
    time_sheet = TimeSheet.where({user_id: current_user.id, clock_out: nil}).last
    if time_sheet.nil?
      time_sheet = TimeSheet.new
      time_sheet.clock_in = Time.now.strftime('%Y-%m-%d %H:%M')
      time_sheet.user = current_user
    else
      time_sheet.clock_out = Time.now.strftime('%Y-%m-%d %H:%M')
      time_sheet.total_minutes = (time_sheet.clock_out - time_sheet.clock_in) / 60
      time_sheet.work_report = params[:work_report]
      time_sheet.report_date = Time.now
    end

    is_clock_in = params[:is_clock_in] == 'true'
    need_redirect = is_clock_in ? time_sheet.id? : !time_sheet.id?

    if need_redirect
      flash[:error] = is_clock_in ? t('time_sheets.errors.clock_in') : t('time_sheets.errors.clock_out')
      render nothing: true, status: :unauthorized
    else
      time_sheet.ip_address = request.remote_ip
      time_sheet.save

      @time_sheets = TimeSheet.find_for_today
      @formatted_total_work_time = format_total_work_time(total_minutes(@time_sheets))
      render '_time_sheet', layout: false
    end
  end

  def view_note
    @time_sheet = TimeSheet.where({id: params[:id], user_id: current_user.id}).first
    render 'note', layout: false
  end

  def edit_note
    @time_sheet = TimeSheet.where({id: params[:id], user_id: current_user.id}).first
    render 'edit_note', layout: false
  end

  def update_note
    time_sheet = TimeSheet.where({id: params[:id], user_id: current_user.id}).first
    if time_sheet.nil?
      flash[:error] = t('errors.unauthorized').html_safe
      render json: {success: false}, status: :unauthorized
    else
      is_note_editable = time_sheet.is_note_editable
      if is_note_editable
        time_sheet.update({work_report: params[:time_sheet][:work_report]})
        message = t('time_sheets.messages.updated_note')
      else
        message = t('time_sheets.errors.edit_note')
      end

      render json: {success: is_note_editable, message: message}
    end
  end

  private
    def total_minutes(time_sheets)
      total_minutes = 0
      time_sheets.each do |time_sheet|
        total_minutes += time_sheet.get_total_minutes
      end
      total_minutes
    end

    def format_total_work_time(minutes)
      minutes = minutes % 60
      hours = (minutes / 60) % 60

      formatted_total_work_time = (hours > 0) ? ("#{hours} " + I18n.t('time_sheets.hours') + ' ') : ''
      formatted_total_work_time + "#{minutes} " + I18n.t('time_sheets.minutes')
    end
end
