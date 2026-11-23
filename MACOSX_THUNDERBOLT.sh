#!/bin/bash
# MACOSX_THUNDERBOLT.sh — configure Thunderbolt Bridge for two-Mac LAN co-op
# Usage:
#   On Mac A (host):   ./MACOSX_THUNDERBOLT.sh host
#   On Mac B (client): ./MACOSX_THUNDERBOLT.sh client
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

# How to use it
# Save it as setup_bridge.sh in your repo (e.g. igi1-macbook-3d-workstation/scripts/).

# Make it executable on both Macs:

# bash
# chmod +x setup_bridge.sh
# Run on Mac A (host):

# bash
# ./setup_bridge.sh host
# Run on Mac B (client):

# bash
# ./setup_bridge.sh client
# Check the link (no sudo needed):

# bash
# ./setup_bridge.sh status
# Verify connectivity (from Mac A):

# bash
# ping 169.254.1.2
# You want <2ms latency and 0% packet loss.

# Revert to automatic if you ever want macOS to handle it again:

# bash
# ./setup_bridge.sh reset
# Notes on the choices
# 169.254.1.x is a link-local range. It avoids clashing with any home router (192.168.1.x etc.) and is the same range macOS itself uses for self-assigned IPs, so it's safe for a direct cable.

# networksetup -setmanual is the documented way to set static IPs from the CLI (equivalent to System Settings → Network → Thunderbolt Bridge → Details → TCP/IP → Manually).

# "" for the router field means "no router," which is correct for a direct cable.

# require_sudo re-execs itself with sudo if needed, so you can run it without sudo and it will prompt.

# status doesn't need sudo — it's safe to run any time.

# reset returns the service to DHCP, which is the "Thunderbolt Bridge automatic" mode if you ever want to test the plug-and-play path instead.

# One caveat
The check_service function requires the Thunderbolt cable to be connected before it runs, otherwise networksetup won't list the service and the script will bail with a helpful message. That's intentional — it stops you from setting an IP on a non-existent interface.
