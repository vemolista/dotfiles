function pullall -d "Recursively run git pull on every git repository in a directory"
    if test (count $argv) -ne 1
        echo "Usage: pullall <directory>" >&2
        return 2
    end

    set -l root $argv[1]

    if not test -d $root
        echo "pullall: '$root' is not a directory" >&2
        return 1
    end

    for git_dir in (find $root -type d -name .git)
        set -l repo (dirname $git_dir)
        echo "==> $repo"
        git -C $repo pull
    end
end
