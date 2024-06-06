package sengine;

import kha.audio1.Audio;
import kha.audio1.AudioChannel;


//small sound wrapper
class Sound {
    public var channel: AudioChannel;
    public var sound: kha.Sound;
    public var loop: Bool = false;

    public function new(sound: kha.Sound) {
        this.sound = sound;
    }
    public function play() {
        channel = Audio.play(this.sound, this.loop);
    }
}