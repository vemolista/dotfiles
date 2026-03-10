function lt --description "List directory tree using eza"
    set -l level (test (count $argv) -gt 0; and echo $argv[1]; or echo 3)
    eza --classify --recurse --tree --level $level
end
