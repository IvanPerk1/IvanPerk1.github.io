# IvanPerk1.github.io — только релизы агентов

Исходники сайта переехали в приватный репозиторий (18.08.2026).
Здесь остаётся то, без чего сломается автообновление установленных агентов:

- **Releases** — инсталлеры. Windows: обычный релиз (Latest), тег `vX.X.X`.
  macOS: всегда pre-release, тег `vX.X.X-mac`.
- **CNAME** — держит редирект `ivanperk1.github.io` -> `wakepc.app`,
  по нему ходит Sparkle старых macOS-агентов.
- **appcast.xml** — копия фида обновлений.

Windows-агент жёстко зашит на
`api.github.com/repos/IvanPerk1/IvanPerk1.github.io/releases/latest`,
поэтому репозиторий обязан оставаться публичным, а имя менять нельзя.
