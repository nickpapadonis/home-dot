if [ "$TERM_PROGRAM" == "Apple_Terminal" ]; then
    echo -e "\033];\007"
elif [ "$TERM_PROGRAM" == *"xterm"* ]; then
    echo -e "\033];\007"
fi

