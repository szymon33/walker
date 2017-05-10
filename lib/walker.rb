class Walker < String
  def replace!
    regexp1 = /<object\s+class="BrightcoveExperience\s+video-player">.+
              (<param\s+name="playerID"\s+value="(\d+)">).+<\/object>/ixm
    regexp2 = /<script.+brightcove\..+<\/script>/im

    gsub!(regexp1, 'brightcove-default(\2)')
    gsub!(regexp2, "")
    gsub!(/\s*[\r\n]\s*[\r\n]<\/div>/, "\r\n<\/div>")
    fix_css
  end

  private

  def fix_css
    gsub!(/<div class="video-embed-container">(.+)[\r\n]<\/div>/im, '\1')
    gsub(/-->[\s]*brightcove-default/im, "-->\r\nbrightcove-default")
  end
end

tracker = "<object class=\"BrightcoveExperience video-player\""
counter = 0
Lesson.where("article LIKE ?", "%#{tracker}%").find_each do |lesson|
  article = lesson.article
  next unless article
  article = Walker.new(article).replace!

  if article != lesson.article
    counter = counter + 1
    lesson.update_column(:article, article)
  end
end

puts "#{counter} video embeds converted!"
