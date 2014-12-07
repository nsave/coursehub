module CoursesHelper
  def enroll_button
    link_to 'Enroll in this course', enroll_course_path(@course), method: 'put', class: 'btn btn-primary'
  end
end
