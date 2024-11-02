function _tackle_inner
    eval "function fish_prompt; end"
    set -g _tackle_epoch 0
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

    $_flag_init
    eval "function _tackle_update_view --on-variable _tackle_epoch; $_flag_view; end"
    $_flag_view
end

function _tackle_epoch_increment
    set _tackle_epoch $(math $_tackle_epoch + 1)
end

function _tackle_state
    for arg in $argv
        eval "function _tackle_handle_state_$arg --on-variable $arg; _tackle_epoch_increment; end"
    end
end
