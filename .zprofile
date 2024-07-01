# if already not inside a tmux session
# start a new session or attach to an existing session
if [ -z $TMUX ]
then
    tmux new-session -A -s tmux
fi
