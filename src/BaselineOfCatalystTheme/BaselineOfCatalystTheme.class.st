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
		do: [
			spec
				package: 'BVC-Theme-Core';
				package: 'BVC-Theme-GT' with: [ spec requires: #('BVC-Theme-Core') ];
				package: 'BVC-Theme-Palettes-Core' with: [ spec requires: #('BVC-Theme-Core') ];
				package: 'BVC-Theme-Dark' with: [ spec requires: #('BVC-Theme-GT' 'BVC-Theme-Palettes-Core') ] ]
]
