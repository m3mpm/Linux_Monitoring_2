# Linux_Monitoring_2

Мониторинг и исследование состояния системы в реальном времени.

## Требование к проекту

- Написанные Bash-скрипты должны находиться в папке src;
- Для каждого задания должна быть создана папка с названием вида: **0x**, где x - номер задания;
- Все скрипты должны быть декомпозированы и разбиты на несколько файлов;
- Файл с основным сценарием для каждого задания должен называться **main.sh**;
- Во всех скриптах необходимо предусмотреть проверки на некорректный ввод (указаны не все параметры, параметры неправильного формата и т.д.);

## Примечание

- Если скрипты запускаются на _Ubuntu_, то необходимо использовать команду **sudo**. Пример запуска скрипта: \
  `sudo ./main.sh /opt/test 4 az 5 az.az 3kb`

## Задача 1. Генератор файлов

Написать bash-скрипт. Скрипт запускается с 6 параметрами. Пример запуска скрипта: \
`main.sh /opt/test 4 az 5 az.az 3kb`

**Параметр 1** - это абсолютный путь. \
**Параметр 2** - количество вложенных папок. \
**Параметр 3** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 4** - количество файлов в каждой созданной папке. \
**Параметр 5** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 6** - размер файлов (в килобайтах, но не более 100).

Имена папок и файлов должны состоять только из букв, указанных в параметрах, и использовать каждую из них хотя бы один раз.  
Длина этой части имени должна быть от четырех знаков, плюс дата запуска скрипта в формате DDMMYY, отделённая нижним подчёркиванием, например: \
**./aaaz_021121/**, **./aaazzzz_021121**

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок не может быть обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных символов в параметре должен сохраняться.

При запуске скрипта в месте, указанном в Параметре 1, должны быть созданы папки и файлы в них с соответствующими именами и размером.  
Скрипт должен остановить работу, если в файловой системе (в разделе /) останется 1 Гб свободного места.  
Создать лог-файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).

## Задача 2. Засорение файловой системы

Написать bash-скрипт. Скрипт запускается с 3 параметрами. Пример запуска скрипта: \
`main.sh az az.az 3Mb`

**Параметр 1** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 2** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 3** - размер файла (в Мегабайтах, но не более 100).

Имена папок и файлов должны состоять только из букв, указанных в параметрах, и использовать каждую из них хотя бы 1 раз.  
Длина этой части имени должна быть от 5 знаков, плюс дата запуска скрипта в формате DDMMYY, отделённая нижним подчёркиванием, например: \
**./aaazz_021121/**, **./aaazzzz_021121**

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок не может быть обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных в параметре символов должен сохраняться.

При запуске скрипта в различных (любых, кроме путей содержащих **bin** или **sbin**) местах файловой системы должны быть созданы папки с файлами.
Количество вложенных папок - до 100. Количество файлов в каждой папке - случайное число (для каждой папки своё).  
Скрипт должен остановить работу, когда в файловой системе (в разделе /) останется 1 Гб свободного места.  
Свободное место в файловой системе определять командой: `df -h /`

Создать лог-файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).  
В конце работы скрипта необходимо вывести на экран время начала работы скрипта, время окончания и общее время его работы. Дополни этими данными лог-файл.

## Задача 3. Очистка файловой системы

Написать bash-скрипт. Скрипт запускается с 1 параметром.
Скрипт должен уметь очистить систему от созданных в [Задаче 2](#задача-2-засорение-файловой-системы) папок и файлов 3 способами:

1. По лог файлу
2. По дате и времени создания
3. По маске имени (т.е. символы, нижнее подчёркивание и дата).

Способ очистки задается при запуске скрипта, как параметр со значением 1, 2 или 3.

_При удалении по дате и времени создания пользователем вводятся времена начала и конца с точностью до минуты. Удаляются все файлы, созданные в указанном временном промежутке. Ввод может быть реализован как через параметры, так и во время выполнения программы._

## Задача 4. Генератор логов

Написать bash-скрипт, генерирующие 5 файлов логов **nginx** в _combined_ формате.
Каждый лог должен содержать информацию за один день.

За день должно быть сгенерировано случайное число записей от 100 до 1000.
Для каждой записи должны случайным образом генерироваться:

1. IP (любые корректные, т.е. не должно быть ip вида 999.111.777.777)
2. Коды ответа (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. Методы (GET, POST, PUT, PATCH, DELETE)
4. Даты (в рамках заданного дня лога, должны идти по увеличению)
5. URL запроса агента
6. Агенты (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

В комментариях к своему скрипту/программе необходимо указать, что означает каждый из использованных кодов ответа.

## Задача 5. Мониторинг

Написать bash-скрипт для разбора логов **nginx** из [Части 4](#задача-4-генератор-логов) через **awk**.

Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.
В зависимости от значения параметра выведи:

1. Все записи, отсортированные по коду ответа;
2. Все уникальные IP, встречающиеся в записях;
3. Все запросы с ошибками (код ответа - 4хх или 5хх);
4. Все уникальные IP, которые встречаются среди ошибочных запросов.

## Задача 6. **GoAccess**

С помощью утилиты GoAccess получи ту же информацию, что и в [Части 5](#задача-5-мониторинг).

Открой веб-интерфейс утилиты на локальной машине.
