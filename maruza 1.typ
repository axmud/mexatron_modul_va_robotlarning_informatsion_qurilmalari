// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №1. Fanning tarixi, rivojlanishi, dolzarb muammolari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")

#set document(title: "Maʼruza №1. Fanning tarixi, rivojlanishi, dolzarb muammolari")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 1  // amaliyot raqami
#set document(keywords: (info.fan,))
#set page(header: context {
  set text(size: 9pt, fill: luma(110))
  grid(
    columns: (3fr, auto, 1fr),
    align: (left, center, right),
    info.fan, info.semestr, [Maʼruza №#raqam],
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + luma(170))
})
// ===================
#set text(size: 12pt, lang: "uz")
#set par(justify: true, leading: 0.75em, first-line-indent: (amount: 1.25cm, all: true))
#set heading(numbering: "1.1.")
#show heading: set text(fill: headingblue)
#show heading.where(level: 1): it => block(above: 1.4em, below: 0.9em, text(size: 14pt, it))
#show heading.where(level: 2): it => block(above: 1.2em, below: 0.7em, text(size: 12.5pt, it))
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)

#show figure.where(kind: image): set figure(supplement: "Rasm")
#show figure.where(kind: table): set figure(supplement: "Jadval")
#show figure.where(kind: table): set figure.caption(position: top)
#show table: set par(justify: false, first-line-indent: 0pt)
#show figure.caption: set text(size: 11pt)

#let eq(body) = math.equation(block: true, numbering: "(1)", body)
#show figure.where(kind: table): set block(breakable: true)

// booktabs uslubidagi jadval
#let btable(columns: auto, align: left, header: (), ..rows) = table(
  columns: columns,
  align: align,
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 1pt),
  table.header(..header.map(h => text(weight: "bold", h))),
  table.hline(stroke: 0.6pt),
  ..rows,
  table.hline(stroke: 1pt),
)

// ---------------------------------------------------------------------
// Sarlavha
// ---------------------------------------------------------------------
#align(center)[
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №1]
  #v(0.3em)
  #text(size: 14pt, weight: "bold")[Mavzu: Fanning tarixi, rivojlanishi, dolzarb muammolari]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[(kirish maʼruzasi)]
]

#v(0.8em)

#block(inset: (left: 0pt))[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Fanning maqsadi, vazifalari va tuzilishi.
  + Asosiy tushunchalar: robot, mexatronika, mexatron modul, informatsion qurilma.
  + Avtomatika, robototexnika va mexatronikaning tarixiy rivojlanishi.
  + Datchiklar texnikasining rivojlanish bosqichlari va robotlar avlodlari.
  + Informatsion tizimlarning bionik jihatlari.
  + Informatsion qurilmalarning tasnifi.
  + Zamonaviy rivojlanish tendensiyalari va dolzarb muammolar.

  *Tayanch iboralar:* robot, robototexnik tizim, mexatronika, mexatron modul, informatsion qurilma, datchik, oʻlchash oʻzgartkichi, sensor, qayta aloqa, robotlar avlodlari, bionika, proprioseptiv va eksteroseptiv datchiklar, MEMS, intellektual datchik, sensorlar kompleksirovaniyasi.
]

// =====================================================================
= Fanning maqsadi, vazifalari va tuzilishi
// =====================================================================

Zamonaviy robot yoki har qanday mexatron tizim faqat harakatni bajaruvchi mexanizmdan iborat emas. U oʻzining ichki holatini va atrof-muhitni «sezishi», olingan maʼlumotni qayta ishlashi va shu asosda harakatini oʻzgartirishi kerak. Bu vazifani robotning *informatsion qurilmalari* — datchiklar, oʻlchash oʻzgartkichlari, signalga ishlov berish sxemalari va axborotni qayta ishlash vositalari bajaradi. Informatsion qurilmalarning sifati robotning aniqligi, tezkorligi, xavfsizligi va «aqlliligi»ni bevosita belgilaydi.

*Fanning maqsadi* — talabalarda zamonaviy robototexnik va mexatron tizimlarning informatsion-oʻlchash qurilmalari haqida asosiy bilimlarni shakllantirish, ularning qurilish va ishlash prinsiplarini, axborotni olish, saqlash va qayta ishlash usullarini hamda samarali algoritmlarini oʻrgatishdir.

*Fanning asosiy vazifalari:*
- datchiklarning fizik ishlash prinsiplari, tavsiflari va xatoliklarini oʻrganish;
- robotning kinestetik (ichki holat), lokatsion, taktil va koʻrish tizimlarini qurish usullarini oʻzlashtirish;
- oʻlchash sxemalari va signalga dastlabki ishlov berish usullarini oʻrganish;
- bir nechta datchik maʼlumotlarini birlashtirish (kompleksirovaniya) tamoyillari bilan tanishish;
- sunʼiy intellekt usullarining robot informatsion tizimlarida qoʻllanilishini oʻrganish;
- inson va robot oʻrtasidagi interfeysni loyihalash asoslarini oʻzlashtirish.

Fan mazmuni 1-jadvalda keltirilgan yettita boʻlimga ajratiladi. Fan «Oʻlchash va metrologiya asoslari», «Elektronika va sxemotexnika», «Avtomatik boshqarish nazariyasi», «Robototexnika asoslari» kabi fanlarga tayanadi va mexatron tizimlarni loyihalash, bitiruv malakaviy ishi uchun asos boʻlib xizmat qiladi.

#figure(
  btable(
    columns: (auto, 1fr, 1.6fr),
    header: ([№], [Boʻlim nomi], [Asosiy mavzular]),
    [1],
    [Robototexnika rivojlanishining asosiy bosqichlari va tendensiyalari],
    [Asosiy tushunchalar, intellektual robotlar, bionik jihatlar],
    [2],
    [Sunʼiy intellekt usullari],
    [Ekspert tizimlar, neyron tarmoqlar, assotsiativ xotira, noaniq mantiq],
    [3],
    [Informatsion tizimlar elementlari],
    [Datchiklar va ularning tavsiflari, sezgir elementlar, oʻlchash sxemalari, kinestetik, lokatsion, taktil va texnik koʻrish tizimlari, kompleksirovaniya],
    [4],
    [Intellektual yuritmalar],
    [Adaptiv yuritmalar, noaniq mantiqli rostlagichlar],
    [5],
    [Robotlar harakatini intellektual boshqarish],
    [Ekspert tizimlar, assotsiativ xotira va neyron tarmoqlar asosida boshqarish],
    [6],
    [Intellektual robotlar xatti-harakatini rejalashtirish],
    [Harakatlarni rejalashtirish masalasi, graf usullari, oʻz-oʻzini oʻqitish],
    [7],
    [«Operator — robot» interfeysi],
    [Inson-mashina muloqoti usullari, intellektual interfeys],
  ),
  caption: [Fanning tuzilishi],
) <tab-fan>

// =====================================================================
= Asosiy tushunchalar
// =====================================================================

*Robot* — atrof-muhitdan keladigan signallarga javob bergan holda, inson bevosita aralashuvisiz, avtomatik ravishda harakatlarni bajaradigan qayta dasturlanadigan mashina. Bolton taʼrificha, operator boshqaradigan oddiy qoʻl qurilmasidan farqli ravishda, robot kompyuter tomonidan boshqariladi va keyingi harakat haqidagi qarorni muhitdan olingan signallar asosida oʻzi qabul qiladi.

*Robototexnika* — robotlarni loyihalash, yaratish, boshqarish va qoʻllash bilan shugʻullanadigan fan va texnika sohasi.

*Mexatronika* — mexanika, elektronika, boshqarish nazariyasi va hisoblash texnikasining sinergetik birlashuvi asosida mashina va tizimlarni yaratuvchi fan sohasi. Mexatron tizimni oʻrganish odatda beshta yoʻnalishga ajratiladi: fizik tizimlarni modellashtirish, datchiklar va ijro qurilmalari, signallar va tizimlar, kompyuter va mantiqiy tizimlar, dasturiy taʼminot va maʼlumotlarni yigʻish.

*Mexatron modul* — harakatlantiruvchi qism (dvigatel, uzatma), informatsion qism (datchiklar) va boshqaruv qismi (kontroller, quvvat elektronikasi) yagona konstruksiyada birlashtirilgan, funksional va konstruktiv jihatdan tugallangan qurilma. Masalan, robot boʻgʻinining servoyuritmasi dvigatel, reduktor, enkoder, tormoz va drayverdan iborat yagona modul boʻlishi mumkin.

*Informatsion qurilma* — robotning ichki holati va tashqi muhit haqidagi maʼlumotni olish, oʻzgartirish, uzatish va dastlabki qayta ishlashni taʼminlovchi qurilma. Uning asosiy elementi — datchik.

Terminologiyada maʼlum farqlar mavjud. Regtien va Dertien taʼrifiga koʻra, *oʻzgartkich* (transducer) — oʻlchanayotgan kattalik haqidagi axborotni bir fizik sohadan (mexanik, issiqlik, optik, magnit) boshqasiga, ideal holda axborotni yoʻqotmasdan oʻtkazuvchi qurilma. Kirishi noelektrik, chiqishi elektrik boʻlgan oʻzgartkich *sensor (datchik)*, aksincha, elektrik signalni noelektrik kattalikka aylantiruvchi oʻzgartkich esa *aktuator (ijro qurilmasi)* deb ataladi. Xalqaro metrologik lugʻat (VIM) boʻyicha sensor — oʻlchash tizimining oʻlchanayotgan kattalik bevosita taʼsir qiladigan elementi. Zamonaviy datchiklar sezgir elementdan tashqari kuchaytirish, filtrlash, analog-raqamli oʻzgartirish va raqamli interfeysni ham oʻz ichiga oladi, shuning uchun amaliyotda «datchik» va «oʻzgartkich» chegarasi tobora yoʻqolib bormoqda.

Robototexnik tizimdagi informatsion qurilmalarning oʻrni 1-rasmda koʻrsatilgan. Informatsion qurilmalar ikki xil axborot oqimini shakllantiradi: mexanizmning ichki holati (boʻgʻinlar burchaklari, tezliklari, dvigatel toklari) va tashqi muhit (obyektlar, toʻsiqlar, kontakt kuchlari) haqidagi axborot.

#figure(
  diagram(
    spacing: (20mm, 14mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    edge-stroke: 1pt,
    node((0, 0), [Operator], name: <op>),
    node((1, 0), [Boshqaruv \ tizimi], name: <bt>),
    node((2, 0), [Yuritmalar], name: <yu>),
    node((3, 0), [Mexanizm \ (manipulyator)], name: <mx>),
    node((3, 1), [Ishchi muhit \ va obyekt], name: <mu>),
    node((1, 1), [Axborotga \ ishlov berish], name: <ai>),
    node((2, 1), [Informatsion \ qurilmalar], name: <iq>, fill: rgb("#fbe3cf")),
    edge(<op>, <bt>, "<->"),
    edge(<bt>, <yu>, "->"),
    edge(<yu>, <mx>, "->"),
    edge(<mx>, <mu>, "<->", [taʼsir], label-side: left),
    edge(<mx>, <iq>, "->", [ichki holat], label-side: right, label-pos: 0.4),
    edge(<mu>, <iq>, "->", [tashqi muhit], label-side: right),
    edge(<iq>, <ai>, "->"),
    edge(<ai>, <bt>, "->"),
  ),
  caption: [Robototexnik tizimning umumlashgan tuzilishi va informatsion qurilmalarning oʻrni],
) <fig-tuzilish>

Har qanday datchikning chiqish signali faqat oʻlchanayotgan kattalikka emas, balki taʼsir etuvchi boshqa omillarga (harorat, taʼminot kuchlanishi, vibratsiya) ham bogʻliq boʻladi:

#eq($ y = F(x, z_1, z_2, dots, z_m) + xi, $)

bu yerda $x$ — oʻlchanayotgan kattalik, $z_1, dots, z_m$ — taʼsir etuvchi omillar, $xi$ — tasodifiy shovqin. Ideal datchik uchun $y$ faqat $x$ ga bogʻliq. Amaliyotda koʻpincha chiziqli model qoʻllaniladi:

#eq($ y = S x + y_0 + xi, $)

bu yerda $S$ — sezgirlik, $y_0$ — nol siljishi. Datchiklar texnikasining asosiy muammolaridan biri — taʼsir etuvchi omillar va shovqinning ulushini kamaytirish, yaʼni (2) modelga imkon qadar yaqinlashishdir. Bu masalalar keyingi maʼruzalarda batafsil koʻriladi.

// =====================================================================
= Avtomatika, robototexnika va mexatronikaning tarixiy rivojlanishi
// =====================================================================

== Qayta aloqali qurilmalarning ilk namunalari

Avtomatik qurilmalar yaratishga urinishlar uzoq tarixga ega. Miloddan avvalgi III–I asrlarda Qadimgi Yunonistonda qalqovichli rostlagichlar paydo boʻlgan: Ktesibiosning suv soati va Filonning moy chirogʻi suyuqlik sathini qalqovich yordamida barqaror ushlab turgan. Milodiy I asrda Iskandariyalik Geron «Pnevmatika» asarida qalqovichli sath rostlagichlarining turli xillarini tasvirlagan.

XVII–XIX asrlarda Yevropa va Rossiyada mexatronikaning kelajakdagi asoslari boʻlgan muhim qurilmalar ixtiro qilingan. Gollandiyalik Kornelis Drebbel (1572–1633) birinchi qayta aloqali tizimlardan biri — harorat rostlagichini yaratgan. Deni Papen 1681-yilda bugʻ qozonlari uchun bosim saqlagich klapanini ixtiro qilgan. 1765-yilda I. I. Polzunov bugʻ qozoni uchun suv sathining qalqovichli rostlagichini ishlab chiqqan. Jeyms Uattning markazdan qochma (sharli) rostlagichi bugʻ mashinasi valining tezligini oʻlchab, unga beriladigan bugʻ miqdorini avtomatik oʻzgartirgan.

Bu misollarning barchasida bitta umumiy gʻoya bor: tizim *oʻzining holatini oʻlchaydi* va natijaga qarab taʼsirni oʻzgartiradi. Demak, informatsion qurilma (qalqovich, sharli mexanizm) qayta aloqali boshqaruvning ajralmas qismi sifatida eng boshidanoq mavjud boʻlgan.

== «Robot» tushunchasining paydo boʻlishi

«Robot» soʻzi chex yozuvchisi Karel Chapekning 1920-yilda yozilgan va 1921-yilda sahnalashtirilgan «R.U.R.» («Rossumning universal robotlari») pyesasi orqali keng tarqalgan. Pyesada sunʼiy odamlar ishlab chiqaradigan zavod tasvirlangan, soʻz esa slavyan tillaridagi «robota» — «mehnat», «ogʻir ish» soʻzidan olingan. «Robototexnika» (robotics) atamasini fantast yozuvchi Ayzek Azimov 1940-yillar boshida oʻz hikoyalarida qoʻllagan va robototexnikaning mashhur uch qonunini taklif etgan:

+ Robot insonga zarar yetkazmasligi yoki harakatsizligi bilan insonga zarar yetishiga yoʻl qoʻymasligi kerak.
+ Robot birinchi qonunga zid boʻlmagan holda inson buyruqlariga boʻysunishi kerak.
+ Robot birinchi va ikkinchi qonunlarga zid boʻlmagan holda oʻzini himoya qilishi kerak.

Bu qonunlar badiiy gʻoya boʻlsa-da, bugungi kunda robot xavfsizligi masalasi — himoya toʻsiqlari, yaqinlik va kuch datchiklari, xavfsizlik standartlari — aynan informatsion qurilmalar orqali hal qilinadi.

== Sanoat robotlarining paydo boʻlishi

Sanoat robototexnikasining asosiy bosqichlari 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1fr),
    header: ([Yil], [Voqea]),
    [1956],
    [J. Devol va J. Engelberger Unimation kompaniyasini tashkil etib, birinchi sanoat manipulyatori Unimate ustida ish boshlaydi],
    [1961],
    [Devolga «Programmed Article Transfer» patenti beriladi; General Motors zavodida birinchi Unimate roboti quyma detallarni taxlash uchun oʻrnatiladi],
    [1966–1972],
    [Stenford tadqiqot institutida (SRI) Shakey — kamera va masofa oʻlchagich yordamida muhitni idrok etib, harakatini rejalashtiradigan birinchi mobil robot yaratiladi],
    [1967],
    [General Motors kuzovni nuqtali payvandlovchi robotlarni joriy qiladi],
    [1973],
    [KUKA kompaniyasi oltita elektromexanik yuritmali birinchi sanoat roboti Famulus ni yaratadi],
    [1974],
    [ASEA (Shvetsiya) uchun 8 bitli Intel mikroprotsessori bilan boshqariladigan birinchi sanoat roboti ishlab chiqiladi],
    [1978],
    [Unimation General Motors uchun PUMA (Programmable Universal Machine for Assembly) robotini yaratadi],
    [1979],
    [Yaponiyada Nachi kompaniyasi gidravlik yuritmalar oʻrniga elektr dvigatelli payvandlash robotlarini ishlab chiqadi],
    [1986],
    [Honda oʻzining birinchi gumanoid robotini taqdim etadi],
    [1987],
    [Xalqaro robototexnika federatsiyasi (IFR) tashkil etiladi],
  ),
  caption: [Sanoat robototexnikasi rivojlanishining asosiy bosqichlari~[1]],
) <tab-robot-tarix>

Jadvaldan muhim bir qonuniyatni koʻrish mumkin: dastlabki robotlar gidravlik yuritmali boʻlib, oldindan yozilgan dasturni «koʻr-koʻrona» bajargan. Mikroprotsessorlar (1970-yillar) va elektr yuritmalarning keng tarqalishi bilan robotga koʻproq datchik oʻrnatish va ularning signallarini real vaqtda qayta ishlash imkoniyati paydo boʻldi.

== Mexatronikaning shakllanishi

«Mexatronika» atamasini 1969-yilda yapon kompaniyasi Yaskawa Electric muhandisi mexanika va elektronikani birlashtirgan tizimlarni ifodalash uchun taklif etgan. Kompaniya 1972-yilda bu atamaga savdo belgisi huquqini olgan, ammo atama keng tarqalgach, 1982-yilda bu huquqdan voz kechgan. Dastlab mexatronika hisoblash qismisiz elektromexanik tizimlarni (avtomatik eshiklar, savdo avtomatlari) anglatgan.

1970-yillar oxirida Yaponiya mashinasozlik sanoatini rivojlantirish jamiyati (JSPMI) mexatron mahsulotlarni toʻrt sinfga ajratgan (3-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr, 1fr),
    header: ([Sinf], [Tavsifi], [Misollar]),
    [I],
    [Funksionalligini oshirish uchun elektronika qoʻshilgan asosan mexanik mahsulotlar],
    [Raqamli dasturiy boshqariladigan dastgohlar, rostlanuvchi tezlikli yuritmalar],
    [II],
    [Tashqi interfeysi oʻzgarmagan, ichki qurilmalari elektronika bilan yangilangan anʼanaviy mexanik tizimlar],
    [Zamonaviy tikuv mashinasi],
    [III],
    [Funksiyasi saqlangan, ammo ichki mexanizmlari elektronika bilan almashtirilgan tizimlar],
    [Raqamli soat],
    [IV],
    [Mexanika va elektronikaning sinergetik integratsiyasi asosida loyihalangan mahsulotlar],
    [Nusxa koʻchirish apparati, aqlli kir yuvish mashinasi],
  ),
  caption: [Mexatron mahsulotlarning JSPMI tasnifi~[3]],
) <tab-jspmi>

Haqiqiy mexatron tizimlar mikroprotsessor (Intel, 1970-yillar) paydo boʻlgandan keyingina amaliy jihatdan mumkin boʻldi. Avtomobil buning yaqqol misoli: 1960-yillargacha avtomobildagi yagona jiddiy elektron qurilma radio boʻlgan. 1970-yillar oxirida tirsakli val va taqsimlash vali holati datchiklari (dastlab Xoll datchigi), havo sarfi va drossel holati datchiklari hamda mikrokontrollerdan iborat elektron oʻt oldirish tizimi, shuningdek gʻildiraklar aylanish tezligi datchiklariga asoslangan bloklanishga qarshi tormoz tizimi (ABS) joriy etilgan. Bugungi avtomobilda yuzlab datchiklar mavjud, avtonom avtomobil esa koʻp jihatdan gʻildirakli robotdir.

// =====================================================================
= Datchiklar texnikasining rivojlanishi va robotlar avlodlari
// =====================================================================

== Datchiklar texnikasining asosiy bosqichlari

Robotlarning informatsion qurilmalari fizikaning turli sohalaridagi kashfiyotlarga tayanadi. Bugun robotlarda qoʻllanadigan koʻplab datchiklarning ishlash prinsiplari XIX asrda kashf etilgan, ammo ularning keng qoʻllanilishi yarimoʻtkazgichlar texnologiyasi va mikroelektronika rivoji bilan bogʻliq (4-jadval).

#figure(
  btable(
    columns: (auto, 1fr),
    header: ([Yil], [Kashfiyot yoki texnologiya va uning robototexnikadagi ahamiyati]),
    [1856],
    [U. Tomson (lord Kelvin) metall simning qarshiligi deformatsiyaga bogʻliqligini aniqlaydi — tenzorezistiv datchiklar asosi],
    [1879],
    [E. Xoll magnit maydonda oʻtkazgichda koʻndalang kuchlanish hosil boʻlishini kashf etadi — Xoll datchiklari (pozitsiya, tok, tezlik)],
    [1880],
    [P. va J. Kyuri aka-ukalar piezoelektrik effektni kashf etadi — kuch, bosim va tezlanish datchiklari],
    [1938],
    [E. Simmons va A. Ruge yopishtiriladigan simli tenzorezistorni yaratadi — kuch va moment datchiklarining asosi],
    [1954],
    [Ch. Smit kremniy va germaniyda kuchli piezorezistiv effektni aniqlaydi — yarimoʻtkazgichli bosim va tezlanish datchiklari],
    [1960],
    [Birinchi lazer yaratiladi; R. Kalman filtri taklif etiladi — lazerli masofa oʻlchagichlar va datchik maʼlumotlarini birlashtirish],
    [1960-yillar boshi],
    [Kremniy asosidagi birinchi bosim datchiklari — mikroelektromexanik tizimlar (MEMS) yoʻnalishining boshlanishi~[2]],
    [1969],
    [U. Boyl va J. Smit zaryad bogʻlangan qurilmani (PZS, CCD) ixtiro qiladi — raqamli kameralar va texnik koʻrish tizimlari],
    [1990-yillar],
    [MEMS akselerometrlar va giroskoplarning ommaviy ishlab chiqarilishi (avtomobil xavfsizlik yostiqlari); GPS tizimining toʻliq ishga tushishi],
    [2005],
    [DARPA Grand Challenge musobaqasida avtonom avtomobil lazer skanerlari (LiDAR), kamera, GPS va inersial datchiklar majmuasi yordamida choʻl yoʻlini toʻliq bosib oʻtadi],
    [2010],
    [Arzon RGB-D (rang va chuqurlik) kameralarning paydo boʻlishi — mobil robotlar uchun uch oʻlchamli koʻrish ommalashadi],
  ),
  caption: [Datchiklar texnikasi rivojlanishining asosiy bosqichlari],
) <tab-datchik-tarix>

== Robotlar avlodlari

Robotlarning rivojlanishini ularning informatsion imkoniyatlariga qarab uch avlodga ajratish qabul qilingan (5-jadval). Bu tasnif aynan informatsion qurilmalarning roli ortib borishini aks ettiradi.

#figure(
  btable(
    columns: (1fr, 1.3fr, 1.3fr),
    header: ([Avlod], [Informatsion taʼminoti], [Imkoniyatlari]),
    [I avlod — \ dasturiy robotlar],
    [Faqat ichki datchiklar (boʻgʻin holati); tashqi muhit haqida axborot yoʻq],
    [Qatʼiy dasturni takrorlaydi; obyekt joyi aniq belgilangan, muhit oʻzgarmas boʻlishi shart],
    [II avlod — \ adaptiv (sezgir) robotlar],
    [Tashqi datchiklar: taktil, kuch-moment, lokatsion, oddiy texnik koʻrish],
    [Muhitning cheklangan oʻzgarishlariga moslashadi: obyekt joyini aniqlaydi, kontakt kuchini rostlaydi],
    [III avlod — \ intellektual robotlar],
    [Koʻp sonli turli datchiklar, ularning maʼlumotlarini birlashtirish, sunʼiy intellekt],
    [Muhitni tanib oladi, maqsadga erishish yoʻlini oʻzi rejalashtiradi, tajribadan oʻrganadi, inson bilan muloqot qiladi],
  ),
  caption: [Robotlar avlodlari va ularning informatsion taʼminoti],
) <tab-avlod>

Hozirgi sanoat robotlarining katta qismi hali ham I avlodga yaqin, ammo kollaborativ robotlar, avtonom mobil robotlar va avtonom transport vositalari II va III avlod xususiyatlariga ega. Bunday tizimlarda informatsion qurilmalar qiymati va murakkabligi koʻpincha mexanik qismdan ustun keladi.

// =====================================================================
= Informatsion tizimlarning bionik jihatlari
// =====================================================================

Robotlarning informatsion tizimlarini yaratishda koʻpincha tirik organizmlar, birinchi navbatda inson sezgi organlari namuna sifatida olinadi. Bu yondashuv *bionika* deb ataladi. Inson tashqi dunyo haqidagi axborotni bir nechta sezgi kanali orqali oladi, markaziy asab tizimida ularni birlashtiradi va harakatni boshqaradi. Robotning informatsion tizimi ham xuddi shunday tuzilgan: datchiklar sezgi organlari, kontroller esa «miya» vazifasini bajaradi (6-jadval).

#figure(
  btable(
    columns: (1fr, 1.2fr, 1.4fr),
    header: ([Inson sezgisi], [Vazifasi], [Robotdagi texnik analogi]),
    [Kinestetik (mushak-boʻgʻin) sezgi],
    [Tana qismlarining holati va harakatini sezish],
    [Enkoderlar, rezolverlar, potensiometrlar, tezlik va tok datchiklari],
    [Vestibulyar apparat],
    [Muvozanat, burilish va tezlanishni sezish],
    [Akselerometrlar, giroskoplar, inersial oʻlchash bloklari (IMU)],
    [Taktil (teri) sezgi],
    [Tegish, bosim, sirpanish, harorat],
    [Taktil matritsalar, kuch-moment datchiklari, sirpanish datchiklari],
    [Eshitish],
    [Tovush manbai va masofani aniqlash],
    [Mikrofonlar, ultratovush lokatorlari],
    [Koʻrish],
    [Obyektlarni tanish, masofa va harakatni baholash],
    [Kameralar, stereokameralar, chuqurlik kameralari, lazer skanerlari],
    [Hid bilish],
    [Kimyoviy moddalarni aniqlash],
    [Gaz datchiklari («elektron burun»)],
  ),
  caption: [Inson sezgi organlari va ularning texnik analoglari],
) <tab-bionika>

Inson axborotning katta qismini koʻrish orqali oladi, shuning uchun texnik koʻrish tizimlari robototexnikada eng murakkab va jadal rivojlanayotgan yoʻnalish hisoblanadi. Shu bilan birga, bionik yondashuv bevosita nusxa koʻchirishni anglatmaydi: texnik datchiklar inson sezgi organlariga ega boʻlmagan imkoniyatlarga ham ega boʻlishi mumkin. Masalan, lazerli masofa oʻlchagich millimetr aniqlikda masofani bevosita oʻlchaydi, radar tuman va zulmatda ishlaydi, infraqizil kamera issiqlik nurlanishini «koʻradi». Aksincha, inson terisining taktil sezgirligi va moslashuvchanligi hozircha texnik taktil datchiklardan ancha yuqori.

*Informatsion yondashuv* nuqtai nazaridan robot harakatining sifati u olayotgan axborotning hajmi, aniqligi va oʻz vaqtida kelishi bilan belgilanadi. Robot qanchalik toʻliq va ishonchli axborotga ega boʻlsa, u shunchalik murakkab va oʻzgaruvchan muhitda ishlay oladi.

// =====================================================================
= Informatsion qurilmalarning tasnifi
// =====================================================================

Robotlarning informatsion qurilmalarini bir nechta belgi boʻyicha tasniflash mumkin.

*Axborot manbai boʻyicha:*
- *ichki holat datchiklari (proprioseptiv)* — robotning oʻz holatini oʻlchaydi: boʻgʻinlarning burchak va chiziqli siljishi, tezligi, tezlanishi, dvigatel toki va momenti, harorat;
- *tashqi muhit datchiklari (eksteroseptiv)* — robot atrofidagi muhit va obyektlar haqida axborot beradi: masofa, obyekt shakli va joylashuvi, kontakt kuchi, yoritilganlik.

*Tashqi muhit bilan oʻzaro taʼsir usuli boʻyicha:* kontaktli (taktil datchiklar, kuch-moment datchiklari, chegara uzgichlari) va kontaktsiz (lokatsion tizimlar, yaqinlik datchiklari, texnik koʻrish).

*Energiya manbai boʻyicha:* passiv datchiklar oʻlchanayotgan obyekt energiyasidan foydalanadi (masalan, termojuft, piezoelektrik datchik, oddiy kamera); aktiv datchiklar muhitga oʻzi signal yuboradi va qaytgan signalni tahlil qiladi (ultratovush lokatori, lazer skaneri, radar).

*Fizik ishlash prinsipi boʻyicha:* rezistiv, sigʻim, induktiv va magnit, optik, piezoelektrik, akustik datchiklar. Regtien va Dertien datchiklarni aynan shu belgi boʻyicha tasniflashni tavsiya etadi, chunki datchikning tavsiflari asosan uning fizik prinsipi bilan belgilanadi: masalan, pozitsiya datchigini rezistiv, sigʻim, induktiv, akustik yoki optik usulda qurish mumkin va ularning har biri turli imkoniyat va cheklovlarga ega.

Asosiy tasnif belgilari 2-rasmda umumlashtirilgan.

#figure(
  diagram(
    spacing: (8mm, 10mm),
    node-stroke: 1pt,
    node-corner-radius: 3pt,
    edge-stroke: 1pt,
    node((0.75, 0), [*Robotning informatsion qurilmalari*], fill: rgb("#fbe3cf"), name: <root>),
    node((0, 1), [Ichki holat datchiklari \ (proprioseptiv)], fill: lightblue, name: <ich>),
    node((1.5, 1), [Tashqi muhit datchiklari \ (eksteroseptiv)], fill: lightblue, name: <tash>),
    node(
      (0, 2),
      align(left)[• pozitsiya va burchak \ • tezlik va tezlanish \ • tok va moment \ • harorat],
      name: <ich2>,
    ),
    node((1, 2), align(left)[*Kontaktli:* \ • taktil \ • kuch-moment \ • chegara uzgichlari], name: <kon>),
    node(
      (2, 2),
      align(left)[*Kontaktsiz:* \ • yaqinlik datchiklari \ • lokatsion tizimlar \ • texnik koʻrish],
      name: <kons>,
    ),
    edge(<root>, <ich>, "->"),
    edge(<root>, <tash>, "->"),
    edge(<ich>, <ich2>, "->"),
    edge(<tash>, <kon>, "->"),
    edge(<tash>, <kons>, "->"),
  ),
  caption: [Robot informatsion qurilmalarining asosiy tasnifi],
) <fig-tasnif>

// =====================================================================
= Zamonaviy rivojlanish tendensiyalari
// =====================================================================

*Miniatyurizatsiya va MEMS texnologiyasi.* Integral sxemalar texnologiyasi va mikroishlov berish yutuqlari tufayli koʻplab anʼanaviy mexanik datchiklar oʻrnini kremniy asosidagi mikroelektromexanik tizimlar (MEMS) egallamoqda. Eng ommaviy MEMS datchiklar — akselerometrlar va giroskoplar. Ommaviy ishlab chiqarish tufayli datchik narxi yakka nusxalar uchun bir necha oʻn ming yevrodan yuz millionlab partiyalar uchun bir necha yevrosentgacha tushadi. Bu robototexnikada koʻp sonli datchiklardan foydalanish imkonini beradi.

*Intellektual (smart) datchiklar.* Bitta kristallda sezgir element bilan birga kuchaytirgich, filtr, analog-raqamli oʻzgartkich va mikroprotsessor joylashtiriladi. Bunday datchik raqamli interfeys (I²C, SPI, CAN, EtherCAT, IO-Link) orqali tayyor, kalibrlangan va haroratga kompensatsiya qilingan natijani beradi, oʻzini oʻzi diagnostika qila oladi.

*Sensorlar kompleksirovaniyasi (sensor fusion).* Bitta datchik har doim cheklangan va shovqinli axborot beradi. Turli datchiklar maʼlumotlarini birlashtirish natijaning aniqligi va ishonchliligini oshiradi. Eng oddiy holatda, bir kattalikni dispersiyalari $sigma_1^2$ va $sigma_2^2$ boʻlgan ikki mustaqil datchik bilan oʻlchab, natijalarni optimal tortish mumkin:

#eq(
  $
    hat(x) = (sigma_2^2 x_1 + sigma_1^2 x_2) / (sigma_1^2 + sigma_2^2), quad sigma^2 = (sigma_1^2 sigma_2^2) / (sigma_1^2 + sigma_2^2).
  $,
)

(3) ifodadan koʻrinadiki, birlashtirilgan natija dispersiyasi $sigma^2$ har ikkala datchik dispersiyasidan kichik boʻladi. Bu gʻoya Kalman filtrining asosida yotadi va IMU bilan GPS, kamera bilan LiDAR, enkoder bilan giroskop maʼlumotlarini birlashtirishda keng qoʻllanadi.

*Texnik koʻrish va sunʼiy intellekt.* Chuqur neyron tarmoqlar obyektlarni tanib olish, tasvirni segmentatsiyalash va sahnani tushunish masalalarida klassik algoritmlardan sezilarli ustunlikka erishdi. Natijada kamera eng universal va arzon datchikka aylanib bormoqda. Shu bilan birga, neyron tarmoqqa asoslangan tizimlar katta hajmdagi oʻqitish maʼlumotlarini va kuchli hisoblash resurslarini talab qiladi.

*Kollaborativ robotlar.* Inson bilan bir ish joyida xavfsiz ishlaydigan robotlar (kobotlar) boʻgʻinlardagi moment datchiklari, dvigatel toki orqali kontaktni aniqlash, yaqinlik datchiklari va kameralar bilan jihozlanadi. Bunday robotlarda informatsion qurilmalar xavfsizlikning asosiy vositasi hisoblanadi.

*Avtonom transport vositalari va mobil robotlar.* Avtonom avtomobil, dron va omborxona robotlari muhitni kameralar, radarlar, LiDAR, ultratovush datchiklari, GNSS va inersial tizimlar majmuasi orqali idrok etadi. Bu yoʻnalish hozirgi kunda datchiklar texnikasi rivojining asosiy harakatlantiruvchi kuchlaridan biridir.

*Sanoat 4.0 va raqamli egizaklar.* Datchiklar tarmoqqa ulanib, uskunalar holatini uzluksiz kuzatish, nosozliklarni oldindan bashorat qilish va jismoniy tizimning raqamli modelini (raqamli egizagini) real vaqtda yangilash imkonini beradi.

// =====================================================================
= Dolzarb muammolar
// =====================================================================

Datchiklar texnikasi va robototexnikaning jadal rivojlanishiga qaramay, robotlarning informatsion qurilmalari sohasida hali hal qilinmagan koʻplab muammolar mavjud.

+ *Noaniqlik va shovqin.* Har qanday oʻlchash xatolikka ega. Robot noaniq, toʻliq boʻlmagan va ziddiyatli axborot asosida ishonchli qaror qabul qilishi kerak. Bu ehtimollik usullari, filtrlash va sensorlar kompleksirovaniyasini talab qiladi.

+ *Strukturalanmagan va dinamik muhit.* Zavoddagi tartibli ish joyidan farqli ravishda, uy, koʻcha yoki qishloq xoʻjaligi muhiti oldindan maʼlum emas va doimo oʻzgaradi. Bunday muhitda obyektlarni ishonchli tanib olish va harakatlanayotgan toʻsiqlarni kuzatish hali ham murakkab masala.

+ *Tashqi sharoitlarning taʼsiri.* Yomgʻir, tuman, qor, chang va kuchli yorugʻlik kamera hamda LiDAR ishini sezilarli yomonlashtiradi. Harorat oʻzgarishi datchiklarda nol siljishi va sezgirlik oʻzgarishini keltirib chiqaradi. Har xil fizik prinsipdagi datchiklarni birgalikda qoʻllash bu muammoni qisman hal qiladi.

+ *Kalibrlash va sinxronlash.* Koʻp datchikli tizimda har bir datchikning ichki parametrlari, ularning bir-biriga nisbatan joylashuvi va vaqt boʻyicha sinxronligi aniq maʼlum boʻlishi kerak. Ekspluatatsiya davomida bu parametrlar oʻzgaradi, shuning uchun avtomatik kalibrlash usullari dolzarbdir.

+ *Maʼlumotlarni real vaqtda qayta ishlash.* Zamonaviy kameralar va lazer skanerlari soniyasiga juda katta hajmdagi maʼlumot beradi. Ularni boshqaruv konturi talab qiladigan kechikish bilan qayta ishlash uchun kuchli, lekin kam energiya sarflaydigan hisoblash vositalari kerak.

+ *Ishonchlilik va funksional xavfsizlik.* Datchikning nosozligi robot yoki avtonom avtomobilning xavfli harakatiga olib kelishi mumkin. Shuning uchun datchiklarni zaxiralash, nosozliklarni aniqlash va funksional xavfsizlik standartlari (IEC 61508, ISO 13849, avtomobillar uchun ISO 26262) talablarini bajarish zarur.

+ *Inson bilan xavfsiz hamkorlik.* Kollaborativ robot insonga tegish ehtimolini oldindan sezishi va kontakt kuchini cheklashi kerak (ISO 10218, ISO/TS 15066). Buning uchun tez va ishonchli yaqinlik, kuch-moment va koʻrish datchiklari talab qilinadi.

+ *Taktil sezgining cheklanganligi.* Inson qoʻlining sezgirligi va moslashuvchanligiga yaqin taktil «teri» yaratish hali ham ilmiy muammo boʻlib qolmoqda. Bu robotlarning nozik va notanish obyektlar bilan ishlash qobiliyatini cheklaydi.

+ *Sunʼiy intellekt tizimlarining ishonchliligi.* Neyron tarmoqlar oʻqitish maʼlumotlarida uchramagan vaziyatlarda kutilmagan xatoga yoʻl qoʻyishi mumkin, ularning qarorlarini tushuntirish va sertifikatlash qiyin.

+ *Kiberxavfsizlik.* Tarmoqqa ulangan datchiklar va sunʼiy signallar yordamida datchiklarni aldash (masalan, GNSS signalini soxtalashtirish) robot tizimlari uchun yangi xavf manbai hisoblanadi.

+ *Narx va energiya isteʼmoli.* Yuqori aniqlikdagi datchiklar (LiDAR, kuch-moment datchiklari, aniq enkoderlar) robot narxining katta qismini tashkil qiladi. Mobil robotlar uchun esa datchiklar va hisoblash vositalarining energiya isteʼmoli ish vaqtini cheklaydi.

Bu muammolarning har biri fanning keyingi boʻlimlarida koʻriladigan mavzular bilan bevosita bogʻliq: datchiklar tavsiflari va xatoliklari, oʻlchash sxemalari, lokatsion va koʻrish tizimlari, kompleksirovaniya, sunʼiy intellekt usullari va inson-robot interfeysi.

// =====================================================================
= Xulosa
// =====================================================================

Robotlarning informatsion qurilmalari qadimgi qalqovichli rostlagichlardan zamonaviy intellektual datchiklar va texnik koʻrish tizimlarigacha boʻlgan uzoq rivojlanish yoʻlini bosib oʻtdi. Robotlar avlodlarining almashinuvi asosan informatsion imkoniyatlarning kengayishi bilan bogʻliq: dasturiy robotlar faqat oʻz holatini «bilgan» boʻlsa, adaptiv robotlar muhitni sezishni, intellektual robotlar esa uni tushunishni va oʻz harakatini rejalashtirishni oʻrganmoqda. Bugungi kunda robot imkoniyatlarini cheklayotgan omil koʻpincha mexanika emas, balki uning muhitni qanchalik toʻliq, aniq va ishonchli idrok eta olishidir. Shu sababli informatsion qurilmalarni chuqur bilish mexatronika va robototexnika mutaxassisi uchun zarur hisoblanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robotning informatsion qurilmalari qanday vazifalarni bajaradi?
  + Robot, robototexnika, mexatronika va mexatron modul tushunchalarini taʼriflang.
  + Oʻzgartkich, sensor va aktuator oʻrtasidagi farq nimada?
  + Qayta aloqali avtomatik qurilmalarning ilk tarixiy namunalariga misollar keltiring.
  + «Robot» va «mexatronika» atamalari qachon va kim tomonidan kiritilgan?
  + Birinchi sanoat robotlari qanday vazifalarni bajargan va ularning informatsion imkoniyatlari qanday boʻlgan?
  + JSPMI boʻyicha mexatron mahsulotlarning toʻrt sinfini tavsiflang.
  + Robotlarning uch avlodi informatsion taʼminoti boʻyicha qanday farqlanadi?
  + Inson sezgi organlari va robot datchiklari oʻrtasidagi oʻxshashlik va farqlarni tushuntiring.
  + Proprioseptiv va eksteroseptiv datchiklarga misollar keltiring.
  + Sensorlar kompleksirovaniyasi oʻlchash aniqligini qanday oshiradi?
  + Robotlarning informatsion qurilmalari sohasidagi uchta asosiy dolzarb muammoni izohlang.
]
