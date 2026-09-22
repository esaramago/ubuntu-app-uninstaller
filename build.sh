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
BUILD_DIR=$(mktemp -d)
trap 'rm -rf "$BUILD_DIR"' EXIT

echo "==> Preparando estrutura de empacotamento..."
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr"

cp -r DEBIAN/* "$BUILD_DIR/DEBIAN/"
cp -r usr/* "$BUILD_DIR/usr/"

echo "==> Ajustando permissões..."
chmod 755 "$BUILD_DIR"
chmod 755 "$BUILD_DIR/DEBIAN"
chmod 644 "$BUILD_DIR/DEBIAN/control"
find "$BUILD_DIR/usr" -type d -exec chmod 755 {} +
find "$BUILD_DIR/usr" -type f -exec chmod 644 {} +
chmod 755 "$BUILD_DIR/usr/local/bin/uninstaller"
chmod 755 usr/local/bin/uninstaller

echo "==> Gerando pacote ${OUTPUT}..."
dpkg-deb --root-owner-group --build "$BUILD_DIR" "${OUTPUT}"

echo "==> Pacote criado com sucesso: ${OUTPUT}"

