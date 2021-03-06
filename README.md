<h1 align="center">
  <img src="https://d.pr/i/TZ2kXs+" width="160" alt="icon"><br>
  Framer Slider<br>
  <br>
</h1>
<br>

<p align="center">
   <img src="https://d.pr/i/jdsv6T+" width="820" alt="banner">	
  <br>
  <h6 align="center">INTRODUCTION</h6>
  <p align="center">From adaptive sliders created in <a href="https://framer.com/features/design?utm_source=github&utm_medium=link&utm_campaign=framer_slider_benjamin">Design</a> to fully functional ones in <a href="https://framer.com/features/code?utm_source=github&utm_medium=link&utm_campaign=framer_slider_benjamin">Code</a>. A <strong>Framer</strong> module that allows you to design sliders and then bring them to life, without losing customizability. Appearance and logic—separated.</p>
</p>
<br>
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

```
# Wrap slider logic
Slider.wrap(background, fill, knob)
```

To customize the Slider, you can store it in a variable.

```
# Wrap slider logic
slider = Slider.wrap(background, fill, knob)
```

This allows you to customize its properties, like the `min`, `max` and `value`.

```
# Set range, default value
slider.props = 
	min: 0
	max: 100
	value: 50
```

And finally—to output its values, you can use the `onValueChange` method.

```
# Update value & print output
slider.onValueChange ->
	print slider.value
```
---

## Examples

- **[Slider Wrapping](https://framer.cloud/aWnxD).** Simple example with realtime value.
- **[Value Modulating](https://framer.cloud/WJpNi).** Adjust the background color of a layer.
- **[Gradient Sliders](https://framer.cloud/rqJjF/).** Adjust the properties of a linear gradient.
- **[Photo Filters](https://framer.cloud/ervdH).** Adjust saturation, contrast and grayscale filters.
- See the **[Framer Audio](https://github.com/benjamindenboer/FramerAudio)** module for more.

---

## Resources
- **[SliderComponent Properties](https://framer.com/docs/#slider.slidercomponent)** — Discover all properties.
- **[SliderComponent Events](https://framer.com/docs/#events.value)** — Discover all events.
- **[SliderComponent Guide](https://framer.com/getstarted/guides/code/#slider)** — See the official beginners guide.
- **[Utils.Modulate Docs](https://framer.com/docs/#utils.modulate)** — Learn how to convert value ranges.

---

## Contact
- Follow me <a href="https://twitter.com/benjaminnathan">@benjaminnathan</a>.
- Follow <a href="https://twitter.com/framer">@framer</a>.
