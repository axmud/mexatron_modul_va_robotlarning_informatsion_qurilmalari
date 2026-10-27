// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №11. Informatsion qurilmalarni avtomatlashgan loyihalash
//              tizimlarining tuzilishi va xususiyatlari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №11. Mexatron modullar va robotlarning informatsion qurilmalarini avtomatlashgan loyihalash tizimlarining tuzilishi va xususiyatlari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 11  // maʼruza raqami
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
#show figure.caption: set text(size: 11pt)
#show table: set par(justify: false, first-line-indent: 0pt)

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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №11]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarning informatsion qurilmalarini avtomatlashgan loyihalash tizimlarining tuzilishi va xususiyatlari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Avtomatlashgan loyihalash tizimi tushunchasi. CAD, CAE, CAM, PDM va PLM.
  + Mexatron qurilmalarni loyihalash bosqichlari. V-model.
  + Avtomatlashgan loyihalash tizimining tuzilishi va taʼminot turlari.
  + Informatsion qurilmalarni loyihalashda qoʻllanadigan ALT lar.
  + Chekli elementlar usuli asoslari.
  + Loyihalash misoli: tenzometrik kuch datchigi.
  + ALT lar orasida maʼlumot almashish. ALT larning xususiyatlari va rivojlanish tendensiyalari.

  *Tayanch iboralar:* avtomatlashgan loyihalash tizimi (ALT), CAD, CAE, CAM, EDA, PDM, PLM, V-model, verifikatsiya, validatsiya, texnik, matematik, dasturiy, informatsion taʼminot, parametrik modellashtirish, chekli elementlar usuli, bikrlik matritsasi, tor (mesh), SPICE, bosma plata, ko-simulyatsiya, STEP, FMI, raqamli egizak.
]

// =====================================================================
= Avtomatlashgan loyihalash tizimi tushunchasi
// =====================================================================

Informatsion qurilma — datchik, kamera moduli yoki intellektual datchik — bir vaqtning oʻzida mexanik konstruksiya, fizik oʻzgartirgich, elektron sxema va dasturiy taʼminotdan iborat. Bunday qurilmani faqat qogʻozda hisoblash va tajriba namunalarini koʻp marta yasash orqali loyihalash uzoq va qimmat. Shuning uchun zamonaviy loyihalash kompyuter yordamida, *avtomatlashgan loyihalash tizimlari* (ALT) vositasida bajariladi.

*Avtomatlashgan loyihalash tizimi* — loyihalash jarayonini avtomatlashtiruvchi, loyihalovchilar va kompyuter vositalarining oʻzaro taʼsirida ishlaydigan tashkiliy-texnik tizim. U loyihalovchini almashtirmaydi, balki koʻp mehnat talab qiladigan hisoblash, chizish, modellashtirish va hujjatlashtirish ishlarini bajarib, unga variantlarni tez solishtirish va asosli qaror qabul qilish imkonini beradi.

Xalqaro amaliyotda ALT turlari quyidagi qisqartmalar bilan ataladi:
- *CAD* (_Computer-Aided Design_) — geometrik modellashtirish va chizmalar tayyorlash;
- *CAE* (_Computer-Aided Engineering_) — muhandislik tahlili: mustahkamlik, tebranishlar, issiqlik, elektromagnit maydonlar, oqimlar;
- *CAM* (_Computer-Aided Manufacturing_) — ishlab chiqarishni tayyorlash, raqamli dasturiy boshqariladigan dastgohlar uchun dasturlar;
- *EDA* (_Electronic Design Automation_) — elektron sxemalar va bosma platalarni loyihalash;
- *PDM / PLM* (_Product Data / Lifecycle Management_) — mahsulot haqidagi barcha maʼlumotlar va uning hayotiy siklini boshqarish.

ALT qoʻllanishi loyihalash muddatini va tajriba namunalari sonini qisqartiradi, xatolarni erta bosqichlarda — mahsulot hali yasalmasdan aniqlash imkonini beradi, loyiha sifatini oshiradi va hujjatlarni tartibli saqlashni taʼminlaydi.

// =====================================================================
= Mexatron qurilmalarni loyihalash bosqichlari. V-model
// =====================================================================

Anʼanaviy loyihalashda mexanika, elektronika va dastur ketma-ket ishlab chiqilgan. Mexatron qurilmalarda esa bu sohalar bir-biri bilan chambarchas bogʻliq, shuning uchun ular parallel va kelishilgan holda loyihalanadi. Mexatron tizimlarni loyihalash metodikasi sifatida keng tarqalgan *V-model* (Germaniya muhandislar uyushmasining VDI 2206 tavsiyasi) 1-rasmda koʻrsatilgan.

#figure(
  diagram(
    spacing: (10mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Talablar], fill: lightorange, name: <t>),
    node((1, 1), [Tizim \ loyihasi], name: <tl>),
    node((2, 2), [Sohalar boʻyicha \ loyihalash], name: <sl>),
    node((3, 1), [Tizim \ integratsiyasi], name: <ti>),
    node((4, 0), [Tasdiqlash, \ mahsulot], fill: lightorange, name: <xt>),
    edge(<t>, <tl>, "->"),
    edge(<tl>, <sl>, "->"),
    edge(<sl>, <ti>, "->"),
    edge(<ti>, <xt>, "->"),
    edge(<t>, <xt>, "<->", stroke: (dash: "dashed", thickness: 1pt), [verifikatsiya, validatsiya], label-side: left),
    edge(<tl>, <ti>, "<->", stroke: (dash: "dashed", thickness: 1pt)),
  ),
  caption: [Mexatron tizimlarni loyihalashning V-modeli],
) <fig-v>

V-modelning chap tarmogʻida loyiha yuqoridan pastga — talablardan tizim konsepsiyasiga, soʻngra alohida sohalar (mexanika, elektronika, dasturiy taʼminot) boʻyicha batafsil loyihaga qarab aniqlashtiriladi. Oʻng tarmogʻida esa alohida qismlar birlashtiriladi va har bir sathda chap tarmoqdagi mos talablarga muvofiqligi tekshiriladi: *verifikatsiya* — qurilma loyihada belgilanganidek toʻgʻri yasalganini tekshirish, *validatsiya* — qurilma haqiqatan foydalanuvchi talablarini qondirishini tasdiqlash. Barcha bosqichlarda modellashtirish va model tahlili parallel olib boriladi. Murakkab qurilmalarda V-model bir necha marta takrorlanadi: har bir sikl natijasida tobora mukammalroq namuna (laboratoriya maketi, tajriba namunasi, seriyaga tayyor namuna) olinadi.

Informatsion qurilmalar uchun bosqichlar mazmuni quyidagicha:
+ *talablar* — oʻlchanadigan kattalik, diapazon, aniqlik, tezkorlik, ish sharoiti, oʻlcham, interfeys, narx;
+ *tizim loyihasi* — fizik prinsipni tanlash, struktura sxemasini tuzish, xatolik «byudjetini» elementlar oʻrtasida taqsimlash (9-maʼruza);
+ *sohalar boʻyicha loyihalash* — sezgir element va korpus konstruksiyasi (CAD, CAE), elektron sxema va plata (EDA), mikrodastur va ishlov berish algoritmlari;
+ *integratsiya va tasdiqlash* — prototipni yigʻish, kalibrlash, metrologik tavsiflarini va ish sharoitiga chidamliligini sinash.

// =====================================================================
= Avtomatlashgan loyihalash tizimining tuzilishi
// =====================================================================

ALT ni tashkil etuvchi qismlar *taʼminot turlari* boʻyicha tasniflanadi (1-jadval).

#figure(
  btable(
    columns: (auto, 1.6fr),
    header: ([Taʼminot turi], [Mazmuni]),
    [Texnik],
    [Kompyuterlar, ishchi stansiyalar, serverlar, tarmoq, kiritish-chiqarish qurilmalari (3D skanerlar, printerlar, plotterlar)],
    [Matematik],
    [Loyihalanayotgan obyekt modellari, hisoblash usullari va algoritmlar (chekli elementlar usuli, optimallash, simulyatsiya)],
    [Dasturiy],
    [Operatsion tizimlar va amaliy ALT dasturlari (CAD, CAE, EDA, PDM)],
    [Informatsion],
    [Maʼlumotlar bazalari: standart detallar, materiallar xossalari, elektron komponentlar, datchik modellari kutubxonalari],
    [Lingvistik],
    [Loyihalovchi va tizim muloqoti tillari, maʼlumot almashish formatlari, skript va dasturlash tillari],
    [Metodik],
    [Loyihalash metodikalari, standartlar, yoʻriqnomalar],
    [Tashkiliy],
    [Loyihalash boʻlinmalarining tuzilishi, vazifalar taqsimoti, hujjat aylanishi qoidalari],
  ),
  caption: [ALT taʼminot turlari],
) <tab-taminot>

Dasturiy nuqtai nazardan zamonaviy ALT quyidagi asosiy modullardan iborat: foydalanuvchi interfeysi, geometrik yadro (3D modellarni qurish va oʻzgartirish), hisoblash va tahlil modullari (solverlar), vizualizatsiya, komponentlar kutubxonalari va maʼlumotlarni boshqarish moduli. Turli ALT lar yagona maʼlumotlar muhiti (PDM) orqali bogʻlanadi.

// =====================================================================
= Informatsion qurilmalarni loyihalashda qoʻllanadigan ALT lar
// =====================================================================

Informatsion qurilma bir nechta fizik sohani qamrab olgani uchun uni loyihalashda turli ALT lar birgalikda qoʻllanadi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.4fr, 1.2fr),
    header: ([Soha], [Loyihalash vazifalari], [Dasturiy vositalarga misollar]),
    [Mexanik konstruksiya (CAD)],
    [Sezgir element, korpus, mahkamlash elementlari, kodli disk 3D modeli va chizmalari],
    [SolidWorks, Siemens NX, CATIA, Autodesk Inventor va Fusion, KOMPAS-3D, FreeCAD],
    [Fizik maydonlar tahlili (CAE)],
    [Elastik element deformatsiyasi, xususiy chastotalar, issiqlik, elektrostatik va magnit maydonlar, MEMS tuzilmalari],
    [ANSYS, COMSOL Multiphysics, Abaqus],
    [Optika],
    [Obyektiv, yoritish va optik datchiklarning nurlar yoʻli],
    [Zemax OpticStudio va oʻxshash dasturlar],
    [Elektronika (EDA)],
    [Oʻlchash sxemasi, kuchaytirgich, filtr, ARO ulanishi, bosma plata],
    [Altium Designer, KiCad, Cadence OrCAD; SPICE simulyatorlari (LTspice)],
    [Tizim darajasida modellashtirish],
    [Datchik dinamikasi, shovqin, filtrlar, butun oʻlchash kanali va boshqaruv konturi],
    [MATLAB/Simulink, Simscape, Modelica (OpenModelica), LabVIEW],
    [Dasturiy taʼminot],
    [Mikrodastur, ishlov berish algoritmlari, avtomatik kod generatsiyasi],
    [Ishlab chiqish muhitlari (IDE), Embedded Coder, Git],
    [Maʼlumotlarni boshqarish (PDM/PLM)],
    [Hujjatlar, versiyalar, konfiguratsiyalar, oʻzgarishlar],
    [Teamcenter, Windchill, 3DEXPERIENCE],
  ),
  caption: [Informatsion qurilmalarni loyihalashda qoʻllanadigan ALT lar],
) <tab-alt>

Jadvalda keltirilgan dasturlar misol sifatida berilgan; amaliyotda tanlov tashkilotda mavjud litsenziyalar, vazifa murakkabligi va boshqa ALT lar bilan moslikka bogʻliq. Oʻquv maqsadlarida bepul va ochiq dasturlar (FreeCAD, KiCad, LTspice, OpenModelica) ham toʻliq loyihalash siklini oʻtash imkonini beradi.

// =====================================================================
= Chekli elementlar usuli asoslari
// =====================================================================

Sezgir elementlar va korpuslarni mustahkamlik, deformatsiya, issiqlik va elektromagnit maydonlarga hisoblashda CAE tizimlarining asosiy matematik usuli — *chekli elementlar usuli* (ChEU). Unda murakkab shakldagi jism koʻplab oddiy kichik elementlarga (tetraedrlar, oltiyoqlilar) — *torga* (_mesh_) — boʻlinadi. Har bir element ichida nomaʼlum kattalik (masalan, koʻchish) oddiy funksiya bilan approksimatsiya qilinadi va butun jism uchun chiziqli algebraik tenglamalar tizimi tuziladi. Statik mexanik masala uchun u quyidagi koʻrinishga ega:

#eq($ bold(K) dot bold(u) = bold(F), $)

bu yerda $bold(K)$ — tizimning bikrlik matritsasi, $bold(u)$ — tugunlar koʻchishlari vektori, $bold(F)$ — tugunlarga qoʻyilgan kuchlar vektori. Tenglamalar yechilgach, koʻchishlardan deformatsiyalar va kuchlanishlar hisoblanadi.

ChEU bilan ishlashda quyidagi qoidalarga amal qilinadi:
- materiallar xossalari, mahkamlash shartlari va yuklamalar real sharoitga mos berilishi kerak — notoʻgʻri chegaraviy shartlar notoʻgʻri natija beradi;
- tor kuchlanishlar keskin oʻzgaradigan joylarda (teshiklar, burchaklar, tenzorezistor yopishtiriladigan joy) maydalashtiriladi;
- natijaning tor oʻlchamiga bogʻliq emasligi tekshiriladi (torni maydalashtirganda natija deyarli oʻzgarmasligi kerak);
- hisoblash natijalari oddiy analitik baho va keyinchalik tajriba bilan solishtiriladi.

// =====================================================================
= Loyihalash misoli: tenzometrik kuch datchigi
// =====================================================================

ALT ning birgalikda qoʻllanishini robot tutqichi uchun tenzometrik kuch datchigini loyihalash misolida koʻramiz.

*1. Talablar.* Oʻlchash diapazoni 0…100 N, keltirilgan xatolik 0,5 % dan oshmasin, ish harorati 0…50 °C, raqamli interfeys, oʻlchamlari tutqichga sigʻsin.

*2. Konsepsiya va analitik baho.* Sezgir element sifatida bir uchi mahkamlangan alyuminiy balka tanlanadi, uning ustki va pastki sirtlariga toʻrtta tenzorezistor yopishtirilib, toʻliq koʻprik hosil qilinadi. Balka mahkamlangan joyidagi sirt deformatsiyasi:

#eq($ epsilon = (6 F L) / (E b h^2), $)

bu yerda $L$ — kuch qoʻyilgan nuqtagacha masofa, $E$ — elastiklik moduli, $b$ va $h$ — kesim eni va balandligi. $F = 100$ N, $L = 40$ mm, $E = 70$ GPa, $b = 20$ mm, $h = 5$ mm uchun $epsilon = 6 dot 100 dot 0","04 slash (70 dot 10^9 dot 0","02 dot 0","005^2) approx 6","9 dot 10^(-4)$. Toʻrt faol tenzorezistorli koʻprikning chiqish kuchlanishi:

#eq($ U_"chiq" = k dot epsilon dot U_t, $)

$k = 2$ va taʼminot $U_t = 5$ V boʻlganda $U_"chiq" approx 6","9$ mV. Balkadagi eng katta kuchlanish va mustahkamlik zaxirasi:

#eq($ sigma = E dot epsilon approx 48 "MPa", quad n = sigma_T / sigma, $)

oquvchanlik chegarasi $sigma_T approx 275$ MPa boʻlgan alyuminiy qotishmasi uchun $n approx 5","7$ — yetarli zaxira.

*3. CAD va CAE.* Balka, mahkamlash va korpusning 3D modeli CAD da quriladi va CAE ga uzatiladi. ChEU tahlili analitik bahoni aniqlashtiradi: haqiqiy mahkamlashda deformatsiya taqsimoti, tenzorezistorlar uchun eng qulay joy, kuchlanish konsentratsiyasi, boshqa yoʻnalishdagi kuchlarning taʼsiri va xususiy chastota (datchik tezkorligi uchun) aniqlanadi. Natijaga koʻra balka oʻlchamlari oʻzgartiriladi va hisob takrorlanadi — parametrik modellashtirish buni bir necha daqiqada bajarish imkonini beradi.

*4. Elektronika (EDA).* Koʻprik, instrumental kuchaytirgich, filtr, ARO va mikrokontrollerdan iborat sxema chiziladi va SPICE da modellashtiriladi: kuchaytirish koeffitsienti (6,9 mV ni ARO diapazoniga moslash), filtrning kesish chastotasi va shovqin tekshiriladi. Soʻngra bosma plata loyihalanadi va uning 3D modeli korpus bilan moslik uchun CAD ga qaytariladi.

*5. Tizim modeli.* Simulink yoki Modelica da butun kanal — balka dinamikasi, koʻprik, kuchaytirgich shovqini, kvantlash va raqamli filtr — modellashtirilib, umumiy xatolik va javob vaqti talablarga mosligi baholanadi (9-maʼruza).

*6. Prototip va sinov.* Prototip yasaladi, kalibrlanadi va metrologik tavsiflari (chiziqlilik, gisterezis, harorat drifti) oʻlchanadi. Natijalar modellar bilan solishtiriladi va kerak boʻlsa modellar aniqlashtiriladi — bu V-modelning oʻng tarmogʻi.

// =====================================================================
= ALT lar orasida maʼlumot almashish
// =====================================================================

Informatsion qurilmani loyihalashda bir necha ALT qoʻllangani uchun ular orasida maʼlumot almashish muhim masala hisoblanadi. Buning uchun standart formatlar qoʻllanadi (3-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Format yoki standart], [Vazifasi]),
    [STEP (ISO 10303), IGES],
    [3D geometrik modellarni turli CAD va CAE tizimlari orasida uzatish],
    [STL, 3MF],
    [Modelni 3D bosib chiqarishga uzatish (prototiplash)],
    [IDF, IDX],
    [Elektron (ECAD) va mexanik (MCAD) loyihalash tizimlari orasida plata va korpus maʼlumotlarini almashish],
    [Gerber, ODB++],
    [Bosma platani ishlab chiqarishga uzatish],
    [FMI (FMU)],
    [Turli modellashtirish dasturlarida yaratilgan dinamik modellarni almashish va birgalikda simulyatsiya qilish (ko-simulyatsiya)],
    [URDF, SDF],
    [Robot va uning datchiklari modellarini robot simulyatorlari va ROS 2 ga uzatish],
  ),
  caption: [ALT lar orasida maʼlumot almashish formatlari],
) <tab-format>

Turli ALT lardagi modellar va hujjatlar yagona PDM tizimida saqlanadi. U har bir hujjatning versiyasini, qaysi qism qaysi modelga bogʻliqligini va kim tomonidan oʻzgartirilganini kuzatadi. Masalan, korpus oʻlchami oʻzgartirilsa, PDM bu oʻzgarish plata, CAE modeli va chizmalarga taʼsir qilishini koʻrsatadi.

// =====================================================================
= ALT larning xususiyatlari va rivojlanish tendensiyalari
// =====================================================================

Zamonaviy ALT larning asosiy xususiyatlari:
- *parametrik modellashtirish* — model oʻlchamlari parametrlar va ular orasidagi bogʻliqliklar bilan beriladi; bitta parametr oʻzgarsa, butun model va chizmalar avtomatik yangilanadi;
- *assotsiativlik* — 3D model, chizma, CAE modeli va spetsifikatsiya oʻzaro bogʻlangan;
- *koʻp fizikali tahlil* — mexanik, issiqlik, elektr va magnit maydonlarning oʻzaro taʼsirini birgalikda hisoblash (masalan, sigʻim datchigida elektrostatik kuch va deformatsiya);
- *komponentlar kutubxonalari* — standart detallar, elektron komponentlar va tayyor datchik modellari;
- *optimallash* — berilgan cheklovlar ostida sezgirlikni maksimal, massani minimal qiladigan oʻlchamlarni avtomatik izlash;
- *hujjatlarni avtomatik tayyorlash* — chizmalar, spetsifikatsiyalar, ishlab chiqarish fayllari.

Rivojlanish tendensiyalari:
- *raqamli egizak* — real qurilmaning datchiklardan olingan maʼlumotlar bilan doimiy yangilanib turuvchi virtual modeli; u ekspluatatsiyada holatni kuzatish va keyingi avlod qurilmalarini loyihalashda qoʻllanadi;
- *generativ dizayn va topologik optimallash* — sunʼiy intellekt va optimallash algoritmlari berilgan talablar asosida konstruksiya variantlarini avtomatik yaratadi; additiv texnologiyalar (3D bosib chiqarish) bunday murakkab shakllarni yasash imkonini beradi;
- *bulutli ALT* — hisoblash resurslari va loyiha maʼlumotlari bulutda joylashadi, bu jamoaviy ishlashni va katta hisoblarni osonlashtiradi;
- *modelga asoslangan tizimlar muhandisligi* (MBSE) — talablar, tuzilma va xatti-harakatni yagona tizim modelida (masalan, SysML tilida) tavsiflash.

ALT larni qoʻllashdagi muammolar ham mavjud: litsenziyalarning yuqori narxi, malakali mutaxassislarga ehtiyoj, turli tizimlar orasida maʼlumot almashishda yoʻqotishlar, eng muhimi — model *adekvatligi*: modellashtirish natijasi faqat model va kiritilgan maʼlumotlar qanchalik toʻgʻri boʻlsa, shunchalik ishonchli. Shuning uchun modellar albatta tajriba natijalari bilan tekshiriladi.

// =====================================================================
= Xulosa
// =====================================================================

Avtomatlashgan loyihalash tizimlari informatsion qurilmalarni loyihalash muddatini qisqartiradi, xatolarni erta aniqlash va variantlarni tez solishtirish imkonini beradi. Mexatron qurilmalar V-model asosida loyihalanadi: talablardan tizim va sohalar boʻyicha loyihaga, soʻngra integratsiya va tasdiqlashga qarab. ALT texnik, matematik, dasturiy, informatsion, lingvistik, metodik va tashkiliy taʼminotdan iborat.

Informatsion qurilmani loyihalashda CAD (konstruksiya), CAE (chekli elementlar usuli asosida fizik maydonlar tahlili), EDA (sxema va plata), tizim darajasidagi modellashtirish va PDM birgalikda qoʻllanadi; ular orasida STEP, IDF/IDX, Gerber, FMI, URDF kabi standart formatlar orqali maʼlumot almashiladi. Tenzometrik kuch datchigi misoli analitik baho, ChEU tahlili, sxemani modellashtirish, tizim modeli va prototip sinovining oʻzaro bogʻliqligini koʻrsatadi. Raqamli egizak, generativ dizayn va bulutli ALT lar sohaning asosiy rivojlanish yoʻnalishlaridir.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Avtomatlashgan loyihalash tizimi nima? CAD, CAE, CAM, EDA va PDM qanday farqlanadi?
  + Mexatron qurilmalarni loyihalashning V-modelini tushuntiring.
  + Verifikatsiya va validatsiya qanday farqlanadi?
  + ALT ning taʼminot turlarini sanab bering va ularning mazmunini tushuntiring.
  + Informatsion qurilmaning qaysi qismlari qaysi ALT da loyihalanadi?
  + Chekli elementlar usulining mohiyati nimada?
  + ChEU natijalarining ishonchliligi qanday tekshiriladi?
  + Bir uchi mahkamlangan balka uchun $F = 50$ N, $L = 30$ mm, $E = 70$ GPa, $b = 15$ mm, $h = 4$ mm boʻlsa, sirt deformatsiyasini toping.
  + Toʻliq tenzokoʻprikda $k = 2$, $epsilon = 5 dot 10^(-4)$, $U_t = 10$ V boʻlsa, chiqish kuchlanishi qancha?
  + ALT lar orasida maʼlumot almashishda qanday standart formatlar qoʻllanadi?
  + Parametrik modellashtirish va assotsiativlik qanday afzallik beradi?
  + Raqamli egizak nima va u informatsion qurilmalar bilan qanday bogʻliq?
  + Model adekvatligi nima va nima uchun u muhim?
]
