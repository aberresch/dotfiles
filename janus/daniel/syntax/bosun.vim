" Vim syntax file
" Language: Bosun Configuration Files
" Maintainer: Daniel Schneller

if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'bosun'
endif

" Set number of lines to look back for syntax
" highlighting regions / blocks.
if !exists("bosun_lines")
  let bosun_lines = 250
endif

" set the block size
exec "syn sync lines=" . bosun_lines



" Keywords will always override any other match type
syn keyword bosunConfigKeyword tsdbHost tsdbVersion ledisDir logstashElasticHosts stateFile emailFrom smtpHost hostname unknownTemplate
syn keyword bosunBoolean true false

" Match by regex. < and > mean the match must be at
" the beginning / end of what VIM considers a word.
" Hence, this requires the word to stand alone. Otherwise
" e. g. 'warn' would match in 'warning'.
syn match   bosunKeyword /\v<(critNotification|crit|email|entry|next|log|print|template|timeout|ignoreUnknown|unknown|warnNotification|warn)>/
syn cluster bosunContainedInBlock add=bosunKeyword

" Top level type definitions
syn match   bosunEntityDeclaration   /\v^\s*(alert|lookup|macro|notification|template)\s+\S+/


" comments must be at the beginning of a line or be
" separated from the text before by a non-word character
syn match bosunComment "\(^\|\W\)#.*$"

" Operators are listed individually, because they are
" easier to grasp that way
syn match bosunOperator "="
syn match bosunOperator ">"
syn match bosunOperator "<"
syn match bosunOperator "+"
syn match bosunOperator "-"
syn match bosunOperator "/"
syn match bosunOperator "*"
syn match bosunOperator "!"
syn cluster bosunContainedInBlock add=bosunOperator


" \< means the number must be at the beginning of what
" vim considers to be a word. Matches integer and float.
syn match bosunNumber /\v<\d+(\.?\d*)?/
syn cluster bosunContainedInBlock add=bosunNumber

" Matches a timespan in milliseconds, seconds, minutes,
" hours, days, weeks, months, years.
syn match bosunTimespan /\v<\d+(ms|s|m|h|d|w|n|y)/


syn match bosunUrl /\v(https?:\/\/)?(\w+(:\w+)?\@)?([A-Za-z][-_0-9A-Za-z]*\.){1,}(\w{2,}\.?){1,}(:[0-9]{1,5})?\S*/
syn match bosunUrlIPv4 /\v(https?:\/\/)?(\w+(:\w+)?\@)?((25\_[0-5]|2\_[0-4]\_[0-9]|\_[01]?\_[0-9]\_[0-9]?)\.){3}(25\_[0-5]|2\_[0-4]\_[0-9]|\_[01]?\_[0-9]\_[0-9]?)(:[0-9]{1,5})?\S*/
syn match bosunEmail '\v\S+\@\S+'

syn region bosunBlock start='{' end='}' contains=@bosunContainedInBlock
syn region bosunTemplateExpression start='{{' end='}}' containedin=bosunMultilineString,bosunTemplateAttrAssignmentValue,bosunBlock contains=bosunString
syn region bosunQuery start="q(" end=")" contains=bosunString
syn region bosunQueryFunction start="\(lookup\|last\|max\|avg\|change\)(" end=")" contains=bosunString,bosunQuery
syn region bosunVariable  start="\$\w" end=/\W/re=e-1,he=e-1
syn region bosunVariable2 start="\${\w" end="}"
syn region bosunString start='"' end='"'
syn region bosunMultilineString start='`' end='`'

syn match   bosunTemplateAttr /\v^\s*(subject|body|macro)/ contained nextgroup=bosunTemplateAttrAssignment
syn match   bosunTemplateAttrAssignment /\v\s*\=\s*/ nextgroup=bosunTemplateAttrAssignmentValue
syn match   bosunTemplateAttrAssignmentValue /\.+$/ contains=bosunTemplateExpression
syn cluster bosunContainedInBlock add=bosunTemplateAttr,bosunTemplateAttrAssignment,bosunTemplateAttrAssignmentValue



syn cluster bosunContainedInBlock add=bosunBoolean,bosunMultilineString,bosunString,bosunOperator,bosunComment,bosunQuery,bosunQueryFunction,bosunVariable,bosunVariable2,bosunTimespan,bosunEmail,bosunUrl,bosunUrlIPv4,bosunBlock

let b:current_syntax = "bosun"

hi def link bosunBoolean         Constant
hi def link bosunComment         Comment
hi def link bosunConfigKeyword   Statement
hi def link bosunEntityDeclaration Type
hi def link bosunEmail           Identifier
hi def link bosunEntityRef       Identifier
hi def link bosunVariable        Identifier
hi def link bosunVariable2       Identifier
hi def link bosunKeyword         Statement
hi def link bosunNumber          Constant
hi def link bosunOperator        Statement
hi def link bosunQuery           Comment
hi def link bosunMultilineString Special
hi def link bosunQueryFunction   PreProc

hi def link bosunTemplateAttr    Statement
hi def link bosunTemplateAttrAssignment Statement
hi def link bosunTemplateAttrAssignmentValue Identifier

hi def link bosunTemplateExpression PreProc
hi def link bosunTimespan        Constant
hi def link bosunUrl             Identifier
hi def link bosunString          Constant
hi def link bosunUrlIPv4         Identifier
