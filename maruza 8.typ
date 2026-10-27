// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №8. Mexatron modullar va robotlarning texnik koʻrish tizimlari.
//             Struktura sxemasi, ishlash tamoyili. Videodatchiklar va videokameralar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №8. Mexatron modullar va robotlarning texnik koʻrish tizimlari. Texnik koʻrish tizimining umumlashgan struktura sxemasi. Texnik koʻrish tizimining ishlash tamoyili. Videodatchiklar va videokameralar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 8  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №8]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarning texnik koʻrish tizimlari. Texnik koʻrish tizimining umumlashgan struktura sxemasi va ishlash tamoyili. Videodatchiklar va videokameralar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Texnik koʻrish tizimi tushunchasi va robototexnikadagi vazifalari.
  + Texnik koʻrish tizimining umumlashgan struktura sxemasi.
  + Tasvir hosil boʻlishi: kamera modeli va koʻrish maydoni.
  + Texnik koʻrish tizimining ishlash tamoyili: tasvirga ishlov berish bosqichlari.
  + Videodatchiklar: CCD va CMOS matritsalar, ularning parametrlari.
  + Videokameralar: tuzilishi, turlari va interfeyslari. 3D kameralar.
  + Robotda kamerani joylashtirish va kalibrlash.

  *Tayanch iboralar:* texnik koʻrish tizimi, sahna, yoritish, obyektiv, fokus masofasi, koʻrish maydoni, videodatchik, piksel, CCD, CMOS, global va qatorli zatvor, Bayer filtri, dinamik diapazon, kadrlar chastotasi, segmentatsiya, belgilarni ajratish, tanib olish, aqlli kamera, stereokamera, dispersiya (disparity), strukturalangan yorugʻlik, ToF kamera, eye-in-hand, kalibrlash.
]

// =====================================================================
= Texnik koʻrish tizimi tushunchasi va robototexnikadagi vazifalari
// =====================================================================

*Texnik koʻrish tizimi* (TKT) — sahna tasvirini olish, uni qayta ishlash va tahlil qilish orqali obyektlar haqida axborot oluvchi hamda shu axborot asosida boshqaruv tizimiga maʼlumot yoki buyruq beruvchi apparat-dasturiy kompleks. Inson tashqi dunyo haqidagi axborotning katta qismini koʻrish orqali olganidek (1-maʼruza), robot uchun ham TKT eng boy axborot manbai hisoblanadi.

Robototexnikada TKT quyidagi asosiy vazifalarni bajaradi:
- *obyektlarni aniqlash va tanib olish* — sahnada qanday obyektlar borligini va ularning turini aniqlash;
- *obyektlarning holati va yoʻnalishini aniqlash* — robot obyektni ushlashi uchun uning koordinatalari va burilish burchagini topish (masalan, konveyerdan tartibsiz joylashgan detallarni olish);
- *sifat nazorati va oʻlchash* — detal oʻlchamlari, nuqsonlari, yorliqlar va shtrix-kodlarni tekshirish;
- *navigatsiya* — mobil robotning harakat yoʻlini, toʻsiqlarni va oʻz oʻrnini aniqlash;
- *vizual qayta aloqa (visual servoing)* — robot harakatini kamera tasviri asosida real vaqtda boshqarish;
- *inson bilan muloqot* — odamlarni, imo-ishoralar va yuz ifodalarini tanib olish.

TKT kontaktsiz ishlaydi, juda katta hajmdagi axborot beradi va bitta datchik bilan koʻplab turli vazifalarni hal qilish imkonini beradi. Shu bilan birga, u boshqa datchiklarga qaraganda murakkab ishlov berish algoritmlari va kuchli hisoblash resurslarini talab qiladi, natijasi esa yoritish sharoitiga kuchli bogʻliq.

// =====================================================================
= Texnik koʻrish tizimining umumlashgan struktura sxemasi
// =====================================================================

TKT ning umumlashgan struktura sxemasi 1-rasmda keltirilgan.

#figure(
  diagram(
    spacing: (3.5mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Yoritish \ tizimi], fill: white, name: <yo>),
    node((1, 0), [Sahna, \ obyekt], fill: lightorange, name: <sa>),
    node((2, 0), [Optik \ tizim], name: <op>),
    node((3, 0), [Video- \ datchik], name: <vd>),
    node((4, 0), [ARO va \ interfeys], name: <if>),
    node((4, 1), [Tasvirga \ ishlov berish], name: <ib>),
    node((3, 1), [Tahlil va \ tanib olish], name: <ta>),
    node((2, 1), [Robot boshqaruv \ tizimi], fill: lightorange, name: <bt>),
    node((0, 1), [Manipu- \ lyator], fill: white, name: <ij>),
    edge(<yo>, <sa>, "->"),
    edge(<sa>, <op>, "->"),
    edge(<op>, <vd>, "->"),
    edge(<vd>, <if>, "->"),
    edge(<if>, <ib>, "->"),
    edge(<ib>, <ta>, "->"),
    edge(<ta>, <bt>, "->"),
    edge(<bt>, <ij>, "->"),
    edge(<ij>, <sa>, "->", stroke: (dash: "dashed", thickness: 1pt)),
  ),
  caption: [Texnik koʻrish tizimining umumlashgan struktura sxemasi],
) <fig-tkt>

Sxema elementlarining vazifalari:
- *yoritish tizimi* obyektni kerakli tarzda yoritib, uning muhim belgilarini (chegaralar, sirt nuqsonlari, konturlar) yaqqol koʻrsatadi. Sanoat TKT larida yoritish toʻgʻri tanlansa, keyingi ishlov berish ancha soddalashadi;
- *optik tizim* (obyektiv, filtrlar) sahna tasvirini videodatchik sirtiga tushiradi;
- *videodatchik* (fotomatritsa) optik tasvirni elektr signallari majmuasiga aylantiradi;
- *ARO va interfeys* signallarni raqamli tasvirga aylantiradi va uni hisoblash qurilmasiga uzatadi;
- *tasvirga ishlov berish bloki* shovqinni kamaytiradi, tasvir sifatini yaxshilaydi va obyektlarni fondan ajratadi;
- *tahlil va tanib olish bloki* obyekt belgilarini hisoblaydi, ularni maʼlum obyektlar bilan solishtiradi va obyekt turi, holati, oʻlchamlari haqida xulosa chiqaradi;
- *robot boshqaruv tizimi* bu xulosa asosida ijro mexanizmining harakatini rejalashtiradi.

Ijro mexanizmi sahnani oʻzgartirgani (obyektni koʻchirgani) sababli tizim yopiq kontur hosil qiladi: TKT harakat natijasini ham nazorat qiladi.

// =====================================================================
= Tasvir hosil boʻlishi: kamera modeli va koʻrish maydoni
// =====================================================================

== Teshikli kamera modeli

Kamera tasvir hosil qilishini tavsiflash uchun eng sodda va keng qoʻllanadigan model — *teshikli kamera* (_pinhole_) modeli (2-rasm). Unda sahnadagi har bir nuqtadan kelgan nur bitta nuqta — optik markaz orqali oʻtib, undan fokus masofasi $f$ uzoqlikdagi tasvir tekisligiga tushadi.

#let pinhole = {
  let st = 1pt + headingblue
  let ln(a, b, s: st) = place(line(start: a, end: b, stroke: s))
  box(width: 12cm, height: 4.6cm, {
    // optik oʻq
    ln((0cm, 2.3cm), (12cm, 2.3cm), s: (paint: luma(150), thickness: 0.6pt, dash: "dash-dotted"))
    // tasvir tekisligi
    ln((1.2cm, 0.6cm), (1.2cm, 4.0cm), s: 2pt + luma(80))
    place(dx: 0.0cm, dy: 4.1cm, text(size: 9pt)[Tasvir tekisligi])
    // optik markaz
    place(dx: 3.65cm, dy: 2.15cm, circle(radius: 0.15cm, fill: lightorange, stroke: 1pt))
    place(dx: 3.2cm, dy: 2.55cm, text(size: 9pt)[Optik markaz])
    // obyekt
    ln((10.5cm, 2.3cm), (10.5cm, 0.4cm), s: 2.5pt + rgb("#d9692b"))
    place(dx: 10.7cm, dy: 0.25cm, text(size: 10pt)[$P(X, Y, Z)$])
    // nur
    ln((10.5cm, 0.4cm), (1.2cm, 3.04cm))
    // tasvir nuqtasi
    place(dx: 1.08cm, dy: 2.92cm, circle(radius: 0.12cm, fill: headingblue))
    place(dx: 0.0cm, dy: 3.1cm, text(size: 10pt)[$p$])
    // oʻlchamlar
    ln((1.2cm, 1.5cm), (3.8cm, 1.5cm), s: 0.6pt + black)
    place(dx: 2.35cm, dy: 1.05cm, text(size: 10pt)[$f$])
    ln((3.8cm, 4.3cm), (10.5cm, 4.3cm), s: 0.6pt + black)
    place(dx: 7.0cm, dy: 3.85cm, text(size: 10pt)[$Z$])
    place(dx: 10.7cm, dy: 1.2cm, text(size: 10pt)[$Y$])
  })
}

#figure(
  pinhole,
  caption: [Teshikli kamera modeli],
) <fig-pinhole>

Oʻxshash uchburchaklardan kamera koordinatalar tizimidagi $P(X, Y, Z)$ nuqtaning tasvirdagi koordinatalari (piksellarda) quyidagicha topiladi:

#eq($ u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y, $)

bu yerda $f_x, f_y$ — piksellarda ifodalangan fokus masofalari, $c_x, c_y$ — optik markazning tasvirdagi proyeksiyasi (bosh nuqta). Bu parametrlar kameraning *ichki parametrlari* deyiladi va kalibrlash orqali aniqlanadi. (1) ifodadan muhim xulosa kelib chiqadi: bitta kamera tasviridan $X slash Z$ va $Y slash Z$ nisbatlarini topish mumkin, lekin masofa $Z$ ning oʻzini — yoʻq. Chuqurlikni aniqlash uchun qoʻshimcha axborot (ikkinchi kamera, strukturalangan yorugʻlik, obyektning maʼlum oʻlchami) kerak. Real obyektivlar shuningdek tasvirni biroz egadi (distorsiya); bu ham kalibrlash orqali tuzatiladi.

== Koʻrish maydoni va fazoviy ruxsat

Videodatchik kengligi $w$ va obyektiv fokus masofasi $f$ boʻlsa, gorizontal *koʻrish maydoni* burchagi:

#eq($ "FOV" = 2 dot "arctg" w / (2 f). $)

$Z$ masofada kamera koʻradigan sahna kengligi va bitta pikselga toʻgʻri keladigan obyekt oʻlchami (fazoviy ruxsat):

#eq($ W = Z dot w / f, quad Delta = W / N_x, $)

bu yerda $N_x$ — gorizontal piksellar soni.

*Misol.* Kengligi $w = 6","4$ mm boʻlgan matritsa va $f = 8$ mm obyektiv uchun $"FOV" = 2 "arctg"(3","2 slash 8) approx 43","6 degree$. $Z = 1$ m masofada sahna kengligi $W = 1000 dot 6","4 slash 8 = 800$ mm. Matritsa gorizontal boʻyicha 1280 piksel boʻlsa, $Delta = 800 slash 1280 approx 0","63$ mm/piksel. Demak, bu kamera bilan 1 m masofada taxminan 1 mm dan kichik nuqsonni ishonchli aniqlab boʻlmaydi. Kichikroq detallarni koʻrish uchun fokus masofasi kattaroq obyektiv, koʻproq pikselli matritsa yoki kameraning obyektga yaqinroq joylashuvi kerak — lekin bunda koʻrish maydoni torayadi.

*Obyektivning* boshqa muhim parametrlari: diafragma soni $N = f slash D$ ($D$ — kirish teshigi diametri) — u matritsaga tushadigan yorugʻlik miqdorini va keskinlik chuqurligini belgilaydi: diafragma kichraytirilsa ($N$ katta), keskinlik chuqurligi ortadi, lekin tasvir qorongʻiroq boʻladi.

// =====================================================================
= Texnik koʻrish tizimining ishlash tamoyili
// =====================================================================

== Raqamli tasvir

Raqamli tasvir — piksellar matritsasi. Kulrang tasvirda har bir piksel $I(x, y)$ yorugʻlik intensivligini ifodalaydi va odatda 8 bit bilan kodlanadi (0 — qora, 255 — oq). Rangli tasvirda har bir piksel uchta komponentdan (qizil, yashil, koʻk — RGB) iborat va odatda 24 bit egallaydi. Chuqurlik kamerasida esa har bir piksel qiymati obyektgacha masofani bildiradi. 3-maʼruzada koʻrsatilganidek, rangli Full HD tasvirlar oqimi sekundiga gigabitlar tartibidagi maʼlumot hosil qiladi, shuning uchun ishlov berish algoritmlarining samaradorligi muhim.

== Tasvirga ishlov berish bosqichlari

TKT da axborot pastki (piksellar) sathdan yuqori (obyektlar va sahna) sathga qarab bosqichma-bosqich qayta ishlanadi (1-jadval). Har bir bosqichda maʼlumot hajmi kamayadi, uning mazmuni esa boyiydi.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.1fr),
    header: ([Bosqich], [Mazmuni], [Natija]),
    [1. Tasvirni olish],
    [Yoritish, ekspozitsiya, kadrni kiritish],
    [Raqamli tasvir],
    [2. Oldindan ishlov berish],
    [Shovqinni filtrlash, kontrast va yorqinlikni tuzatish, distorsiyani tuzatish],
    [Sifati yaxshilangan tasvir],
    [3. Segmentatsiya],
    [Tasvirni sohalarga ajratish: obyektni fondan ajratish (chegaraviy qiymat, chegaralarni aniqlash)],
    [Obyektlar sohalari, konturlar],
    [4. Belgilarni ajratish],
    [Obyekt yuzasi, perimetri, markazi, yoʻnalishi, shakl va rang belgilari, xarakterli nuqtalar],
    [Belgilar vektori],
    [5. Tanib olish],
    [Belgilarni namunalar bilan solishtirish, tasniflash (shu jumladan neyron tarmoqlar yordamida)],
    [Obyekt turi va holati],
    [6. Sahnani talqin qilish],
    [Obyektlar orasidagi munosabatlar, harakat, robot uchun qaror],
    [Boshqaruv uchun axborot],
  ),
  caption: [Texnik koʻrish tizimida tasvirga ishlov berish bosqichlari],
) <tab-bosqich>

Masalan, konveyerdagi detalni olishda TKT tasvirni oladi, uni chegaraviy qiymat boʻyicha ikkilik (qora-oq) tasvirga aylantiradi, detal sohasini ajratadi, uning markazi koordinatalari va asosiy oʻqining burilish burchagini hisoblaydi, detal turini shakl belgilari boʻyicha aniqlaydi va bu maʼlumotlarni kalibrlash orqali robot koordinatalariga oʻtkazib, boshqaruv tizimiga beradi. Klassik algoritmlar bilan bir qatorda hozirgi kunda 3–6 bosqichlarni chuqur neyron tarmoqlar birgalikda bajarishi tobora keng tarqalmoqda. Tasvirga ishlov berish va tanib olish algoritmlari keyingi maʼruzalarda batafsil koʻriladi.

// =====================================================================
= Videodatchiklar
// =====================================================================

== Ishlash prinsipi

*Videodatchik* (fotomatritsa) — tekislikda qator va ustunlar boʻyicha joylashgan koʻplab fotosezgir elementlar (piksellar) majmuasi. Har bir pikselga tushgan yorugʻlik fotoeffekt hisobiga zaryad hosil qiladi; zaryad *ekspozitsiya vaqti* davomida toʻplanadi va unga tushgan yorugʻlik miqdoriga proporsional boʻladi. Soʻngra zaryadlar oʻqiladi, kuchlanishga aylantiriladi va raqamlanadi. Zaryadni oʻqish usuliga koʻra ikki asosiy turdagi matritsa mavjud.

*CCD matritsa* (zaryad bogʻlangan qurilma) — toʻplangan zaryadlar matritsa boʻylab qatorma-qator bitta yoki bir nechta chiqish kuchaytirgichiga ketma-ket koʻchiriladi. *CMOS matritsa* — har bir pikselda oʻzining kuchaytirgichi bor, piksellar esa xotira kabi qator va ustun manzili boʻyicha oʻqiladi; ARO va boshqarish sxemalari bitta kristallda joylashadi.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Koʻrsatkich], [CCD], [CMOS]),
    [Zaryadni oʻqish],
    [Ketma-ket koʻchirish, umumiy kuchaytirgich],
    [Har bir pikselda kuchaytirgich, manzil boʻyicha],
    [Integratsiya],
    [Tashqi elektronika kerak],
    [ARO va boshqarish kristallda],
    [Energiya isteʼmoli],
    [Yuqori],
    [Past],
    [Tezlik],
    [Oʻrtacha],
    [Yuqori; tasvirning bir qismini (ROI) oʻqish mumkin],
    [Narxi],
    [Yuqoriroq],
    [Past (ommaviy texnologiya)],
    [Bugungi holati],
    [Maxsus ilmiy va tibbiy qoʻllanish],
    [Robototexnika va sanoatda asosiy tur],
  ),
  caption: [CCD va CMOS videodatchiklarini taqqoslash],
) <tab-ccd>

== Zatvor turi

Harakatlanuvchi robotlar va obyektlar uchun matritsaning *zatvor turi* muhim:
- *global zatvor* — barcha piksellar bir vaqtda ekspozitsiya qilinadi; tez harakatlanayotgan obyektlar buzilmasdan tasvirlanadi;
- *qatorli zatvor* (_rolling shutter_) — qatorlar navbatma-navbat ekspozitsiya qilinadi; arzonroq va sezgirroq, lekin tez harakatda tasvir qiyshayadi (masalan, vertikal ustun egik koʻrinadi).

Konveyer, tez harakatlanuvchi manipulyator yoki dronga oʻrnatilgan kameralarda global zatvorli matritsalar afzal.

== Rangli tasvir olish

Fotosezgir element yorugʻlik rangini farqlamaydi. Rangli tasvir olish uchun koʻpincha matritsa ustiga *Bayer filtri* — qizil, yashil va koʻk mikrofiltrlar mozaikasi qoʻyiladi: piksellarning 50 % i yashil, 25 % i qizil va 25 % i koʻk filtr ostida boʻladi (inson koʻzi yashil rangga eng sezgir). Har bir pikselning yetishmayotgan rang komponentlari qoʻshni piksellar boʻyicha interpolyatsiya qilinadi. Shu sababli rangli kameraning haqiqiy fazoviy ruxsati monoxrom kameranikidan biroz past; oʻlchash vazifalarida koʻpincha monoxrom kameralar ishlatiladi.

== Videodatchiklarning asosiy parametrlari

- *Ruxsat (piksellar soni)* — masalan, 1280 × 1024 yoki 5 Mpiksel; fazoviy ruxsatni belgilaydi.
- *Piksel oʻlchami* — odatda bir necha mikrometr; katta piksel koʻproq yorugʻlik yigʻadi va shovqini kamroq.
- *Matritsa formati* — fizik oʻlchami; koʻrish maydonini va obyektiv tanlovini belgilaydi.
- *Kadrlar chastotasi* — sekundiga kadrlar soni; tez jarayonlarni kuzatish imkoniyati.
- *Kvant samaradorligi va sezgirlik* — tushgan fotonlarning qancha qismi elektronga aylanishi.
- *Spektral diapazon* — koʻrinadigan, yaqin infraqizil yoki issiqlik (uzoq infraqizil) diapazoni.
- *Dinamik diapazon* — matritsa bir kadrda farqlay oladigan eng yorugʻ va eng xira signallar nisbati:

#eq($ "DR" = 20 lg N_max / N_"sh" quad ["dB"], $)

bu yerda $N_max$ — piksel toʻplay oladigan eng katta zaryad (elektronlarda), $N_"sh"$ — shovqin darajasi. *Misol.* $N_max = 10 000$ e⁻ va $N_"sh" = 5$ e⁻ boʻlsa, $"DR" = 20 lg 2000 approx 66$ dB. Kichik dinamik diapazonli kamera bir vaqtda yorqin deraza va qorongʻi burchakni yaxshi koʻrsata olmaydi; bunday sharoitlar uchun keng dinamik diapazonli (HDR) kameralar ishlatiladi.

// =====================================================================
= Videokameralar
// =====================================================================

== Tuzilishi va turlari

*Videokamera* obyektiv, optik filtrlar, videodatchik, uni boshqaruvchi va signalga ishlov beruvchi elektronika hamda maʼlumot uzatish interfeysidan iborat. TKT larda qoʻllanadigan kameralar quyidagi turlarga boʻlinadi:
- *sanoat (mashinaviy koʻrish) kameralari* — tasvirni kompyuterga uzatadi, ishlov esa kompyuterda bajariladi; parametrlari (ekspozitsiya, kuchaytirish, trigger) dasturiy boshqariladi;
- *aqlli (smart) kameralar* — protsessor va tasvirga ishlov berish dasturi kamera ichida joylashgan; kontrollerga faqat natija (masalan, «detal yaroqli», detal koordinatalari) uzatiladi. Ular intellektual datchiklarning (7-maʼruza) texnik koʻrish sohasidagi namunasidir;
- *3D (chuqurlik) kameralari* — har bir piksel uchun masofani beradi;
- *issiqlik (termal) kameralari* — uzoq infraqizil nurlanish boʻyicha harorat taqsimotini koʻrsatadi; qorongʻilikda odamlarni aniqlash va qizigan qismlarni nazorat qilish uchun.

Raqamli kameralar kompyuterga standart interfeyslar orqali ulanadi: *GigE Vision* (Ethernet, uzun kabellar), *USB3 Vision* (oddiy ulanish), *Camera Link* va *CoaXPress* (juda yuqori tezlik), shuningdek oʻrnatilgan tizimlar uchun *MIPI CSI-2*.

== 3D kameralar

Teshikli kamera modelidan koʻrinadiki, bitta oddiy kamera masofani bevosita oʻlchamaydi. Chuqurlik axborotini olish uchun quyidagi usullar qoʻllanadi.

*Stereokamera* — bir-biridan $B$ masofada (baza) joylashgan ikkita kamera. Bir nuqta chap va oʻng tasvirlarda turli joylarda koʻrinadi; bu farq *dispersiya* (_disparity_) $d$ deyiladi. Nuqtagacha masofa:

#eq($ Z = (f dot B) / d, $)

bu yerda $f$ — piksellarda ifodalangan fokus masofasi, $d$ — piksellardagi dispersiya. Dispersiyani $Delta d$ xatolik bilan aniqlash masofa xatoligiga olib keladi:

#eq($ Delta Z approx Z^2 / (f dot B) dot Delta d. $)

*Misol.* $f = 700$ piksel, $B = 0","12$ m va $d = 42$ piksel boʻlsa, $Z = 700 dot 0","12 slash 42 = 2$ m. Dispersiya 0,25 piksel aniqlikda topilsa, $Delta Z approx 4 slash 84 dot 0","25 approx 1","2$ sm. Xuddi triangulyatsiyadagi kabi (6-maʼruza), masofa ortishi bilan xatolik kvadratik ortadi; uni kamaytirish uchun bazani yoki fokus masofasini kattalashtirish kerak. Stereokamera passiv ishlaydi, lekin teksturasiz (bir xil rangli) sirtlarda mos nuqtalarni topish qiyin.

*Strukturalangan yorugʻlik kamerasi* obyektga maʼlum naqsh (chiziqlar, nuqtalar) proyeksiyalaydi va naqshning buzilishi boʻyicha triangulyatsiya orqali chuqurlikni hisoblaydi. U teksturasiz sirtlarda ham ishlaydi va yaqin masofada yuqori aniqlik beradi, lekin kuchli quyosh nurida yomonlashadi.

*ToF kamera* har bir pikselda modulyatsiyalangan yorugʻlikning borib-qaytish vaqtini (faza siljishini) oʻlchaydi (6-maʼruza). U ixcham va tezkor, chuqurlik xaritasini bevosita beradi, lekin ruxsat qobiliyati odatda past.

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Usul], [Prinsip], [Afzalligi], [Cheklovi]),
    [Stereokamera],
    [Ikki tasvirdagi dispersiya],
    [Passiv, tashqarida ishlaydi],
    [Teksturasiz sirt, hisoblash murakkab],
    [Strukturalangan yorugʻlik],
    [Proyeksiyalangan naqsh triangulyatsiyasi],
    [Yaqin masofada yuqori aniqlik],
    [Quyosh nuriga sezgir],
    [ToF kamera],
    [Yorugʻlikning borib-qaytish vaqti],
    [Ixcham, tez, bevosita chuqurlik],
    [Past ruxsat, koʻp marta aks etish xatoligi],
  ),
  caption: [3D kameralarning turlari],
) <tab-3d>

// =====================================================================
= Robotda kamerani joylashtirish va kalibrlash
// =====================================================================

Robotga nisbatan kamera ikki xil joylashtiriladi:
- *qoʻzgʻalmas kamera* (_eye-to-hand_) — robot ishchi zonasi tepasida yoki yonida oʻrnatiladi; butun zonani va robotning oʻzini koʻradi, lekin robot qoʻli obyektni toʻsib qolishi mumkin;
- *robot qoʻlidagi kamera* (_eye-in-hand_) — robot bilagi yoki tutqichiga oʻrnatiladi; obyektga yaqinlashib, uni katta ruxsat bilan koʻradi, lekin koʻrish maydoni tor va kamera harakatlanadi.

TKT natijalarini robot ishlata olishi uchun tizim *kalibrlanadi*:
+ *ichki kalibrlash* — kameraning fokus masofalari, bosh nuqtasi va distorsiya koeffitsientlarini aniqlash (odatda shaxmat taxtasi shaklidagi kalibrlash namunasi yordamida);
+ *tashqi kalibrlash* — kamera koordinatalar tizimining robot koordinatalar tizimiga nisbatan joylashuvi va yoʻnalishini aniqlash (_hand-eye_ kalibrlash).

Kalibrlash xatoligi bevosita robot pozitsiyalash xatoligiga aylanadi, shuning uchun kamera yoki robot qayta oʻrnatilganda, shuningdek muntazam ravishda kalibrlash tekshiriladi.

// =====================================================================
= Xulosa
// =====================================================================

Texnik koʻrish tizimi robotga eng boy axborot beradi: obyektlarni tanib olish, ularning holatini aniqlash, sifat nazorati va navigatsiya uchun. Uning umumlashgan tuzilishi yoritish, optik tizim, videodatchik, raqamlash, tasvirga ishlov berish, tahlil va robot boshqaruv tizimidan iborat. Tasvir hosil boʻlishi teshikli kamera modeli bilan tavsiflanadi; koʻrish maydoni va fazoviy ruxsat matritsa oʻlchami, obyektiv fokus masofasi va masofaga bogʻliq. TKT ning ishlash tamoyili tasvirni bosqichma-bosqich — olish, oldindan ishlov, segmentatsiya, belgilarni ajratish, tanib olish va talqin qilish orqali — qayta ishlashdan iborat.

Zamonaviy TKT larda asosan CMOS videodatchiklar qoʻllanadi; ularning ruxsati, piksel oʻlchami, zatvor turi, kadrlar chastotasi va dinamik diapazoni vazifaga mos tanlanadi. Videokameralar sanoat, aqlli, 3D va termal turlarga boʻlinadi; chuqurlik axborotini stereokameralar, strukturalangan yorugʻlik va ToF kameralari beradi. Robotda kamera qoʻzgʻalmas yoki robot qoʻliga oʻrnatiladi va ichki hamda tashqi kalibrlash talab qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Texnik koʻrish tizimi robototexnikada qanday vazifalarni bajaradi?
  + TKT ning umumlashgan struktura sxemasini chizing va elementlarining vazifasini tushuntiring.
  + Yoritish tizimi TKT da qanday ahamiyatga ega?
  + Teshikli kamera modelini tushuntiring. Nima uchun bitta kamera masofani bevosita oʻlchay olmaydi?
  + $w = 8","8$ mm matritsa va $f = 16$ mm obyektiv uchun gorizontal koʻrish maydonini va 2 m masofadagi sahna kengligini toping.
  + Tasvirga ishlov berish bosqichlarini sanab bering va har birining natijasini ayting.
  + CCD va CMOS matritsalar qanday farqlanadi?
  + Global va qatorli zatvorlar qanday farqlanadi? Robotlarda qaysi biri afzal va nima uchun?
  + Bayer filtri nima va u tasvir ruxsatiga qanday taʼsir qiladi?
  + Videodatchikning dinamik diapazoni nimani anglatadi?
  + Aqlli kamera oddiy sanoat kamerasidan nimasi bilan farq qiladi?
  + $f = 600$ piksel, $B = 0","1$ m va $d = 20$ piksel boʻlsa, stereokamera obyektgacha qanday masofani aniqlaydi?
  + Eye-in-hand va eye-to-hand joylashuvlarning afzallik va kamchiliklari nimada?
]
