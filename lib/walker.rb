class Walker < String
  def replace!
    regexp1 = /<object\s+class="BrightcoveExperience\s+video-player">.+
              (<param\s+name="playerID"\s+value="(\d+)">).+<\/object>/ixm
    regexp2 = /<script.+brightcove\..+<\/script>/im

    gsub!(regexp1, 'brightcove-public(\2)')
    gsub!(regexp2, "")
    gsub!(/\s*[\n]\s*[\n]<\/div>/, "\n<\/div>")
    fix_css
  end

  private

  def fix_css
    gsub(/video-embed-container/, "embed-responsive embed-responsive-16by9")
  end
end

# tracker = "<object class=\"BrightcoveExperience video-player\""
# counter = 0
# Lesson.where("article LIKE ?", "%#{tracker}%").find_each do |lesson|
#   article = lesson.article
#   next unless article
#   article = Walker.new(article).replace!

#   if article != lesson.article
#     counter = counter + 1
#     lesson.update_column(:article, article)
#   end
# end

# puts "#{counter} video embeds converted!"

# l = Lesson.find(3337)
# article = Walker.new(l.article).replace!
# l.update_column(:article, article)
