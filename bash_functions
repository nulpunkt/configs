function watchAndSyncColourbox {
        while true; do
                inotifywait -r -e modify -q application library private public-src scripts more-tests tests
                make 
                rsync -vaCzh --timeout=5 --delete --exclude=public-src --exclude=node_modules --exclude=logs --exclude=\*.swp . www@beta.colourbox.com:/mnt/www/jesper
				# sed -i 's/127.0.0.1/beta.colourbox.com/g' application/configs/application.ini
				# sed -i 's/localhost/test-api.cbx.xyz/g' application/configs/application.ini
                # rsync -vaCzh --timeout=5 --delete --exclude=public-src --exclude=node_modules --exclude=logs --exclude=\*.swp . 3.250.155.40:/var/www/jesper2
        done
}

function watchAndSyncColourbox8 {
        while true; do
                inotifywait -r -e modify -q application library private public-src scripts more-tests tests
                make 
				sed -i 's/127.0.0.1/beta.colourbox.com/g' application/configs/application.ini
				sed -i 's/localhost/test-api.cbx.xyz/g' application/configs/application.ini
                rsync -vaCzh --timeout=5 --delete --exclude=public-src --exclude=node_modules --exclude=logs --exclude=\*.swp . 3.250.155.40:/var/www/jesper2
        done
}

function watchAndSyncApi {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --timeout=5 --delete --exclude=logs --exclude=\*.swp . www@beta.colourbox.com:/mnt/www/jesper-api
        done
}

function watchAndSyncSkyfishFrontpage {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --delete --exclude=logs --exclude=\*.swp ./server/* www@beta.colourbox.com:/mnt/www/jesper-skyfish-frontpage
        done
}

function watchAndSyncArbeit {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --delete --exclude=lib/arbeit/test --exclude=logs --exclude=\*.swp . beta.colourbox.com:~/jesper-arbeit
        done
}

function watchAndSyncPublicPage {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --delete --exclude=public-src --exclude=node_modules --exclude=logs --exclude=\*.swp . www@beta.colourbox.com:/mnt/www/jesper-public
        done
}

function watchAndSyncPublicPage8 {
        while true; do
                inotifywait -r -e modify -q .
				rsync -vrCzh --delete --exclude=public-src --exclude=node_modules --exclude=logs --exclude=\*.swp . 3.250.155.40:/var/www/jesper-public
        done
}

function watchAndSyncTranslationBackend {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --delete --exclude=\*.swp . www@beta.colourbox.com:/mnt/www/jesper-tb
        done
}

function watchAndSyncMailservice {
        while true; do
                inotifywait -r -e modify -q .
                rsync -vaCzh --delete --exclude=\*.swp . www@beta.colourbox.com:/mnt/www/jesper-mailservice
        done
}

function cw-tail {
        (cd ~/Bin/cw-tail && pipenv run python tail.py '/aws/codebuild/'$1 $2)
}

function nodelol() {
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        nvm use
}
