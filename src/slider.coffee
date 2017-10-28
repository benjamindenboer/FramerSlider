# Framer Slider Module
# By Benjamin den Boer
# Follow me @benjaminnathan
# Follow Framer @framer

Events.SliderValueChange  = "sliderValueChange"

class exports.Slider extends Layer

	constructor: (options={}) ->
		super options

	@_knob = undefined
	@_fill = undefined
	@_background = undefined

	_touchStart: (event) =>
		event.preventDefault()

		if @_background.width > @_background.height
			touchX = Events.touchEvent(event).clientX - Screen.canvasFrame.x
			scaleX = @canvasScaleX()
			@value = @valueForPoint(touchX / scaleX - @screenFrame.x)
		else
			touchY = Events.touchEvent(event).clientY - Screen.canvasFrame.y
			scaleY = @canvasScaleY()
			@value = @valueForPoint(touchY / scaleY - @screenFrame.y)

		@_knob.draggable._touchStart(event)
		@_updateValue()

	_touchEnd: (event) =>
		@_updateValue()

	_updateFill: =>
		if @_background.width > @_background.height
			@_fill.width = @_knob.midX
		else
			@_fill.height = @_knob.midY

	_updateKnob: =>
		if @_background.width > @_background.height
			@_knob.midX = @_fill.width
			@_knob.centerY()
		else
			@_knob.midY = @_fill.height
			@_knob.centerX()

	_updateFrame: =>
		@_knob.draggable.constraints =
			x: -knob.width / 2
			y: -knob.height / 2
			width: @_background.width + @_knob.width
			height: @_background.height + @_knob.height

		if @constrained
			@_knob.draggable.constraints =
				x: 0
				y: 0
				width: @_background.width
				height: @_background.height

		if @_background.width > @_background.height
			@_fill.height = @_background.height
			@_knob.midX = @pointForValue(@value)
			@_knob.centerY()
		else
			@_fill.width = @_background.width
			@_knob.midY = @pointForValue(@value)
			@_knob.centerX()

		if @_background.width > @_background.height
			@_knob.draggable.speedY = 0
			@_knob.draggable.speedX = 1
		else
			@_knob.draggable.speedX = 0
			@_knob.draggable.speedY = 1

	addBackgroundLayer: (layer) ->
		@_background = layer
		@_background.parent = @
		@_background.name = "background"
		@_background.x = @_background.y = 0
		return @_background

	addFillLayer: (layer) ->
		@_fill = layer
		@_fill.parent = @
		@_fill.name = "fill"
		@_fill.x = @_fill.y = 0
		@_fill.width = @width / 2
		return @_fill

	addKnobLayer: (layer) ->
		@_knob = layer
		@_knob.parent = @
		@_knob.name = "knob"
		@_knob.draggable.enabled = true
		@_knob.draggable.overdrag = false
		@_knob.draggable.momentum = true
		@_knob.draggable.momentumOptions = {friction: 5, tolerance: 0.25}
		@_knob.draggable.bounce = false
		@_knob.x = Align.center()
		@_knob.y = Align.center()

		return @_knob

	@define "constrained", @simpleProperty("constrained", false)

	@define "min",
		get: -> @_min or 0
		set: (value) ->
			@_min = value if _.isFinite(value)
			@emit("change:min", @_min)

	@define "max",
		get: -> @_max or 1
		set: (value) ->
			@_max = value if _.isFinite(value)
			@emit("change:max", @_max)

	@define "value",
		get: -> return @_value
		set: (value) ->
			return unless _.isFinite(value)

			@_value = Utils.clamp(value, @min, @max)

			if @_background.width > @_background.height
				@_knob.midX = @pointForValue(value)
			else
				@_knob.midY = @pointForValue(value)

			@_updateFill()
			@_updateValue()

	_knobDidMove: =>
		if @_background.width > @_background.height
			@value = @valueForPoint(@_knob.midX)
		else
			@value = @valueForPoint(@_knob.midY)

	_updateValue: =>
		return if @_lastUpdatedValue is @value

		@_lastUpdatedValue = @value
		@emit("change:value", @value)
		@emit(Events.SliderValueChange, @value)

	pointForValue: (value) ->
		if @_background.width > @_background.height
			if @constrained
				return Utils.modulate(value, [@min, @max], [0 + (@_knob.width / 2), @_background.width - (@_knob.width / 2)], true)
			else
				return Utils.modulate(value, [@min, @max], [0, @_background.width], true)
		else
			if @constrained
				return Utils.modulate(value, [@min, @max], [0 + (@_knob.height / 2), @_background.height - (@_knob.height / 2)], true)
			else
				return Utils.modulate(value, [@min, @max], [0, @_background.height], true)

	valueForPoint: (value) ->
		if @_background.width > @_background.height
			if @constrained
				return Utils.modulate(value, [0 + (@_knob.width / 2), @_background.width - (@_knob.width / 2)], [@min, @max], true)
			else
				return Utils.modulate(value, [0, @_background.width], [@min, @max], true)
		else
			if @constrained
				return Utils.modulate(value, [0 + (@_knob.height / 2), @_background.height - (@_knob.height / 2)], [@min, @max], true)
			else
				return Utils.modulate(value, [0, @_background.height], [@min, @max], true)

	animateToValue: (value, animationOptions={curve:"spring(300, 25, 0)"}) ->
		if @_background.width > @_background.height
			animationOptions.properties = {x: @pointForValue(value) - (@_knob.width/2)}
		else
			animationOptions.properties = {y: @pointForValue(value) - (@_knob.height/2)}

		@_knob.animate(animationOptions)

	# New Constructor
	@wrap = (background, fill, knob, options) ->
		return wrapSlider(new @(options), background, fill, knob, options)

	onValueChange: (cb) -> @on(Events.SliderValueChange, cb)

wrapSlider = (instance, background, fill, knob) ->

	if not (background instanceof Layer)
		throw new Error("AudioLayer expects a background layer.")

	if not (fill instanceof Layer)
		throw new Error("AudioLayer expects a fill layer.")

	if not (knob instanceof Layer)
		throw new Error("AudioLayer expects a knob layer.")

	slider = instance

	slider.clip = false
	slider.backgroundColor = "transparent"
	slider.frame = background.frame
	slider.parent = background.parent
	slider.index = background.index

	slider.addBackgroundLayer(background)
	slider.addFillLayer(fill)
	slider.addKnobLayer(knob)

	slider._updateFrame()
	slider._updateKnob()
	slider._updateFill()
	slider._knobDidMove()

	background.onTapStart ->
		slider._touchStart(event)

	slider.on "change:frame", ->
		slider._updateFrame()

	knob.on "change:size", ->
		slider._updateKnob()

	knob.on "change:frame", ->
		slider._updateFill()
		slider._knobDidMove()

	slider.on "change:max", ->
		slider._updateFrame()
		slider._updateKnob()
		slider._updateFill()
		slider._knobDidMove()

	return slider