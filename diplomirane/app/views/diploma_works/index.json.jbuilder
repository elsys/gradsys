json.array!(@diploma_works) do |diploma_work|
  json.extract! diploma_work, :id, :title, :description, :diploma_supervisor_id, :reviewer_id, :covenanted, :approved
  json.url diploma_work_url(diploma_work, format: :json)
end
