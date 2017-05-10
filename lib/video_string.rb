class VideoString < String
  def replace!
    gsub(/brightcove-(\w+)\((\w+)\)/i) { brightcove_snippet_default($1, $2) }
  end

  private

  def brightcove_snippet_default(player_id, video_id)
    # embed-responsive-item is a Boostrap class dealing with aspect ratio
    <<-HTML
<iframe class="embed-responsive-item"
  src="//players.brightcove.net/1111111111111/#{player_id}_default/index.html?videoId=#{video_id}"
  allowfullscreen webkitallowfullscreen mozallowfullscreen>
</iframe>
    HTML
  end
end
