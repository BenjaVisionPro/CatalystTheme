Class {
	#name : 'BaselineOfCatalystTheme',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCatalystTheme',
	#package : 'BaselineOfCatalystTheme'
}

{ #category : 'baseline' }
BaselineOfCatalystTheme >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				package: 'BVC-Theme-Core';
				package: 'BVC-Theme-Dark';
				package: 'BVC-Theme-DarkHighContrast';
				package: 'BVC-Theme-Light';
				package: 'BVC-Theme-Debug' ]
]
