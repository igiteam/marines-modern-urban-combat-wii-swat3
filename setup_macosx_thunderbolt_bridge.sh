#!/bin/bash
# setup_macosx_thunderbolt_bridge.sh — configure Thunderbolt Bridge for two-Mac LAN co-op
# Usage:
#   On Mac A (host):   ./setup_macosx_thunderbolt_bridge.sh host
#   On Mac B (client): ./setup_macosx_thunderbolt_bridge.sh client
#
# Requires: sudo (for networksetup changes)

set -euo pipefail

SERVICE="Thunderbolt Bridge"
SUBNET="169.254.1"          # link-local range; safe for direct Mac-to-Mac
HOST_IP="${SUBNET}.1"
CLIENT_IP="${SUBNET}.2"
MASK="255.255.255.0"

usage() {
    echo "Usage: $0 {host|client|status|reset}"
    echo "  host   — set this Mac to ${HOST_IP}"
    echo "  client — set this Mac to ${CLIENT_IP}"
    echo "  status — show current Thunderbolt Bridge config"
    echo "  reset  — return the service to DHCP (automatic)"
    exit 1
}

require_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo "This action needs sudo. Re-running with sudo..."
        exec sudo "$0" "$@"
    fi
}

check_service() {
    if ! networksetup -listallnetworkservices | grep -qx "$SERVICE"; then
        echo "ERROR: '$SERVICE' not found."
        echo "Available services:"
        networksetup -listallnetworkservices
        echo
        echo "Is the Thunderbolt cable connected and the interface present?"
        exit 1
    fi
}

set_static() {
    local ip="$1"
    require_sudo "$@"
    check_service
    echo "Setting '$SERVICE' to static IP ${ip}/${MASK}..."
    networksetup -setmanual "$SERVICE" "$ip" "$MASK" ""
    echo "Done. Current config:"
    networksetup -getinfo "$SERVICE"
}

show_status() {
    check_service
    echo "=== $SERVICE ==="
    networksetup -getinfo "$SERVICE"
    echo
    echo "=== Interface link status ==="
    # Find the interface backing the service, then show its media
    iface=$(networksetup -listnetworkserviceorder | awk -v svc="$SERVICE" '
        $0 ~ svc {found=1; next}
        found && /Device:/ {gsub(/.*Device: /,""); gsub(/\)/,""); print; exit}
    ')
    if [[ -n "${iface:-}" ]]; then
        echo "Interface: $iface"
        ifconfig "$iface" 2>/dev/null | grep -E "status|inet " || true
    fi
}

reset_dhcp() {
    require_sudo "$@"
    check_service
    echo "Resetting '$SERVICE' to DHCP..."
    networksetup -setdhcp "$SERVICE"
    echo "Done."
    networksetup -getinfo "$SERVICE"
}

case "${1:-}" in
    host)   set_static "$HOST_IP" ;;
    client) set_static "$CLIENT_IP" ;;
    status) show_status ;;
    reset)  reset_dhcp ;;
    *)      usage ;;
esac
