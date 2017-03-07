//This Source Code Form is subject to the terms of the Mozilla
//Public License, v. 2.0. If a copy of the MPL was not distributed
//with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#Использовать cmdline
#Использовать logos
#Использовать tempfiles
#Использовать asserts
#Использовать v8runner
#Использовать strings

#Использовать "../src"

Перем Лог;
Перем КодВозврата;
Перем мВозможныеКоманды;
Перем ЭтоWindows;
Перем РезультатыОбработкиВнешнихОбработок;
Перем КаталогЛогов;
Перем КорневойПутьПроекта;

Функция ВозможныеКоманды()
	
	Если мВозможныеКоманды = Неопределено Тогда
		//Работаем в 8.3.8, внешние обработки как исходники и только исходники. 
		мВозможныеКоманды = Новый Структура;
		мВозможныеКоманды.Вставить("ИнициализацияОкружения", "init-dev");
		мВозможныеКоманды.Вставить("ОбновлениеОкружения", "update-dev");
		мВозможныеКоманды.Вставить("Помощь", "--help");
	КонецЕсли;
	
	Возврат мВозможныеКоманды;
	
КонецФункции

Процедура ВывестиСправку()
	
	Сообщить("Утилита для инициализации окружения разработчика для доработки vanessa");
	Сообщить(" ");
	Сообщить("Параметры командной строки:");
	
	Сообщить(" init-dev");
	Сообщить("     инициализируем пустую базу данных для выполнения необходимых тестов");
	Сообщить("     указываем путь к исходниками с конфигурацией");
	Сообщить("     указываем версию платформы которую хотим использовать");
	Сообщить("     и получаем по пути build\ib готовую базу для тестирования. ");
	
	Сообщить(" update-dev");
	Сообщить("     обновляет пустую базу данных для выполнения необходимых тестов");
	Сообщить("     указываем путь к исходниками с конфигурацией");
	Сообщить("     указываем версию платформы которую хотим использовать");
	Сообщить("     и получаем по пути build\ib готовую базу для тестирования. ");
	
	Сообщить(" общие для всех параметры");
	Сообщить("       --v8version Маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.)");
	Сообщить(" общие для xunit, vaness, tests, compilecurrent, decompilecurrent, run, dbupdate");
	Сообщить("       --ibname строка подключения к базе данных");
	Сообщить("       --db-user имя пользователя для подключения к базе");
	Сообщить("       --db-pwd пароль пользователя");
	
	Сообщить("	--help");
	Сообщить("		Показ этого экрана");
	
КонецПроцедуры

Процедура ДобавитьОписаниеКомандыИнициализацияОкружения(Знач Парсер)
	ОписаниеКоманды = Парсер.ОписаниеКоманды(ВозможныеКоманды().ИнициализацияОкружения);
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--src", "Путь к папке исходников");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--dt", "Путь к файлу с dt выгрузкой");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "--dev", "Признак dev режима, создаем и загружаем автоматом структуру конфигурации");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "--storage", "Признак обновления из хранилища");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-name", "Строка подключения к хранилище");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-user", "Пользователь хранилища");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-pwd", "Пароль");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-ver",	"Номер версии, по умолчанию берем последнюю");
	Парсер.ДобавитьКоманду(ОписаниеКоманды);
КонецПроцедуры

Процедура ДобавитьОписаниеКомандыОбновлениеОкружения(Знач Парсер)
	ОписаниеКоманды = Парсер.ОписаниеКоманды(ВозможныеКоманды().ОбновлениеОкружения);
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--src", "Путь к папке исходников");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--dt", "Путь к файлу с dt выгрузкой");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "--dev", "Признак dev режима, создаем и загружаем автоматом структуру конфигурации");
	Парсер.ДобавитьПараметрФлагКоманды(ОписаниеКоманды, "--storage", "Признак обновления из хранилища");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-name", "Строка подключения к хранилище");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-user", "Пользователь хранилища");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-pwd", "Пароль");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "--storage-ver",	"Номер версии, по умолчанию берем последнюю");
	Парсер.ДобавитьКоманду(ОписаниеКоманды);
КонецПроцедуры

Процедура ДобавитьОписаниеКомандыПомощь(Знач Парсер)
	ОписаниеКоманды = Парсер.ОписаниеКоманды(ВозможныеКоманды().Помощь);
	Парсер.ДобавитьКоманду(ОписаниеКоманды);
КонецПроцедуры

Процедура ДополнитьАргументыИзПеременныхОкружения(ЗначенияПараметров = Неопределено, СоответствиеПеременных)
	
	СИ = Новый СистемнаяИнформация;
	Для каждого Элемент Из СоответствиеПеременных Цикл
		ЗначениеПеременной = СИ.ПолучитьПеременнуюСреды(ВРег(Элемент.Ключ));
		ПараметрКомманднойСтроки = ЗначенияПараметров.Получить(Элемент.Значение);
		Если ПараметрКомманднойСтроки = Неопределено ИЛИ ПустаяСтрока(ПараметрКомманднойСтроки) Тогда 
			Если ЗначениеЗаполнено(ЗначениеПеременной) И НЕ ПустаяСтрока(ЗначениеПеременной) Тогда
				ЗначенияПараметров.Вставить(Элемент.Значение, ЗначениеПеременной);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция ЗапуститьПроцесс(Знач СтрокаВыполнения)
	Перем ПаузаОжиданияЧтенияБуфера;
	
	ПаузаОжиданияЧтенияБуфера = 10;
	
	Лог.Отладка(СтрокаВыполнения);
	Процесс = СоздатьПроцесс(СтрокаВыполнения,,Истина);
	Процесс.Запустить();
	
	ТекстБазовый = "";
	Счетчик = 0; МаксСчетчикЦикла = 100000;
	
	Пока Истина Цикл 
		Текст = Процесс.ПотокВывода.Прочитать();
		Лог.Отладка("Цикл ПотокаВывода "+Текст);
		Если Текст = Неопределено ИЛИ ПустаяСтрока(СокрЛП(Текст))  Тогда 
			Прервать;
		КонецЕсли;
		Счетчик = Счетчик + 1;
		Если Счетчик > МаксСчетчикЦикла Тогда 
			Прервать;
		КонецЕсли;
		ТекстБазовый = ТекстБазовый + Текст;
		
		sleep(ПаузаОжиданияЧтенияБуфера); //Подождем, надеюсь буфер не переполниться. 
		
	КонецЦикла;
	
	Процесс.ОжидатьЗавершения();
	
	Если Процесс.КодВозврата = 0 Тогда
		Текст = Процесс.ПотокВывода.Прочитать();
		Если Текст = Неопределено ИЛИ ПустаяСтрока(СокрЛП(Текст)) Тогда 

		Иначе
			ТекстБазовый = ТекстБазовый + Текст;
		КонецЕсли;
		Лог.Отладка(ТекстБазовый);
		Возврат ТекстБазовый;
	Иначе
		ВызватьИсключение "Сообщение от процесса 
		| код:" + Процесс.КодВозврата + " процесс: "+ Процесс.ПотокОшибок.Прочитать();
	КонецЕсли;	

КонецФункции

Функция ПрочитатьФайлИнформации(Знач ПутьКФайлу)

	Текст = "";
	Файл = Новый Файл(ПутьКФайлу);
	Если Файл.Существует() Тогда
		Чтение = Новый ЧтениеТекста(Файл.ПолноеИмя);
		Текст = Чтение.Прочитать();
		Чтение.Закрыть();
	Иначе
		Текст = "Информации об ошибке нет";
	КонецЕсли;

	Лог.Отладка("файл информации:
	|"+Текст);
	Возврат Текст;

КонецФункции

Процедура ОбеспечитьКаталог(Знач Каталог)

	Файл = Новый Файл(Каталог);
	Если Не Файл.Существует() Тогда
		СоздатьКаталог(Каталог);
	ИначеЕсли Не Файл.ЭтоКаталог() Тогда
		ВызватьИсключение "Каталог " + Каталог + " не является каталогом";
	КонецЕсли;

КонецПроцедуры

Процедура СоздатьФайловуюБазу(Конфигуратор, Знач КаталогБазы, Знач ПутьКШаблону="", Знач ИмяБазыВСписке="") Экспорт
	Лог.Отладка("Создаю файловую базу "+КаталогБазы);

	ОбеспечитьКаталог(КаталогБазы);
	УдалитьФайлы(КаталогБазы, "*.*");

	ПараметрыЗапуска = Новый Массив;
	ПараметрыЗапуска.Добавить("CREATEINFOBASE");
	ПараметрыЗапуска.Добавить("File="""+КаталогБазы+"""");
	ПараметрыЗапуска.Добавить("/Out""" +Конфигуратор.ФайлИнформации() + """");
	ПараметрыЗапуска.Добавить("/Lru");
	
	Если ИмяБазыВСписке <> "" Тогда
		ПараметрыЗапуска.Добавить("/AddInList"""+ ИмяБазыВСписке + """");
	КонецЕсли;
	Если ПутьКШаблону<> "" Тогда
		ПараметрыЗапуска.Добавить("/UseTemplate"""+ ПутьКШаблону + """");
	КонецЕсли;

	СтрокаЗапуска = "";
	СтрокаДляЛога = "";
	Для Каждого Параметр Из ПараметрыЗапуска Цикл
		СтрокаЗапуска = СтрокаЗапуска + " " + Параметр;
		Если Лев(Параметр,2) <> "/P" и Лев(Параметр,25) <> "/ConfigurationRepositoryP" Тогда
			СтрокаДляЛога = СтрокаДляЛога + " " + Параметр;
		КонецЕсли;
	КонецЦикла;

	Приложение = "";
	Приложение = Конфигуратор.ПутьКПлатформе1С();
	Если Найти(Приложение, " ") > 0 Тогда 
		Приложение = ОбернутьПутьВКавычки(Приложение);
	КонецЕсли;
	Приложение = Приложение + " "+СтрокаЗапуска;
	Попытка
		ЗапуститьПроцесс(Приложение);    
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
	РезультатСообщение = ПрочитатьФайлИнформации(Конфигуратор.ФайлИнформации());
	Если СтрНайти(РезультатСообщение, "успешно завершено") = 0 Тогда
		ВызватьИсключение "Результат работы не успешен: " + Символы.ПС + РезультатСообщение; 
	КонецЕсли;


КонецПроцедуры

Процедура ИнициализироватьБазуДанных(Знач ПутьКSRC="", Знач ПутьКDT="", Знач СтрокаПодключения="", Знач Пользователь="", Знач Пароль="",
										Знач КлючРазрешенияЗапуска = "", Знач ВерсияПлатформы="", Знач РежимРазработчика = Ложь, 
										Знач РежимОбновленияХранилища = Ложь, Знач СтрокаПодключенияХранилище = "", Знач ПользовательХранилища="", Знач ПарольХранилища="",
										Знач ВерсияХранилища="") 
	Перем БазуСоздавали;
	БазуСоздавали = Ложь;                                    
	ТекущаяПроцедура = "Запускаем инициализацию";

	Конфигуратор = Новый УправлениеКонфигуратором();
	Логирование.ПолучитьЛог("oscript.lib.v8runner").УстановитьУровень(Лог.Уровень());

	Если НЕ ПустаяСтрока(ВерсияПлатформы) Тогда
		Лог.Отладка("ИнициализироватьБазуДанных ВерсияПлатформы:"+ВерсияПлатформы);
		Конфигуратор.ИспользоватьВерсиюПлатформы(ВерсияПлатформы);
	КонецЕсли;
	Конфигуратор.УстановитьИмяФайлаСообщенийПлатформы(ПолучитьИмяВременногоФайла("log"));
	СоздатьКаталог(ОбъединитьПути(КорневойПутьПроекта, "build", "out"));

	Если ПустаяСтрока(СтрокаПодключения) Тогда

		КаталогБазы = ОбъединитьПути(КорневойПутьПроекта, ?(РежимРазработчика = Истина, "./build/ibservice", "./build/ib"));
		СтрокаПодключения = "/F""" + КаталогБазы + """";
	КонецЕсли;

	Лог.Отладка("ИнициализироватьБазуДанных СтрокаПодключения:"+ВерсияПлатформы);

	Если Лев(СтрокаПодключения,2)="/F" Тогда
		КаталогБазы = УбратьКавычкиВокругПути(Сред(СтрокаПодключения,3, СтрДлина(СтрокаПодключения)-2));
		ФайлБазы = Новый Файл(КаталогБазы);
		Если ФайлБазы.Существует() Тогда 
			Лог.Отладка("Удаляем файл "+ФайлБазы.ПолноеИмя);
			УдалитьФайлы(ФайлБазы.ПолноеИмя, ПолучитьМаскуВсеФайлы());
		КонецЕсли;
		СоздатьКаталог(ФайлБазы.ПолноеИмя);
		СоздатьФайловуюБазу(Конфигуратор, ФайлБазы.ПолноеИмя, ,);
		БазуСоздавали = Истина;
		Лог.Информация("Создали базу данных для " + СтрокаПодключения);
	КонецЕсли;

	Конфигуратор.УстановитьКонтекст(СтрокаПодключения, "", "");
	Если Не ПустаяСтрока(ПутьКDT) Тогда
		ПутьКDT = Новый Файл(ОбъединитьПути(КорневойПутьПроекта, ПутьКDT)).ПолноеИмя;
		Лог.Информация("Загружаем dt "+ ПутьКDT);
		Если БазуСоздавали = Истина Тогда 
			Попытка 
				Конфигуратор.ЗагрузитьИнформационнуюБазу(ПутьКDT);
			Исключение
				Лог.Ошибка("Не удалось загрузить:"+ОписаниеОшибки());
			КонецПопытки;
		Иначе
			Попытка
				Конфигуратор.УстановитьКонтекст(СтрокаПодключения, Пользователь, Пароль);
				Конфигуратор.ЗагрузитьИнформационнуюБазу(ПутьКDT);    
			Исключение
				Лог.Ошибка("Не удалось загрузить:"+ОписаниеОшибки());
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;

	Конфигуратор.УстановитьКонтекст(СтрокаПодключения, Пользователь, Пароль);
	ПодключитьСценарий(ОбъединитьПути(КаталогПроекта(),"runner.os"), "runner");
	runner = Новый runner();

	Если Не ПустаяСтрока(ПутьКSRC) Тогда
		Лог.Информация("Загружаем из исходников конфигурацию");
		ПутьКSRC = Новый Файл(ОбъединитьПути(КорневойПутьПроекта, ПутьКSRC)).ПолноеИмя;
		СписокФайлов = "";
		runner.СобратьИзИсходниковТекущуюКонфигурацию(ПутьКSRC, СтрокаПодключения, Пользователь, Пароль, ВерсияПлатформы, СписокФайлов, Ложь);
	КонецЕсли;

	Если РежимОбновленияХранилища = Истина Тогда
		Лог.Информация("Обновляем из хранилища");
		runner.ЗапуститьОбновлениеИзХранилища(СтрокаПодключения, Пользователь, Пароль, СтрокаПодключенияХранилище, ПользовательХранилища, ПарольХранилища, ВерсияХранилища, ВерсияПлатформы)
	КонецЕсли;

	Если РежимРазработчика = Ложь Тогда 
		runner.ЗапуститьОбновлениеКонфигурации(СтрокаПодключения, Пользователь, Пароль, КлючРазрешенияЗапуска, ВерсияПлатформы);
	КонецЕсли;

	Лог.Информация("Инициализация завершена");
	
КонецПроцедуры //ИнициализироватьБазуДанных


Процедура ОбновитьБазуДанных(Знач ПутьКSRC="", Знач ПутьКDT="", Знач СтрокаПодключения="", Знач Пользователь="", Знач Пароль="",
										Знач КлючРазрешенияЗапуска = "", Знач ВерсияПлатформы="", Знач РежимРазработчика = Ложь, 
										Знач РежимОбновленияХранилища = Ложь, Знач СтрокаПодключенияХранилище = "", Знач ПользовательХранилища="", Знач ПарольХранилища="",
										Знач ВерсияХранилища="") 
	Перем БазуСоздавали;
	БазуСоздавали = Ложь;                                    
	ТекущаяПроцедура = "Запускаем обновление";

	Конфигуратор = Новый УправлениеКонфигуратором();
	Логирование.ПолучитьЛог("oscript.lib.v8runner").УстановитьУровень(Лог.Уровень());

	Если НЕ ПустаяСтрока(ВерсияПлатформы) Тогда
		Лог.Отладка("ИнициализироватьБазуДанных ВерсияПлатформы:"+ВерсияПлатформы);
		Конфигуратор.ИспользоватьВерсиюПлатформы(ВерсияПлатформы);
	КонецЕсли;
	Конфигуратор.УстановитьИмяФайлаСообщенийПлатформы(ПолучитьИмяВременногоФайла("log"));
	
	Если РежимРазработчика = Истина Тогда 
		КаталогБазы = ОбъединитьПути(КорневойПутьПроекта, "./build/ibservice");
		СтрокаПодключения = "/F""" + КаталогБазы + """";
	КонецЕсли;

	Если ПустаяСтрока(СтрокаПодключения) Тогда
		КаталогБазы = ОбъединитьПути(КорневойПутьПроекта, ?(РежимРазработчика = Истина, "./build/ibservice", "./build/ib"));
		СтрокаПодключения = "/F""" + КаталогБазы + """";
	КонецЕсли;

	Лог.Отладка("ИнициализироватьБазуДанных СтрокаПодключения:"+ВерсияПлатформы);

	Если Лев(СтрокаПодключения,2)="/F" Тогда
		КаталогБазы = УбратьКавычкиВокругПути(Сред(СтрокаПодключения,3, СтрДлина(СтрокаПодключения)-2));
		ФайлБазы = Новый Файл(КаталогБазы);
		Ожидаем.Что(ФайлБазы.Существует(), ТекущаяПроцедура + " папка с базой существует").ЭтоИстина();
	КонецЕсли;

	Конфигуратор.УстановитьКонтекст(СтрокаПодключения, "", "");
	Если Не ПустаяСтрока(ПутьКDT) Тогда
		ПутьКDT = Новый Файл(ОбъединитьПути(КорневойПутьПроекта, ПутьКDT)).ПолноеИмя;
		Лог.Информация("Загружаем dt "+ ПутьКDT);
		Попытка
			Конфигуратор.УстановитьКонтекст(СтрокаПодключения, Пользователь, Пароль);
			Конфигуратор.ЗагрузитьИнформационнуюБазу(ПутьКDT);    
		Исключение
			Лог.Ошибка("Не удалось загрузить:"+ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;

	Конфигуратор.УстановитьКонтекст(СтрокаПодключения, Пользователь, Пароль);

	ПодключитьСценарий(ОбъединитьПути(КаталогПроекта(),"runner.os"), "runner");
	runner = Новый runner();
	
	Если Не ПустаяСтрока(ПутьКSRC) Тогда
		Лог.Информация("Загружаем из исходников конфигурацию");
		ПутьКSRC = Новый Файл(ОбъединитьПути(КорневойПутьПроекта, ПутьКSRC)).ПолноеИмя;
		СписокФайлов = "";
		runner.СобратьИзИсходниковТекущуюКонфигурацию(ПутьКSRC, СтрокаПодключения, Пользователь, Пароль, ВерсияПлатформы, СписокФайлов, Ложь);
	КонецЕсли;

	Если РежимОбновленияХранилища = Истина Тогда
		Лог.Информация("Обновляем из хранилища");
		runner.ЗапуститьОбновлениеИзХранилища(СтрокаПодключения, Пользователь, Пароль, СтрокаПодключенияХранилище, ПользовательХранилища, ПарольХранилища, ВерсияХранилища, ВерсияПлатформы);
	КонецЕсли;

	Если РежимРазработчика = Ложь Тогда 
		runner.ЗапуститьОбновлениеКонфигурации(СтрокаПодключения, Пользователь, Пароль, КлючРазрешенияЗапуска, ВерсияПлатформы);
	КонецЕсли;     
	
КонецПроцедуры //ЗапуститьОбновлениеКонфигурации

Процедура УстановитьКаталогТекущегоПроекта(Знач Путь = "")
	КорневойПутьПроекта = "";
	Если ПустаяСтрока(Путь) Тогда
		Попытка
			КорневойПутьПроекта = СокрЛП(ЗапуститьПроцесс("git rev-parse --show-toplevel"));
		Исключение
		КонецПопытки;
	Иначе
		КорневойПутьПроекта = Путь;
	КонецЕсли;

КонецПроцедуры // УстановитьКаталогТекущегоПроекта()

Функция ЗапускВКоманднойСтроке()
	
	Лог_cmdline = Логирование.ПолучитьЛог("oscript.lib.cmdline");
	Лог_v8runner = Логирование.ПолучитьЛог("oscript.lib.v8runner");
	
	// Лог.УстановитьУровень(УровниЛога.Отладка);
	ВыводПоУмолчанию = Новый ВыводЛогаВКонсоль();
	Лог_cmdline.ДобавитьСпособВывода(ВыводПоУмолчанию);
	Лог_v8runner.ДобавитьСпособВывода(ВыводПоУмолчанию);
	
	СИ = Новый СистемнаяИнформация;
	УровеньЛога = УровниЛога.Отладка;
	РежимРаботы = СИ.ПолучитьПеременнуюСреды("RUNNER_ENV");
	Если ЗначениеЗаполнено(РежимРаботы) И РежимРаботы = "production" Тогда
		УровеньЛога = УровниЛога.Информация;
	Иначе
		Аппендер = Новый ВыводЛогаВФайл();
		ИмяВременногоФайла = ОбщиеМетоды.ПолучитьИмяВременногоФайлаВКаталоге(КаталогЛогов, СтрШаблон("%1.cmdline.log", ИмяСкрипта()));
		Аппендер.ОткрытьФайл(ИмяВременногоФайла);
		Лог_cmdline.ДобавитьСпособВывода(Аппендер);	
	КонецЕсли;
	
	Лог_cmdline.УстановитьУровень(УровеньЛога);
	Лог_cmdline.УстановитьРаскладку(ЭтотОбъект);
	Лог_v8runner.УстановитьУровень(УровеньЛога);
	Лог_v8runner.УстановитьРаскладку(ЭтотОбъект);
	
	КодВозврата = 0;
	Если ТекущийСценарий().Источник <> СтартовыйСценарий().Источник Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Попытка
	
		Парсер = Новый ПарсерАргументовКоманднойСтроки();
		
		Парсер.ДобавитьИменованныйПараметр("--ibname", "Строка подключения к БД", Истина);
		Парсер.ДобавитьИменованныйПараметр("--db-user", "Пользователь БД", Истина);
		Парсер.ДобавитьИменованныйПараметр("--db-pwd", "Пароль БД", Истина);
		Парсер.ДобавитьИменованныйПараметр("--v8version", "Версия платформы", Истина);
		Парсер.ДобавитьИменованныйПараметр("--root", "Полный путь к проекту", Истина);
		
		ДобавитьОписаниеКомандыИнициализацияОкружения(Парсер);
		ДобавитьОписаниеКомандыОбновлениеОкружения(Парсер);
		
		Аргументы = Парсер.РазобратьКоманду(АргументыКоманднойСтроки);
		Лог.Отладка("ТипЗнч(Аргументы)= "+ТипЗнч(Аргументы));
		Если Аргументы = Неопределено Тогда
			ВывестиСправку();
			Возврат Истина;
		КонецЕсли;

		Команда = Аргументы.Команда;
		Лог.Отладка("Передана команда: "+Команда);

		СоответствиеПеременных = Новый Соответствие();
		СоответствиеПеременных.Вставить("RUNNER_IBNAME", "--ibname");
		СоответствиеПеременных.Вставить("RUNNER_DBUSER", "--db-user");
		СоответствиеПеременных.Вставить("RUNNER_DBPWD", "--db-pwd");
		СоответствиеПеременных.Вставить("RUNNER_v8version", "--v8version");
		СоответствиеПеременных.Вставить("RUNNER_uccode", "--uccode");
		СоответствиеПеременных.Вставить("RUNNER_command", "--command");
		СоответствиеПеременных.Вставить("RUNNER_execute", "--execute");
		СоответствиеПеременных.Вставить("RUNNER_ROOT", "--root");
				
		ДополнитьАргументыИзПеременныхОкружения(Аргументы.ЗначенияПараметров, СоответствиеПеременных);
		Для Каждого Параметр Из Аргументы.ЗначенияПараметров Цикл
			Лог.Отладка(Параметр.Ключ + " = " + Параметр.Значение);
		КонецЦикла;
		
		УстановитьКаталогТекущегоПроекта(Аргументы.ЗначенияПараметров["--root"]);

		Если Команда = ВозможныеКоманды().ИнициализацияОкружения Тогда
			ИнициализироватьБазуДанных(Аргументы.ЗначенияПараметров["--src"], Аргументы.ЗначенияПараметров["--dt"],
							Аргументы.ЗначенияПараметров["--ibname"], Аргументы.ЗначенияПараметров["--db-user"], Аргументы.ЗначенияПараметров["--db-pwd"],, 
							Аргументы.ЗначенияПараметров["--v8version"], Аргументы.ЗначенияПараметров["--dev"], Аргументы.ЗначенияПараметров["--storage"], 
							Аргументы.ЗначенияПараметров["--storage-name"], Аргументы.ЗначенияПараметров["--storage-user"], Аргументы.ЗначенияПараметров["--storage-pwd"], Аргументы.ЗначенияПараметров["--storage-ver"]);
		ИначеЕсли Команда = ВозможныеКоманды().ОбновлениеОкружения Тогда 
			ОбновитьБазуДанных(Аргументы.ЗначенияПараметров["--src"], Аргументы.ЗначенияПараметров["--dt"],
							Аргументы.ЗначенияПараметров["--ibname"], Аргументы.ЗначенияПараметров["--db-user"], Аргументы.ЗначенияПараметров["--db-pwd"],, 
							Аргументы.ЗначенияПараметров["--v8version"], Аргументы.ЗначенияПараметров["--dev"], Аргументы.ЗначенияПараметров["--storage"], 
							Аргументы.ЗначенияПараметров["--storage-name"], Аргументы.ЗначенияПараметров["--storage-user"], Аргументы.ЗначенияПараметров["--storage-pwd"], Аргументы.ЗначенияПараметров["--storage-ver"]);
		
		КонецЕсли;
	Исключение
		Лог.Ошибка(ОписаниеОшибки());
		КодВозврата = 1;
	КонецПопытки;
	
	ВременныеФайлы.Удалить();

	Возврат Истина;
	
КонецФункции

Процедура Инициализация()
	СистемнаяИнформация = Новый СистемнаяИнформация;
	ЭтоWindows = Найти(ВРег(СистемнаяИнформация.ВерсияОС), "WINDOWS") > 0;

	Попытка 
		 КаталогЛогов = СокрЛП(ЗапуститьПроцесс("git rev-parse --show-toplevel"));
	Исключение
		КаталогЛогов = ВременныеФайлы.НовоеИмяФайла(ИмяСкрипта());
		СоздатьКаталог(КаталогЛогов);
	КонецПопытки;  

	Лог = Логирование.ПолучитьЛог("oscript.app.vanessa-init");
	УровеньЛога = УровниЛога.Отладка;
	РежимРаботы = СистемнаяИнформация.ПолучитьПеременнуюСреды("RUNNER_ENV");
	Если ЗначениеЗаполнено(РежимРаботы) И РежимРаботы = "production" Тогда
		УровеньЛога = УровниЛога.Информация;
	Иначе
		Аппендер = Новый ВыводЛогаВФайл();
		ИмяВременногоФайла = ОбщиеМетоды.ПолучитьИмяВременногоФайлаВКаталоге(КаталогЛогов, СтрШаблон("%1.log", ИмяСкрипта()));
		Аппендер.ОткрытьФайл(ИмяВременногоФайла);
		Лог.ДобавитьСпособВывода(Аппендер);
	КонецЕсли;
	
	Лог.УстановитьУровень(УровеньЛога);
	Лог.УстановитьРаскладку(ЭтотОбъект);
	
	ВыводПоУмолчанию = Новый ВыводЛогаВКонсоль();
	Лог.ДобавитьСпособВывода(ВыводПоУмолчанию);
	
КонецПроцедуры

/////////////////////////////////////////////////////////////////////////////
// РЕАЛИЗАЦИЯ КОМАНД
Функция ОбернутьПутьВКавычки(Знач Путь)

	Результат = Путь;
	Если Прав(Результат, 1) = "\" Тогда
		Результат = Лев(Результат, СтрДлина(Результат) - 1);
	КонецЕсли;

	Результат = """" + Результат + """";

	Возврат Результат;

КонецФункции

Функция УбратьКавычкиВокругПути(Путь)
	//NOTICE: https://github.com/xDrivenDevelopment/precommit1c 
	//Apache 2.0 
	ОбработанныйПуть = Путь;

	Если Лев(ОбработанныйПуть, 1) = """" Тогда
		ОбработанныйПуть = Прав(ОбработанныйПуть, СтрДлина(ОбработанныйПуть) - 1);
	КонецЕсли;
	Если Прав(ОбработанныйПуть, 1) = """" Тогда
		ОбработанныйПуть = Лев(ОбработанныйПуть, СтрДлина(ОбработанныйПуть) - 1);
	КонецЕсли;
	
	Возврат ОбработанныйПуть;
	
КонецФункции

Функция КаталогПроекта()
	ФайлИсточника = Новый Файл(ТекущийСценарий().Источник);
	Возврат ФайлИсточника.Путь;
КонецФункции

Функция ИмяСкрипта()
	ФайлИсточника = Новый Файл(ТекущийСценарий().Источник);
	Возврат ФайлИсточника.ИмяБезРасширения;
КонецФункции

Функция Форматировать(Знач Уровень, Знач Сообщение) Экспорт

	Возврат СтрШаблон("%1: %2 - %3", ТекущаяДата(), УровниЛога.НаименованиеУровня(Уровень), Сообщение);

КонецФункции

Инициализация();

Если ЗапускВКоманднойСтроке() Тогда
	ЗавершитьРаботу(КодВозврата);
КонецЕсли;

РезультатыОбработкиВнешнихОбработок = Новый Соответствие;