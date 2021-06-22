local config = {}

config.browser = "firefox"
config.editor = os.getenv("EDITOR") or "nvim"
config.editorgui = "atom"
config.filemanager = "thunar"
config.mailclient = "geary"
config.mediaplayer = "vlc"
config.scrlocker = "slimlock"
config.terminal = "alacritty"

return config
