Extension { #name : #BlElement }

{ #category : #'*BVC-Theme-GT' }
BlElement >> onThemeChanged [
	self background: (self background blocResolveForTheme: self theme).
	self border: (self border blocResolveForTheme: self theme).
	self dispatchEvent: BlElementThemeChanged new
]
