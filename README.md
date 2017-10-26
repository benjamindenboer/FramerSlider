<h1 align="center">
  <img src="https://d.pr/i/TZ2kXs+" width="160" alt="icon"><br>
  Framer Slider<br>
  <br>
</h1>
<br>
<p align="center">  
  <img src="https://d.pr/i/ivheWo+" width="840" alt="banner">
  <br>
  <h6 align="center">INTRODUCTION</h6>
  <p align="center">From music player mocks in <a href="https://framer.com/features/design?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Design</a>, to fully functional audio players in <a href="https://framer.com/features/code?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Code</a>. A <strong>Framer</strong> module that allows you to design audio interfaces for iOS, Android, Desktop and more—and then bring them to life. From play buttons to volume sliders.</p>
 <p align="center"><a href="https://youtu.be/KCeOa9F3L9A">Watch the video.</a></p>
</p>
<br>

## Overview

| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Slider.wrap    | Method  |  `background, fill, knob`  | Wrap slider logic around 3 layers. |

<br>

## Get Started
First, grab the `slider.coffee` file and place it within the `/modules` folder (located within your `.framer` folder).
Then, to include the module, `require` the `Slider` class:

```
# Include the module
{Slider} = require "slider"
```


The `Slider.wrap` method takes three parameters:
- `background` — The background layer of the slider.
- `fill` — The fill layer of the slider.
- `knob` – The knob layer of the slider.

All of these can be styled completely in the design. The method wraps a component around these 3 layers to handle all of the sliding functionality for you.

---

## Examples
See the [Framer Audio](https://github.com/benjamindenboer/FramerAudio) module for more examples.

- **[Slider Wrapping](https://framer.cloud/BlHxd).** From 3 layers in Design to an interactive slider in Code.

---

## Contact
- Follow me <a href="https://twitter.com/benjaminnathan">@benjaminnathan</a>.
- Follow <a href="https://twitter.com/framer">@framer</a>.
