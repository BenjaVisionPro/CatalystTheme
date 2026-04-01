"
#Theme Style Inspector Active Rule Changed Event
I announce a style-inspector session change so higher-level editor coordination can react explicitly instead of inferring the change from selector churn.
"
Class {
	#name : 'CgtThemeStyleInspectorActiveRuleChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'styleInspectorModel',
		'previousActiveStyleRule',
		'activeStyleRule',
		'previousRelatedStyleRules',
		'relatedStyleRules'
	],
	#category : 'BVC-Theme-Editor-Core',
	#package : 'BVC-Theme-Editor-Core'
}

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> styleInspectorModel [ ^ styleInspectorModel ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> styleInspectorModel: aCgtThemeStyleInspectorModel [ styleInspectorModel := aCgtThemeStyleInspectorModel ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> previousActiveStyleRule [ ^ previousActiveStyleRule ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> previousActiveStyleRule: aCgtThemeStyleRule [ previousActiveStyleRule := aCgtThemeStyleRule ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> activeStyleRule [ ^ activeStyleRule ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> activeStyleRule: aCgtThemeStyleRule [ activeStyleRule := aCgtThemeStyleRule ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> previousRelatedStyleRules [ ^ previousRelatedStyleRules ifNil: [ #() ] ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> previousRelatedStyleRules: aCollection [ previousRelatedStyleRules := aCollection ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> relatedStyleRules [ ^ relatedStyleRules ifNil: [ #() ] ]

{ #category : 'accessing' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> relatedStyleRules: aCollection [ relatedStyleRules := aCollection ]

{ #category : 'sending' }
CgtThemeStyleInspectorActiveRuleChangedEvent >> sendTo: anObject [ anObject styleInspectorActiveRuleChangedEvent: self ]

