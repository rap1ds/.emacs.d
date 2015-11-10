(add-to-list 'load-path "~/Documents/Projects/own/spotify-el")
(require 'spotify)

(spotify-enable-song-notifications)

(global-set-key (kbd "<f6>") 'spotify-previous)
(global-set-key (kbd "<f7>") 'spotify-playpause)
(global-set-key (kbd "<f8>") 'spotify-next)

(provide 'init-spotify)
