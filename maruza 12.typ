// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №12. Radiotexnika, taʼlim, tibbiyot, harbiy va boshqa sohalarda
//              qoʻllaniladigan robotlarning informatsion qurilmalari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №12. Radiotexnika tizimlarida, taʼlim tizimlarida, tibbiyot va diagnostika tizimlarida, harbiy va boşqa turli maqsadlarda qöllaniladigan mexatron modullar va robotlarning informatsion qurilmalari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 12  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №12]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Radiotexnika, taʼlim, tibbiyot va diagnostika, harbiy va boşqa \ sohalarda qöllaniladigan mexatron modullar va robotlarning \ informatsion qurilmalari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Qöllaniş sohasining informatsion qurilmalarga qöyadigan talablari.
  + Radiotexnika tizimlarida informatsion qurilmalar.
  + Taʼlim tizimlarida mexatron modullar va robotlar.
  + Tibbiyot va diagnostika tizimlarida informatsion qurilmalar.
  + Harbiy, xavfsizlik va qutqaruv sohalaridagi robotlarning informatsion qurilmalari.
  + Boşqa sohalar: qişloq xöjaligi, kosmik, suv osti, yadro energetikasi, logistika.

  *Tayanç iboralar:* antenna pozitsioneri, radiolokator, FMCW radar, Doppler effekti, RFID, UWB, GNSS RTK, taʼlim robotlari, çiziq datçiklari, jarrohlik roboti, teleoperatsiya, harakatni masştablaş, titraşni filtrlaş, kuç qayta aloqasi, optik tolali datçik, Bregg panjarasi, reabilitatsiya, ekzoskelet, EMG, inersial navigatsiya, drift, termal kamera, yer osti radari, NDVI, gidrolokator, radiatsiyaga çidamlilik.
]

// =====================================================================
= Qöllaniş sohasining informatsion qurilmalarga qöyadigan talablari
// =====================================================================

Oldingi maʼruzalarda informatsion qurilmalarning işlaş prinsiplari, tavsiflari va dasturiy taʼminoti umumiy holda körib çiqildi. Amaliyotda esa robot va uning datçiklari qayerda işlatilişiga qarab ularga juda turli talablar qöyiladi. Bir xil vazifani — masalan, masofani ölçaşni — zavod sexida, operatsiya xonasida, suv ostida yoki kosmosda bajariş butunlay boşqa yeçimlarni talab qiladi.

Qöllaniş sohasiga boğliq asosiy talablar:
- *muhit şaroiti* — harorat, namlik, çang, vibratsiya va zarba, bosim, radiatsiya, elektromagnit maydonlar;
- *xavfsizlik* — inson bilan bevosita işlaş (tibbiyot, xizmat körsatiş), elektr xavfsizligi, sterillaş imkoniyati;
- *aniqlik va işonçlilik* — xato narxi qançalik yuqori bölsa (jarrohlik, kosmos), zaxiralaş va diagnostikaga talab şunçalik qatʼiy;
- *avtonomlik* — aloqa yöq yoki çeklangan şaroitda (suv osti, kosmos, yer osti) robot öz datçiklariga tayanişi kerak;
- *narx va soddalik* — ayniqsa taʼlim va ommaviy xizmat robotlari uçun;
- *meʼyoriy talablar* — sohaga xos standartlar va sertifikatlaş (tibbiyot, aviatsiya, avtomobil sanoati).

Quyida asosiy sohalar böyiça robotlar va mexatron modullarning informatsion qurilmalari körib çiqiladi.

// =====================================================================
= Radiotexnika tizimlarida informatsion qurilmalar
// =====================================================================

Radiotexnika bilan mexatronika ikki yönalişda kesişadi: birinçidan, radiotexnik tizimlarning özida mexatron modullar işlatiladi (antennalarni yönaltiriş), ikkinçidan, radiotexnik usullar robotlar uçun datçik vazifasini bajaradi (radar, radionavigatsiya).

== Antenna pozitsionerlari

Sunʼiy yöldoş aloqasi, radiolokatsiya va radioastronomiya antennalari azimut va elevatsiya böyiça aylanuvçi ikki öqli mexatron yuritmalar — *antenna pozitsionerlari* yordamida yönaltiriladi. Ularning informatsion qurilmalari: öqlar burçagini ölçovçi absolyut enkoderlar yoki rezolverlar, qiyalik datçiklari (inklinometrlar), şamol yuklamasini nazorat qiluvçi datçiklar, harakatlanuvçi platformalarda (kemalar, avtomobillar) esa platforma tebranişini kompensatsiya qiliş uçun IMU va GNSS.

Talab qilinadigan yönaltiriş aniqligi antenna yönalganlik diagrammasi kengligiga boğliq. Parabolik antenna uçun yarim quvvat böyiça diagramma kengligi taxminan:

#eq($ theta approx 70 dot lambda / D quad ["grad"], $)

bu yerda $lambda$ — tölqin uzunligi, $D$ — antenna diametri. *Misol.* 12 GHz ($lambda = 2","5$ sm) çastotada işlaydigan $D = 1","2$ m antenna uçun $theta approx 70 dot 0","025 slash 1","2 approx 1","46 degree$. Signal sezilarli yöqolmasligi uçun yönaltiriş xatoligi diagramma kengligining taxminan 0,1 qismidan, yaʼni 0,15° dan oşmasligi kerak. Bu enkoder ruxsati, reduktor lyufti va platforma tebranişini kompensatsiya qiliş aniqligiga qatʼiy talab qöyadi (9-maʼruza).

== Radar — robot datçigi sifatida

*Radiolokator* (radar) radiotölqinlar yordamida obyektgaça masofa va uning tezligini ölçaydi. Robototexnika va avtomobillarda köpinça çastotasi çiziqli özgaruvçi uzluksiz signalli (FMCW) radarlar, masalan 77–81 GHz diapazonidagi radarlar qöllanadi. Radarning masofa böyiça ruxsat qobiliyati signal çastota polosasi $B$ bilan belgilanadi:

#eq($ Delta R = c / (2 B), $)

bu yerda $c$ — yoruğlik tezligi. $B = 4$ GHz uçun $Delta R approx 3","75$ sm. Obyekt tezligi Doppler çastota siljişi $f_d$ böyiça topiladi:

#eq($ v = (f_d dot lambda) / 2. $)

77 GHz ($lambda approx 3","9$ mm) radarda $f_d = 1$ kHz siljiş $v approx 1","95$ m/s radial tezlikka mos keladi. Radarning optik datçiklardan asosiy afzalligi — tuman, yomğir, çang, tutun va qoronğilikda işlaşi va tezlikni bevosita ölçaşi; kamçiligi — burçak ruxsati past va obyekt şaklini kam ajratadi. Şuning uçun avtonom transport va mobil robotlarda radar kamera va LiDAR bilan birga işlatiladi.

== Radionavigatsiya va radioidentifikatsiya

- *GNSS* (GPS, GLONASS, Galileo, BeiDou) oçiq joyda robot koordinatalarini beradi; oddiy rejimda xatolik metrlar, tayanç stansiya tuzatmalari bilan işlaydigan *RTK* rejimida esa santimetrlar tartibida.
- *Öta keng polosali (UWB) tizimlar* bino içida GNSS işlamaydigan joyda radiosignal tarqaliş vaqti böyiça robot yoki yuk joylaşuvini aniqlaydi.
- *RFID* belgilar robotga obyektlar va joylarni kontaktsiz tanib oliş imkonini beradi (omborxonalar, işlab çiqariş liniyalari).

// =====================================================================
= Taʼlim tizimlarida mexatron modullar va robotlar
// =====================================================================

Taʼlimda robotlar ikki maqsadda qöllanadi: mexatronika, robototexnika, dasturlaş va datçiklar texnikasini örganiş uçun *öquv vositasi* sifatida hamda öquv jarayonini qöllab-quvvatlovçi *yordamçi* (masalan, telepresens yoki ijtimoiy robotlar) sifatida.

Taʼlim robotlari va laboratoriya stendlarining turlari:
- *maktab va boşlanğiç darajadagi konstruktorlar* — modulli qismlar, sodda dasturlaş muhitlari;
- *mikrokontroller va bir platali kompyuter asosidagi platformalar* — Arduino, ESP32, Raspberry Pi va şu kabi platalar asosida mobil robotlar va manipulyatorlar;
- *oçiq tadqiqot platformalari* — ROS 2 bilan işlaydigan mobil robotlar va kiçik manipulyatorlar;
- *öquv-laboratoriya stendlari* — datçiklar, yuritmalar, PLC va pnevmatika böyiça sanoat uskunalariga yaqin modullar;
- *virtual laboratoriyalar va simulyatorlar* — real uskunasiz tajriba ötkaziş va raqamli egizaklar bilan işlaş.

Taʼlim robotlarida keng tarqalgan informatsion qurilmalar: ultratovuş masofa ölçagiçlar (7-maʼruza), infraqizil çiziq va tösiq datçiklari, ğildirak enkoderlari, MEMS IMU, kameralar, tugmalar va çegara kalitlari. Ularga qöyiladigan asosiy talablar — arzonlik, xavfsizlik, ulaş va dasturlaş soddaligi, oçiq hujjatlar va işning körgazmaliligi.

*Misol: çiziq böylab harakatlanuvçi robot.* Robot ostiga bir qatorga $n$ ta infraqizil aks ettiriş datçigi örnatiladi. $i$-datçik koordinatasi $x_i$, uning normallaştirilgan signali $s_i$ (0 — oq fon, 1 — qora çiziq) bölsa, çiziqning robot öqiga nisbatan holati signallarning «oğirlik markazi» sifatida hisoblanadi:

#eq($ e = (sum_(i=1)^n x_i dot s_i) / (sum_(i=1)^n s_i). $)

Beşta datçik $x = -2, -1, 0, 1, 2$ sm nuqtalarda joylaşgan va signallar $0; 0","2; 1; 0","6; 0$ bölsa, $e = (-0","2 + 0","6) slash 1","8 approx 0","22$ sm. Bu xatolik rostlagiçga beriladi va robot çiziq markaziga qaytariladi. Oddiy misolda talabalar datçik signallarini normallaştiriş, kalibrlaş, filtrlaş va qayta aloqali boşqaruvni amalda örganadi.

// =====================================================================
= Tibbiyot va diagnostika tizimlarida informatsion qurilmalar
// =====================================================================

Tibbiyot robototexnikaning eng masʼuliyatli va jadal rivojlanayotgan sohalaridan biri. Bu yerda robotlar inson bilan bevosita aloqada bölgani uçun ularning informatsion qurilmalariga eng qatʼiy talablar qöyiladi.

== Jarrohlik robotlari

Minimal invaziv jarrohlik robotlari odatda *teleoperatsion* tizim sifatida işlaydi: jarroh boşqaruv pultidagi qöl manipulyatorlarini (master qurilma) harakatlantiradi, bemor yonidagi robot (slave) esa asboblarni mos ravişda harakatlantiradi (1-rasm).

#figure(
  diagram(
    spacing: (7mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Jarroh], fill: white, name: <j>),
    node((1, 0), [Master \ qurilma], name: <m>),
    node((2, 0), [Masştablaş, \ titraş filtri], fill: lightorange, name: <f>),
    node((3, 0), [Slave robot \ va asbob], name: <s>),
    node((4, 0), [Bemor], fill: white, name: <b>),
    node((2, 1), [Displey \ (3D endoskop)], name: <d>),
    edge(<j>, <m>, "->"),
    edge(<m>, <f>, "->"),
    edge(<f>, <s>, "->"),
    edge(<s>, <b>, "->"),
    edge(<s>, <m>, "->", bend: -35deg, [kuç / taktil qayta aloqa], label-side: right),
    edge(<s>, <d>, "->", [tasvir], label-side: left),
    edge(<d>, <j>, "->"),
  ),
  caption: [Teleoperatsion jarrohlik robotining informatsion oqimlari],
) <fig-jarroh>

Bu tizimda informatsion qurilmalar quyidagi vazifalarni bajaradi: master qurilma böğinlaridagi yuqori ruxsatli enkoderlar jarroh qöli harakatini ölçaydi; slave robot enkoderlari asbob holatini nazorat qiladi; stereoskopik endoskop operatsiya maydonining 3D tasvirini beradi; asbobdagi kuç datçiklari töqimaga taʼsir kuçini ölçaydi va uni jarrohga qayta aloqa sifatida qaytaradi. Dastur jarroh harakatini kiçraytiradi (*masştablaş*):

#eq($ x_"asbob" = k_m dot x_"qöl", $)

masalan, $k_m = 1 slash 5$ bölsa, qölning 10 mm siljişi asbobning 2 mm siljişiga aylanadi, bu nozik harakatlarni aniqroq bajariş imkonini beradi. Bundan taşqari, insonning fiziologik titraşi (taxminan 8–12 Hz) past çastotali raqamli filtr bilan susaytiriladi (10-maʼruza).

== Tibbiyotga xos datçiklar

Tibbiyot robotlarida işlatiladigan datçiklar sterillaşga (yuqori harorat, kimyoviy moddalar) çidamli, biologik mos va elektr jihatdan xavfsiz bölişi kerak; tibbiy elektr uskunalari maxsus standartlar (IEC 60601 seriyasi) talablariga javob beradi. Magnit-rezonans tomograf içida işlaydigan robotlarda kuçli magnit maydon tufayli oddiy elektromagnit datçik va dvigatellar işlatib bölmaydi; bu yerda pnevmatik yuritmalar va *optik tolali datçiklar* qöllanadi.

Optik tolali deformatsiya va kuç datçiklarining keng tarqalgan turi — *Bregg panjarali tola* (FBG). Tola içidagi davriy tuzilma maʼlum tölqin uzunligi $lambda_B$ dagi yoruğlikni aks ettiradi; tola çözilganda bu tölqin uzunligi siljiydi:

#eq($ Delta lambda_B approx K_epsilon dot epsilon, $)

bu yerda $K_epsilon$ — sezgirlik; 1550 nm atrofida işlaydigan FBG uçun u taxminan 1,2 pm/µε. Masalan, 500 µε deformatsiya taxminan 0,6 nm siljiş beradi. FBG datçiklar elektromagnit maydonga sezgir emas, juda ingiçka va bitta tolada bir neçta ölçaş nuqtasini joylaştiriş mumkin; ular egiluvçan jarrohlik asboblari va kateterlarning şakli hamda kuçini ölçaşda işlatiladi.

== Reabilitatsiya va diagnostika

*Reabilitatsiya robotlari va ekzoskeletlar* bemor harakatini qöllab-quvvatlaydi. Ularda böğin burçagi va moment datçiklari, IMU, oyoq ostidagi bosim datçiklari hamda muşaklar elektr faolligini qayd etuvçi *elektromiografiya* (EMG) datçiklari qöllanadi: EMG signali böyiça robot bemorning harakat niyatini oldindan aniqlaydi.

*Diagnostika tizimlarida* robotlar ultratovuş tekşiruvi zondini aniq va bir xil kuç bilan harakatlantiradi, rentgen va tomografiya uskunalarini pozitsiyalaydi, laboratoriyalarda namunalarni tahlil qiladi (pipetkalaş robotlari, ştrix-kod va texnik köriş yordamida namunalarni identifikatsiya qiliş). Kapsula endoskoplari esa miniatyur kamera, yoritgiç va radiouzatgiç bilan jihozlangan.

// =====================================================================
= Harbiy, xavfsizlik va qutqaruv sohalaridagi robotlarning informatsion qurilmalari
// =====================================================================

Harbiy va xavfsizlik sohalarida robotlar asosan insonni xavfli vazifalardan ozod qiliş uçun qöllanadi: portlovçi qurilmalarni tekşiriş va zararsizlantiriş, razvedka va kuzatiş, minalardan tozalaş, xavfli kimyoviy va radioaktiv muhitda işlaş, şuningdek favqulodda vaziyatlarda qidiruv-qutqaruv işlari. Bu robotlarning köpçiligi (tirtilli yer usti robotlari, uçuvçisiz uçiş apparatlari) fuqarolik maqsadlarida — qutqaruv, gumanitar minalardan tozalaş, sanoat inspeksiyasida ham keng qöllanadi.

Bunday robotlarning informatsion qurilmalari:
- *köriş tizimlari* — kunduzgi kameralar, issiqlik (termal) kameralari, tungi köriş qurilmalari; ular çang, tutun va qoronğilikda odamlarni va obyektlarni aniqlaş imkonini beradi;
- *navigatsiya* — GNSS, IMU, odometriya, LiDAR; GNSS signali bölmagan yoki buzilgan şaroitda inersial navigatsiyaga tayaniladi;
- *maxsus datçiklar* — metall detektorlari va yer osti radarlari (gumanitar minalardan tozalaşda), gaz va kimyoviy datçiklar, radiatsiya datçiklari;
- *manipulyator datçiklari* — operator robot qölini masofadan aniq boşqarişi uçun böğin enkoderlari, kuç datçiklari va qöl kamerasi.

Ularga qöyiladigan maxsus talablar: zarba, vibratsiya, harorat va namlikka çidamlilik (atrof-muhit sinovlari standartlari böyiça), elektromagnit moslik, aloqa uzilganda xavfsiz harakat, kiçik massa va energiya isteʼmoli.

*Inersial navigatsiya xatoligi.* Faqat IMU ga tayanilganda akselerometrning kiçik özgarmas xatoligi (siljişi) $b$ ham ikki marta integrallanib, vaqt böyiça kvadratik ösuvçi pozitsiya xatoligini beradi:

#eq($ Delta s approx 1 / 2 dot b dot t^2. $)

*Misol.* $b = 0","01$ m/s² (taxminan 1 mg) bölsa, 60 s dan keyin $Delta s approx 18$ m, 10 minutdan keyin esa taxminan 1,8 km. Şuning uçun GNSS bölmagan şaroitda inersial navigatsiya odometriya, LiDAR, kamera (vizual odometriya) yoki magnitometr maʼlumotlari bilan muntazam tuzatilişi kerak (10-maʼruza).

// =====================================================================
= Boşqa sohalar
// =====================================================================

== Qişloq xöjaligi

Qişloq xöjaligi robotlari (avtonom traktorlar, purkagiç dronlar, hosil yiğuvçi robotlar) RTK GNSS orqali santimetr aniqlikda harakatlanadi, kamera va LiDAR yordamida qatorlarni, ösimliklar va mevalarni aniqlaydi. Ösimliklar holatini baholaş uçun *multispektral kameralar* qöllanadi: soğlom ösimlik yaqin infraqizil nurni kuçli, qizil nurni esa kuçsiz aks ettiradi. Bu xossa *NDVI* (normallaştirilgan vegetatsiya indeksi) bilan ifodalanadi:

#eq($ "NDVI" = ("NIR" - "Red") / ("NIR" + "Red"), $)

bu yerda NIR va Red — yaqin infraqizil va qizil diapazonlardagi aks ettiriş koeffitsientlari. *Misol.* $"NIR" = 0","50$, $"Red" = 0","08$ bölsa, $"NDVI" = 0","42 slash 0","58 approx 0","72$ — soğlom ösimlik; kasallangan yoki suvsiz ösimlikda indeks kamayadi. Bunday xarita asosida robot öğit va himoya vositalarini faqat kerakli joyga beradi.

== Kosmik robototexnika

Kosmik manipulyatorlar, planetaxodlar va sunʼiy yöldoşlarda informatsion qurilmalar vakuum, katta harorat özgarişlari va kosmik radiatsiya şaroitida işlaydi. Yönalişni aniqlaş uçun yulduz datçiklari (yulduzlar xaritasi böyiça), quyoş datçiklari, giroskoplar va magnitometrlar qöllanadi. Elektron qurilmalar radiatsiyaga çidamli qilib yasaladi, muhim kanallar zaxiralanadi (5-amaliyot), çunki taʼmirlaş imkoni yöq.

== Suv osti robototexnikasi

Suv ostida radiotölqinlar va yoruğlik tez sönadi, GNSS işlamaydi. Şuning uçun suv osti robotlari *gidrolokatorlar* (sonar), Doppler tezlik ölçagiçlari (DVL), IMU va akustik navigatsiya tizimlaridan foydalanadi. Çuqurlik bosim datçigi bilan ölçanadi:

#eq($ h = (p - p_"atm") / (rho dot g), $)

bu yerda $rho approx 1025$ kg/m³ — dengiz suvi ziçligi. Ortiqça bosim 1 MPa bölsa, $h approx 10^6 slash (1025 dot 9","81) approx 99$ m. Datçik korpuslari katta bosim va korroziyaga çidamli bölişi kerak.

== Yadro energetikasi, logistika va transport

*Yadro energetikasida* robotlar reaktor va saqlaş joylarini kuzatadi, radioaktiv materiallar bilan işlaydi; ularning kameralari va elektronikasi radiatsiyaga çidamli, işlamay qolganda xavfsiz holatga ötadi. *Logistikada* avtonom mobil robotlar LiDAR, kamera, ştrix-kod va RFID öquvçilar yordamida omborda harakatlanadi va yuklarni aniqlaydi. *Avtomobil sanoatida* haydovçiga yordam tizimlari va avtonom avtomobillar kamera, radar, LiDAR, ultratovuş datçiklari, GNSS va IMU majmuasidan foydalanadi; bu yerda funksional xavfsizlik standarti ISO 26262 talablari muhim.

Körib çiqilgan sohalar 1-jadvalda umumlaştirilgan.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.1fr),
    header: ([Soha], [Asosiy informatsion qurilmalar], [Maxsus talablar]),
    [Radiotexnika],
    [Enkoderlar, rezolverlar, inklinometrlar, radar, GNSS, UWB, RFID],
    [Yönaltiriş aniqligi, taşqi muhitga çidamlilik],
    [Taʼlim],
    [Ultratovuş va IQ datçiklar, enkoderlar, IMU, kameralar],
    [Arzonlik, xavfsizlik, soddalik, oçiqlik],
    [Tibbiyot],
    [Yuqori ruxsatli enkoderlar, kuç datçiklari, endoskoplar, FBG, EMG],
    [Sterillaş, elektr xavfsizligi, işonçlilik, aniqlik],
    [Xavfsizlik va qutqaruv],
    [Termal kameralar, IMU, LiDAR, gaz va radiatsiya datçiklari, metall detektorlari],
    [Mustahkamlik, GNSS siz navigatsiya, aloqa uzilişiga çidamlilik],
    [Qişloq xöjaligi],
    [RTK GNSS, multispektral kameralar, LiDAR],
    [Çang, namlik, oçiq muhit],
    [Kosmos],
    [Yulduz va quyoş datçiklari, giroskoplar, magnitometrlar],
    [Radiatsiya, vakuum, harorat, zaxiralaş],
    [Suv osti],
    [Sonar, DVL, IMU, bosim datçiklari],
    [Bosim, germetiklik, korroziya],
  ),
  caption: [Turli sohalarda informatsion qurilmalar va ularga qöyiladigan talablar],
) <tab-soha>

// =====================================================================
= Xulosa
// =====================================================================

Mexatron modullar va robotlarning informatsion qurilmalari qöllaniş sohasiga qarab turliça talablarga javob berişi kerak: muhit şaroiti, xavfsizlik, aniqlik, avtonomlik, narx va meʼyoriy talablar. Radiotexnika tizimlarida antenna pozitsionerlari yuqori aniqlikdagi burçak datçiklarini talab qiladi, radar esa robotlar uçun yomon ob-havoda işlaydigan masofa va tezlik datçigi hisoblanadi. Taʼlimda arzon va oçiq platformalar datçiklar, boşqaruv va dasturlaşni amalda örganiş imkonini beradi.

Tibbiyotda teleoperatsion jarrohlik robotlari, reabilitatsiya qurilmalari va diagnostika tizimlari yuqori aniqlik, kuç qayta aloqasi, sterillaş va elektr xavfsizligini talab qiladi; maxsus şaroitlarda optik tolali datçiklar qöllanadi. Xavfsizlik va qutqaruv robotlari termal kameralar, maxsus datçiklar va GNSS siz navigatsiyaga tayanadi. Qişloq xöjaligi, kosmos, suv osti va yadro energetikasi sohalari ham öziga xos datçiklar va konstruktiv yeçimlarni talab qiladi. Barça sohalarda umumiy tendensiya — turli fizik prinsipdagi datçiklarni birgalikda qöllaş va ularning maʼlumotlarini dasturiy birlaştiriş.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Qöllaniş sohasi informatsion qurilmalarga qanday talablar qöyadi?
  + Antenna pozitsionerida qanday informatsion qurilmalar işlatiladi?
  + Diametri 2,4 m bölgan antenna 12 GHz çastotada işlasa, yönalganlik diagrammasi kengligi taxminan qança?
  + FMCW radarning masofa böyiça ruxsati nimaga boğliq? $B = 1$ GHz uçun uni hisoblang.
  + Radarning optik datçiklarga nisbatan afzallik va kamçiliklari nimada?
  + Taʼlim robotlarida qanday datçiklar keng tarqalgan va ularga qanday talablar qöyiladi?
  + Çiziq böylab harakatlanuvçi robotda çiziq holati qanday hisoblanadi?
  + Teleoperatsion jarrohlik robotida informatsion qurilmalar qanday vazifalarni bajaradi?
  + Harakatni masştablaş va titraşni filtrlaş nima uçun kerak?
  + Optik tolali Bregg datçiklari qanday işlaydi va nima uçun tibbiyotda qöllanadi?
  + Nima uçun faqat IMU ga asoslangan navigatsiya xatoligi tez ösadi? $b = 0","005$ m/s² uçun 2 minutdan keyingi xatolikni toping.
  + NDVI indeksi nimani körsatadi va qanday hisoblanadi?
  + Suv osti robotlarida qanday navigatsiya datçiklari qöllanadi va nima uçun?
]
