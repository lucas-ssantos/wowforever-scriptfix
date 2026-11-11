#!/usr/bin/env bash
# Launcher do Battle.net com Proton GE (independente do Faugus Launcher)
#
# Uso:
#   battlenet.sh [opções]
#
# Opções:
#   --no-mangohud     Desativa o MangoHUD
#   --no-gamemode     Desativa o GameMode
#   --no-gamescope    Desativa o Gamescope
#   --fullscreen      Gamescope em tela cheia (-f)
#
# Também é possível usar variáveis de ambiente (1 = ligado, 0 = desligado):
#   USE_MANGOHUD=0 USE_GAMEMODE=1 USE_GAMESCOPE=1 battlenet.sh

set -u

# ----------------------------- Configurações -----------------------------
PROTON="/home/<user>/.steam/debian-installation/compatibilitytools.d/GE-Proton11-12/proton"
STEAM_ROOT="/home/<user>/.steam/debian-installation"
PREFIX="/home/<user>/Faugus/battlenet"
BNET_EXE="/<user>/luke/Faugus/battlenet/pfx/pfx/pfx/pfx/drive_c/Program Files (x86)/Battle.net/Battle.net Launcher.exe"

# Resolução do Gamescope
WIDTH=1920
HEIGHT=1080

# Padrões (podem ser sobrescritos por variável de ambiente ou flags)
USE_MANGOHUD="${USE_MANGOHUD:-0}"
USE_GAMEMODE="${USE_GAMEMODE:-1}"
USE_GAMESCOPE="${USE_GAMESCOPE:-0}"
GAMESCOPE_FULLSCREEN="${GAMESCOPE_FULLSCREEN:-0}"

# ------------------------------- Argumentos -------------------------------
for arg in "$@"; do
    case "$arg" in
        --no-mangohud)  USE_MANGOHUD=0 ;;
        --no-gamemode)  USE_GAMEMODE=0 ;;
        --no-gamescope) USE_GAMESCOPE=0 ;;
        --fullscreen)   GAMESCOPE_FULLSCREEN=1 ;;
        -h|--help)
            sed -n '2,16p' "$0"
            exit 0
            ;;
        *) echo "Opção desconhecida: $arg" >&2; exit 1 ;;
    esac
done

# ------------------------------- Verificações -------------------------------
[[ -x "$PROTON" ]]   || { echo "Proton não encontrado: $PROTON" >&2; exit 1; }
[[ -f "$BNET_EXE" ]] || { echo "Battle.net não encontrado: $BNET_EXE" >&2; exit 1; }

check_cmd() {
    command -v "$1" >/dev/null 2>&1 || { echo "Aviso: '$1' não está instalado, ignorando." >&2; return 1; }
}

# ------------------------------- Ambiente Proton -------------------------------
export STEAM_COMPAT_DATA_PATH="$PREFIX"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_ROOT"
export SteamAppId=0
export SteamGameId=0

# ------------------------------- Montagem do comando -------------------------------
CMD=()

# GameMode (externo)
if [[ "$USE_GAMEMODE" == "1" ]] && check_cmd gamemoderun; then
    CMD+=(gamemoderun)
fi

# Gamescope
if [[ "$USE_GAMESCOPE" == "1" ]] && check_cmd gamescope; then
    CMD+=(gamescope -W "$WIDTH" -H "$HEIGHT" -w "$WIDTH" -h "$HEIGHT" --force-grab-cursor)
    [[ "$GAMESCOPE_FULLSCREEN" == "1" ]] && CMD+=(-f)
    CMD+=(--)
fi

# MangoHUD (dentro do gamescope)
if [[ "$USE_MANGOHUD" == "1" ]] && check_cmd mangohud; then
    CMD+=(mangohud)
fi

CMD+=("$PROTON" run "$BNET_EXE")

echo "Executando: ${CMD[*]}"
exec "${CMD[@]}"
