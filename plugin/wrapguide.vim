if exists('g:loaded_wrap_guide')
  finish
endif
let g:loaded_wrap_guide = 1

command! WrapGuideEnable call wrapguide#WrapGuideEnable()
command! WrapGuideDisable call wrapguide#WrapGuideDisable()
command! WrapGuideToggle call wrapguide#WrapGuideToggle()
