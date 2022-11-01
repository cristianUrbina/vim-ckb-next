if exists("g:loaded_vimckbnext")
	finish
endif
let g:loaded_vimckbnext = 1

let s:LastUpdatedMode = ""

function! s:CKBRefresh(id)
	if s:LastUpdatedMode == mode()
		return
	endif
	let s:LastUpdatedMode = mode()

	if mode() == "n" " Normal mode
		call system("ckb-next -m Normal")
	elseif mode() == "i" " Insert mode
		call system("ckb-next -m Insert")
	elseif mode() == "R" || mode() == "Rv" " Replace mode
		call system("ckb-next -m Replace")
	elseif mode() == "v" || mode() == "V" || mode() == "" " Visual
		call system("ckb-next -m Visual")
	endif
endfunction

call timer_start(100, function("s:CKBRefresh"), {"repeat": -1})
call system("ckb-next -p Vim")
autocmd InsertEnter,InsertChange,InsertLeave * call s:CKBRefresh(0)

