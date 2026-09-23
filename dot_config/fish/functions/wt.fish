function wt --description 'Fuzzy-switch between worktrees of the current repo'
    set -l dir (git worktree list --porcelain 2>/dev/null \
        | awk '/^worktree /{p=substr($0,10)} /^branch /{print p"\t"substr($0,19)} /^detached/{print p"\t(detached)"}' \
        | fzf --delimiter='\t' --with-nth=2,1 \
            --query="$argv" --select-1 --exit-0 \
            --preview 'git -C {1} status -sb --color=always; echo; git -C {1} log --oneline --color=always -15' \
            --preview-window=right,55% \
        | cut -f1)
    test -n "$dir"; and cd $dir
end
