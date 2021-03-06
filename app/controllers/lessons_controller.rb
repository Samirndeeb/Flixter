class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
  end

  def create
    @lesson = current_lesson.section.course(lesson_params)
  end

  private

  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_lesson.section.course) == false
      redirect_to course_path, alert: 'Invalid User'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
