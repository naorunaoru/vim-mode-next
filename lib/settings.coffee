
settings =
  config:
    startInInsertMode:
      type: 'boolean'
      default: false
    useSmartcaseForSearch:
      type: 'boolean'
      default: false
    wrapLeftRightMotion:
      type: 'boolean'
      default: false
    useClipboardAsDefaultRegister:
      type: 'boolean'
      default: false
    numberRegex:
      type: 'string'
      default: '-?[0-9]+'
      description: 'Use this to control how Ctrl-A/Ctrl-X finds numbers; use "(?:\\B-)?[0-9]+" to treat numbers as positive if the minus is preceded by a character, e.g. in "identifier-1".'

Object.keys(settings.config).forEach (k) ->
  settings[k] = ->
    atom.config.get('vim-mode.'+k)

  # work around vim-mode's settings sometimes being undefined
  # https://github.com/bronson/vim-mode-next/issues/2
  atom.config.observe 'vim-mode-next.'+k, (val) ->
    val = undefined if val is settings.config[k].default
    atom.config.set 'vim-mode.'+k, val

# ensure vim-mode has the proper schema too
atom.config.setSchema 'vim-mode', {type: 'object', properties: settings.config}

settings.defaultRegister = ->
  if settings.useClipboardAsDefaultRegister() then '*' else '"'

module.exports = settings
