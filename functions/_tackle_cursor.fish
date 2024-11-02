function _tackle_cursor
    if not set -q argv[2]
        set argv[2] 1
    end

    switch $argv[1]
        case home
            echo -ne "\e[H"
        case up
            echo -nes "\e[$argv[2]" A
        case down
            echo -nes "\e[$argv[2]" B
        case right
            echo -nes "\e[$argv[2]" C
        case left
            echo -nes "\e[$argv[2]" D
        case line-down
            echo -nes "\e[$argv[2]" E
        case line-up
            echo -nes "\e[$argv[2]" F
        case column
            echo -nes "\e[$argv[2]" G
        case save
            echo -nes "\e[s"
        case restore
            echo -nes "\e[u"
        case hide
            echo -nes "\e[?25l"
        case show
            echo -nes "\e[?25h"
        case '*'
            return 1
    end
end
