#!/bin/bash
:; for v in "${@//!/!1}" ; do v=${v// /!0} ; v=${v//	/!+}; a[++n]=${v:-!.} ; done ; LC_ALL=C SCAM_ARGS=${a[*]} exec make -Rr --no-print-directory -j ${SCAM_JOBS:-9} -f"$0" 9>&1
SHELL:=/bin/bash

define [mod-'core]
# compiled from core.scm
# Requires: 'runtime
# Uses: 'scam-ct
# Exports: intersperse_2 foldr_3 foldl_3 index-of_2 assoc&x;2;\.;\>;~%-initial`<]subst],1'|@],1'|@1],1>|^d|@[}1}0`[]2]0 assoc-vec&x;2;\.;\>;~assoc-initial`>]^d],1[|1|0`[]2]0 assoc-initial_2 sort-by_2 memoize_1 memoenc)1]or]2]or]3 mcache)6 1!S_1 split_2 uniq_1 see_2 fexpect&x;2;\.;\>;~expect-x`>]~format],1[|1|0`>]~format],1[|2|0`:IL9]core.scm:518 assert&x;1;\.;\>;~%-x`[]1]0`:IL9]core.scm:507 assert-x)2 expect&x;2;\.;\>;~%-x`[]1]0`[]2]0`:IL9]core.scm:497 expect-x_3 printf_1]or]more sprintf_1]or]more vsprintf_2 format_1 format-custom)2 format-add_1 *format-funcs*#0;~%;p format-record+data-foreach)4 format-dict+symbol?+format_1 dict-collate_1 dict-keys_1 dict-compact_1]or]2 dict-set_3 dict-get_2]or]3 dict-find_2 dict-value_1;\.;\>;~nth`']2`<]subst],1'|@=],1'|}],1[|1|0 dict-key_1;\.;\>;~promote`<]subst],1'|@8],1'|!p],1<|word|@'}1|@<}subst}@1'@0@11=}@1'@0@10}@1[@01@00 append_0]or]more filtersub&x;3;\.;\<;patsubst`[]1]0`[]2]0`<]filter],1[|1|0],1[|3|0 word-index?_1 numeric?_1 while_3 reverse_1 rev-zeroes)2 rev-by-10s)2 indices&x;1;\.;\>;~%-a`<]words],1[|1|0 indices-a+indices-b)3 vec-or_1;\.;\>;^u`<]word],1'|1],1<|filter-out|@'}@1.|@[}1}0 select-words_2 select-vec_2 butlast_1 strip-vec_1;\.;\<;filter`']!p`[]1]0 last_1;\.;\>;~promote`<]%word],1[|1|0 conj_2 cons_2 concat-vec_1]or]2 xor_2 identity_1;\.;\[;1;0 eq?_2 SCAM!TDEBUG#0;%;p
~eq? = $(if $(findstring 1$1,$(findstring 1$2,1$1)),1)
~identity = $1
~xor = $(if $1,$(if $2,,$1),$2)
~concat-vec = $(call ~promote,$(subst $  ,$(call ~demote,$2),$1))
~cons = $(call ~demote,$1)$(if $2, )$2
~conj = $1$(if $1, )$(call ~demote,$2)
~last = $(call ~promote,$(lastword $1))
~strip-vec = $(filter %,$1)
~butlast = $(wordlist 2,$(words $1),X $1)
~select-vec = $(filter-out !,$(foreach dx,$2,$(if $(call ^Y,$(call ~promote,$(dx)),,,,,,,,,$1),$(dx),!)))
~select-words = $(foreach a,$(foreach x,$2,$(if $(call ^Y,$x,,,,,,,,,$1),$x)),$a)
~vec-or = $(call ^u,$(word 1,$(filter-out !.,$1)))
~indices-b = $(if $(filter $1,$2),$2,$2 $(call ~indices-b,$1,$(words $3),. $3))
~indices-a = $(if $(filter-out 0,$1),$(call ~indices-b,$1,1,. .))
~rev-by-10s = $(if $1,$(if $2,$(foreach p,10 9 8 7 6 5 4 3 2 1,$(call ~rev-by-10s,$(wordlist $(word $p,0 1 2 3 4 5 6 7 8 9)$(patsubst %0,%1,$2),$p$2,$1),$(patsubst 0%,%,$2))),$(foreach p,10 9 8 7 6 5 4 3 2 1,$(word $p,$1))))
~rev-zeroes = $(if $(word 1$21,$1),$(call ~rev-zeroes,$1,0$2),$2)
~reverse = $(wordlist 1,99999999,$(call ~rev-by-10s,$1,$(call ~rev-zeroes,$1,)))
~while-0 = $(if $(filter iiiiiiiiiiiiiiiiiiii,$4),1 $(call ^d,$3),$(if $(call ^Y,$3,,,,,,,,,$1),$(call ~while-0,$1,$2,$(call ^Y,$3,,,,,,,,,$2),i$4),0 $(call ^d,$3)))
~while-N = $(if $(filter 0,$(word 1,$3)),$3,$(if $(filter iii,$5),$(if $(filter 1,$4),$(call ~while-N,$1,$2,$3,$4 0,ii),$3),$(call ~while-N,$1,$2,$(if $4,$(call ~while-N,$1,$2,$3,$(wordlist 2,99999999,$4),),$(call ~while-0,$1,$2,$(call ~nth,2,$3),)),$4,i$5)))
~while = $(if $(call ^Y,$3,,,,,,,,,$1),$(call ^Y,$(call ^Y,$3,,,,,,,,,$2),,,,,,,,,$`(call ~nth,2,$`(call ~while-N,$(call ^E,$1),$(call ^E,$2),$`(call ~while-0,$(call ^E,$1),$(call ^E,$2),$`1,),1,ii))),$3)
~numeric? = $(if $(filter 0% 1% 2% 3% 4% 5% 6% 7% 8% 9%,$(subst -,,$1)),$(if $(patsubst .%,%,$(patsubst %e,%,$(subst 0,,$(patsubst -%,%,$(subst $  ,_,$(subst E0,e,$(subst E-,E,$(subst e,E,$(subst +,-,$(subst 9,0,$(subst 8,0,$(subst 7,0,$(subst 6,0,$(subst 5,0,$(subst 4,0,$(subst 3,0,$(subst 2,0,$(subst 1,0,$1)))))))))))))))))),,$1))
~word-index? = $(call ~numeric?,$(subst 0,,$(subst .,~,$(subst -,~,$(subst e,~,$(subst E,~,$1))))))
~append = $(filter %,$1 $2 $3 $4 $5 $6 $7 $8 $(if $9,$(call ~promote,$9)))
~dict-key = $(call ~promote,$(subst !8,%,$(word 1,$(subst !=, ,$1))))
~dict-value = $(call ~nth,2,$(subst !=, ,$1))
~dict-find = $(word 1,$(filter $(subst %,!8,$(call ^d,$1))!=%,$2))
~dict-get = $(call ~nth,2,$(subst !=, ,$(call ~dict-find,$1,$2))$(if $3, x $(call ~demote,$3)))
~dict-set = $(foreach p,$(subst %,!8,$(call ^d,$1))!=,$p$(call ^d,$2) $(filter-out $p%,$3))
~dict-compact = $(if $(if $1,,1),$2,$(call ~append,$(word 1,$1),$(call ~dict-compact,$(filter-out $(word 1,$(subst !=,!=% ,$(word 1,$1))),$(wordlist 2,99999999,$1)))))
~dict-keys = $(foreach e,$1,$(subst !8,%,$(word 1,$(subst !=, ,$e))))
~dict-collate = $(foreach p,$(word 1,$(subst !=,!= ,$(word 1,$1))),$(call ~append,$p$(call ^d,$(patsubst $p%,%,$(filter $p%,$1))),$(call ~dict-collate,$(filter-out $p%,$1))))
define ~symbol?
$(and $(findstring $1,$(call ~promote,$(word 1,$1))),$(if $(or $(findstring 
,$1),$(findstring $[,$1),$(findstring $],$1),$(findstring [,$1),$(findstring ],$1),$(findstring $(if ,,,),$1),$(findstring ;,$1),$(findstring !=,$1)),,1),$1)
endef
~format-dict = $(if $(findstring !=,$1),$(if $(call ~eq?,$1,$(foreach w,$1,$(call ^k,$(call ~nth,1,$(subst !=, ,$w)))!=$(call ^d,$(call ~nth,2,$(subst !=, ,$w))))),{$(call ~concat-vec,$(foreach e,$1,$(call ^d,$(or $(call ~symbol?,$(call ~promote,$(subst !8,%,$(word 1,$(subst !=, ,$e))))),$(call ~format,$(call ~promote,$(subst !8,%,$(word 1,$(subst !=, ,$e)))))): $(call ~format,$(call ~nth,2,$(subst !=, ,$e))))),$(if ,,, ))}))
~data-foreach = $(if $2,$(call ~data-foreach,$1,$(wordlist 2,99999999,$2),$(wordlist 2,99999999,$3),$4$(if $4, )$(call ^Y,$(if $(filter L,$(word 1,$2)),$3,$(if $(filter S,$(word 1,$2)),$(call ~nth,1,$3),$(if $(filter W,$(word 1,$2)),$(word 1,$3),$(error bad encoding in ctor pattern)))),$(word 1,$2),,,,,,,,$1)),$4)
~format-record = $(if $(filter !:%,$(word 1,$1)),$(call ^Y,$(call ~dict-get,$(word 1,$1),$(^tags)),$(wordlist 2,99999999,$1),$(word 1,$1),$1,,,,,,$`(and $`1,$`(call ~eq?,$`(filter %,$`4),$`(filter %,$`(call ~data-foreach,$``(if $``(call ~eq?,S,$``2),$``(call ^d,$``1),$``1),$`(wordlist 2,99999999,$`1),$`2,$`3))),($`(call ~nth,1,$`1)$`(if $`(wordlist 2,99999999,$`1), )$`(call ~data-foreach,$``(if $``(and $``(call ~eq?,L,$``2),$``(if $``1,,1)),[],$``(call ~format,$``1)),$`(wordlist 2,99999999,$`1),$`2,)))))
~*format-funcs* := 
~format-add = $(call ^set,~*format-funcs*,$(call ~cons,$1,$(~*format-funcs*)))
~format-custom = $(if $2,$(or $(call ^Y,$1,,,,,,,,,$(call ^u,$(word 1,$2))),$(call ~format-custom,$1,$(wordlist 2,99999999,$2))))
define ~format
$(or $(call ~format-custom,$1,$(~*format-funcs*)),$(if $(findstring !,$1),$(or $(call ~format-dict,$1),$(call ~format-record,$1))),$(if $(or $(findstring !,$1),$(and $(findstring $  ,$1),$(call ~numeric?,$(subst $  ,,$1)))),$(if $(call ~eq?,$1,$(foreach w,$1,$(call ~demote,$(call ~promote,$w)))),[$(foreach w,$1,$(call ~format,$(call ~promote,$w)))])),$(call ~numeric?,$1),"$(subst $ 	,\t,$(subst 
,\n,$(subst ",\",$(subst \,\\,$1))))")
endef
~vsprintf = $(call ~concat-vec,$(foreach w,$(join !. $2,$(subst $  !% !%,%,$(subst %, !%,%s$(call ^d,$1)))),$(if $(findstring !%s,$w),$(subst !%s,,$w),$(if $(findstring !%q,$w),$(call ~cons,$(call ~format,$(call ^u,$(word 1,$(subst !%q,!. ,$w)))),$(word 2,$(subst !%q,!. ,$w))),$(if $(findstring !%,$w),$(subst !%,[unknown % escape]%,$w))))))
~sprintf = $(call ~vsprintf,$1,$(foreach N,2,$(^v)))
~printf = $(info $(call ~vsprintf,$1,$(foreach N,2,$(^v))))
define ~expect-x
$(if $(call ~eq?,$1,$2),$(if $(findstring O,$(SCAM_DEBUG)),$(info $3: OK: $1)),$(and $(info $3: error: assertion failed
A: $(call ~format,$1)
B: $(call ~format,$2)

Raw:
A: $1
B: $2
)1,$(if $(if $(findstring K,$(SCAM_DEBUG)),,1),$(error ))))
endef
~assert-x = $(or $1,$(error $(info $2: error: assertion failed)))
define ~see
$(if $(findstring $1,$2),1,$(and $(info Expected: $(subst 
,
          ,$1))1,$(info $   Within: $(subst 
,
          ,$2))))
endef
~uniq-x = $(if $1,$(word 1,$1) $(call ~uniq-x,$(filter-out $(word 1,$1),$(wordlist 2,99999999,$1))))
~uniq = $(subst ~1,~,$(subst ~p,%,$(filter %,$(call ~uniq-x,$(subst %,~p,$(subst ~,~1,$1))))))
~split = $(foreach w,$(subst $(or $(subst $ 	,{t},$(subst $  ,{s},$(subst {L,{L},$(subst },{R},$(subst {,{L,$1))))),{}),{} {},$(or $(subst $ 	,{t},$(subst $  ,{s},$(subst {L,{L},$(subst },{R},$(subst {,{L,$2))))),{})),$(call ^d,$(subst {L,{,$(subst {R},},$(subst {L},{L,$(subst {s}, ,$(subst {t},	,$(subst {},,$w))))))))
~1+ = $(if $(filter %1 %2 %3 %4,$1),$(subst 1~,2,$(subst 2~,3,$(subst 3~,4,$(subst 4~,5,$1~)))),$(if $(filter %5 %6 %7,$1),$(subst 5~,6,$(subst 6~,7,$(subst 7~,8,$1~))),$(if $(findstring 9~,$1~),$(call ~1+,$(or $(subst 9~,,$1~),0))0,$(patsubst %0,%1,$(patsubst %8,%9,$1)))))
~mcache = $(and $(if $6,$(info Warning: memoized function passed more than three arguments))1,$(if $(if $(if $(filter-out u%,$(flavor $1)),1),,1),$(call ~set-global,$1,$(call ^Y,$3,$4,$5,,,,,,,$2)))1,$(value $1))
~memoenc = $(if $(or $1,$2,$3),~~$(subst ~,~0,$1)$(call ~memoenc,$2,$3))
~memoize = $(if $(if $(if $(filter-out u%,$(flavor $1)),1),,1),$(info Warning: [memoize-1] function '$1' not defined.),$(call ^Y,$(value $1),*memo$(call ~memoenc,$1),$1,,,,,,,$`(call ~set-rglobal,$`3,$``(call ~mcache,$`(call ^E,$`2)$``(call ~memoenc,$``1,$``2,$``3),$`(call ^E,$`1),$``1,$``2,$``3,$``(or $``4,$``5,$``6,$``7,$``8)))))
~sort-by = $(filter-out %!!,$(subst !!,!! ,$(sort $(foreach w,$2,$(call ~demote,$(call ^Y,$(call ~promote,$w),,,,,,,,,$1))!!$w))))
~assoc-initial = $(call ~promote,$(firstword $(if $(findstring %,$1),$(subst !8,$1,$(filter !8 !8!0%,$(subst $1,!8,$2))),$(filter $1 $1!0%,$2))))
~index-of = $(words $(subst !_, ,$(filter %!|,$(subst !_$(call ^d,$2)!_,!_!| ,!_$(subst $  ,!_,$1)!_))))
~foldl = $(if $(firstword $3),$(call ~foldl,$1,$(call ^Y,$2,$(call ^u,$(word 1,$3)),,,,,,,,$1),$(wordlist 2,99999999,$3)),$2)
~foldr = $(if $(firstword $3),$(call ^Y,$(call ^u,$(word 1,$3)),$(call ~foldr,$1,$2,$(wordlist 2,99999999,$3)),,,,,,,,$1),$2)
~intersperse = $(subst $  , $(call ^d,$1) ,$2)

endef
 
define [mod-'runtime]
# compiled from runtime.scm
# Requires: 'runtime
# Uses: 'scam-ct
# Exports: ^start#1;%;p;3 check-exit+start-trace+run-at-exits)0 at-exit_1 *atexits*#0;~%;p tracing&x;2;\.;\>;~untrace`>]~trace],1[|1|0`[]2]0 untrace_1]or]2 trace_1 untrace-ext+trace-ext)2 do-not-trace_1 ^require#1;%;p;1 ^load#1;%;p;1 load-ext+mod-var&p;1;\.;\:IL6`']!Hmod-`[]1]0`']!I *required*#0;~%;p ^add-tags#1;%;p;1 ^tags#0;%;x bound?&x;1;\.;\<;if`<]filter-out],1'|u!p],1<|flavor|@[}1}0`']1 rrest&x;1;\.;\<;wordlist`']3`']99999999`[]1]0 rest&x;1;\.;\<;wordlist`']2`']99999999`[]1]0 first&x;1;\.;\>;^u`<]word],1'|1],1[|1|0 nth-rest&x;2;\.;\<;wordlist`[]1]0`']99999999`[]2]0 not&x;1;\.;\<;if`[]1]0`'],.`']1 nil#2;\.;x;\';\. set-rglobal_2]or]3 set-global_2]or]3 nth_2 demote_1 promote_1 apply_2 ^E#1;%;p;1]or]2 ^fset#1;%;p;3 ^set#1;%;p;2]or]3 esc-LHS+esc-RHS&p;1;\.;\<;subst`']!n`']$!E`<]subst],1'|!N],1'|$!O],1<|subst|@'}$|@'}$$|@[}1}0 ^t#1;%;p;0 ^ta#1;%;p;0]or]more ^tc#1;%;p;1]or]more ^tp#1;%;p;2 ^f#1;%;p;1 ^apply)1]or]more ^av#1;%;p;0 ^v#1;%;p;0 ^Y#1;%;p;0]or]more ^k#1;%;p;1 ^n#1;%;p;2 ^u#1;%;p;1 ^d#1;%;p;1 *do-not-trace*#0;~%;p
~*do-not-trace* := $(value .VARIABLES)
define '


endef
 [ := (
 ] := )
" := \#
' := $'
` := $$
& := ,

^d = $(or $(subst $  ,!0,$(subst $ 	,!+,$(subst !,!1,$1))),!.)
^u = $(subst !1,!,$(subst !+,	,$(subst !0, ,$(subst !.,,$1))))
^n = $(call ^u,$(word $1,$2))
^k = $(subst %,!8,$(^d))
^Y = $(call if,,,$(10))
^v = $(subst !.,!. ,$(filter-out %!,$(subst !. ,!.,$(foreach n,$(wordlist $N,9,1 2 3 4 5 6 7 8),$(call ^d,$($n)))$(if $9, $9) !)))
^av = $(foreach N,1,$(^v))
~^apply = $(call ^Y,$(call ^n,1,$2),$(call ^n,2,$2),$(call ^n,3,$2),$(call ^n,4,$2),$(call ^n,5,$2),$(call ^n,6,$2),$(call ^n,7,$2),$(call ^n,8,$2),$(wordlist 9,9999,$2),$1)
define ^f
"$(subst 
,\n,$(subst ",\",$(subst \,\\,$1)))"
endef
^tp = $(info $1 $(call ^f,$2))$2
^tc = $(call $1,$2,$3,$4,$5,$6,$7,$8,$(call ^n,1,$9),$(wordlist 2,9999,$9))
^ta = $(if $(or $1,$2,$3,$4,$5,$6,$7,$8,$9), $(^f)$(call ^tc,^ta,$2,$3,$4,$5,$6,$7,$8,$9))
^t = $(info --> ($1$(call ^tc,^ta,$2,$3,$4,$5,$6,$7,$8,$9)))$(call ^tp,<-- $1:,$(call ^tc,$1,$2,$3,$4,$5,$6,$7,$8,$9))
define ~esc-LHS
$`(if ,,$(subst $],$`],$(subst $[,$`[,$(subst 
,$`',$(subst #,$`",$(subst $`,$`$`,$1))))))
endef
define ^set
$(eval $(call ~esc-LHS,$1) :=$` $(subst 
,$`',$(subst #,$`",$(subst $`,$`$`,$2))))$3
endef
define ^fset
$(and $(eval define $(call ~esc-LHS,$1)
$(subst \$ 
,\$` 
,$(subst define,$` define,$(subst endef,$` endef,$2
)))endef
)1,$3)
endef
$(if ,, ) := 
define ^E
$(subst $`,$`$2,$`(if ,,$(subst 
,$`',$(subst $[,$`[,$(subst $],$`],$(subst $`,$``,$1))))))
endef
~apply = $(call ~^apply,$1,$2)
~promote = $(call ^u,$1)
~demote = $(call ^d,$1)
~nth = $(call ^n,$1,$2)
~set-global = $(call ^set,$1,$2,$3)
~set-rglobal = $(call ^fset,$1,$2,$3)
^tags := 
^add-tags = $(call ^set,^tags,$(^tags) $(filter-out $(^tags),$1))
~*required* := 
~load-ext = 
^load = $(and $(or $(call ~load-ext,$1),$(if $(if $(filter-out u%,$(flavor [mod-$1])),1),$(eval $(value [mod-$1])),$(error module $1 not found!)))1,$1)
^require = $(and $(or $(filter $1,$(~*required*)),$(and $(call ^set,~*required*,$(~*required*) $1)1,$(call ^load,$1)))1,)
~do-not-trace = $(call ^set,~*do-not-trace*,$(~*do-not-trace*) $1)
~trace = $(if $1,$(and $(call ^require,'trace)1,$(call ~trace-ext,$1,$(~*do-not-trace*))))
~untrace = $(and $(if $1,$(and $(call ^require,'trace)1,$(call ~untrace-ext,$1)))1,$2)
~*atexits* := 
~at-exit = $(call ^set,~*atexits*,$(call ^d,$1) $(~*atexits*))
~run-at-exits = $(and $(foreach fn,$(~*atexits*),$(call ^d,$(call ^Y,,,,,,,,,,$(call ^u,$(fn)))))1,)
~start-trace = $(call ~trace,$(value $(if $(filter '%,$1),_)SCAM_TRACE))
~check-exit = $(if $(subst 0,,$(subst 9,,$(subst 8,,$(subst 7,,$(subst 6,,$(subst 5,,$(subst 4,,$(subst 3,,$(subst 2,,$(subst 1,,$(patsubst -%,%,$(subst $ 	,x,$(subst $  ,x,$1))))))))))))),$(error scam: main returned '$1'),$(or $1,0))
define ^start
$(and $(call ~start-trace,$1)1,$(call ~do-not-trace,^require ^load ^load-ext)1,$(call ^require,$1)1,$(call ~start-trace,$1)1,$(eval $(call ^Y,$(call ~check-exit,$(call ^Y,$3,,,,,,,,,$(value $2))),,,,,,,,,.DEFAULT_GOAL :=
.PHONY: [exit]
[exit]: $`(.DEFAULT_GOAL);@exit $`1$``(call ~run-at-exits))))
endef
$(if $(call ~do-not-trace,^start ~start-trace),)

endef
 
define [mod-'trace]
# compiled from trace.scm
# Requires: 'runtime
# Uses: 'scam-ct
# Exports: untrace-ext+trace-dump+trace-rev+trace-ext)2 known-names#2;\.;p;\<;filter-out`']:!p`<]subst],1'|:],1'|}:],1:IL1|~*trace-ids* trace-id)1]or]2 *trace-ids*#0;~%;p trace-match)2 trace-body)4 count-var&p;1;\.;\:IL6`']!HK-`[]1]0`']!I save-var&p;1;\.;\:IL6`']!HS-`[]1]0`']!I trace-words)1]or]2 trace-digits+zero#2;\.;p;\';/////// filtersub&p;3;\.;\<;patsubst`[]1]0`[]2]0`<]filter],1[|1|0],1[|3|0 trace-info)1]or]2]or]3]or]4
~trace-info = $(info TRACE: $1$2$3$4)
~trace-digits = $(if $(findstring /1111111111,$1),$(call ~trace-digits,$(subst /1111111111,1/,$1)),$(subst !:,,$(subst :!,0!,$(subst :0,::,$(subst :00,:::,$(subst :0000,:::::,$(subst $  ,,!:$(foreach d,/$(subst /, /,$1),$(words $(subst /,,$(subst 1, 1,$d))))!:)))))))
~trace-words = $(if $(word $1,$2),$2,$(call ~trace-words,$1,1 $2))
~trace-body = $(subst :D,$4,$(subst :N,$2,$(subst :C,$`(call [S-$3],$`1,$`2,$`3,$`4,$`5,$`6,$`7,$`8,$`9),$(subst :E,$`(eval ^TI:=$`$`(^TI) ):C$`(eval ^TI:=$`$`(subst x ,,x$`$`(^TI))),$(subst :I,info $`(^TI),$(if $(filter c,$1),$(and $(call ~set-global,[K-$3],$(or $(value [K-$3]),///////))1,$`(eval [K-$3]:=$`(subst /1111111111,1/,$`([K-$3])1)):D),$(if $(filter p%,$1),$(subst :,:$` ,$(call ~promote,$(patsubst p%,%,$1))):D,$(if $(filter t f,$1),$(if $(or $(filter f,$1),$(filter ^ta ^f ^tc ^tp ^n,$2)),$`(:I--> :N):E$`(:I<-- :N),$`(:I--> (:N$`(^ta)))$`(call ^tp,$`(^TI)<-- :N:,:E)),$(if $(filter x%,$1),$`(foreach ^X,1,:C)$`(if $`(^X),,$`(if $`(foreach ^X,$(wordlist 2,99999999,$(call ~trace-words,$(or $(patsubst x%,%,$1),11),1)),$`(if :C,)),)),$(error TRACE: Unknown mode: '$1'))))))))))
~trace-match = $(filter-out $(foreach p,^% ~% ~trace%,$(if $(filter-out $p,$1),$p)),$(filter $1,$2))
~*trace-ids* := 
~trace-id = $(or $(patsubst $1:%,%,$(filter $1:%,$(~*trace-ids*))),$(if $2,$(call ^set,~*trace-ids*,$(~*trace-ids*) $1:$(words $(~*trace-ids*)),$(words $(~*trace-ids*)))))
define ~trace-ext
$(filter %,$(foreach _-spec,$(filter-out %:v %:-,$1),$(foreach _-name,$(foreach v,$(call ~trace-match,$(filter-out :%,$(subst :, :,$(_-spec))),$(filter-out $2 [% ~trace ~untrace ~trace-ext ~untrace-ext ^Y  $(patsubst %:-,%,$(filter %:-,$1)),$(.VARIABLES))),$(if $(filter filerec%,$(origin $v)$(flavor $v)),$v)),$(foreach id,$(call ~trace-id,$(_-name),1),$(and $(and $(if $(filter u%,$(origin [S-$(id)])),$(call ~set-rglobal,[S-$(id)],$(value $(_-name))))1,$(if $(filter %:v,$1),$(call ~trace-info,[,$(subst $  ,,$(wordlist 2,999,$(subst :,: ,$(_-spec)))),] ,$(_-name)))1,$(call ~set-rglobal,$(_-name),$(call ~trace-body,$(or $(subst $  ,,$(wordlist 2,999,$(subst :,: ,$(_-spec)))),t),$(subst #,$`",$(_-name)),$(id),$(value [S-$(id)]))))1,$(_-name))))))
endef
~trace-rev = $(if $1,$(call ~trace-rev,$(wordlist 2,99999,$1)) $(word 1,$1))
~trace-dump = $(foreach line,$(sort $(foreach name,$1,$(foreach k,$(value [K-$(call ~trace-id,$(name))]),$(if $(findstring 1,$k),$(and $(call ~set-global,[K-$(call ~trace-id,$(name))],///////)1,$(call ^d,$(subst :, ,$(call ~trace-digits,$k)) $(name))))))),$(call ^d,$(call ~trace-info,$(call ^u,$(line)))))
~untrace-ext = $(call ~trace-dump,$(foreach name,$(filter $1,$(filter-out :%,$(subst :, :,$(~*trace-ids*)))),$(foreach id,$(call ~trace-id,$(name)),$(and $(call ~set-rglobal,$(name),$(value [S-$(id)]))1,$(name)))))
$(if $(call ~at-exit,$`(call ~trace-dump,$`(filter-out :%,$`(subst :, :,$`(~*trace-ids*))))),)

endef
 
define [mod-make]
# compiled from make.scm
# Requires: 'core 'runtime
# Uses: 'scam-ct
# Exports: main#1;%;p;1 build#1;%;p;1 rules#0;%;p visit-files#1;%;p;1 uninstall-file#1;%;p;1 install-file#1;%;p;2 help-str#2;\.;p;\<;subst`']LDIRS`<]foreach],1'|d],1:IL1|linked-dirs],1<|subst|@'}D|@:IL1}d|@'}!n@0@0@0~/D/`:IL1]help-raw help-raw#0;%;p is-symlink?#1;%;p;1 exists?&p;1;\.;\<;wildcard`[]1]0 find-files#1;%;p;1 relpath#1;%;p;2 vec-relpath#1;%;p;2 linked-dirs#0;%;p top#0;%;p
$(call ^require,'core)

top := top
linked-dirs := .emacs.d .config/git
vec-relpath = $(if $(and $1,$(call ~eq?,$(call ^u,$(word 1,$1)),$(call ^u,$(word 1,$2)))),$(call vec-relpath,$(wordlist 2,99999999,$1),$(wordlist 2,99999999,$2)),$(call ~append,$(foreach x,$1,..),$2))
relpath = $(call ~concat-vec,$(call vec-relpath,$(call ~split,/,$(abspath $1)),$(call ~split,/,$(abspath $2))),/)
find-files = $(foreach name,$1,$(call ^Y,$(wildcard $(name)/.* $(name)/*),,,,,,,,,$`(if $`1,$`(call find-files,$`(filter-out %/.. %/.,$`1)),$`(name))))
is-symlink? = $(shell if [ -L '$1' ] ; then echo 1 ; fi)
help-raw := Usage:$'   make help         Display this message$'   make install      Install symbolic links$'   make uninstall    Remove symbolic links$'$'The `top` directory contains an image of files to be propagated to your$'$`HOME directory.$'$'Instead of copying the files, `make install` creates symbolic links so that$'this repository can be easily updated using git.  `make install` avoids$'removing files or links that already exist; you may have to manually remove$'some files in order to deploy the ones in this project.  Also, you can$'manually replace a symbolic link with a copy in order to maintain the local$'$`HOME directory in a state that diverges from the project (e.g. work$'machines vs. personal machines).$'$'In some cases, symbolic links are created to directories rather than$'individual files.  This can make it easier to track files that are added to$'those directories and propagate changes back into this project.  Linked$'directories are: LDIRS$'$'Modify the `linked-dirs` variable in make.scm to change this.$'
install-file = $(and $(if $(if $(wildcard $(dir $1)),,1),$(and $(info Creating directory: $(dir $1))1,$(shell mkdir -p $(dir $1))))1,$(if $(wildcard $1),$(if $(call is-symlink?,$1),$(info Skipping $2 (already a symlink)),$(info AVOIDING $2 (remove pre-existing file first))),$(and $(shell ln -fs $(call relpath,$(dir $1),$(top))/$2 $1)1,$(info Installed $2))))
uninstall-file = $(if $(call is-symlink?,$1),$(and $(info Removing $1)1,$(shell rm $1)),$(if $(wildcard $1),$(info LEAVING $1 (not a symlink)),$(info Missing $1)))
visit-files = $(foreach f,$(call ~append,$(filter-out $(addsuffix /%,$(linked-dirs)),$(patsubst $(top)/%,%,$(call find-files,$(top)))),$(linked-dirs)),$(call ^Y,$(HOME)/$f,$f,,,,,,,,$1))
rules := help show install uninstall
define build
$(if $(call ~eq?,$1,help),$(info $(subst LDIRS,$(foreach d,$(linked-dirs),$(subst D,$d,
   ~/D/)),$(help-raw))),$(if $(call ~eq?,$1,show),$(call visit-files,$`(info $`1 --> $`2)),$(if $(call ~eq?,$1,install),$(call visit-files,$(value install-file)),$(if $(call ~eq?,$1,uninstall),$(call visit-files,$(value uninstall-file))))))
endef
define main
$(and $(foreach r,$(rules),$(eval $(subst X,$r,.PHONY: X
X: ; @true $`(call build,X)
)))1,$(eval Makefile: make.scm; @top/local/bin/scam -o $`@ $`< && rm *.min))
endef

endef
$(eval $(value [mod-'runtime]))
$(call ^start,make,main,$(value SCAM_ARGS))
