t = {}
--БЛОКИ ИСПОЛНЕНИЯ
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = true, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Когда игра запустилась", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "start", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Позвать команду по имени", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "transive", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = true, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Когда позовут команду", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "recive", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = true, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Когда клавиша нажата(АНГЛ)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "whenkey", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Повтрорять всегда", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "forever", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = true, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Если", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "if", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = true, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Повтрорять пока", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "while", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = true, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Повтрорить раз", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "runtimes", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = true, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 2, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Ждать изменений", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "waitchange", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Ждать секунд", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "waittimes", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 1, 0}
}
--ДВИЖЕНИЕ
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Идти шагов", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "WalkSteps", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Перейти в случайное место", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "SetRandomPos", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Положение X", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getX", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Положение Y", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getY", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Поворот (макс 360)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getrotation", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Поворот влево на градусов", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "rotateleft", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Поворот вправо на градусов", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "rotateright", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить поворот", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setrotation", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить X", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setX", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить Y", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setY", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить XY", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setpos", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 1}
}
--КОСТЮМЫ
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Следующий костюм", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "nextcostume", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Предыдущий костюм", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "backcostume", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить костюм №", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setcostume", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Мой костюм №", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getcostume", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить размер", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setsize", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Показаться", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "showme", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Спрятаться", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "hideme", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Мой размер", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getsize", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0.7, 0, 0.9}
}
--МАТЕМАТИКА
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "+", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "mathplus", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "-", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "mathminus", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "*", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "mathmultiply", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "/", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "mathdivide", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "?=", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "equals", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "?не=", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "notequals", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = ">", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "1bigger", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "<", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "1smaller", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "НЕ ", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "not", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Всегда правда", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "true", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Всегда ложь", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "false", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "И", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "and", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Или", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "or", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Склеить слова", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "glue", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Буква в слове (Буква номер, слово)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getletter", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Получить переменную", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "getvar", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Установить (переменная, значение)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "setvar", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Показать переменную", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "showvar", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Показать переменную в большом формате", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "showvarbig", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Скрыть переменную", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "hidevar", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Отобразить переменную в XY (ИМЯ,X,Y)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "varsetXY", -- СИСТЕМНОЕ ИМЯ
    args = 3, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Очистить переменную", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "clearvar", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {1, 0.5, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Отобразить в консоли", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "debug", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
t[#t+1] = {
    type = 1, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Спросить значение", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "ask", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Ответ", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "response", -- СИСТЕМНОЕ ИМЯ
    args = 0, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Случайное значение (от, до)", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "random", -- СИСТЕМНОЕ ИМЯ
    args = 2, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Нажата клавиша", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "iskeypressed", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
t[#t+1] = {
    type = 3, --ТИП БЛОКА 1 - ОБЫЧНЫЙ 2 - ИСПОЛНЕНИЯ 3 - ДАННЫХ
    isStarter = false, --ЭТО БЛОК НАЧАЛА СКРИПТА???
    DisplayName = "Касается спрайта имя", -- ОТОБРАЖАЕМОЕ ИМЯ
    name = "istouching", -- СИСТЕМНОЕ ИМЯ
    args = 1, -- КОЛИЧЕСТВО АРГУМЕНТОВ
    containBlocksIn = false, -- ИМЕЕТ БЛОКИ ВНУТРИ
    color = {0, 0, 0}
}
--ДЛЯ БЛОКОВ ДАННЫХ {type = "text", data = ""} - текст {type = "block", data = блок} - блок
function r(block,args,draw,x,y,secretDebug) --САМ БЛОК, ЕГО АРГУМЕНТЫ, НУЖНО ЛИ РИСОВАТЬ,X,Y БЛОКИ ДАННЫХ АРГУМЕНТ(Д(Д(ТЕКСТ)))
    love.graphics.setFont(FontBlocks)
    local poss = {}
    local function s(color,name,x,y,xx,yy,isStarter)
        love.graphics.setFont(FontBlocks)
        if draw then
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", x, y, xx, yy)
            if isStarter then
                love.graphics.circle("fill", x + 20, y, 20)
            end
            love.graphics.setColor(1 - color[1],1 - color[2],1 - color[3])
            love.graphics.print(name, x, y)
        end

        poss[#poss+1] = {x,y,xx,yy}

    end
    local ultrayy = 50
    if block.type == 3 then
        ultrayy = 25
    end
    --ОБРАБОТЧИК АРГУМЕНТОВ, УЗНАЁМ ДЛИНУ
    local sizex = FontBlocks:getWidth(block.DisplayName)
    local i = 0
    while #args > i do --ПОКА ТОЛЬКО text
        i = i + 1
        if "text" == args[i].type then
            sizex = sizex + 10 + FontBlocks:getWidth(args[i].data)
        end
    end
    s(block.color,block.DisplayName,x,y,sizex,ultrayy,block.isStarter)
    --ОБРАБОТЧИК АРГУМЕНТОВ РИСУЕМ ДАННЫЕ
    sizex = FontBlocks:getWidth(block.DisplayName)
    i = 0
    while #args > i do --ПОКА ТОЛЬКО text
        love.graphics.setFont(FontBlocks)
        i = i + 1
        if "text" == args[i].type then
            if draw then
                love.graphics.setColor(1,1,1)
                love.graphics.rectangle("fill", x + sizex, y, FontBlocks:getWidth(args[i].data), 25)
                love.graphics.setColor(0,0,0)
                love.graphics.print(args[i].data, x + sizex, y)
            end
            table.insert(poss,{x + sizex, y, FontBlocks:getWidth(args[i].data), 25})
            sizex = sizex + 10 + FontBlocks:getWidth(args[i].data)
        end
        if "block" == args[i].type then
            local blockz = args[i].data
            local ppos = BlockRender(blockz,blockz.args,draw,x + sizex,y)
            sizex = sizex + ppos[1][3]
            table.move(ppos, 1, #ppos, #poss + 1, poss)
        end
    end
    love.graphics.setFont(Font)
    if secretDebug then
    end
    poss[1][3] = sizex
    return poss
end
return {t,r}