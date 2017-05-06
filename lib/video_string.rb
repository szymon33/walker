class VideoString < String
  def replace!
    gsub(/brightcove-default\((\w+)\)/i) { brightcove_snippet_default($1) }
  end

  private

  def brightcove_snippet_default(video_id)
    # embed-responsive-item is a Boostrap class dealing with aspect ratio
    <<-HTML
<iframe class="embed-responsive-item"
  src="//players.brightcove.net/1111111111111/HJBxhl1r_default/index.html?videoId=#{video_id}"
  allowfullscreen webkitallowfullscreen mozallowfullscreen>
</iframe>
    HTML
  end
end
