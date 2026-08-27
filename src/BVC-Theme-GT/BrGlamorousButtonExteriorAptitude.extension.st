Extension { #name : #BrGlamorousButtonExteriorAptitude }

{ #category : #'*BVC-Theme-GT' }
BrGlamorousButtonExteriorAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [
		self theme button defaultBackground
			blocResolveColorForTheme: self theme ]
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousButtonExteriorAptitude >> borderPaint [
	^ borderPaint ifNil: [
		self theme button defaultBorderColor
			blocResolveColorForTheme: self theme ]
]

{ #category : #'*BVC-Theme-GT' }
BrGlamorousButtonExteriorAptitude >> initialize [
	super initialize.

	self default: [ :aStyle |
		aStyle
			background: self backgroundPaint;
			border: (BlBorder paint: self borderPaint width: self borderWidth) ].

	self focused: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: (self theme button hoveredBorderColor
					blocResolveColorForTheme: self theme)
				width: self borderWidth) ].

	self hovered: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: (self theme button hoveredBorderColor
					blocResolveColorForTheme: self theme)
				width: self borderWidth) ].

	self pressed: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: (self theme button pressedBorderColor
					blocResolveColorForTheme: self theme)
				width: self borderWidth) ].

	self disabled: [ :aStyle |
		aStyle
			background: (self theme button disabledBackgroundColor
				blocResolveColorForTheme: self theme);
			border:
				(BlBorder
					paint: (self theme button disabledBorderColor
						blocResolveColorForTheme: self theme)
					width: self borderWidth) ]
]
