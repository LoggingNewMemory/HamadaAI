while [ -z "$(getprop sys.boot_completed)" ]; do
sleep 5
done
su -lp 2000 -c "cmd notification post -S bigtext -t 'HamadaAI' TagHamada 'HamadaAI - Starting...'"
sleep 20
Hamada64
