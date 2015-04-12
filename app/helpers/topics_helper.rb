module TopicsHelper

  def merge_topic_filters(params, option)
    filters = params.slice(:sort, :order, :cate)
    filters.merge(option)
  end
end
