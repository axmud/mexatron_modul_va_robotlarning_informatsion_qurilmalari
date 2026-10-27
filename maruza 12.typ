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
  title: "Maʼruza №12. Radiotexnika tizimlarida, taʼlim tizimlarida, tibbiyot va diagnostika tizimlarida, harbiy va boshqa turli maqsadlarda qoʻllaniladigan mexatron modullar va robotlarning informatsion qurilmalari",
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №12]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Radiotexnika, taʼlim, tibbiyot va diagnostika, harbiy va boshqa \ sohalarda qoʻllaniladigan mexatron modullar va robotlarning \ informatsion qurilmalari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Qoʻllanish sohasining informatsion qurilmalarga qoʻyadigan talablari.
  + Radiotexnika tizimlarida informatsion qurilmalar.
  + Taʼlim tizimlarida mexatron modullar va robotlar.
  + Tibbiyot va diagnostika tizimlarida informatsion qurilmalar.
  + Harbiy, xavfsizlik va qutqaruv sohalaridagi robotlarning informatsion qurilmalari.
  + Boshqa sohalar: qishloq xoʻjaligi, kosmik, suv osti, yadro energetikasi, logistika.

  *Tayanch iboralar:* antenna pozitsioneri, radiolokator, FMCW radar, Doppler effekti, RFID, UWB, GNSS RTK, taʼlim robotlari, chiziq datchiklari, jarrohlik roboti, teleoperatsiya, harakatni masshtablash, titrashni filtrlash, kuch qayta aloqasi, optik tolali datchik, Bregg panjarasi, reabilitatsiya, ekzoskelet, EMG, inersial navigatsiya, drift, termal kamera, yer osti radari, NDVI, gidrolokator, radiatsiyaga chidamlilik.
]

// =====================================================================
= Qoʻllanish sohasining informatsion qurilmalarga qoʻyadigan talablari
// =====================================================================

Oldingi maʼruzalarda informatsion qurilmalarning ishlash prinsiplari, tavsiflari va dasturiy taʼminoti umumiy holda koʻrib chiqildi. Amaliyotda esa robot va uning datchiklari qayerda ishlatilishiga qarab ularga juda turli talablar qoʻyiladi. Bir xil vazifani — masalan, masofani oʻlchashni — zavod sexida, operatsiya xonasida, suv ostida yoki kosmosda bajarish butunlay boshqa yechimlarni talab qiladi.

Qoʻllanish sohasiga bogʻliq asosiy talablar:
- *muhit sharoiti* — harorat, namlik, chang, vibratsiya va zarba, bosim, radiatsiya, elektromagnit maydonlar;
- *xavfsizlik* — inson bilan bevosita ishlash (tibbiyot, xizmat koʻrsatish), elektr xavfsizligi, sterillash imkoniyati;
- *aniqlik va ishonchlilik* — xato narxi qanchalik yuqori boʻlsa (jarrohlik, kosmos), zaxiralash va diagnostikaga talab shunchalik qatʼiy;
- *avtonomlik* — aloqa yoʻq yoki cheklangan sharoitda (suv osti, kosmos, yer osti) robot oʻz datchiklariga tayanishi kerak;
- *narx va soddalik* — ayniqsa taʼlim va ommaviy xizmat robotlari uchun;
- *meʼyoriy talablar* — sohaga xos standartlar va sertifikatlash (tibbiyot, aviatsiya, avtomobil sanoati).

Quyida asosiy sohalar boʻyicha robotlar va mexatron modullarning informatsion qurilmalari koʻrib chiqiladi.

// =====================================================================
= Radiotexnika tizimlarida informatsion qurilmalar
// =====================================================================

Radiotexnika bilan mexatronika ikki yoʻnalishda kesishadi: birinchidan, radiotexnik tizimlarning oʻzida mexatron modullar ishlatiladi (antennalarni yoʻnaltirish), ikkinchidan, radiotexnik usullar robotlar uchun datchik vazifasini bajaradi (radar, radionavigatsiya).

== Antenna pozitsionerlari

Sunʼiy yoʻldosh aloqasi, radiolokatsiya va radioastronomiya antennalari azimut va elevatsiya boʻyicha aylanuvchi ikki oʻqli mexatron yuritmalar — *antenna pozitsionerlari* yordamida yoʻnaltiriladi. Ularning informatsion qurilmalari: oʻqlar burchagini oʻlchovchi absolyut enkoderlar yoki rezolverlar, qiyalik datchiklari (inklinometrlar), shamol yuklamasini nazorat qiluvchi datchiklar, harakatlanuvchi platformalarda (kemalar, avtomobillar) esa platforma tebranishini kompensatsiya qilish uchun IMU va GNSS.

Talab qilinadigan yoʻnaltirish aniqligi antenna yoʻnalganlik diagrammasi kengligiga bogʻliq. Parabolik antenna uchun yarim quvvat boʻyicha diagramma kengligi taxminan:

#eq($ theta approx 70 dot lambda / D quad ["grad"], $)

bu yerda $lambda$ — toʻlqin uzunligi, $D$ — antenna diametri. *Misol.* 12 GHz ($lambda = 2","5$ sm) chastotada ishlaydigan $D = 1","2$ m antenna uchun $theta approx 70 dot 0","025 slash 1","2 approx 1","46 degree$. Signal sezilarli yoʻqolmasligi uchun yoʻnaltirish xatoligi diagramma kengligining taxminan 0,1 qismidan, yaʼni 0,15° dan oshmasligi kerak. Bu enkoder ruxsati, reduktor lyufti va platforma tebranishini kompensatsiya qilish aniqligiga qatʼiy talab qoʻyadi (9-maʼruza).

== Radar — robot datchigi sifatida

*Radiolokator* (radar) radiotoʻlqinlar yordamida obyektgacha masofa va uning tezligini oʻlchaydi. Robototexnika va avtomobillarda koʻpincha chastotasi chiziqli oʻzgaruvchi uzluksiz signalli (FMCW) radarlar, masalan 77–81 GHz diapazonidagi radarlar qoʻllanadi. Radarning masofa boʻyicha ruxsat qobiliyati signal chastota polosasi $B$ bilan belgilanadi:

#eq($ Delta R = c / (2 B), $)

bu yerda $c$ — yorugʻlik tezligi. $B = 4$ GHz uchun $Delta R approx 3","75$ sm. Obyekt tezligi Doppler chastota siljishi $f_d$ boʻyicha topiladi:

#eq($ v = (f_d dot lambda) / 2. $)

77 GHz ($lambda approx 3","9$ mm) radarda $f_d = 1$ kHz siljish $v approx 1","95$ m/s radial tezlikka mos keladi. Radarning optik datchiklardan asosiy afzalligi — tuman, yomgʻir, chang, tutun va qorongʻilikda ishlashi va tezlikni bevosita oʻlchashi; kamchiligi — burchak ruxsati past va obyekt shaklini kam ajratadi. Shuning uchun avtonom transport va mobil robotlarda radar kamera va LiDAR bilan birga ishlatiladi.

== Radionavigatsiya va radioidentifikatsiya

- *GNSS* (GPS, GLONASS, Galileo, BeiDou) ochiq joyda robot koordinatalarini beradi; oddiy rejimda xatolik metrlar, tayanch stansiya tuzatmalari bilan ishlaydigan *RTK* rejimida esa santimetrlar tartibida.
- *Oʻta keng polosali (UWB) tizimlar* bino ichida GNSS ishlamaydigan joyda radiosignal tarqalish vaqti boʻyicha robot yoki yuk joylashuvini aniqlaydi.
- *RFID* belgilar robotga obyektlar va joylarni kontaktsiz tanib olish imkonini beradi (omborxonalar, ishlab chiqarish liniyalari).

// =====================================================================
= Taʼlim tizimlarida mexatron modullar va robotlar
// =====================================================================

Taʼlimda robotlar ikki maqsadda qoʻllanadi: mexatronika, robototexnika, dasturlash va datchiklar texnikasini oʻrganish uchun *oʻquv vositasi* sifatida hamda oʻquv jarayonini qoʻllab-quvvatlovchi *yordamchi* (masalan, telepresens yoki ijtimoiy robotlar) sifatida.

Taʼlim robotlari va laboratoriya stendlarining turlari:
- *maktab va boshlangʻich darajadagi konstruktorlar* — modulli qismlar, sodda dasturlash muhitlari;
- *mikrokontroller va bir platali kompyuter asosidagi platformalar* — Arduino, ESP32, Raspberry Pi va shu kabi platalar asosida mobil robotlar va manipulyatorlar;
- *ochiq tadqiqot platformalari* — ROS 2 bilan ishlaydigan mobil robotlar va kichik manipulyatorlar;
- *oʻquv-laboratoriya stendlari* — datchiklar, yuritmalar, PLC va pnevmatika boʻyicha sanoat uskunalariga yaqin modullar;
- *virtual laboratoriyalar va simulyatorlar* — real uskunasiz tajriba oʻtkazish va raqamli egizaklar bilan ishlash.

Taʼlim robotlarida keng tarqalgan informatsion qurilmalar: ultratovush masofa oʻlchagichlar (7-maʼruza), infraqizil chiziq va toʻsiq datchiklari, gʻildirak enkoderlari, MEMS IMU, kameralar, tugmalar va chegara kalitlari. Ularga qoʻyiladigan asosiy talablar — arzonlik, xavfsizlik, ulash va dasturlash soddaligi, ochiq hujjatlar va ishning koʻrgazmaliligi.

*Misol: chiziq boʻylab harakatlanuvchi robot.* Robot ostiga bir qatorga $n$ ta infraqizil aks ettirish datchigi oʻrnatiladi. $i$-datchik koordinatasi $x_i$, uning normallashtirilgan signali $s_i$ (0 — oq fon, 1 — qora chiziq) boʻlsa, chiziqning robot oʻqiga nisbatan holati signallarning «ogʻirlik markazi» sifatida hisoblanadi:

#eq($ e = (sum_(i=1)^n x_i dot s_i) / (sum_(i=1)^n s_i). $)

Beshta datchik $x = -2, -1, 0, 1, 2$ sm nuqtalarda joylashgan va signallar $0; 0","2; 1; 0","6; 0$ boʻlsa, $e = (-0","2 + 0","6) slash 1","8 approx 0","22$ sm. Bu xatolik rostlagichga beriladi va robot chiziq markaziga qaytariladi. Oddiy misolda talabalar datchik signallarini normallashtirish, kalibrlash, filtrlash va qayta aloqali boshqaruvni amalda oʻrganadi.

// =====================================================================
= Tibbiyot va diagnostika tizimlarida informatsion qurilmalar
// =====================================================================

Tibbiyot robototexnikaning eng masʼuliyatli va jadal rivojlanayotgan sohalaridan biri. Bu yerda robotlar inson bilan bevosita aloqada boʻlgani uchun ularning informatsion qurilmalariga eng qatʼiy talablar qoʻyiladi.

== Jarrohlik robotlari

Minimal invaziv jarrohlik robotlari odatda *teleoperatsion* tizim sifatida ishlaydi: jarroh boshqaruv pultidagi qoʻl manipulyatorlarini (master qurilma) harakatlantiradi, bemor yonidagi robot (slave) esa asboblarni mos ravishda harakatlantiradi (1-rasm).

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
    node((2, 0), [Masshtablash, \ titrash filtri], fill: lightorange, name: <f>),
    node((3, 0), [Slave robot \ va asbob], name: <s>),
    node((4, 0), [Bemor], fill: white, name: <b>),
    node((2, 1), [Displey \ (3D endoskop)], name: <d>),
    edge(<j>, <m>, "->"),
    edge(<m>, <f>, "->"),
    edge(<f>, <s>, "->"),
    edge(<s>, <b>, "->"),
    edge(<s>, <m>, "->", bend: -35deg, [kuch / taktil qayta aloqa], label-side: right),
    edge(<s>, <d>, "->", [tasvir], label-side: left),
    edge(<d>, <j>, "->"),
  ),
  caption: [Teleoperatsion jarrohlik robotining informatsion oqimlari],
) <fig-jarroh>

Bu tizimda informatsion qurilmalar quyidagi vazifalarni bajaradi: master qurilma boʻgʻinlaridagi yuqori ruxsatli enkoderlar jarroh qoʻli harakatini oʻlchaydi; slave robot enkoderlari asbob holatini nazorat qiladi; stereoskopik endoskop operatsiya maydonining 3D tasvirini beradi; asbobdagi kuch datchiklari toʻqimaga taʼsir kuchini oʻlchaydi va uni jarrohga qayta aloqa sifatida qaytaradi. Dastur jarroh harakatini kichraytiradi (*masshtablash*):

#eq($ x_"asbob" = k_m dot x_"qoʻl", $)

masalan, $k_m = 1 slash 5$ boʻlsa, qoʻlning 10 mm siljishi asbobning 2 mm siljishiga aylanadi, bu nozik harakatlarni aniqroq bajarish imkonini beradi. Bundan tashqari, insonning fiziologik titrashi (taxminan 8–12 Hz) past chastotali raqamli filtr bilan susaytiriladi (10-maʼruza).

== Tibbiyotga xos datchiklar

Tibbiyot robotlarida ishlatiladigan datchiklar sterillashga (yuqori harorat, kimyoviy moddalar) chidamli, biologik mos va elektr jihatdan xavfsiz boʻlishi kerak; tibbiy elektr uskunalari maxsus standartlar (IEC 60601 seriyasi) talablariga javob beradi. Magnit-rezonans tomograf ichida ishlaydigan robotlarda kuchli magnit maydon tufayli oddiy elektromagnit datchik va dvigatellar ishlatib boʻlmaydi; bu yerda pnevmatik yuritmalar va *optik tolali datchiklar* qoʻllanadi.

Optik tolali deformatsiya va kuch datchiklarining keng tarqalgan turi — *Bregg panjarali tola* (FBG). Tola ichidagi davriy tuzilma maʼlum toʻlqin uzunligi $lambda_B$ dagi yorugʻlikni aks ettiradi; tola choʻzilganda bu toʻlqin uzunligi siljiydi:

#eq($ Delta lambda_B approx K_epsilon dot epsilon, $)

bu yerda $K_epsilon$ — sezgirlik; 1550 nm atrofida ishlaydigan FBG uchun u taxminan 1,2 pm/µε. Masalan, 500 µε deformatsiya taxminan 0,6 nm siljish beradi. FBG datchiklar elektromagnit maydonga sezgir emas, juda ingichka va bitta tolada bir nechta oʻlchash nuqtasini joylashtirish mumkin; ular egiluvchan jarrohlik asboblari va kateterlarning shakli hamda kuchini oʻlchashda ishlatiladi.

== Reabilitatsiya va diagnostika

*Reabilitatsiya robotlari va ekzoskeletlar* bemor harakatini qoʻllab-quvvatlaydi. Ularda boʻgʻin burchagi va moment datchiklari, IMU, oyoq ostidagi bosim datchiklari hamda mushaklar elektr faolligini qayd etuvchi *elektromiografiya* (EMG) datchiklari qoʻllanadi: EMG signali boʻyicha robot bemorning harakat niyatini oldindan aniqlaydi.

*Diagnostika tizimlarida* robotlar ultratovush tekshiruvi zondini aniq va bir xil kuch bilan harakatlantiradi, rentgen va tomografiya uskunalarini pozitsiyalaydi, laboratoriyalarda namunalarni tahlil qiladi (pipetkalash robotlari, shtrix-kod va texnik koʻrish yordamida namunalarni identifikatsiya qilish). Kapsula endoskoplari esa miniatyur kamera, yoritgich va radiouzatgich bilan jihozlangan.

// =====================================================================
= Harbiy, xavfsizlik va qutqaruv sohalaridagi robotlarning informatsion qurilmalari
// =====================================================================

Harbiy va xavfsizlik sohalarida robotlar asosan insonni xavfli vazifalardan ozod qilish uchun qoʻllanadi: portlovchi qurilmalarni tekshirish va zararsizlantirish, razvedka va kuzatish, minalardan tozalash, xavfli kimyoviy va radioaktiv muhitda ishlash, shuningdek favqulodda vaziyatlarda qidiruv-qutqaruv ishlari. Bu robotlarning koʻpchiligi (tirtilli yer usti robotlari, uchuvchisiz uchish apparatlari) fuqarolik maqsadlarida — qutqaruv, gumanitar minalardan tozalash, sanoat inspeksiyasida ham keng qoʻllanadi.

Bunday robotlarning informatsion qurilmalari:
- *koʻrish tizimlari* — kunduzgi kameralar, issiqlik (termal) kameralari, tungi koʻrish qurilmalari; ular chang, tutun va qorongʻilikda odamlarni va obyektlarni aniqlash imkonini beradi;
- *navigatsiya* — GNSS, IMU, odometriya, LiDAR; GNSS signali boʻlmagan yoki buzilgan sharoitda inersial navigatsiyaga tayaniladi;
- *maxsus datchiklar* — metall detektorlari va yer osti radarlari (gumanitar minalardan tozalashda), gaz va kimyoviy datchiklar, radiatsiya datchiklari;
- *manipulyator datchiklari* — operator robot qoʻlini masofadan aniq boshqarishi uchun boʻgʻin enkoderlari, kuch datchiklari va qoʻl kamerasi.

Ularga qoʻyiladigan maxsus talablar: zarba, vibratsiya, harorat va namlikka chidamlilik (atrof-muhit sinovlari standartlari boʻyicha), elektromagnit moslik, aloqa uzilganda xavfsiz harakat, kichik massa va energiya isteʼmoli.

*Inersial navigatsiya xatoligi.* Faqat IMU ga tayanilganda akselerometrning kichik oʻzgarmas xatoligi (siljishi) $b$ ham ikki marta integrallanib, vaqt boʻyicha kvadratik oʻsuvchi pozitsiya xatoligini beradi:

#eq($ Delta s approx 1 / 2 dot b dot t^2. $)

*Misol.* $b = 0","01$ m/s² (taxminan 1 mg) boʻlsa, 60 s dan keyin $Delta s approx 18$ m, 10 minutdan keyin esa taxminan 1,8 km. Shuning uchun GNSS boʻlmagan sharoitda inersial navigatsiya odometriya, LiDAR, kamera (vizual odometriya) yoki magnitometr maʼlumotlari bilan muntazam tuzatilishi kerak (10-maʼruza).

// =====================================================================
= Boshqa sohalar
// =====================================================================

== Qishloq xoʻjaligi

Qishloq xoʻjaligi robotlari (avtonom traktorlar, purkagich dronlar, hosil yigʻuvchi robotlar) RTK GNSS orqali santimetr aniqlikda harakatlanadi, kamera va LiDAR yordamida qatorlarni, oʻsimliklar va mevalarni aniqlaydi. Oʻsimliklar holatini baholash uchun *multispektral kameralar* qoʻllanadi: sogʻlom oʻsimlik yaqin infraqizil nurni kuchli, qizil nurni esa kuchsiz aks ettiradi. Bu xossa *NDVI* (normallashtirilgan vegetatsiya indeksi) bilan ifodalanadi:

#eq($ "NDVI" = ("NIR" - "Red") / ("NIR" + "Red"), $)

bu yerda NIR va Red — yaqin infraqizil va qizil diapazonlardagi aks ettirish koeffitsientlari. *Misol.* $"NIR" = 0","50$, $"Red" = 0","08$ boʻlsa, $"NDVI" = 0","42 slash 0","58 approx 0","72$ — sogʻlom oʻsimlik; kasallangan yoki suvsiz oʻsimlikda indeks kamayadi. Bunday xarita asosida robot oʻgʻit va himoya vositalarini faqat kerakli joyga beradi.

== Kosmik robototexnika

Kosmik manipulyatorlar, planetaxodlar va sunʼiy yoʻldoshlarda informatsion qurilmalar vakuum, katta harorat oʻzgarishlari va kosmik radiatsiya sharoitida ishlaydi. Yoʻnalishni aniqlash uchun yulduz datchiklari (yulduzlar xaritasi boʻyicha), quyosh datchiklari, giroskoplar va magnitometrlar qoʻllanadi. Elektron qurilmalar radiatsiyaga chidamli qilib yasaladi, muhim kanallar zaxiralanadi (5-amaliyot), chunki taʼmirlash imkoni yoʻq.

== Suv osti robototexnikasi

Suv ostida radiotoʻlqinlar va yorugʻlik tez soʻnadi, GNSS ishlamaydi. Shuning uchun suv osti robotlari *gidrolokatorlar* (sonar), Doppler tezlik oʻlchagichlari (DVL), IMU va akustik navigatsiya tizimlaridan foydalanadi. Chuqurlik bosim datchigi bilan oʻlchanadi:

#eq($ h = (p - p_"atm") / (rho dot g), $)

bu yerda $rho approx 1025$ kg/m³ — dengiz suvi zichligi. Ortiqcha bosim 1 MPa boʻlsa, $h approx 10^6 slash (1025 dot 9","81) approx 99$ m. Datchik korpuslari katta bosim va korroziyaga chidamli boʻlishi kerak.

== Yadro energetikasi, logistika va transport

*Yadro energetikasida* robotlar reaktor va saqlash joylarini kuzatadi, radioaktiv materiallar bilan ishlaydi; ularning kameralari va elektronikasi radiatsiyaga chidamli, ishlamay qolganda xavfsiz holatga oʻtadi. *Logistikada* avtonom mobil robotlar LiDAR, kamera, shtrix-kod va RFID oʻquvchilar yordamida omborda harakatlanadi va yuklarni aniqlaydi. *Avtomobil sanoatida* haydovchiga yordam tizimlari va avtonom avtomobillar kamera, radar, LiDAR, ultratovush datchiklari, GNSS va IMU majmuasidan foydalanadi; bu yerda funksional xavfsizlik standarti ISO 26262 talablari muhim.

Koʻrib chiqilgan sohalar 1-jadvalda umumlashtirilgan.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.1fr),
    header: ([Soha], [Asosiy informatsion qurilmalar], [Maxsus talablar]),
    [Radiotexnika],
    [Enkoderlar, rezolverlar, inklinometrlar, radar, GNSS, UWB, RFID],
    [Yoʻnaltirish aniqligi, tashqi muhitga chidamlilik],
    [Taʼlim],
    [Ultratovush va IQ datchiklar, enkoderlar, IMU, kameralar],
    [Arzonlik, xavfsizlik, soddalik, ochiqlik],
    [Tibbiyot],
    [Yuqori ruxsatli enkoderlar, kuch datchiklari, endoskoplar, FBG, EMG],
    [Sterillash, elektr xavfsizligi, ishonchlilik, aniqlik],
    [Xavfsizlik va qutqaruv],
    [Termal kameralar, IMU, LiDAR, gaz va radiatsiya datchiklari, metall detektorlari],
    [Mustahkamlik, GNSS siz navigatsiya, aloqa uzilishiga chidamlilik],
    [Qishloq xoʻjaligi],
    [RTK GNSS, multispektral kameralar, LiDAR],
    [Chang, namlik, ochiq muhit],
    [Kosmos],
    [Yulduz va quyosh datchiklari, giroskoplar, magnitometrlar],
    [Radiatsiya, vakuum, harorat, zaxiralash],
    [Suv osti],
    [Sonar, DVL, IMU, bosim datchiklari],
    [Bosim, germetiklik, korroziya],
  ),
  caption: [Turli sohalarda informatsion qurilmalar va ularga qoʻyiladigan talablar],
) <tab-soha>

// =====================================================================
= Xulosa
// =====================================================================

Mexatron modullar va robotlarning informatsion qurilmalari qoʻllanish sohasiga qarab turlicha talablarga javob berishi kerak: muhit sharoiti, xavfsizlik, aniqlik, avtonomlik, narx va meʼyoriy talablar. Radiotexnika tizimlarida antenna pozitsionerlari yuqori aniqlikdagi burchak datchiklarini talab qiladi, radar esa robotlar uchun yomon ob-havoda ishlaydigan masofa va tezlik datchigi hisoblanadi. Taʼlimda arzon va ochiq platformalar datchiklar, boshqaruv va dasturlashni amalda oʻrganish imkonini beradi.

Tibbiyotda teleoperatsion jarrohlik robotlari, reabilitatsiya qurilmalari va diagnostika tizimlari yuqori aniqlik, kuch qayta aloqasi, sterillash va elektr xavfsizligini talab qiladi; maxsus sharoitlarda optik tolali datchiklar qoʻllanadi. Xavfsizlik va qutqaruv robotlari termal kameralar, maxsus datchiklar va GNSS siz navigatsiyaga tayanadi. Qishloq xoʻjaligi, kosmos, suv osti va yadro energetikasi sohalari ham oʻziga xos datchiklar va konstruktiv yechimlarni talab qiladi. Barcha sohalarda umumiy tendensiya — turli fizik prinsipdagi datchiklarni birgalikda qoʻllash va ularning maʼlumotlarini dasturiy birlashtirish.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Qoʻllanish sohasi informatsion qurilmalarga qanday talablar qoʻyadi?
  + Antenna pozitsionerida qanday informatsion qurilmalar ishlatiladi?
  + Diametri 2,4 m boʻlgan antenna 12 GHz chastotada ishlasa, yoʻnalganlik diagrammasi kengligi taxminan qancha?
  + FMCW radarning masofa boʻyicha ruxsati nimaga bogʻliq? $B = 1$ GHz uchun uni hisoblang.
  + Radarning optik datchiklarga nisbatan afzallik va kamchiliklari nimada?
  + Taʼlim robotlarida qanday datchiklar keng tarqalgan va ularga qanday talablar qoʻyiladi?
  + Chiziq boʻylab harakatlanuvchi robotda chiziq holati qanday hisoblanadi?
  + Teleoperatsion jarrohlik robotida informatsion qurilmalar qanday vazifalarni bajaradi?
  + Harakatni masshtablash va titrashni filtrlash nima uchun kerak?
  + Optik tolali Bregg datchiklari qanday ishlaydi va nima uchun tibbiyotda qoʻllanadi?
  + Nima uchun faqat IMU ga asoslangan navigatsiya xatoligi tez oʻsadi? $b = 0","005$ m/s² uchun 2 minutdan keyingi xatolikni toping.
  + NDVI indeksi nimani koʻrsatadi va qanday hisoblanadi?
  + Suv osti robotlarida qanday navigatsiya datchiklari qoʻllanadi va nima uchun?
]
