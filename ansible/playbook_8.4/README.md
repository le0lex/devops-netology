Данный play:

- устанавливает репозиторий EPEL;
- устанавливает ngin;
- устанавливает git;
- стартует nginx и добавляет его в автозагрузку;
- устанавливает firewall;
- запускает fireWall;
- конфигурирует FireWall;
- создаем директорию, где будет находиться lighthouse;
- создает директорию, для lighthouse;
- проверяет, наличие установленного lighthouse, если он установлен, то следующий шаг пропускается;
- клонирует репозиторий в созданную папку и меняет путь в nginx.conf где у нас находится lighthouse;
- перезапускает nginx;
