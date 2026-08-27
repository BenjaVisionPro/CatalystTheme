Class {
	#name : #CgtGlamorousMenuTheme,
	#superclass : #BlSubTheme,
	#category : #'BVC-Theme-GT'
}

{ #category : #accessing }
CgtGlamorousMenuTheme >> containerBackground [ ^ self theme default contentBackground ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> containerBorderColor [ ^ Color veryLightGray ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> containerCornerRadius [ ^ BrMenuConstants cornerRadius + 1 ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> containerShadowColor [ ^ self theme default defaultShadowColor ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> containerShadowOffset [ ^ 0 @ 1 ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> containerShadowWidth [ ^ 2 ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> itemCornerRadius [ ^ 0 ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> itemPadding [
	^ BlInsets
		top: BrMenuConstants defaultMenuItemTopPadding
		bottom: BrMenuConstants defaultMenuItemBottomPadding
		left: BrMenuConstants defaultMenuItemLeftPadding
		right: BrMenuConstants defaultMenuItemRightPadding
]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuBackground [ ^ Color transparent ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuBorderColor [ ^ Color transparent ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuContentPadding [ ^ BlInsets empty ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuCornerRadius [ ^ BrMenuConstants cornerRadius ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuShadowColor [ ^ Color transparent ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuShadowOffset [ ^ 0 @ 0 ]
{ #category : #accessing }
CgtGlamorousMenuTheme >> menuShadowWidth [ ^ 0 ]
