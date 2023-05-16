#!/bin/bash
echo "Привет пользователь, этот скрипт тебе позволит конвертировать все твои файлы в нужный тебе формат. Введи расширение файлов которых нужно изменить и в какое расширение их преобразовать"
read -p "Вы хотете изменить все файлы в данной папке(1),в определенной папке(2)" answer
read -p "Введите расширение исходных файлов " original
read -p "Введите расширение целевых файлов " target
if [ -z $answer ]
then
echo "Вы не ввели свое решение"
exit 1
fi
# Проверяем, что был передан параметр с расширением исходных файлов
if [ -z $original ]
then
echo "Ошибка: не указано расширение исходных файлов."
exit 1
fi
# Проверяем, что был передан параметр с расширением целевых файлов
if [ -z $target ]
then
echo "Ошибка: не указано расширение целевых файлов."
exit 1
fi
read -p "В какую папку сохранить: " dir
# Создаем директорию, если ее не существует
if [[ ! -d $dir ]]
then
    echo "Папка для вывода не найдена, создаю новую"
    mkdir -p $dir
else
    echo "Папка для вывода найдена, продолжаю"
fi
if [[ $answer -eq 2 ]]
then
    read -p "Введите название папки в которой нужно изменить файлы [folder1/folder2/target_folder]: " folder
    if [[ ! -d $folder ]]
    then
        echo "Папка для с файлами не найдена"
        exit 1
    else
        echo "Папка найдена"
        fol=$(ls $folder/*.$original)
    fi
else
    fol=*.$original
fi
for file in $fol
do
    #Получаем имя файла с помощью функции basename
    filename=$(basename "$file")
    #Получем расширение
    extension=${filename##*.}
    #Получаем имя фала без расширения
    filename=${filename%.*}
    echo "Конвертирую файл $filename.$original в $filename.$target"
    libreoffice --headless --convert-to $target --outdir $dir/ $file
done
fi
