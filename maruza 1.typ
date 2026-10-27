// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №1. Fanning tarixi, rivojlanishi, dolzarb muammolari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")

#set document(title: "Maʼruza №1. Fanning tarixi, rivojlanişi, dolzarb muammolari")
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
#set text(size: 12pt, lang: "uz", font: info.font)
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
  #text(size: 14pt, weight: "bold")[Mavzu: Fanning tarixi, rivojlanişi, dolzarb muammolari]
  #v(0.2em)
  #text(size: 12pt, style: "italic")[(kiriş maʼruzasi)]
]

#v(0.8em)

#block(inset: (left: 0pt))[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Fanning maqsadi, vazifalari va tuzilişi.
  + Asosiy tuşunçalar: robot, mexatronika, mexatron modul, informatsion qurilma.
  + Avtomatika, robototexnika va mexatronikaning tarixiy rivojlanişi.
  + Datçiklar texnikasining rivojlaniş bosqiçlari va robotlar avlodlari.
  + Informatsion tizimlarning bionik jihatlari.
  + Informatsion qurilmalarning tasnifi.
  + Zamonaviy rivojlaniş tendensiyalari va dolzarb muammolar.

  *Tayanç iboralar:* robot, robototexnik tizim, mexatronika, mexatron modul, informatsion qurilma, datçik, ölçaş özgartkiçi, sensor, qayta aloqa, robotlar avlodlari, bionika, proprioseptiv va eksteroseptiv datçiklar, MEMS, intellektual datçik, sensorlar kompleksirovaniyasi.
]

// =====================================================================
= Fanning maqsadi, vazifalari va tuzilişi
// =====================================================================

Zamonaviy robot yoki har qanday mexatron tizim faqat harakatni bajaruvçi mexanizmdan iborat emas. U özining içki holatini va atrof-muhitni «sezişi», olingan maʼlumotni qayta işlaşi va şu asosda harakatini özgartirişi kerak. Bu vazifani robotning *informatsion qurilmalari* — datçiklar, ölçaş özgartkiçlari, signalga işlov beriş sxemalari va axborotni qayta işlaş vositalari bajaradi. Informatsion qurilmalarning sifati robotning aniqligi, tezkorligi, xavfsizligi va «aqlliligi»ni bevosita belgilaydi.

*Fanning maqsadi* — talabalarda zamonaviy robototexnik va mexatron tizimlarning informatsion-ölçaş qurilmalari haqida asosiy bilimlarni şakllantiriş, ularning quriliş va işlaş prinsiplarini, axborotni oliş, saqlaş va qayta işlaş usullarini hamda samarali algoritmlarini örgatişdir.

*Fanning asosiy vazifalari:*
- datçiklarning fizik işlaş prinsiplari, tavsiflari va xatoliklarini örganiş;
- robotning kinestetik (içki holat), lokatsion, taktil va köriş tizimlarini quriş usullarini özlaştiriş;
- ölçaş sxemalari va signalga dastlabki işlov beriş usullarini örganiş;
- bir neçta datçik maʼlumotlarini birlaştiriş (kompleksirovaniya) tamoyillari bilan tanişiş;
- sunʼiy intellekt usullarining robot informatsion tizimlarida qöllanilişini örganiş;
- inson va robot örtasidagi interfeysni loyihalaş asoslarini özlaştiriş.

Fan mazmuni 1-jadvalda keltirilgan yettita bölimga ajratiladi. Fan «Ölçaş va metrologiya asoslari», «Elektronika va sxemotexnika», «Avtomatik boşqariş nazariyasi», «Robototexnika asoslari» kabi fanlarga tayanadi va mexatron tizimlarni loyihalaş, bitiruv malakaviy işi uçun asos bölib xizmat qiladi.

#figure(
  btable(
    columns: (auto, 1fr, 1.6fr),
    header: ([№], [Bölim nomi], [Asosiy mavzular]),
    [1],
    [Robototexnika rivojlanişining asosiy bosqiçlari va tendensiyalari],
    [Asosiy tuşunçalar, intellektual robotlar, bionik jihatlar],
    [2],
    [Sunʼiy intellekt usullari],
    [Ekspert tizimlar, neyron tarmoqlar, assotsiativ xotira, noaniq mantiq],
    [3],
    [Informatsion tizimlar elementlari],
    [Datçiklar va ularning tavsiflari, sezgir elementlar, ölçaş sxemalari, kinestetik, lokatsion, taktil va texnik köriş tizimlari, kompleksirovaniya],
    [4],
    [Intellektual yuritmalar],
    [Adaptiv yuritmalar, noaniq mantiqli rostlagiçlar],
    [5],
    [Robotlar harakatini intellektual boşqariş],
    [Ekspert tizimlar, assotsiativ xotira va neyron tarmoqlar asosida boşqariş],
    [6],
    [Intellektual robotlar xatti-harakatini rejalaştiriş],
    [Harakatlarni rejalaştiriş masalasi, graf usullari, öz-özini öqitiş],
    [7],
    [«Operator — robot» interfeysi],
    [Inson-maşina muloqoti usullari, intellektual interfeys],
  ),
  caption: [Fanning tuzilişi],
) <tab-fan>

// =====================================================================
= Asosiy tuşunçalar
// =====================================================================

*Robot* — atrof-muhitdan keladigan signallarga javob bergan holda, inson bevosita aralaşuvisiz, avtomatik ravişda harakatlarni bajaradigan qayta dasturlanadigan maşina. Bolton taʼrifiça, operator boşqaradigan oddiy qöl qurilmasidan farqli ravişda, robot kompyuter tomonidan boşqariladi va keyingi harakat haqidagi qarorni muhitdan olingan signallar asosida özi qabul qiladi.

*Robototexnika* — robotlarni loyihalaş, yaratiş, boşqariş va qöllaş bilan şuğullanadigan fan va texnika sohasi.

*Mexatronika* — mexanika, elektronika, boşqariş nazariyasi va hisoblaş texnikasining sinergetik birlaşuvi asosida maşina va tizimlarni yaratuvçi fan sohasi. Mexatron tizimni örganiş odatda beşta yönalişga ajratiladi: fizik tizimlarni modellaştiriş, datçiklar va ijro qurilmalari, signallar va tizimlar, kompyuter va mantiqiy tizimlar, dasturiy taʼminot va maʼlumotlarni yiğiş.

*Mexatron modul* — harakatlantiruvçi qism (dvigatel, uzatma), informatsion qism (datçiklar) va boşqaruv qismi (kontroller, quvvat elektronikasi) yagona konstruksiyada birlaştirilgan, funksional va konstruktiv jihatdan tugallangan qurilma. Masalan, robot böğinining servoyuritmasi dvigatel, reduktor, enkoder, tormoz va drayverdan iborat yagona modul bölişi mumkin.

*Informatsion qurilma* — robotning içki holati va taşqi muhit haqidagi maʼlumotni oliş, özgartiriş, uzatiş va dastlabki qayta işlaşni taʼminlovçi qurilma. Uning asosiy elementi — datçik.

Terminologiyada maʼlum farqlar mavjud. Regtien va Dertien taʼrifiga köra, *özgartkiç* (transducer) — ölçanayotgan kattalik haqidagi axborotni bir fizik sohadan (mexanik, issiqlik, optik, magnit) boşqasiga, ideal holda axborotni yöqotmasdan ötkazuvçi qurilma. Kirişi noelektrik, çiqişi elektrik bölgan özgartkiç *sensor (datçik)*, aksinça, elektrik signalni noelektrik kattalikka aylantiruvçi özgartkiç esa *aktuator (ijro qurilmasi)* deb ataladi. Xalqaro metrologik luğat (VIM) böyiça sensor — ölçaş tizimining ölçanayotgan kattalik bevosita taʼsir qiladigan elementi. Zamonaviy datçiklar sezgir elementdan taşqari kuçaytiriş, filtrlaş, analog-raqamli özgartiriş va raqamli interfeysni ham öz içiga oladi, şuning uçun amaliyotda «datçik» va «özgartkiç» çegarasi tobora yöqolib bormoqda.

Robototexnik tizimdagi informatsion qurilmalarning örni 1-rasmda körsatilgan. Informatsion qurilmalar ikki xil axborot oqimini şakllantiradi: mexanizmning içki holati (böğinlar burçaklari, tezliklari, dvigatel toklari) va taşqi muhit (obyektlar, tösiqlar, kontakt kuçlari) haqidagi axborot.

#figure(
  diagram(
    spacing: (20mm, 14mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    edge-stroke: 1pt,
    node((0, 0), [Operator], name: <op>),
    node((1, 0), [Boşqaruv \ tizimi], name: <bt>),
    node((2, 0), [Yuritmalar], name: <yu>),
    node((3, 0), [Mexanizm \ (manipulyator)], name: <mx>),
    node((3, 1), [Işçi muhit \ va obyekt], name: <mu>),
    node((1, 1), [Axborotga \ işlov beriş], name: <ai>),
    node((2, 1), [Informatsion \ qurilmalar], name: <iq>, fill: rgb("#fbe3cf")),
    edge(<op>, <bt>, "<->"),
    edge(<bt>, <yu>, "->"),
    edge(<yu>, <mx>, "->"),
    edge(<mx>, <mu>, "<->", [taʼsir], label-side: left),
    edge(<mx>, <iq>, "->", [içki holat], label-side: right, label-pos: 0.4),
    edge(<mu>, <iq>, "->", [taşqi muhit], label-side: right),
    edge(<iq>, <ai>, "->"),
    edge(<ai>, <bt>, "->"),
  ),
  caption: [Robototexnik tizimning umumlaşgan tuzilişi va informatsion qurilmalarning örni],
) <fig-tuzilish>

Har qanday datçikning çiqiş signali faqat ölçanayotgan kattalikka emas, balki taʼsir etuvçi boşqa omillarga (harorat, taʼminot kuçlanişi, vibratsiya) ham boğliq böladi:

#eq($ y = F(x, z_1, z_2, dots, z_m) + xi, $)

bu yerda $x$ — ölçanayotgan kattalik, $z_1, dots, z_m$ — taʼsir etuvçi omillar, $xi$ — tasodifiy şovqin. Ideal datçik uçun $y$ faqat $x$ ga boğliq. Amaliyotda köpinça çiziqli model qöllaniladi:

#eq($ y = S x + y_0 + xi, $)

bu yerda $S$ — sezgirlik, $y_0$ — nol siljişi. Datçiklar texnikasining asosiy muammolaridan biri — taʼsir etuvçi omillar va şovqinning uluşini kamaytiriş, yaʼni (2) modelga imkon qadar yaqinlaşişdir. Bu masalalar keyingi maʼruzalarda batafsil köriladi.

// =====================================================================
= Avtomatika, robototexnika va mexatronikaning tarixiy rivojlanişi
// =====================================================================

== Qayta aloqali qurilmalarning ilk namunalari

Avtomatik qurilmalar yaratişga urinişlar uzoq tarixga ega. Miloddan avvalgi III–I asrlarda Qadimgi Yunonistonda qalqoviçli rostlagiçlar paydo bölgan: Ktesibiosning suv soati va Filonning moy çiroği suyuqlik sathini qalqoviç yordamida barqaror uşlab turgan. Milodiy I asrda Iskandariyalik Geron «Pnevmatika» asarida qalqoviçli sath rostlagiçlarining turli xillarini tasvirlagan.

XVII–XIX asrlarda Yevropa va Rossiyada mexatronikaning kelajakdagi asoslari bölgan muhim qurilmalar ixtiro qilingan. Gollandiyalik Kornelis Drebbel (1572–1633) birinçi qayta aloqali tizimlardan biri — harorat rostlagiçini yaratgan. Deni Papen 1681-yilda buğ qozonlari uçun bosim saqlagiç klapanini ixtiro qilgan. 1765-yilda I. I. Polzunov buğ qozoni uçun suv sathining qalqoviçli rostlagiçini işlab çiqqan. Jeyms Uattning markazdan qoçma (şarli) rostlagiçi buğ maşinasi valining tezligini ölçab, unga beriladigan buğ miqdorini avtomatik özgartirgan.

Bu misollarning barçasida bitta umumiy ğoya bor: tizim *özining holatini ölçaydi* va natijaga qarab taʼsirni özgartiradi. Demak, informatsion qurilma (qalqoviç, şarli mexanizm) qayta aloqali boşqaruvning ajralmas qismi sifatida eng boşidanoq mavjud bölgan.

== «Robot» tuşunçasining paydo bölişi

«Robot» sözi çex yozuvçisi Karel Çapekning 1920-yilda yozilgan va 1921-yilda sahnalaştirilgan «R.U.R.» («Rossumning universal robotlari») pyesasi orqali keng tarqalgan. Pyesada sunʼiy odamlar işlab çiqaradigan zavod tasvirlangan, söz esa slavyan tillaridagi «robota» — «mehnat», «oğir iş» sözidan olingan. «Robototexnika» (robotics) atamasini fantast yozuvçi Ayzek Azimov 1940-yillar boşida öz hikoyalarida qöllagan va robototexnikaning maşhur uç qonunini taklif etgan:

+ Robot insonga zarar yetkazmasligi yoki harakatsizligi bilan insonga zarar yetişiga yöl qöymasligi kerak.
+ Robot birinçi qonunga zid bölmagan holda inson buyruqlariga böysunişi kerak.
+ Robot birinçi va ikkinçi qonunlarga zid bölmagan holda özini himoya qilişi kerak.

Bu qonunlar badiiy ğoya bölsa-da, bugungi kunda robot xavfsizligi masalasi — himoya tösiqlari, yaqinlik va kuç datçiklari, xavfsizlik standartlari — aynan informatsion qurilmalar orqali hal qilinadi.

== Sanoat robotlarining paydo bölişi

Sanoat robototexnikasining asosiy bosqiçlari 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1fr),
    header: ([Yil], [Voqea]),
    [1956],
    [J. Devol va J. Engelberger Unimation kompaniyasini taşkil etib, birinçi sanoat manipulyatori Unimate ustida iş boşlaydi],
    [1961],
    [Devolga «Programmed Article Transfer» patenti beriladi; General Motors zavodida birinçi Unimate roboti quyma detallarni taxlaş uçun örnatiladi],
    [1966–1972],
    [Stenford tadqiqot institutida (SRI) Shakey — kamera va masofa ölçagiç yordamida muhitni idrok etib, harakatini rejalaştiradigan birinçi mobil robot yaratiladi],
    [1967],
    [General Motors kuzovni nuqtali payvandlovçi robotlarni joriy qiladi],
    [1973],
    [KUKA kompaniyasi oltita elektromexanik yuritmali birinçi sanoat roboti Famulus ni yaratadi],
    [1974],
    [ASEA (Şvetsiya) uçun 8 bitli Intel mikroprotsessori bilan boşqariladigan birinçi sanoat roboti işlab çiqiladi],
    [1978],
    [Unimation General Motors uçun PUMA (Programmable Universal Machine for Assembly) robotini yaratadi],
    [1979],
    [Yaponiyada Nachi kompaniyasi gidravlik yuritmalar örniga elektr dvigatelli payvandlaş robotlarini işlab çiqadi],
    [1986],
    [Honda özining birinçi gumanoid robotini taqdim etadi],
    [1987],
    [Xalqaro robototexnika federatsiyasi (IFR) taşkil etiladi],
  ),
  caption: [Sanoat robototexnikasi rivojlanişining asosiy bosqiçlari~[1]],
) <tab-robot-tarix>

Jadvaldan muhim bir qonuniyatni köriş mumkin: dastlabki robotlar gidravlik yuritmali bölib, oldindan yozilgan dasturni «kör-körona» bajargan. Mikroprotsessorlar (1970-yillar) va elektr yuritmalarning keng tarqalişi bilan robotga köproq datçik örnatiş va ularning signallarini real vaqtda qayta işlaş imkoniyati paydo böldi.

== Mexatronikaning şakllanişi

«Mexatronika» atamasini 1969-yilda yapon kompaniyasi Yaskawa Electric muhandisi mexanika va elektronikani birlaştirgan tizimlarni ifodalaş uçun taklif etgan. Kompaniya 1972-yilda bu atamaga savdo belgisi huquqini olgan, ammo atama keng tarqalgaç, 1982-yilda bu huquqdan voz keçgan. Dastlab mexatronika hisoblaş qismisiz elektromexanik tizimlarni (avtomatik eşiklar, savdo avtomatlari) anglatgan.

1970-yillar oxirida Yaponiya maşinasozlik sanoatini rivojlantiriş jamiyati (JSPMI) mexatron mahsulotlarni tört sinfga ajratgan (3-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr, 1fr),
    header: ([Sinf], [Tavsifi], [Misollar]),
    [I],
    [Funksionalligini oşiriş uçun elektronika qöşilgan asosan mexanik mahsulotlar],
    [Raqamli dasturiy boşqariladigan dastgohlar, rostlanuvçi tezlikli yuritmalar],
    [II],
    [Taşqi interfeysi özgarmagan, içki qurilmalari elektronika bilan yangilangan anʼanaviy mexanik tizimlar],
    [Zamonaviy tikuv maşinasi],
    [III],
    [Funksiyasi saqlangan, ammo içki mexanizmlari elektronika bilan almaştirilgan tizimlar],
    [Raqamli soat],
    [IV],
    [Mexanika va elektronikaning sinergetik integratsiyasi asosida loyihalangan mahsulotlar],
    [Nusxa köçiriş apparati, aqlli kir yuviş maşinasi],
  ),
  caption: [Mexatron mahsulotlarning JSPMI tasnifi~[3]],
) <tab-jspmi>

Haqiqiy mexatron tizimlar mikroprotsessor (Intel, 1970-yillar) paydo bölgandan keyingina amaliy jihatdan mumkin böldi. Avtomobil buning yaqqol misoli: 1960-yillargaça avtomobildagi yagona jiddiy elektron qurilma radio bölgan. 1970-yillar oxirida tirsakli val va taqsimlaş vali holati datçiklari (dastlab Xoll datçigi), havo sarfi va drossel holati datçiklari hamda mikrokontrollerdan iborat elektron öt oldiriş tizimi, şuningdek ğildiraklar aylaniş tezligi datçiklariga asoslangan bloklanişga qarşi tormoz tizimi (ABS) joriy etilgan. Bugungi avtomobilda yuzlab datçiklar mavjud, avtonom avtomobil esa köp jihatdan ğildirakli robotdir.

// =====================================================================
= Datçiklar texnikasining rivojlanişi va robotlar avlodlari
// =====================================================================

== Datçiklar texnikasining asosiy bosqiçlari

Robotlarning informatsion qurilmalari fizikaning turli sohalaridagi kaşfiyotlarga tayanadi. Bugun robotlarda qöllanadigan köplab datçiklarning işlaş prinsiplari XIX asrda kaşf etilgan, ammo ularning keng qöllanilişi yarimötkazgiçlar texnologiyasi va mikroelektronika rivoji bilan boğliq (4-jadval).

#figure(
  btable(
    columns: (auto, 1fr),
    header: ([Yil], [Kaşfiyot yoki texnologiya va uning robototexnikadagi ahamiyati]),
    [1856],
    [U. Tomson (lord Kelvin) metall simning qarşiligi deformatsiyaga boğliqligini aniqlaydi — tenzorezistiv datçiklar asosi],
    [1879],
    [E. Xoll magnit maydonda ötkazgiçda köndalang kuçlaniş hosil bölişini kaşf etadi — Xoll datçiklari (pozitsiya, tok, tezlik)],
    [1880],
    [P. va J. Kyuri aka-ukalar piezoelektrik effektni kaşf etadi — kuç, bosim va tezlaniş datçiklari],
    [1938],
    [E. Simmons va A. Ruge yopiştiriladigan simli tenzorezistorni yaratadi — kuç va moment datçiklarining asosi],
    [1954],
    [Ç. Smit kremniy va germaniyda kuçli piezorezistiv effektni aniqlaydi — yarimötkazgiçli bosim va tezlaniş datçiklari],
    [1960],
    [Birinçi lazer yaratiladi; R. Kalman filtri taklif etiladi — lazerli masofa ölçagiçlar va datçik maʼlumotlarini birlaştiriş],
    [1960-yillar boşi],
    [Kremniy asosidagi birinçi bosim datçiklari — mikroelektromexanik tizimlar (MEMS) yönalişining boşlanişi~[2]],
    [1969],
    [U. Boyl va J. Smit zaryad boğlangan qurilmani (PZS, CCD) ixtiro qiladi — raqamli kameralar va texnik köriş tizimlari],
    [1990-yillar],
    [MEMS akselerometrlar va giroskoplarning ommaviy işlab çiqarilişi (avtomobil xavfsizlik yostiqlari); GPS tizimining töliq işga tuşişi],
    [2005],
    [DARPA Grand Challenge musobaqasida avtonom avtomobil lazer skanerlari (LiDAR), kamera, GPS va inersial datçiklar majmuasi yordamida çöl yölini töliq bosib ötadi],
    [2010],
    [Arzon RGB-D (rang va çuqurlik) kameralarning paydo bölişi — mobil robotlar uçun uç ölçamli köriş ommalaşadi],
  ),
  caption: [Datçiklar texnikasi rivojlanişining asosiy bosqiçlari],
) <tab-datchik-tarix>

== Robotlar avlodlari

Robotlarning rivojlanişini ularning informatsion imkoniyatlariga qarab uç avlodga ajratiş qabul qilingan (5-jadval). Bu tasnif aynan informatsion qurilmalarning roli ortib borişini aks ettiradi.

#figure(
  btable(
    columns: (1fr, 1.3fr, 1.3fr),
    header: ([Avlod], [Informatsion taʼminoti], [Imkoniyatlari]),
    [I avlod — \ dasturiy robotlar],
    [Faqat içki datçiklar (böğin holati); taşqi muhit haqida axborot yöq],
    [Qatʼiy dasturni takrorlaydi; obyekt joyi aniq belgilangan, muhit özgarmas bölişi şart],
    [II avlod — \ adaptiv (sezgir) robotlar],
    [Taşqi datçiklar: taktil, kuç-moment, lokatsion, oddiy texnik köriş],
    [Muhitning çeklangan özgarişlariga moslaşadi: obyekt joyini aniqlaydi, kontakt kuçini rostlaydi],
    [III avlod — \ intellektual robotlar],
    [Köp sonli turli datçiklar, ularning maʼlumotlarini birlaştiriş, sunʼiy intellekt],
    [Muhitni tanib oladi, maqsadga erişiş yölini özi rejalaştiradi, tajribadan örganadi, inson bilan muloqot qiladi],
  ),
  caption: [Robotlar avlodlari va ularning informatsion taʼminoti],
) <tab-avlod>

Hozirgi sanoat robotlarining katta qismi hali ham I avlodga yaqin, ammo kollaborativ robotlar, avtonom mobil robotlar va avtonom transport vositalari II va III avlod xususiyatlariga ega. Bunday tizimlarda informatsion qurilmalar qiymati va murakkabligi köpinça mexanik qismdan ustun keladi.

// =====================================================================
= Informatsion tizimlarning bionik jihatlari
// =====================================================================

Robotlarning informatsion tizimlarini yaratişda köpinça tirik organizmlar, birinçi navbatda inson sezgi organlari namuna sifatida olinadi. Bu yondaşuv *bionika* deb ataladi. Inson taşqi dunyo haqidagi axborotni bir neçta sezgi kanali orqali oladi, markaziy asab tizimida ularni birlaştiradi va harakatni boşqaradi. Robotning informatsion tizimi ham xuddi şunday tuzilgan: datçiklar sezgi organlari, kontroller esa «miya» vazifasini bajaradi (6-jadval).

#figure(
  btable(
    columns: (1fr, 1.2fr, 1.4fr),
    header: ([Inson sezgisi], [Vazifasi], [Robotdagi texnik analogi]),
    [Kinestetik (muşak-böğin) sezgi],
    [Tana qismlarining holati va harakatini seziş],
    [Enkoderlar, rezolverlar, potensiometrlar, tezlik va tok datçiklari],
    [Vestibulyar apparat],
    [Muvozanat, buriliş va tezlanişni seziş],
    [Akselerometrlar, giroskoplar, inersial ölçaş bloklari (IMU)],
    [Taktil (teri) sezgi],
    [Tegiş, bosim, sirpaniş, harorat],
    [Taktil matritsalar, kuç-moment datçiklari, sirpaniş datçiklari],
    [Eşitiş],
    [Tovuş manbai va masofani aniqlaş],
    [Mikrofonlar, ultratovuş lokatorlari],
    [Köriş],
    [Obyektlarni taniş, masofa va harakatni baholaş],
    [Kameralar, stereokameralar, çuqurlik kameralari, lazer skanerlari],
    [Hid biliş],
    [Kimyoviy moddalarni aniqlaş],
    [Gaz datçiklari («elektron burun»)],
  ),
  caption: [Inson sezgi organlari va ularning texnik analoglari],
) <tab-bionika>

Inson axborotning katta qismini köriş orqali oladi, şuning uçun texnik köriş tizimlari robototexnikada eng murakkab va jadal rivojlanayotgan yönaliş hisoblanadi. Şu bilan birga, bionik yondaşuv bevosita nusxa köçirişni anglatmaydi: texnik datçiklar inson sezgi organlariga ega bölmagan imkoniyatlarga ham ega bölişi mumkin. Masalan, lazerli masofa ölçagiç millimetr aniqlikda masofani bevosita ölçaydi, radar tuman va zulmatda işlaydi, infraqizil kamera issiqlik nurlanişini «köradi». Aksinça, inson terisining taktil sezgirligi va moslaşuvçanligi hozirça texnik taktil datçiklardan ança yuqori.

*Informatsion yondaşuv* nuqtai nazaridan robot harakatining sifati u olayotgan axborotning hajmi, aniqligi va öz vaqtida kelişi bilan belgilanadi. Robot qançalik töliq va işonçli axborotga ega bölsa, u şunçalik murakkab va özgaruvçan muhitda işlay oladi.

// =====================================================================
= Informatsion qurilmalarning tasnifi
// =====================================================================

Robotlarning informatsion qurilmalarini bir neçta belgi böyiça tasniflaş mumkin.

*Axborot manbai böyiça:*
- *içki holat datçiklari (proprioseptiv)* — robotning öz holatini ölçaydi: böğinlarning burçak va çiziqli siljişi, tezligi, tezlanişi, dvigatel toki va momenti, harorat;
- *taşqi muhit datçiklari (eksteroseptiv)* — robot atrofidagi muhit va obyektlar haqida axborot beradi: masofa, obyekt şakli va joylaşuvi, kontakt kuçi, yoritilganlik.

*Taşqi muhit bilan özaro taʼsir usuli böyiça:* kontaktli (taktil datçiklar, kuç-moment datçiklari, çegara uzgiçlari) va kontaktsiz (lokatsion tizimlar, yaqinlik datçiklari, texnik köriş).

*Energiya manbai böyiça:* passiv datçiklar ölçanayotgan obyekt energiyasidan foydalanadi (masalan, termojuft, piezoelektrik datçik, oddiy kamera); aktiv datçiklar muhitga özi signal yuboradi va qaytgan signalni tahlil qiladi (ultratovuş lokatori, lazer skaneri, radar).

*Fizik işlaş prinsipi böyiça:* rezistiv, siğim, induktiv va magnit, optik, piezoelektrik, akustik datçiklar. Regtien va Dertien datçiklarni aynan şu belgi böyiça tasniflaşni tavsiya etadi, çunki datçikning tavsiflari asosan uning fizik prinsipi bilan belgilanadi: masalan, pozitsiya datçigini rezistiv, siğim, induktiv, akustik yoki optik usulda quriş mumkin va ularning har biri turli imkoniyat va çeklovlarga ega.

Asosiy tasnif belgilari 2-rasmda umumlaştirilgan.

#figure(
  diagram(
    spacing: (8mm, 10mm),
    node-stroke: 1pt,
    node-corner-radius: 3pt,
    edge-stroke: 1pt,
    node((0.75, 0), [*Robotning informatsion qurilmalari*], fill: rgb("#fbe3cf"), name: <root>),
    node((0, 1), [Içki holat datçiklari \ (proprioseptiv)], fill: lightblue, name: <ich>),
    node((1.5, 1), [Taşqi muhit datçiklari \ (eksteroseptiv)], fill: lightblue, name: <tash>),
    node(
      (0, 2),
      align(left)[• pozitsiya va burçak \ • tezlik va tezlaniş \ • tok va moment \ • harorat],
      name: <ich2>,
    ),
    node((1, 2), align(left)[*Kontaktli:* \ • taktil \ • kuç-moment \ • çegara uzgiçlari], name: <kon>),
    node(
      (2, 2),
      align(left)[*Kontaktsiz:* \ • yaqinlik datçiklari \ • lokatsion tizimlar \ • texnik köriş],
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
= Zamonaviy rivojlaniş tendensiyalari
// =====================================================================

*Miniatyurizatsiya va MEMS texnologiyasi.* Integral sxemalar texnologiyasi va mikroişlov beriş yutuqlari tufayli köplab anʼanaviy mexanik datçiklar örnini kremniy asosidagi mikroelektromexanik tizimlar (MEMS) egallamoqda. Eng ommaviy MEMS datçiklar — akselerometrlar va giroskoplar. Ommaviy işlab çiqariş tufayli datçik narxi yakka nusxalar uçun bir neça ön ming yevrodan yuz millionlab partiyalar uçun bir neça yevrosentgaça tuşadi. Bu robototexnikada köp sonli datçiklardan foydalaniş imkonini beradi.

*Intellektual (smart) datçiklar.* Bitta kristallda sezgir element bilan birga kuçaytirgiç, filtr, analog-raqamli özgartkiç va mikroprotsessor joylaştiriladi. Bunday datçik raqamli interfeys (I²C, SPI, CAN, EtherCAT, IO-Link) orqali tayyor, kalibrlangan va haroratga kompensatsiya qilingan natijani beradi, özini özi diagnostika qila oladi.

*Sensorlar kompleksirovaniyasi (sensor fusion).* Bitta datçik har doim çeklangan va şovqinli axborot beradi. Turli datçiklar maʼlumotlarini birlaştiriş natijaning aniqligi va işonçliligini oşiradi. Eng oddiy holatda, bir kattalikni dispersiyalari $sigma_1^2$ va $sigma_2^2$ bölgan ikki mustaqil datçik bilan ölçab, natijalarni optimal tortiş mumkin:

#eq(
  $
    hat(x) = (sigma_2^2 x_1 + sigma_1^2 x_2) / (sigma_1^2 + sigma_2^2), quad sigma^2 = (sigma_1^2 sigma_2^2) / (sigma_1^2 + sigma_2^2).
  $,
)

(3) ifodadan körinadiki, birlaştirilgan natija dispersiyasi $sigma^2$ har ikkala datçik dispersiyasidan kiçik böladi. Bu ğoya Kalman filtrining asosida yotadi va IMU bilan GPS, kamera bilan LiDAR, enkoder bilan giroskop maʼlumotlarini birlaştirişda keng qöllanadi.

*Texnik köriş va sunʼiy intellekt.* Çuqur neyron tarmoqlar obyektlarni tanib oliş, tasvirni segmentatsiyalaş va sahnani tuşuniş masalalarida klassik algoritmlardan sezilarli ustunlikka erişdi. Natijada kamera eng universal va arzon datçikka aylanib bormoqda. Şu bilan birga, neyron tarmoqqa asoslangan tizimlar katta hajmdagi öqitiş maʼlumotlarini va kuçli hisoblaş resurslarini talab qiladi.

*Kollaborativ robotlar.* Inson bilan bir iş joyida xavfsiz işlaydigan robotlar (kobotlar) böğinlardagi moment datçiklari, dvigatel toki orqali kontaktni aniqlaş, yaqinlik datçiklari va kameralar bilan jihozlanadi. Bunday robotlarda informatsion qurilmalar xavfsizlikning asosiy vositasi hisoblanadi.

*Avtonom transport vositalari va mobil robotlar.* Avtonom avtomobil, dron va omborxona robotlari muhitni kameralar, radarlar, LiDAR, ultratovuş datçiklari, GNSS va inersial tizimlar majmuasi orqali idrok etadi. Bu yönaliş hozirgi kunda datçiklar texnikasi rivojining asosiy harakatlantiruvçi kuçlaridan biridir.

*Sanoat 4.0 va raqamli egizaklar.* Datçiklar tarmoqqa ulanib, uskunalar holatini uzluksiz kuzatiş, nosozliklarni oldindan başorat qiliş va jismoniy tizimning raqamli modelini (raqamli egizagini) real vaqtda yangilaş imkonini beradi.

// =====================================================================
= Dolzarb muammolar
// =====================================================================

Datçiklar texnikasi va robototexnikaning jadal rivojlanişiga qaramay, robotlarning informatsion qurilmalari sohasida hali hal qilinmagan köplab muammolar mavjud.

+ *Noaniqlik va şovqin.* Har qanday ölçaş xatolikka ega. Robot noaniq, töliq bölmagan va ziddiyatli axborot asosida işonçli qaror qabul qilişi kerak. Bu ehtimollik usullari, filtrlaş va sensorlar kompleksirovaniyasini talab qiladi.

+ *Strukturalanmagan va dinamik muhit.* Zavoddagi tartibli iş joyidan farqli ravişda, uy, köça yoki qişloq xöjaligi muhiti oldindan maʼlum emas va doimo özgaradi. Bunday muhitda obyektlarni işonçli tanib oliş va harakatlanayotgan tösiqlarni kuzatiş hali ham murakkab masala.

+ *Taşqi şaroitlarning taʼsiri.* Yomğir, tuman, qor, çang va kuçli yoruğlik kamera hamda LiDAR işini sezilarli yomonlaştiradi. Harorat özgarişi datçiklarda nol siljişi va sezgirlik özgarişini keltirib çiqaradi. Har xil fizik prinsipdagi datçiklarni birgalikda qöllaş bu muammoni qisman hal qiladi.

+ *Kalibrlaş va sinxronlaş.* Köp datçikli tizimda har bir datçikning içki parametrlari, ularning bir-biriga nisbatan joylaşuvi va vaqt böyiça sinxronligi aniq maʼlum bölişi kerak. Ekspluatatsiya davomida bu parametrlar özgaradi, şuning uçun avtomatik kalibrlaş usullari dolzarbdir.

+ *Maʼlumotlarni real vaqtda qayta işlaş.* Zamonaviy kameralar va lazer skanerlari soniyasiga juda katta hajmdagi maʼlumot beradi. Ularni boşqaruv konturi talab qiladigan keçikiş bilan qayta işlaş uçun kuçli, lekin kam energiya sarflaydigan hisoblaş vositalari kerak.

+ *Işonçlilik va funksional xavfsizlik.* Datçikning nosozligi robot yoki avtonom avtomobilning xavfli harakatiga olib kelişi mumkin. Şuning uçun datçiklarni zaxiralaş, nosozliklarni aniqlaş va funksional xavfsizlik standartlari (IEC 61508, ISO 13849, avtomobillar uçun ISO 26262) talablarini bajariş zarur.

+ *Inson bilan xavfsiz hamkorlik.* Kollaborativ robot insonga tegiş ehtimolini oldindan sezişi va kontakt kuçini çeklaşi kerak (ISO 10218, ISO/TS 15066). Buning uçun tez va işonçli yaqinlik, kuç-moment va köriş datçiklari talab qilinadi.

+ *Taktil sezgining çeklanganligi.* Inson qölining sezgirligi va moslaşuvçanligiga yaqin taktil «teri» yaratiş hali ham ilmiy muammo bölib qolmoqda. Bu robotlarning nozik va notaniş obyektlar bilan işlaş qobiliyatini çeklaydi.

+ *Sunʼiy intellekt tizimlarining işonçliligi.* Neyron tarmoqlar öqitiş maʼlumotlarida uçramagan vaziyatlarda kutilmagan xatoga yöl qöyişi mumkin, ularning qarorlarini tuşuntiriş va sertifikatlaş qiyin.

+ *Kiberxavfsizlik.* Tarmoqqa ulangan datçiklar va sunʼiy signallar yordamida datçiklarni aldaş (masalan, GNSS signalini soxtalaştiriş) robot tizimlari uçun yangi xavf manbai hisoblanadi.

+ *Narx va energiya isteʼmoli.* Yuqori aniqlikdagi datçiklar (LiDAR, kuç-moment datçiklari, aniq enkoderlar) robot narxining katta qismini taşkil qiladi. Mobil robotlar uçun esa datçiklar va hisoblaş vositalarining energiya isteʼmoli iş vaqtini çeklaydi.

Bu muammolarning har biri fanning keyingi bölimlarida köriladigan mavzular bilan bevosita boğliq: datçiklar tavsiflari va xatoliklari, ölçaş sxemalari, lokatsion va köriş tizimlari, kompleksirovaniya, sunʼiy intellekt usullari va inson-robot interfeysi.

// =====================================================================
= Xulosa
// =====================================================================

Robotlarning informatsion qurilmalari qadimgi qalqoviçli rostlagiçlardan zamonaviy intellektual datçiklar va texnik köriş tizimlarigaça bölgan uzoq rivojlaniş yölini bosib ötdi. Robotlar avlodlarining almaşinuvi asosan informatsion imkoniyatlarning kengayişi bilan boğliq: dasturiy robotlar faqat öz holatini «bilgan» bölsa, adaptiv robotlar muhitni sezişni, intellektual robotlar esa uni tuşunişni va öz harakatini rejalaştirişni örganmoqda. Bugungi kunda robot imkoniyatlarini çeklayotgan omil köpinça mexanika emas, balki uning muhitni qançalik töliq, aniq va işonçli idrok eta olişidir. Şu sababli informatsion qurilmalarni çuqur biliş mexatronika va robototexnika mutaxassisi uçun zarur hisoblanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robotning informatsion qurilmalari qanday vazifalarni bajaradi?
  + Robot, robototexnika, mexatronika va mexatron modul tuşunçalarini taʼriflang.
  + Özgartkiç, sensor va aktuator örtasidagi farq nimada?
  + Qayta aloqali avtomatik qurilmalarning ilk tarixiy namunalariga misollar keltiring.
  + «Robot» va «mexatronika» atamalari qaçon va kim tomonidan kiritilgan?
  + Birinçi sanoat robotlari qanday vazifalarni bajargan va ularning informatsion imkoniyatlari qanday bölgan?
  + JSPMI böyiça mexatron mahsulotlarning tört sinfini tavsiflang.
  + Robotlarning uç avlodi informatsion taʼminoti böyiça qanday farqlanadi?
  + Inson sezgi organlari va robot datçiklari örtasidagi öxşaşlik va farqlarni tuşuntiring.
  + Proprioseptiv va eksteroseptiv datçiklarga misollar keltiring.
  + Sensorlar kompleksirovaniyasi ölçaş aniqligini qanday oşiradi?
  + Robotlarning informatsion qurilmalari sohasidagi uçta asosiy dolzarb muammoni izohlang.
]
