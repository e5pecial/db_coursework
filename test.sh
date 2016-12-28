# Запускаем крон и в нем ставим исполняться данный скрипт

if [ ! -f /home/oleg/backup ]; then
    mkdir backup
fi

now=$(date +"%m_%d_%Y")
sudo -u postgres -i pg_dump carpooling > /home/oleg/backup/$now.sql
exit