Class {
	#name : #CgtTagSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [ 'background', 'hoveredBackground', 'editorBackground' ],
	#category : #'BVC-Theme-GT'
}

{ #category : #initialization }
CgtTagSubTheme >> initializeThemeable [
	background := self color: [ :aTheme | aTheme tag constantAt: #background ] source: [ :aTheme | aTheme tag background ].
	hoveredBackground := self color: [ :aTheme | aTheme tag constantAt: #hoveredBackground ] source: [ :aTheme | aTheme tag hoveredBackground ].
	editorBackground := self color: [ :aTheme | aTheme tag constantAt: #editorBackground ] source: [ :aTheme | aTheme tag editorBackground ]
]

{ #category : #accessing }
CgtTagSubTheme >> background [ ^ background ]
{ #category : #accessing }
CgtTagSubTheme >> hoveredBackground [ ^ hoveredBackground ]
{ #category : #accessing }
CgtTagSubTheme >> editorBackground [ ^ editorBackground ]
