# Configure viewport
Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 1700
	screenHeight: 956
	deviceImageWidth: 1700
	deviceImageHeight: 956
	devicePixelRatio: 1
	
pageOpen = false
allowShow = false;

pageSlideSpeed = .8

# Overlay
overlay.states =
	visible:
		opacity: .7
		animationOptions:
			time: .4
			delay: .1
	hidden:
		opacity: 0
		animationOptions:
			time: .6
			delay: .1
		
overlay.stateSwitch('hidden')

# Page position defaults
page.y = 0
page.x = page.width

page.animationOptions =
	curve: Bezier(.53,.01,.02,1)

# Page slide animation
page.states =
	hidden:
		x: page.width
		animationOptions:
			time: pageSlideSpeed
	visible:
		x: 0
		animationOptions:
			time: pageSlideSpeed

pageAngle = new Layer
	width: 200
	height: page.height
	y: Align.bottom

page.addChild(pageAngle)

pageAngle.sendToBack()
	
pageAngleInner = new Layer
pageAngle.addChild(pageAngleInner)

pageAngleInner.props =
	rotation: 0
	width: pageAngle.width * 2
	height: pageAngle.height * 3.5
	y: Align.center
	x: Align.left
	backgroundColor: '#FBFCFC'

rotateAngleLeft = () ->
	pageAngle.originX = 0
	pageAngle.originY = 1
	
	overlay.animate('visible')
	
	pageAngle.animate
		rotation: -20
		options:
			time: .3

	Utils.delay .2, ->
		if allowShow
			pageAngle.animate
				rotation: 0
				options:
					time: .6
			

rotateAngleRight = () ->
	pageAngle.originX = 0
	pageAngle.originY = 0
	
	overlay.animate('hidden')
	
	pageAngle.animate
		rotation: 20
		options:
			time: .2

	Utils.delay .2, ->
		if !allowShow
			pageAngle.animate
				rotation: 0
				options:
					time: .6
					

# Page contents
navbarLight.states =
	hidden:
		opacity: 0
	visible:
		opacity: 1

navbarLight.stateSwitch 'hidden'

pageTitleText = pageTitle.selectChild('text')

pageTitleText.states =
	hidden:
		opacity: 0
	visible:
		opacity: 1

pageTitleText.stateSwitch 'hidden'

pageDescText = pageDesc.selectChild('text')

pageDescText.states =
	hidden:
		opacity: 0
	visible:
		opacity: 1

pageDescText.stateSwitch 'hidden'


# Show / hide page
showPage = () ->
	
	page.animate 'visible'
	rotateAngleLeft()
	
	Utils.delay page.states.visible.animationOptions.time, ->
		if allowShow
			navbarLight.animate 'visible'
			pageTitleText.animate 'visible'
			pageDescText.animate 'visible'
	
	
hidePage = () ->
	page.animate 'hidden'
	rotateAngleRight()
	
	navbarLight.animate 'hidden'
	pageTitleText.animate 'hidden'
	pageDescText.animate 'hidden'


togglePage = () ->
	if !pageOpen
		allowShow = true
		pageOpen = true
		
		showPage()
	else 
		allowShow = false
		pageOpen = false
		
		hidePage()
	
	
# Events
backButton.on Events.MouseDown, ->
	togglePage()
	
thumbnail_1.on Events.MouseDown, ->
	togglePage()