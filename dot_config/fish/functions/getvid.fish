function getvid
    yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o ~/Downloads/'%(title)s.%(ext)s' $argv
end
