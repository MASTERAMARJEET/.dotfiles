import os
import subprocess

from libqtile.command import lazy


def on_startup():
    script = os.path.expanduser("~/scripts/autostart")
    subprocess.run([script])


@lazy.function
def volume(qtile, option):
    script = os.path.expanduser("~/scripts/audio_control")
    subprocess.run([script, option])


@lazy.function
def brightness(qtile, option):
    script = os.path.expanduser("~/scripts/brightness_control")
    subprocess.run([script, option])
