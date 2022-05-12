
function wrapguide#WrapGuideEnable() abort
    if g:wrap_guide_enabled
        return
    end

    highlight link WrapGuide NonText
    let g:wrap_guide_ns = nvim_create_namespace('wrap_guide')
    augroup WrapGuide
        au!
        au TextChanged,TextChangedI,OptionSet * lua wrap_guide_refresh()
    augroup END
    lua wrap_guide_refresh()
    let g:wrap_guide_enabled = 1
endfunction


lua <<EOT
function _G.wrap_guide_refresh()
    local bnr = vim.fn.bufnr('%')
    local ns_id = vim.g.wrap_guide_ns
    local wrap_col = vim.api.nvim_get_option('textwidth')
    local line_len = vim.fn.line('$')
    local col_num = 0

    local opts = {
        priority = 1000,
        virt_text = {{"│", "WrapGuide"}},
        virt_text_win_col = wrap_col,
    }

    vim.api.nvim_buf_clear_namespace(bnr, ns_id, 0, -1)

    local line_num = 0
    for line = 0, ( line_len-1 ) do
        if vim.fn.virtcol({ line+1, '$' }) <= ( wrap_col + 1 ) then
            local mark_id = vim.api.nvim_buf_set_extmark( bnr, ns_id, line, col_num, opts )
        end
    end
end
EOT


function wrapguide#WrapGuideDisable() abort
    if ! g:wrap_guide_enabled
        return
    end

    call nvim_buf_clear_namespace(0, g:wrap_guide_ns, 0, -1)
    augroup WrapGuide
        au!
    augroup END

    let g:wrap_guide_enabled = 0
endfunction


function wrapguide#WrapGuideToggle() abort
    if g:wrap_guide_enabled
        call wrapguide#WrapGuideDisable()
    else
        call wrapguide#WrapGuideEnable()
    end
endfunction


let g:wrap_guide_enabled = 0

