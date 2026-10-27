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
  title: "Maʼruza №11. Mexatron modullar va robotlarning informatsion qurilmalarini avtomatlaşgan loyihalaş tizimlarining tuzilişi va xususiyatlari",
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
  )[Mavzu: Mexatron modullar va robotlarning informatsion qurilmalarini avtomatlaşgan loyihalaş tizimlarining tuzilişi va xususiyatlari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Avtomatlaşgan loyihalaş tizimi tuşunçasi. CAD, CAE, CAM, PDM va PLM.
  + Mexatron qurilmalarni loyihalaş bosqiçlari. V-model.
  + Avtomatlaşgan loyihalaş tizimining tuzilişi va taʼminot turlari.
  + Informatsion qurilmalarni loyihalaşda qöllanadigan ALT lar.
  + Çekli elementlar usuli asoslari.
  + Loyihalaş misoli: tenzometrik kuç datçigi.
  + ALT lar orasida maʼlumot almaşiş. ALT larning xususiyatlari va rivojlaniş tendensiyalari.

  *Tayanç iboralar:* avtomatlaşgan loyihalaş tizimi (ALT), CAD, CAE, CAM, EDA, PDM, PLM, V-model, verifikatsiya, validatsiya, texnik, matematik, dasturiy, informatsion taʼminot, parametrik modellaştiriş, çekli elementlar usuli, bikrlik matritsasi, tor (mesh), SPICE, bosma plata, ko-simulyatsiya, STEP, FMI, raqamli egizak.
]

// =====================================================================
= Avtomatlaşgan loyihalaş tizimi tuşunçasi
// =====================================================================

Informatsion qurilma — datçik, kamera moduli yoki intellektual datçik — bir vaqtning özida mexanik konstruksiya, fizik özgartirgiç, elektron sxema va dasturiy taʼminotdan iborat. Bunday qurilmani faqat qoğozda hisoblaş va tajriba namunalarini köp marta yasaş orqali loyihalaş uzoq va qimmat. Şuning uçun zamonaviy loyihalaş kompyuter yordamida, *avtomatlaşgan loyihalaş tizimlari* (ALT) vositasida bajariladi.

*Avtomatlaşgan loyihalaş tizimi* — loyihalaş jarayonini avtomatlaştiruvçi, loyihalovçilar va kompyuter vositalarining özaro taʼsirida işlaydigan taşkiliy-texnik tizim. U loyihalovçini almaştirmaydi, balki köp mehnat talab qiladigan hisoblaş, çiziş, modellaştiriş va hujjatlaştiriş işlarini bajarib, unga variantlarni tez soliştiriş va asosli qaror qabul qiliş imkonini beradi.

Xalqaro amaliyotda ALT turlari quyidagi qisqartmalar bilan ataladi:
- *CAD* (_Computer-Aided Design_) — geometrik modellaştiriş va çizmalar tayyorlaş;
- *CAE* (_Computer-Aided Engineering_) — muhandislik tahlili: mustahkamlik, tebranişlar, issiqlik, elektromagnit maydonlar, oqimlar;
- *CAM* (_Computer-Aided Manufacturing_) — işlab çiqarişni tayyorlaş, raqamli dasturiy boşqariladigan dastgohlar uçun dasturlar;
- *EDA* (_Electronic Design Automation_) — elektron sxemalar va bosma platalarni loyihalaş;
- *PDM / PLM* (_Product Data / Lifecycle Management_) — mahsulot haqidagi barça maʼlumotlar va uning hayotiy siklini boşqariş.

ALT qöllanişi loyihalaş muddatini va tajriba namunalari sonini qisqartiradi, xatolarni erta bosqiçlarda — mahsulot hali yasalmasdan aniqlaş imkonini beradi, loyiha sifatini oşiradi va hujjatlarni tartibli saqlaşni taʼminlaydi.

// =====================================================================
= Mexatron qurilmalarni loyihalaş bosqiçlari. V-model
// =====================================================================

Anʼanaviy loyihalaşda mexanika, elektronika va dastur ketma-ket işlab çiqilgan. Mexatron qurilmalarda esa bu sohalar bir-biri bilan çambarças boğliq, şuning uçun ular parallel va kelişilgan holda loyihalanadi. Mexatron tizimlarni loyihalaş metodikasi sifatida keng tarqalgan *V-model* (Germaniya muhandislar uyuşmasining VDI 2206 tavsiyasi) 1-rasmda körsatilgan.

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
    node((2, 2), [Sohalar böyiça \ loyihalaş], name: <sl>),
    node((3, 1), [Tizim \ integratsiyasi], name: <ti>),
    node((4, 0), [Tasdiqlaş, \ mahsulot], fill: lightorange, name: <xt>),
    edge(<t>, <tl>, "->"),
    edge(<tl>, <sl>, "->"),
    edge(<sl>, <ti>, "->"),
    edge(<ti>, <xt>, "->"),
    edge(<t>, <xt>, "<->", stroke: (dash: "dashed", thickness: 1pt), [verifikatsiya, validatsiya], label-side: left),
    edge(<tl>, <ti>, "<->", stroke: (dash: "dashed", thickness: 1pt)),
  ),
  caption: [Mexatron tizimlarni loyihalaşning V-modeli],
) <fig-v>

V-modelning çap tarmoğida loyiha yuqoridan pastga — talablardan tizim konsepsiyasiga, söngra alohida sohalar (mexanika, elektronika, dasturiy taʼminot) böyiça batafsil loyihaga qarab aniqlaştiriladi. Öng tarmoğida esa alohida qismlar birlaştiriladi va har bir sathda çap tarmoqdagi mos talablarga muvofiqligi tekşiriladi: *verifikatsiya* — qurilma loyihada belgilanganidek töğri yasalganini tekşiriş, *validatsiya* — qurilma haqiqatan foydalanuvçi talablarini qondirişini tasdiqlaş. Barça bosqiçlarda modellaştiriş va model tahlili parallel olib boriladi. Murakkab qurilmalarda V-model bir neça marta takrorlanadi: har bir sikl natijasida tobora mukammalroq namuna (laboratoriya maketi, tajriba namunasi, seriyaga tayyor namuna) olinadi.

Informatsion qurilmalar uçun bosqiçlar mazmuni quyidagiça:
+ *talablar* — ölçanadigan kattalik, diapazon, aniqlik, tezkorlik, iş şaroiti, ölçam, interfeys, narx;
+ *tizim loyihasi* — fizik prinsipni tanlaş, struktura sxemasini tuziş, xatolik «byudjetini» elementlar örtasida taqsimlaş (9-maʼruza);
+ *sohalar böyiça loyihalaş* — sezgir element va korpus konstruksiyasi (CAD, CAE), elektron sxema va plata (EDA), mikrodastur va işlov beriş algoritmlari;
+ *integratsiya va tasdiqlaş* — prototipni yiğiş, kalibrlaş, metrologik tavsiflarini va iş şaroitiga çidamliligini sinaş.

// =====================================================================
= Avtomatlaşgan loyihalaş tizimining tuzilişi
// =====================================================================

ALT ni taşkil etuvçi qismlar *taʼminot turlari* böyiça tasniflanadi (1-jadval).

#figure(
  btable(
    columns: (auto, 1.6fr),
    header: ([Taʼminot turi], [Mazmuni]),
    [Texnik],
    [Kompyuterlar, işçi stansiyalar, serverlar, tarmoq, kiritiş-çiqariş qurilmalari (3D skanerlar, printerlar, plotterlar)],
    [Matematik],
    [Loyihalanayotgan obyekt modellari, hisoblaş usullari va algoritmlar (çekli elementlar usuli, optimallaş, simulyatsiya)],
    [Dasturiy],
    [Operatsion tizimlar va amaliy ALT dasturlari (CAD, CAE, EDA, PDM)],
    [Informatsion],
    [Maʼlumotlar bazalari: standart detallar, materiallar xossalari, elektron komponentlar, datçik modellari kutubxonalari],
    [Lingvistik],
    [Loyihalovçi va tizim muloqoti tillari, maʼlumot almaşiş formatlari, skript va dasturlaş tillari],
    [Metodik],
    [Loyihalaş metodikalari, standartlar, yöriqnomalar],
    [Taşkiliy],
    [Loyihalaş bölinmalarining tuzilişi, vazifalar taqsimoti, hujjat aylanişi qoidalari],
  ),
  caption: [ALT taʼminot turlari],
) <tab-taminot>

Dasturiy nuqtai nazardan zamonaviy ALT quyidagi asosiy modullardan iborat: foydalanuvçi interfeysi, geometrik yadro (3D modellarni quriş va özgartiriş), hisoblaş va tahlil modullari (solverlar), vizualizatsiya, komponentlar kutubxonalari va maʼlumotlarni boşqariş moduli. Turli ALT lar yagona maʼlumotlar muhiti (PDM) orqali boğlanadi.

// =====================================================================
= Informatsion qurilmalarni loyihalaşda qöllanadigan ALT lar
// =====================================================================

Informatsion qurilma bir neçta fizik sohani qamrab olgani uçun uni loyihalaşda turli ALT lar birgalikda qöllanadi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.4fr, 1.2fr),
    header: ([Soha], [Loyihalaş vazifalari], [Dasturiy vositalarga misollar]),
    [Mexanik konstruksiya (CAD)],
    [Sezgir element, korpus, mahkamlaş elementlari, kodli disk 3D modeli va çizmalari],
    [SolidWorks, Siemens NX, CATIA, Autodesk Inventor va Fusion, KOMPAS-3D, FreeCAD],
    [Fizik maydonlar tahlili (CAE)],
    [Elastik element deformatsiyasi, xususiy çastotalar, issiqlik, elektrostatik va magnit maydonlar, MEMS tuzilmalari],
    [ANSYS, COMSOL Multiphysics, Abaqus],
    [Optika],
    [Obyektiv, yoritiş va optik datçiklarning nurlar yöli],
    [Zemax OpticStudio va öxşaş dasturlar],
    [Elektronika (EDA)],
    [Ölçaş sxemasi, kuçaytirgiç, filtr, ARO ulanişi, bosma plata],
    [Altium Designer, KiCad, Cadence OrCAD; SPICE simulyatorlari (LTspice)],
    [Tizim darajasida modellaştiriş],
    [Datçik dinamikasi, şovqin, filtrlar, butun ölçaş kanali va boşqaruv konturi],
    [MATLAB/Simulink, Simscape, Modelica (OpenModelica), LabVIEW],
    [Dasturiy taʼminot],
    [Mikrodastur, işlov beriş algoritmlari, avtomatik kod generatsiyasi],
    [Işlab çiqiş muhitlari (IDE), Embedded Coder, Git],
    [Maʼlumotlarni boşqariş (PDM/PLM)],
    [Hujjatlar, versiyalar, konfiguratsiyalar, özgarişlar],
    [Teamcenter, Windchill, 3DEXPERIENCE],
  ),
  caption: [Informatsion qurilmalarni loyihalaşda qöllanadigan ALT lar],
) <tab-alt>

Jadvalda keltirilgan dasturlar misol sifatida berilgan; amaliyotda tanlov taşkilotda mavjud litsenziyalar, vazifa murakkabligi va boşqa ALT lar bilan moslikka boğliq. Öquv maqsadlarida bepul va oçiq dasturlar (FreeCAD, KiCad, LTspice, OpenModelica) ham töliq loyihalaş siklini ötaş imkonini beradi.

// =====================================================================
= Çekli elementlar usuli asoslari
// =====================================================================

Sezgir elementlar va korpuslarni mustahkamlik, deformatsiya, issiqlik va elektromagnit maydonlarga hisoblaşda CAE tizimlarining asosiy matematik usuli — *çekli elementlar usuli* (ÇEU). Unda murakkab şakldagi jism köplab oddiy kiçik elementlarga (tetraedrlar, oltiyoqlilar) — *torga* (_mesh_) — bölinadi. Har bir element içida nomaʼlum kattalik (masalan, köçiş) oddiy funksiya bilan approksimatsiya qilinadi va butun jism uçun çiziqli algebraik tenglamalar tizimi tuziladi. Statik mexanik masala uçun u quyidagi körinişga ega:

#eq($ bold(K) dot bold(u) = bold(F), $)

bu yerda $bold(K)$ — tizimning bikrlik matritsasi, $bold(u)$ — tugunlar köçişlari vektori, $bold(F)$ — tugunlarga qöyilgan kuçlar vektori. Tenglamalar yeçilgaç, köçişlardan deformatsiyalar va kuçlanişlar hisoblanadi.

ÇEU bilan işlaşda quyidagi qoidalarga amal qilinadi:
- materiallar xossalari, mahkamlaş şartlari va yuklamalar real şaroitga mos berilişi kerak — notöğri çegaraviy şartlar notöğri natija beradi;
- tor kuçlanişlar keskin özgaradigan joylarda (teşiklar, burçaklar, tenzorezistor yopiştiriladigan joy) maydalaştiriladi;
- natijaning tor ölçamiga boğliq emasligi tekşiriladi (torni maydalaştirganda natija deyarli özgarmasligi kerak);
- hisoblaş natijalari oddiy analitik baho va keyinçalik tajriba bilan soliştiriladi.

// =====================================================================
= Loyihalaş misoli: tenzometrik kuç datçigi
// =====================================================================

ALT ning birgalikda qöllanişini robot tutqiçi uçun tenzometrik kuç datçigini loyihalaş misolida köramiz.

*1. Talablar.* Ölçaş diapazoni 0…100 N, keltirilgan xatolik 0,5 % dan oşmasin, iş harorati 0…50 °C, raqamli interfeys, ölçamlari tutqiçga siğsin.

*2. Konsepsiya va analitik baho.* Sezgir element sifatida bir uçi mahkamlangan alyuminiy balka tanlanadi, uning ustki va pastki sirtlariga törtta tenzorezistor yopiştirilib, töliq köprik hosil qilinadi. Balka mahkamlangan joyidagi sirt deformatsiyasi:

#eq($ epsilon = (6 F L) / (E b h^2), $)

bu yerda $L$ — kuç qöyilgan nuqtagaça masofa, $E$ — elastiklik moduli, $b$ va $h$ — kesim eni va balandligi. $F = 100$ N, $L = 40$ mm, $E = 70$ GPa, $b = 20$ mm, $h = 5$ mm uçun $epsilon = 6 dot 100 dot 0","04 slash (70 dot 10^9 dot 0","02 dot 0","005^2) approx 6","9 dot 10^(-4)$. Tört faol tenzorezistorli köprikning çiqiş kuçlanişi:

#eq($ U_"çiq" = k dot epsilon dot U_t, $)

$k = 2$ va taʼminot $U_t = 5$ V bölganda $U_"çiq" approx 6","9$ mV. Balkadagi eng katta kuçlaniş va mustahkamlik zaxirasi:

#eq($ sigma = E dot epsilon approx 48 "MPa", quad n = sigma_T / sigma, $)

oquvçanlik çegarasi $sigma_T approx 275$ MPa bölgan alyuminiy qotişmasi uçun $n approx 5","7$ — yetarli zaxira.

*3. CAD va CAE.* Balka, mahkamlaş va korpusning 3D modeli CAD da quriladi va CAE ga uzatiladi. ÇEU tahlili analitik bahoni aniqlaştiradi: haqiqiy mahkamlaşda deformatsiya taqsimoti, tenzorezistorlar uçun eng qulay joy, kuçlaniş konsentratsiyasi, boşqa yönalişdagi kuçlarning taʼsiri va xususiy çastota (datçik tezkorligi uçun) aniqlanadi. Natijaga köra balka ölçamlari özgartiriladi va hisob takrorlanadi — parametrik modellaştiriş buni bir neça daqiqada bajariş imkonini beradi.

*4. Elektronika (EDA).* Köprik, instrumental kuçaytirgiç, filtr, ARO va mikrokontrollerdan iborat sxema çiziladi va SPICE da modellaştiriladi: kuçaytiriş koeffitsienti (6,9 mV ni ARO diapazoniga moslaş), filtrning kesiş çastotasi va şovqin tekşiriladi. Söngra bosma plata loyihalanadi va uning 3D modeli korpus bilan moslik uçun CAD ga qaytariladi.

*5. Tizim modeli.* Simulink yoki Modelica da butun kanal — balka dinamikasi, köprik, kuçaytirgiç şovqini, kvantlaş va raqamli filtr — modellaştirilib, umumiy xatolik va javob vaqti talablarga mosligi baholanadi (9-maʼruza).

*6. Prototip va sinov.* Prototip yasaladi, kalibrlanadi va metrologik tavsiflari (çiziqlilik, gisterezis, harorat drifti) ölçanadi. Natijalar modellar bilan soliştiriladi va kerak bölsa modellar aniqlaştiriladi — bu V-modelning öng tarmoği.

// =====================================================================
= ALT lar orasida maʼlumot almaşiş
// =====================================================================

Informatsion qurilmani loyihalaşda bir neça ALT qöllangani uçun ular orasida maʼlumot almaşiş muhim masala hisoblanadi. Buning uçun standart formatlar qöllanadi (3-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Format yoki standart], [Vazifasi]),
    [STEP (ISO 10303), IGES],
    [3D geometrik modellarni turli CAD va CAE tizimlari orasida uzatiş],
    [STL, 3MF],
    [Modelni 3D bosib çiqarişga uzatiş (prototiplaş)],
    [IDF, IDX],
    [Elektron (ECAD) va mexanik (MCAD) loyihalaş tizimlari orasida plata va korpus maʼlumotlarini almaşiş],
    [Gerber, ODB++],
    [Bosma platani işlab çiqarişga uzatiş],
    [FMI (FMU)],
    [Turli modellaştiriş dasturlarida yaratilgan dinamik modellarni almaşiş va birgalikda simulyatsiya qiliş (ko-simulyatsiya)],
    [URDF, SDF],
    [Robot va uning datçiklari modellarini robot simulyatorlari va ROS 2 ga uzatiş],
  ),
  caption: [ALT lar orasida maʼlumot almaşiş formatlari],
) <tab-format>

Turli ALT lardagi modellar va hujjatlar yagona PDM tizimida saqlanadi. U har bir hujjatning versiyasini, qaysi qism qaysi modelga boğliqligini va kim tomonidan özgartirilganini kuzatadi. Masalan, korpus ölçami özgartirilsa, PDM bu özgariş plata, CAE modeli va çizmalarga taʼsir qilişini körsatadi.

// =====================================================================
= ALT larning xususiyatlari va rivojlaniş tendensiyalari
// =====================================================================

Zamonaviy ALT larning asosiy xususiyatlari:
- *parametrik modellaştiriş* — model ölçamlari parametrlar va ular orasidagi boğliqliklar bilan beriladi; bitta parametr özgarsa, butun model va çizmalar avtomatik yangilanadi;
- *assotsiativlik* — 3D model, çizma, CAE modeli va spetsifikatsiya özaro boğlangan;
- *köp fizikali tahlil* — mexanik, issiqlik, elektr va magnit maydonlarning özaro taʼsirini birgalikda hisoblaş (masalan, siğim datçigida elektrostatik kuç va deformatsiya);
- *komponentlar kutubxonalari* — standart detallar, elektron komponentlar va tayyor datçik modellari;
- *optimallaş* — berilgan çeklovlar ostida sezgirlikni maksimal, massani minimal qiladigan ölçamlarni avtomatik izlaş;
- *hujjatlarni avtomatik tayyorlaş* — çizmalar, spetsifikatsiyalar, işlab çiqariş fayllari.

Rivojlaniş tendensiyalari:
- *raqamli egizak* — real qurilmaning datçiklardan olingan maʼlumotlar bilan doimiy yangilanib turuvçi virtual modeli; u ekspluatatsiyada holatni kuzatiş va keyingi avlod qurilmalarini loyihalaşda qöllanadi;
- *generativ dizayn va topologik optimallaş* — sunʼiy intellekt va optimallaş algoritmlari berilgan talablar asosida konstruksiya variantlarini avtomatik yaratadi; additiv texnologiyalar (3D bosib çiqariş) bunday murakkab şakllarni yasaş imkonini beradi;
- *bulutli ALT* — hisoblaş resurslari va loyiha maʼlumotlari bulutda joylaşadi, bu jamoaviy işlaşni va katta hisoblarni osonlaştiradi;
- *modelga asoslangan tizimlar muhandisligi* (MBSE) — talablar, tuzilma va xatti-harakatni yagona tizim modelida (masalan, SysML tilida) tavsiflaş.

ALT larni qöllaşdagi muammolar ham mavjud: litsenziyalarning yuqori narxi, malakali mutaxassislarga ehtiyoj, turli tizimlar orasida maʼlumot almaşişda yöqotişlar, eng muhimi — model *adekvatligi*: modellaştiriş natijasi faqat model va kiritilgan maʼlumotlar qançalik töğri bölsa, şunçalik işonçli. Şuning uçun modellar albatta tajriba natijalari bilan tekşiriladi.

// =====================================================================
= Xulosa
// =====================================================================

Avtomatlaşgan loyihalaş tizimlari informatsion qurilmalarni loyihalaş muddatini qisqartiradi, xatolarni erta aniqlaş va variantlarni tez soliştiriş imkonini beradi. Mexatron qurilmalar V-model asosida loyihalanadi: talablardan tizim va sohalar böyiça loyihaga, söngra integratsiya va tasdiqlaşga qarab. ALT texnik, matematik, dasturiy, informatsion, lingvistik, metodik va taşkiliy taʼminotdan iborat.

Informatsion qurilmani loyihalaşda CAD (konstruksiya), CAE (çekli elementlar usuli asosida fizik maydonlar tahlili), EDA (sxema va plata), tizim darajasidagi modellaştiriş va PDM birgalikda qöllanadi; ular orasida STEP, IDF/IDX, Gerber, FMI, URDF kabi standart formatlar orqali maʼlumot almaşiladi. Tenzometrik kuç datçigi misoli analitik baho, ÇEU tahlili, sxemani modellaştiriş, tizim modeli va prototip sinovining özaro boğliqligini körsatadi. Raqamli egizak, generativ dizayn va bulutli ALT lar sohaning asosiy rivojlaniş yönalişlaridir.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Avtomatlaşgan loyihalaş tizimi nima? CAD, CAE, CAM, EDA va PDM qanday farqlanadi?
  + Mexatron qurilmalarni loyihalaşning V-modelini tuşuntiring.
  + Verifikatsiya va validatsiya qanday farqlanadi?
  + ALT ning taʼminot turlarini sanab bering va ularning mazmunini tuşuntiring.
  + Informatsion qurilmaning qaysi qismlari qaysi ALT da loyihalanadi?
  + Çekli elementlar usulining mohiyati nimada?
  + ÇEU natijalarining işonçliligi qanday tekşiriladi?
  + Bir uçi mahkamlangan balka uçun $F = 50$ N, $L = 30$ mm, $E = 70$ GPa, $b = 15$ mm, $h = 4$ mm bölsa, sirt deformatsiyasini toping.
  + Töliq tenzoköprikda $k = 2$, $epsilon = 5 dot 10^(-4)$, $U_t = 10$ V bölsa, çiqiş kuçlanişi qança?
  + ALT lar orasida maʼlumot almaşişda qanday standart formatlar qöllanadi?
  + Parametrik modellaştiriş va assotsiativlik qanday afzallik beradi?
  + Raqamli egizak nima va u informatsion qurilmalar bilan qanday boğliq?
  + Model adekvatligi nima va nima uçun u muhim?
]
