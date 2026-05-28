if status is-interactive

    # Aliasy
    alias g git
    alias vim nvim
    alias ll "eza -l --icons --git"
    alias la "eza -la --icons --git"
    alias lt "eza --tree --icons --level=2"

    # Edytor domyślny
    set -gx EDITOR nvim

    # Czytelniejszy prompt: pusta linia między outputem komendy a następnym promptem
    set -g tide_prompt_add_newline_before true

    # PATH
    set -gx PATH ~/.local/bin $PATH
    set -gx PATH ~/bin $PATH

    # Funkcje
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd "$cwd"
        end
        rm -f -- "$tmp"
    end

end
