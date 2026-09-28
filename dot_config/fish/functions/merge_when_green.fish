function merge_when_green --description 'Watch PR checks and squash-merge once they all pass'
    if test (count $argv) -ne 1
        echo "usage: merge_when_green <pr-number>" >&2
        return 2
    end

    set -l pr $argv[1]

    gh pr checks $pr --watch --fail-fast
    or begin
        set -l check_status $status
        echo "merge_when_green: checks failed for PR #$pr, not merging" >&2
        return $check_status
    end

    gh pr merge $pr --squash
end
