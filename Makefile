#!/bin/bash
:; for v in "${@//!/!1}" ; do v=${v// /!0} ; v=${v//	/!+}; a[++n]=${v:-!.} ; done ; SCAM_ARGS=${a[*]} exec make --no-print-directory -j ${SCAM_JOBS:-9} -f"$0"


define ///core.min
~eq? = $(if $(findstring 1$1,$(findstring 1$2,1$1)),1)
~identity = $1
~xor = $(if $1,$(if $2,,$1),$2)
~concat-vec = $(call ~promote,$(subst $  ,$(call ~demote,$2),$1))
~cons = $(call ~demote,$1)$(if $2, )$2
~conj = $1$(if $1, )$(call ~demote,$2)
~last = $(call ~promote,$(lastword $1))
~strip-vec = $(filter %,$1)
~butlast = $(wordlist 2,$(words $1),X $1)
~map-call = $(foreach x,$2,$(call ^d,$(call $1,$(call ^u,$x))))
~select-vec = $(filter-out !,$(foreach dx,$2,$(if $(call ^Y,$(call ~promote,$(dx)),,,,,,,,,$1),$(dx),!)))
~select-words = $(foreach a,$(foreach x,$2,$(if $(call ^Y,$x,,,,,,,,,$1),$x)),$a)
~vec-or = $(call ^u,$(word 1,$(filter-out !.,$1)))
~indices-x = $(if $(word $(words $2),$1),$(words $2) $(call ~indices-x,$1,1 $2))
~rev-by-10s = $(if $1,$(if $2,$(foreach p,10 9 8 7 6 5 4 3 2 1,$(call ~rev-by-10s,$(wordlist $(word $p,0 1 2 3 4 5 6 7 8 9)$(patsubst %0,%1,$2),$p$2,$1),$(patsubst 0%,%,$2))),$(foreach p,10 9 8 7 6 5 4 3 2 1,$(word $p,$1))))
~rev-zeroes = $(if $(word 1$21,$1),$(call ~rev-zeroes,$1,0$2),$2)
~reverse = $(wordlist 1,99999999,$(call ~rev-by-10s,$1,$(call ~rev-zeroes,$1,)))
~while-0 = $(if $(filter iiiiiiiiiiiiiiiiiiii,$4),1 $(call ^d,$3),$(if $(call ^Y,$3,,,,,,,,,$1),$(call ~while-0,$1,$2,$(call ^Y,$3,,,,,,,,,$2),i$4),0 $(call ^d,$3)))
~while-N = $(if $(filter 0,$(word 1,$3)),$3,$(if $(filter iii,$5),$(if $(filter 1,$4),$(call ~while-N,$1,$2,$3,$4 0,ii),$3),$(call ~while-N,$1,$2,$(if $4,$(call ~while-N,$1,$2,$3,$(wordlist 2,99999999,$4),),$(call ~while-0,$1,$2,$(call ~nth,2,$3),)),$4,i$5)))
~while = $(if $(call ^Y,$3,,,,,,,,,$1),$(call ^Y,$(call ^Y,$3,,,,,,,,,$2),,,,,,,,,$`(call ~nth,2,$`(call ~while-N,$(call ^E,$1),$(call ^E,$2),$`(call ~while-0,$(call ^E,$1),$(call ^E,$2),$`1,),1,ii))),$3)
~numeric? = $(if $(filter 0% 1% 2% 3% 4% 5% 6% 7% 8% 9%,$(subst -,,$1)),$(if $(patsubst .%,%,$(patsubst %e,%,$(subst 0,,$(patsubst -%,%,$(subst $  ,_,$(subst E0,e,$(subst E-,E,$(subst e,E,$(subst 9,0,$(subst 8,0,$(subst 7,0,$(subst 6,0,$(subst 5,0,$(subst 4,0,$(subst 3,0,$(subst 2,0,$(subst 1,0,$1))))))))))))))))),,$1))
~natural? = $(call ~numeric?,$(subst 0,,$(subst .,~,$(subst -,~,$(subst e,~,$(subst E,~,$1))))))
~append = $(filter %,$1 $2 $3 $4 $5 $6 $7 $8 $(if $9,$(call ~promote,$9)))
~hash-bind = $(subst %,!8,$(call ^d,$1))!=$(call ^d,$2)$(if $3, )$3
~hash-key = $(call ~promote,$(subst !8,%,$(word 1,$(subst !=, ,$1))))
~hash-value = $(call ~nth,2,$(subst !=, ,$1))
~hash-find = $(word 1,$(filter $(subst %,!8,$(call ^d,$1))!=%,$2))
~hash-get = $(call ~nth,2,$(subst !=, ,$(call ~hash-find,$1,$2))$(if $3, x $(call ~demote,$3)))
~hash-compact = $(if $(if $1,,1),$2,$(call ~append,$(word 1,$1),$(call ~hash-compact,$(filter-out $(word 1,$(subst !=,!=% ,$(word 1,$1))),$(wordlist 2,99999999,$1)))))
~hash-keys = $(foreach e,$1,$(subst !8,%,$(word 1,$(subst !=, ,$e))))
~format-hash = $(if $(findstring !=,$1),$(if $(call ~eq?,$1,$(foreach w,$1,$(call ~hash-bind,$(call ~nth,1,$(subst !=, ,$w)),$(call ~nth,2,$(subst !=, ,$w))))),{$(call ~concat-vec,$(foreach e,$1,$(call ^d,$(call ~format,$(call ~promote,$(subst !8,%,$(word 1,$(subst !=, ,$e))))): $(call ~format,$(call ~nth,2,$(subst !=, ,$e))))),$(if ,,, ))}))
~data-foreach = $(if $2,$(call ~data-foreach,$1,$(wordlist 2,99999999,$2),$(wordlist 2,99999999,$3),$4$(if $4, )$(call ^Y,$(if $(filter L,$(word 1,$2)),$3,$(if $(filter S,$(word 1,$2)),$(call ~nth,1,$3),$(if $(filter W,$(word 1,$2)),$(word 1,$3),$(error bad encoding in ctor pattern)))),$(word 1,$2),,,,,,,,$1)),$4)
~format-record = $(if $(filter !:%,$(word 1,$1)),$(call ^Y,$(call ~hash-get,$(word 1,$1),$(^tags)),$(wordlist 2,99999999,$1),$(word 1,$1),$1,,,,,,$`(and $`1,$`(call ~eq?,$`(filter %,$`4),$`(filter %,$`(call ~data-foreach,$``(if $``(call ~eq?,S,$``2),$``(call ^d,$``1),$``1),$`(wordlist 2,99999999,$`1),$`2,$`3))),($`(call ~nth,1,$`1)$`(if $`(wordlist 2,99999999,$`1), )$`(call ~data-foreach,$``(if $``(and $``(call ~eq?,L,$``2),$``(if $``1,,1)),[],$``(call ~format,$``1)),$`(wordlist 2,99999999,$`1),$`2,)))))
~*format-funcs* := 
~format-add = $(call ^set,~*format-funcs*,$(call ~cons,$1,$(~*format-funcs*)))
~format-custom = $(if $2,$(or $(call ^Y,$1,,,,,,,,,$(call ^u,$(word 1,$2))),$(call ~format-custom,$1,$(wordlist 2,99999999,$2))))
define ~format
$(or $(call ~format-custom,$1,$(~*format-funcs*)),$(if $(findstring !,$1),$(or $(call ~format-hash,$1),$(call ~format-record,$1))),$(if $(or $(findstring !,$1),$(and $(findstring $  ,$1),$(call ~numeric?,$(subst $  ,,$1)))),$(if $(call ~eq?,$1,$(foreach w,$1,$(call ~demote,$(call ~promote,$w)))),[$(foreach w,$1,$(call ~format,$(call ~promote,$w)))])),$(call ~numeric?,$1),"$(subst $ 	,\t,$(subst 
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
 
define ///make.min
$(call ^require,core)
top := top
linked-dirs := .emacs.d .config
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
 
define ///runtime.min
SCAM_DEBUG ?=
$(if $(if $(findstring R,$(SCAM_DEBUG)),$(info runtime: $(lastword $(MAKEFILE_LIST)))),)
define \n


endef
 [ := (
 ] := )
" := \#
' := $(\n)
` := $$
& := ,

^d = $(or $(subst $  ,!0,$(subst $ 	,!+,$(subst !,!1,$1))),!.)
^u = $(subst !1,!,$(subst !+,	,$(subst !0, ,$(subst !.,,$1))))
^n = $(call ^u,$(word $1,$2))
^Y = $(call if,,,$(10))
^v = $(subst !.,!. ,$(filter-out %!,$(subst !. ,!.,$(foreach n,$(wordlist $N,9,1 2 3 4 5 6 7 8),$(call ^d,$($n)))$(if $9, $9) !)))
^av = $(foreach N,1,$(^v))
~^apply = $(call ^Y,$(call ^n,1,$2),$(call ^n,2,$2),$(call ^n,3,$2),$(call ^n,4,$2),$(call ^n,5,$2),$(call ^n,6,$2),$(call ^n,7,$2),$(call ^n,8,$2),$(wordlist 9,9999,$2),$1)
~^f = "$(subst ",\",$(subst \,\\,$1))"
^tp = $(info $1 $(call ~^f,$2))$2
~^tc = $(call $1,$2,$3,$4,$5,$6,$7,$8,$(call ^n,1,$9),$(wordlist 2,9999,$9))
^ta = $(if $(or $1,$2,$3,$4,$5,$6,$7,$8,$9), $(~^f)$(call ~^tc,^ta,$2,$3,$4,$5,$6,$7,$8,$9))
^t = $(info --> ($1$(call ~^tc,^ta,$2,$3,$4,$5,$6,$7,$8,$9)))$(call ^tp,<-- $1:,$(call ~^tc,$1,$2,$3,$4,$5,$6,$7,$8,$9))
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
~add-hook = $(call ^set,~*hooks*,$(~*hooks*) $1=$2)
~run-hooks = $(foreach funcname,$(patsubst $1=%,%,$(filter $1=%,$(~*hooks*))),$(call $(funcname)))
^tags := 
^add-tags = $(call ^set,^tags,$(^tags) $(filter-out $(^tags),$1))
~^required-files := ///runtime.min
^require = $(foreach ^file,$(filter-out $(~^required-files),$(or $(word 1,$(foreach f,$(SCAM_MODS),$(if $(filter $(notdir $1),$(notdir $(basename $f))),$f))),$(if $(if $(filter-out u%,$(flavor ///$(notdir $1).min)),1),///$(notdir $1).min,$1.min))),$(and $(call ^set,~^required-files,$(~^required-files) $(^file))1,$(if $(findstring R,$(SCAM_DEBUG)),$(info require: $(^file)))1,$(if $(filter ///%,$(^file)),$(eval $(value $(^file))),$(eval include $(^file)))1,$(call ~run-hooks,load)1,$(if $(findstring Rx,$(SCAM_DEBUG)),$(info exited: $(^file)))))
define ~start
$(if $(if $(*started*),,1),$(and $(call ^set,*started*,1)1,$(if $(if $(filter-out u%,$(flavor ///trace.min)),1),$(call ^require,trace))1,$(call ^require,$(notdir $1))1,$(call ^Y,$(call $2,$3),,,,,,,,,$`(eval .DEFAULT_GOAL :=
.PHONY: .scam/-exit
.scam/-exit: $`(.DEFAULT_GOAL); @exit '$`(or $`(subst ',,$`(strip $`1)),0)'$``(call ~run-hooks,exit)))))
endef
$(if $(if $(if $(if $(filter-out u%,$(flavor ^start)),1),,1),$(call ^fset,^start,$(value ~start))),)
$(if $(if $(SCAM_MAIN),$(call ~start,$(SCAM_MAIN),,)),)

endef
 
define ///scam-ct.min
~r.sav := $(value ^require)
^require = 
$(call ^require,runtime)
~when = !:P0 118 !1:P2!0119!0if $(word 1,$1) $(call ^d,!:P0 128 !1:P2!0129!0begin $(wordlist 2,99999999,$1))
~unless = !:P0 180 !1:P2!0181!0if $(word 1,$1) !1:P2!0186!0nil $(call ^d,!:P0 188 !1:P2!0189!0begin $(wordlist 2,99999999,$1))
$(call ^fset,^require,$(~r.sav))

endef
 
define ///trace.min
~*trace-ignore-vars* := 
~*traces* := 
override SCAM_PRE := $(value SCAM_PRE)
^K = $(eval ^K_$0:=$(subst ioooooooooo,oi,$(^K_$0:o%=io%)o))
~trace-digits = $(if $(if $(findstring i,$1),,1),$(call ~trace-digits,i$1),$(if $(findstring ioooooooooo,$1),$(call ~trace-digits,$(subst ioooooooooo,oi,$1)),$(subst $  ,,$(wordlist $(words $(subst i, i,$1)),99,. . . . . . . . $(foreach d,$(subst i, i,$1),$(words $(subst i,,$(subst o, o,$d))))))))
~trace-n2a = $(if $(if $(filter i%,$1),,1),$(call ~trace-n2a,i$1),$(if $(findstring ioooooooooo,$1),$(call ~trace-n2a,$(subst ioooooooooo,oi,$1)),$(subst 10,A,$(words $(subst i, i,$1)))!0$(subst $  ,,$(foreach d,$(subst i, i,$1),$(words $(subst i,,$(subst o, o,$d)))))))
~list-of = $(if $(word $1,$2),$2,$(call ~list-of,$1,$2 x))
~trace-repeater = $(subst NAME,$1,$(subst N-1,$(wordlist 2,99999999,$(call ~list-of,$(or $2,11))),$(if $3,$`(if $`(^X),$`(call if,,,$`(value NAME)),$`(if $`(foreach ^X,N-1,$`(if $`(NAME),)),)$`(foreach ^X,0,$`(NAME))),$`(NAME)$`(if $`(foreach ^xx,N-1,$`(NAME)),))))
~trace-info = $(info TRACE: $1$2$3$4$5)
~trace-match-funcs = $(foreach v,$(if $(findstring %,$1),$(filter $1,$(filter-out $(~*trace-ignore-vars*),$(subst %,(),$(.VARIABLES)))),$1),$(if $(filter recur%,$(flavor $v)),$v))
~trace-instrument = $(if $(filter v,$1),$(and $(call ~trace-info,$2, [,$(flavor $2),] = ,$(value $2))1,$3),$(if $(filter c,$1),$`(^K)$3,$(if $(filter x% X%,$1),$(and $(call ~set-rglobal,$2~0~,$3)1,$(call ~trace-repeater,$2~0~,$(patsubst x%,%,$(subst X,x,$1)),$(filter X%,$1))),$(if $(filter p,$1),$(or $(SCAM_PRE),$(call ~trace-info,SCAM_PRE undefined; needed for ,$2,:p))$3,$(if $(filter t,$1),$(subst CODE,$3,$`(info --> ($`0$`(^ta)))$`(call ^tp,<-- $`0:,CODE)),$(and $(call ~trace-info,Unknown action: ',$1,')1,$3))))))
~*traces-active* := 
~trace-check = $(call ^set,~*traces-active*,$(strip $(~*traces-active*) $(foreach w,$(~*traces*),$(foreach name,$(call ~trace-match-funcs,$(firstword $(subst :, % ,$w))),$(foreach action,$(or $(wordlist 2,99999999,$(subst :, ,.$w)),t),$(if $(if $(filter $(name):$(patsubst x%,x,$(subst X,x,$(action))),$(~*traces-active*)),,1),$(and $(call ~set-rglobal,$(name),$(call ~trace-instrument,$(action),$(name),$(value $(name))))1,$(name):$(patsubst x%,x,$(subst X,x,$(action))))))))))
~trace-rev = $(if $1,$(call ~trace-rev,$(wordlist 2,99999999,$1)) $(firstword $1))
~trace-dump = $(and $(foreach s,$(foreach s,$(~*traces*),$(word 1,$(subst :, ,$s))),$(if $(if $(filter $s,$(foreach s,$(~*traces-active*),$(word 1,$(subst :, ,$s)))),,1),$(call ~trace-info,spec ',$s,' did not match any functions.)))1,$(if $(filter %c,$(~*traces-active*)),$(and $(call ~trace-info,function invocations)1,$(foreach r,$(call ~trace-rev,$(sort $(foreach V,$(filter ^K_%,$(.VARIABLES)),$(call ~trace-digits,$(value $V))$(patsubst ^K_%,::%,$V)))),$(call ~trace-info,$(subst ., ,$(word 1,$(subst ::, ,$r))), : ,$(word 2,$(subst ::, ,$r)))))))
~trace = $(and $(call ^set,~*traces*,$(~*traces*) $1)1,$(call ~trace-check))
~*trace-ignore-vars* := $(filter-out $(~*trace-ignore-vars*),$(subst %,(),$(.VARIABLES)))
$(if $(call ~trace,$(SCAM_TRACE)),)
$(if $(call ~add-hook,load,~trace-check),)
$(if $(call ~add-hook,exit,~trace-dump),)

endef
$(eval $(value ///runtime.min))
$(call ^start,///make,main,$(SCAM_ARGS))
