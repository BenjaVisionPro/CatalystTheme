"
#Theme Selector Combinator Changed Event
I announce that the selector renderer requested a combinator change for a selector relation.
"
Class {
	#name : 'CgtThemeSelectorCombinatorChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'relation',
		'combinator'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}
{ #category : 'accessing' }
CgtThemeSelectorCombinatorChangedEvent >> relation [ ^ relation ]
{ #category : 'accessing' }
CgtThemeSelectorCombinatorChangedEvent >> relation: aCgtMatcherProjectionRelation [ relation := aCgtMatcherProjectionRelation ]
{ #category : 'accessing' }
CgtThemeSelectorCombinatorChangedEvent >> combinator [ ^ combinator ]
{ #category : 'accessing' }
CgtThemeSelectorCombinatorChangedEvent >> combinator: aSymbol [ combinator := aSymbol ]
{ #category : 'sending' }
CgtThemeSelectorCombinatorChangedEvent >> sendTo: anObject [ anObject selectorCombinatorChangedEvent: self ]
