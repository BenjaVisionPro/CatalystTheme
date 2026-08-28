Class {
	#name : #BaselineOfCatalystTheme,
	#superclass : #BaselineOf,
	#category : #BaselineOfCatalystTheme,
	#package : #BaselineOfCatalystTheme
}

{ #category : #baseline }
BaselineOfCatalystTheme >> baseline: spec [
	<baseline>
	| foundationRepo |
	foundationRepo := 'gitlocal://', (OSPlatform current environment at: 'PROJECTS_ROOT'), '/CatalystFoundation/src'.
	spec for: #common do: [
		spec
			baseline: 'CatalystFoundation'
			with: [
				spec
					loads: #('BVC-Foundation-Core' 'BVC-Foundation-Magritte-Core' 'BVC-Foundation-Magritte-Detail');
					repository: foundationRepo ].
		spec
			package: 'BVC-Theme-Core' with: [ spec requires: #('CatalystFoundation') ];
			package: 'BVC-Theme-GT' with: [ spec requires: #('BVC-Theme-Core') ];
			package: 'BVC-Theme-Light' with: [ spec requires: #('BVC-Theme-GT') ];
			package: 'BVC-Theme-Dark' with: [ spec requires: #('BVC-Theme-GT') ] ]
]
