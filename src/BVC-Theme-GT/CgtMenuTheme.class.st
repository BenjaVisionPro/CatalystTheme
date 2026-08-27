Class {
	#name : #CgtMenuTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'containerBackground',
		'containerBorderColor',
		'containerShadowColor',
		'menuBackground',
		'menuBorderColor',
		'menuShadowColor'
	],
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtMenuTheme >> containerBackground [ ^ containerBackground ]
{ #category : #accessing }
CgtMenuTheme >> containerBorderColor [ ^ containerBorderColor ]
{ #category : #accessing }
CgtMenuTheme >> containerCornerRadius [ ^ 0 ]
{ #category : #accessing }
CgtMenuTheme >> containerShadowColor [ ^ containerShadowColor ]
{ #category : #accessing }
CgtMenuTheme >> containerShadowOffset [ ^ 0 @ 0 ]
{ #category : #accessing }
CgtMenuTheme >> containerShadowWidth [ ^ 0 ]
{ #category : #accessing }
CgtMenuTheme >> itemCornerRadius [ ^ 6 ]
{ #category : #accessing }
CgtMenuTheme >> itemPadding [
	^ BlInsets top: 4 left: 10 bottom: 4 right: 10
]
{ #category : #accessing }
CgtMenuTheme >> menuBackground [ ^ menuBackground ]
{ #category : #accessing }
CgtMenuTheme >> menuBorderColor [ ^ menuBorderColor ]
{ #category : #accessing }
CgtMenuTheme >> menuContentPadding [ ^ BlInsets all: 4 ]
{ #category : #accessing }
CgtMenuTheme >> menuCornerRadius [ ^ 10 ]
{ #category : #accessing }
CgtMenuTheme >> menuShadowColor [ ^ menuShadowColor ]
{ #category : #accessing }
CgtMenuTheme >> menuShadowOffset [ ^ 0 @ 3 ]
{ #category : #accessing }
CgtMenuTheme >> menuShadowWidth [ ^ 8 ]

{ #category : #initialization }
CgtMenuTheme >> initializeThemeable [
	containerBackground := self
		color: [ :aTheme | aTheme menu constantAt: #containerBackground ]
		source: [ :aTheme | aTheme menu containerBackground ].
	containerBorderColor := self
		color: [ :aTheme | aTheme menu constantAt: #containerBorderColor ]
		source: [ :aTheme | aTheme menu containerBorderColor ].
	containerShadowColor := self
		color: [ :aTheme | aTheme menu constantAt: #containerShadowColor ]
		source: [ :aTheme | aTheme menu containerShadowColor ].
	menuBackground := self
		color: [ :aTheme | aTheme menu constantAt: #menuBackground ]
		source: [ :aTheme | aTheme menu menuBackground ].
	menuBorderColor := self
		color: [ :aTheme | aTheme menu constantAt: #menuBorderColor ]
		source: [ :aTheme | aTheme menu menuBorderColor ].
	menuShadowColor := self
		color: [ :aTheme | aTheme menu constantAt: #menuShadowColor ]
		source: [ :aTheme | aTheme menu menuShadowColor ]
]
