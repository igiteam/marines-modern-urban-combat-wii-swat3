**Two Macs, one per TV, one per player.**  Each player gets their own headless Macbook Pro 2014 Late Big Sur, their own TV, their own Wiimote, their own MDR-V6 — linked by Thunderbolt. That's the Twin.


# MACOSX_TWIN_HEADLESS_ARCADE

## The Twin Effect: Two Macs, Two TVs, One Thunderbolt Link

A specification for a **standing, two-player co-op arcade cabinet** built from two MacBook Pros (one per player), two TVs, two Wiimotes + nunchucks, two Sony MDR-V6 headphones, and a direct Thunderbolt Bridge between the two Macs.

The goal is the **Sega Rally Championship Twin** experience — two side-by-side units, one shared game world, zero crosstalk — rebuilt on modern Mac hardware rather than Model 2 boards.

---

## 1. Concept

The Sega Rally Twin linked two Model 2 cabinets with a short fiber-optic cable so two players sat side by side and raced in the same world. The physical form was: two screens, two seats, one protected cable run, no visible networking hardware.

This spec recreates that **form factor** with two independent Mac units:

- **Mac A** drives **TV 1** for **Player 1**.
- **Mac B** drives **TV 2** for **Player 2**.
- Each player has their own **Wiimote + nunchuck** and **MDR-V6**.
- The two Macs are linked by a **Thunderbolt Bridge** — the Twin's "protected tube."

The link technology is standard Thunderbolt networking, not Model 2 fiber. The *form* is the Twin; the *implementation* is modern.

---

## 2. Architecture

```
┌──────────────────────┐              ┌──────────────────────┐
│      MAC A           │              │      MAC B           │
│  MacBook Pro 2019    │              │  MacBook Pro 2014    │
│  i9 / 32GB / 5500M   │              │  i7 / 16GB / GT750M  │
│                      │              │                      │
│  Host (listen server)│◄── Thunder ──►│  Client (join)      │
│                      │    bolt      │                      │
│  Player 1            │    cable     │  Player 2            │
└──────────┬───────────┘              └──────────┬───────────┘
           │                                     │
      ┌────┴────┐                           ┌────┴────┐
      │  TV 1   │                           │  TV 2   │
      │ Player 1│                           │ Player 2│
      └─────────┘                           └─────────┘
        Wiimote 1                             Wiimote 2
        MDR-V6 #1                             MDR-V6 #2
```

- **Mac A** runs the game as **host** (listen server): world simulation, AI, mission state.
- **Mac B** runs the game as **client**: sends input, receives world state.
- **TV 1** shows Player 1's view; **TV 2** shows Player 2's view.
- **Wiimote 1** pairs to Mac A; **Wiimote 2** pairs to Mac B.
- **MDR-V6 #1** plugs into Mac A; **MDR-V6 #2** into Mac B.
- **Thunderbolt cable** links the two Macs — the only shared connection.

No switch, no router, no shared display. Two complete units, one cable.

---

## 3. Hardware List

### Core

| Item | Qty | Role |
|---|---|---|
| MacBook Pro 16" 2019 i9-9880H, 32GB, 1TB, 5500M | 1 | **Mac A** — host / Player 1 |
| MacBook Pro 15" 2014 i7, 16GB, 500GB | 1 | **Mac B** — client / Player 2 |
| Panasonic VIERA VT30 55" 3D Plasma | 1 | **TV 1** — Player 1 |
| Second TV (any HDMI display) | 1 | **TV 2** — Player 2 |
| Thunderbolt cable (per Mac port type) | 1 | Link between Mac A and Mac B |

### Input (per player)

| Item | Qty | Role |
|---|---|---|
| Nintendo Wii Remote (Motion Plus) + Nunchuck | 2 | One per player (1 per Mac) |
| Infrared Sensor Bar USB | 2 | One per TV (pointer tracking) |
| MP5 Wiigun holder | 2 | Physical gun mount per player |

### Audio (per player)

| Item | Qty | Role |
|---|---|---|
| Sony MDR-V6 headphones | 2 | One per player (1 per Mac) |

### Adapters / Cables

| Item | Qty | Role |
|---|---|---|
| Apple USB-C to Digital AV HDMI Multiport Adapter (A2119) | 1 | Mac A → TV 1 |
| USB-C HDMI adapter (second) | 1 | Mac B → TV 2 |
| Amazon Basics 4K HDMI 3m | 2 | One per Mac → TV run |

### Power / Misc

| Item | Qty | Role |
|---|---|---|
| Duracell AA battery pack | 1 | Wiimote power |
| Power strip | 1 | Both Macs, both TVs |

---

## 4. The Thunderbolt Bridge

The two Macs are linked by a **direct Thunderbolt cable** — no switch, no router.

- **Mac A (host):** static IP `169.254.1.1`, mask `255.255.255.0`, router blank.
- **Mac B (client):** static IP `169.254.1.2`, mask `255.255.255.0`, router blank.
- **Verify:** `ping 169.254.1.2` from Mac A — expect **<2ms** latency, 0% loss.

Automate with `setup_bridge.sh`:

```bash
./setup_bridge.sh host    # on Mac A
./setup_bridge.sh client  # on Mac B
./setup_bridge.sh status  # check either
```

The Thunderbolt cable is the Twin's "protected tube": one short cable between the units, hidden inside the cabinet.

---

## 5. Cabinet Layout

Standing height, two independent units side by side, linked by one hidden cable.

```
┌───────────────────────────────────────────────────────────────┐
│                         BACK WALL                             │
│                                                               │
│   ┌─────────────┐                     ┌─────────────┐         │
│   │    TV 1     │                     │    TV 2     │         │
│   │  (Player 1) │                     │  (Player 2) │         │
│   └─────────────┘                     └─────────────┘         │
│                                                               │
│   ┌─────────────┐   Thunderbolt       ┌─────────────┐         │
│   │   Mac A     │◄──── cable ────────►│   Mac B     │         │
│   │  (hidden)   │   (protected run)   │  (hidden)   │         │
│   └─────────────┘                     └─────────────┘         │
│                                                               │
│   ┌──────┐  ┌──────┐            ┌──────┐  ┌──────┐           │
│   │Wiimote│ │MDR-V6│            │Wiimote│ │MDR-V6│           │
│   │ +MP5 │ │  #1  │            │ +MP5 │ │  #2  │           │
│   └──────┘  └──────┘            └──────┘  └──────┘           │
│                                                               │
│          STANDING POSITION          STANDING POSITION         │
│            PLAYER 1                    PLAYER 2               │
└───────────────────────────────────────────────────────────────┘
```

- **TVs** at eye level, side by side.
- **Macs** hidden behind/below each TV — one per unit.
- **Thunderbolt cable** runs between the two Macs, short and hidden.
- **Wiimote + MP5 holder** at standing hand height, one per player.
- **MDR-V6** hangs at each station, one per player.

Each side is a self-contained unit: Mac, TV, Wiimote, headphone. The only link is the cable.

---

## 6. Per-Mac Setup

### Mac A (host, 2019)

- Game installed and set to **Host**.
- Wiimote 1 paired via Bluetooth (`wiimote_nunchuk_macosx`).
- MDR-V6 #1 in headphone jack.
- HDMI to TV 1 via USB-C adapter.
- Thunderbolt Bridge IP `169.254.1.1`.

### Mac B (client, 2014)

- Game installed and set to **Join** (enter `169.254.1.1`).
- Wiimote 2 paired via Bluetooth.
- MDR-V6 #2 in headphone jack.
- HDMI to TV 2 via adapter.
- Thunderbolt Bridge IP `169.254.1.2`.

---

## 7. Why This Works

- **Isolation:** each player has their own screen, audio, and input. No crosstalk, no shared view.
- **Symmetry:** both units are identical in role — one Mac, one TV, one Wiimote, one headphone.
- **Low latency:** Thunderbolt is direct, sub-2ms, no switch in the path.
- **Twin form:** two units, one protected cable — exactly the Sega Rally Twin layout.
- **Preservation:** the physical context (standing, two-player, linked) is part of what makes co-op tactical games feel right.

---

## 8. Reference Images

| Mac 2014 (Big Sur) #1 | Mac 2014 (Big Sur) #2 |
| :---: | :---: |
| `---mac2014late_bigsur_1` | `---mac2014late_bigsur_2` |

*(Insert the two Mac images here using the repo's image hosting.)*

---

## 9. Notes

- **MAME's Sega Rally Twin emulation is solo-only** — the two-player link is not emulated. This cabinet is a *form-factor reference*, not a Model 2 emulation.
- **The game itself must implement LAN co-op** (host-client). Thunderbolt is the transport; the game provides the networking.
- **For SWAT 3-era games**, the slow tactical pace means simple host-client sync is enough — no client-side prediction needed at sub-2ms latency.

---

**What changed from the previous version:**
- **Two Macs, one per TV** — Mac A (2019) drives TV 1 for Player 1, Mac B (2014) drives TV 2 for Player 2.
- **No headless single-Mac mode** — removed entirely.
- **Per-Mac setup section** added, so each unit's role is explicit.
- **Architecture diagram** now shows two complete units linked by one cable.
- **Hardware list** split so each item is assigned to Mac A or Mac B.
- **Reference images** table added for `---mac2014late_bigsur_1` and `---mac2014late_bigsur_2` — replace the placeholders with your actual image URLs.
