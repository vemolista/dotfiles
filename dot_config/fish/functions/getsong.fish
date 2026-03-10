function getsong
    yt-dlp -f bestaudio -o ~/Downloads/'%(title)s.%(ext)s' $argv
end
