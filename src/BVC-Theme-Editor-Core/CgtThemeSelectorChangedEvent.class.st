"
#Theme Selector Changed Event
I announce that the selector widget produced an updated selector from the current selector projection state. I carry the projection and the recomposed selector.
"
Class {
	#name : 'CgtThemeSelectorChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'projection',
		'selector'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeSelectorChangedEvent >> projection [
	^ projection
]

{ #category : 'accessing' }
CgtThemeSelectorChangedEvent >> projection: aCgtMatcherProjection [
	projection := aCgtMatcherProjection
]

{ #category : 'accessing' }
CgtThemeSelectorChangedEvent >> selector [
	^ selector
]

{ #category : 'accessing' }
CgtThemeSelectorChangedEvent >> selector: aCgtThemeSelector [
	selector := aCgtThemeSelector
]

{ #category : 'sending' }
CgtThemeSelectorChangedEvent >> sendTo: anObject [
	anObject selectorChangedEvent: self
]
