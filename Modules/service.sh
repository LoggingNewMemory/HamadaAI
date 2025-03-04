while [ -z "$(getprop sys.boot_completed)" ]; do
sleep 5
done
sleep 5
su -lp 2000 -c "cmd notification post -S bigtext -t 'HamadaAI' TagHamada 'HamadaAI - Starting...'"
sleep 10
Hamada64
