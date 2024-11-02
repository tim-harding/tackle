function _tackle_inner
    function fish_prompt
    end
    function fish_right_prompt
    end
    function fish_mode_prompt
    end

    argparse "i/init=" "u/update=" "v/view=" -- $argv

    if not set -q _flag_init _flag_update _flag_view
        echo "Expected init, update, and view functions"
        exit
    end

    for key in \$ \\ \* \? \~ \# \( \) \{ \} \[ \] \< \> \& \| \; \" \' \a \e \f \n \r \t \v
        bind "$key" "$_flag_update $(string escape $key)"
    end

    for key in a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \ca \cb \cc \cd \ce \cf \cg \ch \ci \cj \ck \cl \cm \cn \co \cp \cq \cr \cs \ct \cu \cv \cw \cx \cy \cz
        bind $key "$_flag_update $key"
    end

    bind \e\[D "$_flag_update left"
    bind \e\[C "$_flag_update right"
    bind \e\[A "$_flag_update up"
    bind \e\[B "$_flag_update down"
    bind " " "$_flag_update space"
    bind \cC exit

    set -g _tackle_epoch 0
    for var in $($_flag_init)
        function _tackle_handle_state_$var --on-variable $var
            set _tackle_epoch $(math $_tackle_epoch + 1)
        end
    end

    function _tackle_update_view --on-variable _tackle_epoch --inherit-variable _flag_view
        _tackle_erase to-end
        $_flag_view
        _tackle_cursor restore
    end

    # TODO: Save cursor to variable so user code doesn't overwrite saved state
    echo ""
    _tackle_cursor up
    _tackle_cursor save
    _tackle_update_view
end
