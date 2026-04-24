# Raspberry Pi USB MIDI Host

Turn a Raspberry Pi into a plug-and-play USB MIDI host box for hardware synths.


## Signal Flow

AKAI MPK Mini Play mk3 → Raspberry Pi → CME U2MIDI Pro → Make Noise 0-Coast


## Features

- Automatic MIDI connection on boot
- Headless Raspberry Pi OS Lite setup
- Uses ALSA aconnect
- One-way MIDI routing from controller to synth
- No GPIO/UART MIDI yet
- Stable USB MIDI interface output
- Optional boot optimizations to make it up and running in 30 sec


## Hardware Used

- Raspberry Pi
- AKAI MPK Mini Play mk3
- CME U2MIDI Pro
- DIN MIDI to TRS Type A adapter
- Make Noise 0-Coast


## Project Structure

    rpi-midi-host/
    ├── README.md
    ├── setup/
    │   ├── midi-auto.sh
    │   └── midi-connect.service
    └── docs/


## Install

### 1. Install dependencies

    sudo apt update
    sudo apt install alsa-utils -y


### 2. Copy script

    chmod +x setup/midi-auto.sh
    cp setup/midi-auto.sh /home/moudi/midi-auto.sh


### 3. Install systemd service

    sudo cp setup/midi-connect.service /etc/systemd/system/midi-connect.service
    sudo systemctl daemon-reload
    sudo systemctl enable midi-connect.service


### 4. Reboot

    sudo reboot


### 5. Verify

    journalctl -u midi-connect.service -b

Expected output:

    MIDI devices found: MPK=XX CME=YY
    MIDI connected!


## Boot Optimization Optional

Disable network wait:

    sudo systemctl disable NetworkManager-wait-online.service
    sudo systemctl mask NetworkManager-wait-online.service

Disable GUI if using desktop OS:

    sudo systemctl set-default multi-user.target

Disable unused services:

    sudo systemctl disable wayvnc.service
    sudo systemctl disable cups.service cups-browsed.service


## Notes

- MIDI routing is handled using ALSA aconnect.
- Only one-way connection is created: controller to MIDI interface.


## Future Improvements

- Faster boot optimization to run faster than 30 sec.
- USB to (UART-TRS) routing to replace the CME U2MIDI Pro 


## License

MIT
