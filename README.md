каждая папка = тема

index.md — точка входа (оглавление темы)

файлы — атомарные руководства


git pull
vim docs/docker/compose.md

# посмотреть в браузере
docker compose up docs

# собрать EPUB по теме
# docker compose run pandoc sh scripts/build-epub.sh docs/docker/index.md
make epub SRC=docs/docker/index.md

# отправить на Kindle
# docker compose run pandoc sh scripts/send-to-kindle.sh epub/docker.epub
make kindle FILE=epub/docker.epub


# зафиксировать изменения
git commit -am "Update docker docs"
git push