class Walker < String
  def replace!
    regexp1 = /<object\s+class="BrightcoveExperience\s+video-player">.+
              (<param\s+name="playerID"\s+value="(\d+)">).+<\/object>$/ixm
    regexp2 = /<script.+brightcove\..+<\/script>/im

    gsub!(regexp1, 'brightcove-default(\2)')
    gsub(regexp2, '')
  end
end
