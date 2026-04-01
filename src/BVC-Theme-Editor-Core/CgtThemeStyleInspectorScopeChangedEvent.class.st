"
#Theme Style Inspector Scope Changed Event
I announce a style-inspector session change so higher-level editor coordination can react explicitly instead of inferring the change from selector churn.
"
Class {
	#name : 'CgtThemeStyleInspectorScopeChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'styleInspectorModel',
		'previousScopePath',
		'scopePath'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> styleInspectorModel [ ^ styleInspectorModel ]

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> styleInspectorModel: aCgtThemeStyleInspectorModel [ styleInspectorModel := aCgtThemeStyleInspectorModel ]

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> previousScopePath [ ^ previousScopePath ]

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> previousScopePath: aCgtElementPath [ previousScopePath := aCgtElementPath ]

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> scopePath [ ^ scopePath ]

{ #category : 'accessing' }
CgtThemeStyleInspectorScopeChangedEvent >> scopePath: aCgtElementPath [ scopePath := aCgtElementPath ]

{ #category : 'sending' }
CgtThemeStyleInspectorScopeChangedEvent >> sendTo: anObject [ anObject styleInspectorScopeChangedEvent: self ]

