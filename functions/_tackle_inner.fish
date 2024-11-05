function _tackle_inner --argument-names fn
    if not set -q fn
        return 1
    end

    function fish_prompt
    end
    function fish_right_prompt
    end
    function fish_mode_prompt
    end

    for key in a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 \$ \\ \* \? \~ \# \( \) \{ \} \[ \] \< \> \& \| \; \" \'
        bind $key "_tackle_key $key"
    end

    for key in \ca \cb \cc \cd \ce \cf \cg \ch \ci \cj \ck \cl \cm \cn \co \cp \cq \cr \cs \ct \cu \cv \cw \cx \cy \cz
        bind $key "_tackle_key $key command"
    end

    bind \e\[D "_tackle_key left"
    bind \e\[C "_tackle_key right"
    bind \e\[A "_tackle_key up"
    bind \e\[B "_tackle_key down"
    bind " " "_tackle_key space"
    bind \r "_tackle_key enter"
    bind \t "_tackle_key tab"
    bind \e "_tackle_key escape"
    bind \x7F "_tackle_key backspace"
    bind \cC exit 1

    _tackle_cursor hide
    while true
        if set -q input
            set lines ($fn $input)
        else
            set lines ($fn $argv[2..])
        end

        for line in $lines
            echo -e $line
        end

        if set -q _tackle_exit
            _tackle_cursor show
            exit $_tackle_exit
        end

        _tackle_cursor up (count $lines)

        read --prompt "_tackle_cloak hide" input
        _tackle_cloak show
        _tackle_cursor line-up 1
        _tackle_erase to-end
        set_color normal
    end
end

function _tackle_key
    commandline --insert $argv
    commandline --function execute
end

function _tackle_cloak
    switch $argv[1]
        case hide
            echo -nes "\e[8m"
        case show
            echo -nes "\e[28m"
    end
end
