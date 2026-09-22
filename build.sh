#!/usr/bin/env bash
set -e

# Diretório raiz do projeto onde o script está localizado
cd "$(dirname "$0")"

CONTROL_FILE="DEBIAN/control"

if [ ! -f "$CONTROL_FILE" ]; then
    echo "Erro: Arquivo $CONTROL_FILE não encontrado." >&2
    exit 1
fi

# Extrai a versão definida no arquivo DEBIAN/control
VERSION=$(awk -F': ' '/^Version:/ {print $2}' "$CONTROL_FILE" | tr -d '[:space:]')

if [ -z "$VERSION" ]; then
    echo "Erro: Não foi possível obter o campo 'Version' de $CONTROL_FILE." >&2
    exit 1
fi

OUTPUT="ubuntu-app-uninstaller_${VERSION}.deb"

echo "==> Ajustando permissões..."
chmod 755 DEBIAN
chmod 644 DEBIAN/control
chmod 755 usr/local/bin/uninstaller
chmod 644 usr/share/applications/unninstaller.desktop

echo "==> Gerando pacote ${OUTPUT}..."
dpkg-deb --root-owner-group --build . "${OUTPUT}"

echo "==> Pacote criado com sucesso: ${OUTPUT}"

