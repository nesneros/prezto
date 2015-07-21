# unalias all git aliases
for e in $(alias|grep -e "^g..\?='git "|cut -d'=' -f1) ; do
    unalias $e
done

source /etc/unuxus/etc/profile/zshrc

