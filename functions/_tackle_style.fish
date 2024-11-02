function _tackle_style
    # Reference:
    # https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#colors--graphics-mode

    argparse 'f/foreground=?' 'b/background=?' \
        B/bold d/dim i/italic u/underline k/blinking r/reverse v/invisible s/strikethrough \
        h/help -- $argv

    echo -nes "\e[0"

    if set -q _flag_bold
        echo -nes ";1"
    end
    if set -q _flag_dim
        echo -nes ";2"
    end
    if set -q _flag_italic
        echo -nes ";3"
    end
    if set -q _flag_underline
        echo -nes ";4"
    end
    if set -q _flag_blinking
        echo -nes ";5"
    end
    if set -q _flag_reverse
        echo -nes ";7"
    end
    if set -q _flag_invisible
        echo -nes ";8"
    end
    if set -q _flag_strikethrough
        echo -nes ";9"
    end

    switch $_flag_foreground
        case black
            echo -nes ";30"
        case red
            echo -nes ";31"
        case green
            echo -nes ";32"
        case yellow
            echo -nes ";33"
        case blue
            echo -nes ";34"
        case magenta
            echo -nes ";35"
        case cyan
            echo -nes ";36"
        case white
            echo -nes ";37"
        case default
            echo -nes ";39"
    end

    switch $_flag_background
        case black
            echo -nes ";40"
        case red
            echo -nes ";41"
        case green
            echo -nes ";42"
        case yellow
            echo -nes ";43"
        case blue
            echo -nes ";44"
        case magenta
            echo -nes ";45"
        case cyan
            echo -nes ";46"
        case white
            echo -nes ";47"
        case default
            echo -nes ";39"
    end

    echo -nes m
end
