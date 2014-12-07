module CoursesHelper
  def enroll_button
    link_to 'Enroll in this course', enroll_course_path(@course), method: 'put', class: 'btn btn-primary'
  end

  def course_progress
    [@course.course_items.try(:size) || 0, @progress.try(:items).try(:size) || 0]
  end
end
