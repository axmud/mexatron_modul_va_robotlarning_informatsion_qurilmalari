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
  title: "Maʼruza №8. Mexatron modullar va robotlarning texnik köriş tizimlari. Texnik köriş tizimining umumlaşgan struktura sxemasi. Texnik köriş tizimining işlaş tamoyili. Videodatçiklar va videokameralar",
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №8]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarning texnik köriş tizimlari. Texnik köriş tizimining umumlaşgan struktura sxemasi va işlaş tamoyili. Videodatçiklar va videokameralar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Texnik köriş tizimi tuşunçasi va robototexnikadagi vazifalari.
  + Texnik köriş tizimining umumlaşgan struktura sxemasi.
  + Tasvir hosil bölişi: kamera modeli va köriş maydoni.
  + Texnik köriş tizimining işlaş tamoyili: tasvirga işlov beriş bosqiçlari.
  + Videodatçiklar: CCD va CMOS matritsalar, ularning parametrlari.
  + Videokameralar: tuzilişi, turlari va interfeyslari. 3D kameralar.
  + Robotda kamerani joylaştiriş va kalibrlaş.

  *Tayanç iboralar:* texnik köriş tizimi, sahna, yoritiş, obyektiv, fokus masofasi, köriş maydoni, videodatçik, piksel, CCD, CMOS, global va qatorli zatvor, Bayer filtri, dinamik diapazon, kadrlar çastotasi, segmentatsiya, belgilarni ajratiş, tanib oliş, aqlli kamera, stereokamera, dispersiya (disparity), strukturalangan yoruğlik, ToF kamera, eye-in-hand, kalibrlaş.
]

// =====================================================================
= Texnik köriş tizimi tuşunçasi va robototexnikadagi vazifalari
// =====================================================================

*Texnik köriş tizimi* (TKT) — sahna tasvirini oliş, uni qayta işlaş va tahlil qiliş orqali obyektlar haqida axborot oluvçi hamda şu axborot asosida boşqaruv tizimiga maʼlumot yoki buyruq beruvçi apparat-dasturiy kompleks. Inson taşqi dunyo haqidagi axborotning katta qismini köriş orqali olganidek (1-maʼruza), robot uçun ham TKT eng boy axborot manbai hisoblanadi.

Robototexnikada TKT quyidagi asosiy vazifalarni bajaradi:
- *obyektlarni aniqlaş va tanib oliş* — sahnada qanday obyektlar borligini va ularning turini aniqlaş;
- *obyektlarning holati va yönalişini aniqlaş* — robot obyektni uşlaşi uçun uning koordinatalari va buriliş burçagini topiş (masalan, konveyerdan tartibsiz joylaşgan detallarni oliş);
- *sifat nazorati va ölçaş* — detal ölçamlari, nuqsonlari, yorliqlar va ştrix-kodlarni tekşiriş;
- *navigatsiya* — mobil robotning harakat yölini, tösiqlarni va öz örnini aniqlaş;
- *vizual qayta aloqa (visual servoing)* — robot harakatini kamera tasviri asosida real vaqtda boşqariş;
- *inson bilan muloqot* — odamlarni, imo-işoralar va yuz ifodalarini tanib oliş.

TKT kontaktsiz işlaydi, juda katta hajmdagi axborot beradi va bitta datçik bilan köplab turli vazifalarni hal qiliş imkonini beradi. Şu bilan birga, u boşqa datçiklarga qaraganda murakkab işlov beriş algoritmlari va kuçli hisoblaş resurslarini talab qiladi, natijasi esa yoritiş şaroitiga kuçli boğliq.

// =====================================================================
= Texnik köriş tizimining umumlaşgan struktura sxemasi
// =====================================================================

TKT ning umumlaşgan struktura sxemasi 1-rasmda keltirilgan.

#figure(
  diagram(
    spacing: (3.5mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Yoritiş \ tizimi], fill: white, name: <yo>),
    node((1, 0), [Sahna, \ obyekt], fill: lightorange, name: <sa>),
    node((2, 0), [Optik \ tizim], name: <op>),
    node((3, 0), [Video- \ datçik], name: <vd>),
    node((4, 0), [ARO va \ interfeys], name: <if>),
    node((4, 1), [Tasvirga \ işlov beriş], name: <ib>),
    node((3, 1), [Tahlil va \ tanib oliş], name: <ta>),
    node((2, 1), [Robot boşqaruv \ tizimi], fill: lightorange, name: <bt>),
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
  caption: [Texnik köriş tizimining umumlaşgan struktura sxemasi],
) <fig-tkt>

Sxema elementlarining vazifalari:
- *yoritiş tizimi* obyektni kerakli tarzda yoritib, uning muhim belgilarini (çegaralar, sirt nuqsonlari, konturlar) yaqqol körsatadi. Sanoat TKT larida yoritiş töğri tanlansa, keyingi işlov beriş ança soddalaşadi;
- *optik tizim* (obyektiv, filtrlar) sahna tasvirini videodatçik sirtiga tuşiradi;
- *videodatçik* (fotomatritsa) optik tasvirni elektr signallari majmuasiga aylantiradi;
- *ARO va interfeys* signallarni raqamli tasvirga aylantiradi va uni hisoblaş qurilmasiga uzatadi;
- *tasvirga işlov beriş bloki* şovqinni kamaytiradi, tasvir sifatini yaxşilaydi va obyektlarni fondan ajratadi;
- *tahlil va tanib oliş bloki* obyekt belgilarini hisoblaydi, ularni maʼlum obyektlar bilan soliştiradi va obyekt turi, holati, ölçamlari haqida xulosa çiqaradi;
- *robot boşqaruv tizimi* bu xulosa asosida ijro mexanizmining harakatini rejalaştiradi.

Ijro mexanizmi sahnani özgartirgani (obyektni köçirgani) sababli tizim yopiq kontur hosil qiladi: TKT harakat natijasini ham nazorat qiladi.

// =====================================================================
= Tasvir hosil bölişi: kamera modeli va köriş maydoni
// =====================================================================

== Teşikli kamera modeli

Kamera tasvir hosil qilişini tavsiflaş uçun eng sodda va keng qöllanadigan model — *teşikli kamera* (_pinhole_) modeli (2-rasm). Unda sahnadagi har bir nuqtadan kelgan nur bitta nuqta — optik markaz orqali ötib, undan fokus masofasi $f$ uzoqlikdagi tasvir tekisligiga tuşadi.

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
  caption: [Teşikli kamera modeli],
) <fig-pinhole>

Öxşaş uçburçaklardan kamera koordinatalar tizimidagi $P(X, Y, Z)$ nuqtaning tasvirdagi koordinatalari (piksellarda) quyidagiça topiladi:

#eq($ u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y, $)

bu yerda $f_x, f_y$ — piksellarda ifodalangan fokus masofalari, $c_x, c_y$ — optik markazning tasvirdagi proyeksiyasi (boş nuqta). Bu parametrlar kameraning *içki parametrlari* deyiladi va kalibrlaş orqali aniqlanadi. (1) ifodadan muhim xulosa kelib çiqadi: bitta kamera tasviridan $X slash Z$ va $Y slash Z$ nisbatlarini topiş mumkin, lekin masofa $Z$ ning özini — yöq. Çuqurlikni aniqlaş uçun qöşimça axborot (ikkinçi kamera, strukturalangan yoruğlik, obyektning maʼlum ölçami) kerak. Real obyektivlar şuningdek tasvirni biroz egadi (distorsiya); bu ham kalibrlaş orqali tuzatiladi.

== Köriş maydoni va fazoviy ruxsat

Videodatçik kengligi $w$ va obyektiv fokus masofasi $f$ bölsa, gorizontal *köriş maydoni* burçagi:

#eq($ "FOV" = 2 dot "arctg" w / (2 f). $)

$Z$ masofada kamera köradigan sahna kengligi va bitta pikselga töğri keladigan obyekt ölçami (fazoviy ruxsat):

#eq($ W = Z dot w / f, quad Delta = W / N_x, $)

bu yerda $N_x$ — gorizontal piksellar soni.

*Misol.* Kengligi $w = 6","4$ mm bölgan matritsa va $f = 8$ mm obyektiv uçun $"FOV" = 2 "arctg"(3","2 slash 8) approx 43","6 degree$. $Z = 1$ m masofada sahna kengligi $W = 1000 dot 6","4 slash 8 = 800$ mm. Matritsa gorizontal böyiça 1280 piksel bölsa, $Delta = 800 slash 1280 approx 0","63$ mm/piksel. Demak, bu kamera bilan 1 m masofada taxminan 1 mm dan kiçik nuqsonni işonçli aniqlab bölmaydi. Kiçikroq detallarni köriş uçun fokus masofasi kattaroq obyektiv, köproq pikselli matritsa yoki kameraning obyektga yaqinroq joylaşuvi kerak — lekin bunda köriş maydoni torayadi.

*Obyektivning* boşqa muhim parametrlari: diafragma soni $N = f slash D$ ($D$ — kiriş teşigi diametri) — u matritsaga tuşadigan yoruğlik miqdorini va keskinlik çuqurligini belgilaydi: diafragma kiçraytirilsa ($N$ katta), keskinlik çuqurligi ortadi, lekin tasvir qoronğiroq böladi.

// =====================================================================
= Texnik köriş tizimining işlaş tamoyili
// =====================================================================

== Raqamli tasvir

Raqamli tasvir — piksellar matritsasi. Kulrang tasvirda har bir piksel $I(x, y)$ yoruğlik intensivligini ifodalaydi va odatda 8 bit bilan kodlanadi (0 — qora, 255 — oq). Rangli tasvirda har bir piksel uçta komponentdan (qizil, yaşil, kök — RGB) iborat va odatda 24 bit egallaydi. Çuqurlik kamerasida esa har bir piksel qiymati obyektgaça masofani bildiradi. 3-maʼruzada körsatilganidek, rangli Full HD tasvirlar oqimi sekundiga gigabitlar tartibidagi maʼlumot hosil qiladi, şuning uçun işlov beriş algoritmlarining samaradorligi muhim.

== Tasvirga işlov beriş bosqiçlari

TKT da axborot pastki (piksellar) sathdan yuqori (obyektlar va sahna) sathga qarab bosqiçma-bosqiç qayta işlanadi (1-jadval). Har bir bosqiçda maʼlumot hajmi kamayadi, uning mazmuni esa boyiydi.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.1fr),
    header: ([Bosqiç], [Mazmuni], [Natija]),
    [1. Tasvirni oliş],
    [Yoritiş, ekspozitsiya, kadrni kiritiş],
    [Raqamli tasvir],
    [2. Oldindan işlov beriş],
    [Şovqinni filtrlaş, kontrast va yorqinlikni tuzatiş, distorsiyani tuzatiş],
    [Sifati yaxşilangan tasvir],
    [3. Segmentatsiya],
    [Tasvirni sohalarga ajratiş: obyektni fondan ajratiş (çegaraviy qiymat, çegaralarni aniqlaş)],
    [Obyektlar sohalari, konturlar],
    [4. Belgilarni ajratiş],
    [Obyekt yuzasi, perimetri, markazi, yönalişi, şakl va rang belgilari, xarakterli nuqtalar],
    [Belgilar vektori],
    [5. Tanib oliş],
    [Belgilarni namunalar bilan soliştiriş, tasniflaş (şu jumladan neyron tarmoqlar yordamida)],
    [Obyekt turi va holati],
    [6. Sahnani talqin qiliş],
    [Obyektlar orasidagi munosabatlar, harakat, robot uçun qaror],
    [Boşqaruv uçun axborot],
  ),
  caption: [Texnik köriş tizimida tasvirga işlov beriş bosqiçlari],
) <tab-bosqich>

Masalan, konveyerdagi detalni olişda TKT tasvirni oladi, uni çegaraviy qiymat böyiça ikkilik (qora-oq) tasvirga aylantiradi, detal sohasini ajratadi, uning markazi koordinatalari va asosiy öqining buriliş burçagini hisoblaydi, detal turini şakl belgilari böyiça aniqlaydi va bu maʼlumotlarni kalibrlaş orqali robot koordinatalariga ötkazib, boşqaruv tizimiga beradi. Klassik algoritmlar bilan bir qatorda hozirgi kunda 3–6 bosqiçlarni çuqur neyron tarmoqlar birgalikda bajarişi tobora keng tarqalmoqda. Tasvirga işlov beriş va tanib oliş algoritmlari keyingi maʼruzalarda batafsil köriladi.

// =====================================================================
= Videodatçiklar
// =====================================================================

== Işlaş prinsipi

*Videodatçik* (fotomatritsa) — tekislikda qator va ustunlar böyiça joylaşgan köplab fotosezgir elementlar (piksellar) majmuasi. Har bir pikselga tuşgan yoruğlik fotoeffekt hisobiga zaryad hosil qiladi; zaryad *ekspozitsiya vaqti* davomida töplanadi va unga tuşgan yoruğlik miqdoriga proporsional böladi. Söngra zaryadlar öqiladi, kuçlanişga aylantiriladi va raqamlanadi. Zaryadni öqiş usuliga köra ikki asosiy turdagi matritsa mavjud.

*CCD matritsa* (zaryad boğlangan qurilma) — töplangan zaryadlar matritsa böylab qatorma-qator bitta yoki bir neçta çiqiş kuçaytirgiçiga ketma-ket köçiriladi. *CMOS matritsa* — har bir pikselda özining kuçaytirgiçi bor, piksellar esa xotira kabi qator va ustun manzili böyiça öqiladi; ARO va boşqariş sxemalari bitta kristallda joylaşadi.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Körsatkiç], [CCD], [CMOS]),
    [Zaryadni öqiş],
    [Ketma-ket köçiriş, umumiy kuçaytirgiç],
    [Har bir pikselda kuçaytirgiç, manzil böyiça],
    [Integratsiya],
    [Taşqi elektronika kerak],
    [ARO va boşqariş kristallda],
    [Energiya isteʼmoli],
    [Yuqori],
    [Past],
    [Tezlik],
    [Örtaça],
    [Yuqori; tasvirning bir qismini (ROI) öqiş mumkin],
    [Narxi],
    [Yuqoriroq],
    [Past (ommaviy texnologiya)],
    [Bugungi holati],
    [Maxsus ilmiy va tibbiy qöllaniş],
    [Robototexnika va sanoatda asosiy tur],
  ),
  caption: [CCD va CMOS videodatçiklarini taqqoslaş],
) <tab-ccd>

== Zatvor turi

Harakatlanuvçi robotlar va obyektlar uçun matritsaning *zatvor turi* muhim:
- *global zatvor* — barça piksellar bir vaqtda ekspozitsiya qilinadi; tez harakatlanayotgan obyektlar buzilmasdan tasvirlanadi;
- *qatorli zatvor* (_rolling shutter_) — qatorlar navbatma-navbat ekspozitsiya qilinadi; arzonroq va sezgirroq, lekin tez harakatda tasvir qiyşayadi (masalan, vertikal ustun egik körinadi).

Konveyer, tez harakatlanuvçi manipulyator yoki dronga örnatilgan kameralarda global zatvorli matritsalar afzal.

== Rangli tasvir oliş

Fotosezgir element yoruğlik rangini farqlamaydi. Rangli tasvir oliş uçun köpinça matritsa ustiga *Bayer filtri* — qizil, yaşil va kök mikrofiltrlar mozaikasi qöyiladi: piksellarning 50 % i yaşil, 25 % i qizil va 25 % i kök filtr ostida böladi (inson közi yaşil rangga eng sezgir). Har bir pikselning yetişmayotgan rang komponentlari qöşni piksellar böyiça interpolyatsiya qilinadi. Şu sababli rangli kameraning haqiqiy fazoviy ruxsati monoxrom kameranikidan biroz past; ölçaş vazifalarida köpinça monoxrom kameralar işlatiladi.

== Videodatçiklarning asosiy parametrlari

- *Ruxsat (piksellar soni)* — masalan, 1280 × 1024 yoki 5 Mpiksel; fazoviy ruxsatni belgilaydi.
- *Piksel ölçami* — odatda bir neça mikrometr; katta piksel köproq yoruğlik yiğadi va şovqini kamroq.
- *Matritsa formati* — fizik ölçami; köriş maydonini va obyektiv tanlovini belgilaydi.
- *Kadrlar çastotasi* — sekundiga kadrlar soni; tez jarayonlarni kuzatiş imkoniyati.
- *Kvant samaradorligi va sezgirlik* — tuşgan fotonlarning qança qismi elektronga aylanişi.
- *Spektral diapazon* — körinadigan, yaqin infraqizil yoki issiqlik (uzoq infraqizil) diapazoni.
- *Dinamik diapazon* — matritsa bir kadrda farqlay oladigan eng yoruğ va eng xira signallar nisbati:

#eq($ "DR" = 20 lg N_max / N_"ş" quad ["dB"], $)

bu yerda $N_max$ — piksel töplay oladigan eng katta zaryad (elektronlarda), $N_"ş"$ — şovqin darajasi. *Misol.* $N_max = 10 000$ e⁻ va $N_"ş" = 5$ e⁻ bölsa, $"DR" = 20 lg 2000 approx 66$ dB. Kiçik dinamik diapazonli kamera bir vaqtda yorqin deraza va qoronği burçakni yaxşi körsata olmaydi; bunday şaroitlar uçun keng dinamik diapazonli (HDR) kameralar işlatiladi.

// =====================================================================
= Videokameralar
// =====================================================================

== Tuzilişi va turlari

*Videokamera* obyektiv, optik filtrlar, videodatçik, uni boşqaruvçi va signalga işlov beruvçi elektronika hamda maʼlumot uzatiş interfeysidan iborat. TKT larda qöllanadigan kameralar quyidagi turlarga bölinadi:
- *sanoat (maşinaviy köriş) kameralari* — tasvirni kompyuterga uzatadi, işlov esa kompyuterda bajariladi; parametrlari (ekspozitsiya, kuçaytiriş, trigger) dasturiy boşqariladi;
- *aqlli (smart) kameralar* — protsessor va tasvirga işlov beriş dasturi kamera içida joylaşgan; kontrollerga faqat natija (masalan, «detal yaroqli», detal koordinatalari) uzatiladi. Ular intellektual datçiklarning (7-maʼruza) texnik köriş sohasidagi namunasidir;
- *3D (çuqurlik) kameralari* — har bir piksel uçun masofani beradi;
- *issiqlik (termal) kameralari* — uzoq infraqizil nurlaniş böyiça harorat taqsimotini körsatadi; qoronğilikda odamlarni aniqlaş va qizigan qismlarni nazorat qiliş uçun.

Raqamli kameralar kompyuterga standart interfeyslar orqali ulanadi: *GigE Vision* (Ethernet, uzun kabellar), *USB3 Vision* (oddiy ulaniş), *Camera Link* va *CoaXPress* (juda yuqori tezlik), şuningdek örnatilgan tizimlar uçun *MIPI CSI-2*.

== 3D kameralar

Teşikli kamera modelidan körinadiki, bitta oddiy kamera masofani bevosita ölçamaydi. Çuqurlik axborotini oliş uçun quyidagi usullar qöllanadi.

*Stereokamera* — bir-biridan $B$ masofada (baza) joylaşgan ikkita kamera. Bir nuqta çap va öng tasvirlarda turli joylarda körinadi; bu farq *dispersiya* (_disparity_) $d$ deyiladi. Nuqtagaça masofa:

#eq($ Z = (f dot B) / d, $)

bu yerda $f$ — piksellarda ifodalangan fokus masofasi, $d$ — piksellardagi dispersiya. Dispersiyani $Delta d$ xatolik bilan aniqlaş masofa xatoligiga olib keladi:

#eq($ Delta Z approx Z^2 / (f dot B) dot Delta d. $)

*Misol.* $f = 700$ piksel, $B = 0","12$ m va $d = 42$ piksel bölsa, $Z = 700 dot 0","12 slash 42 = 2$ m. Dispersiya 0,25 piksel aniqlikda topilsa, $Delta Z approx 4 slash 84 dot 0","25 approx 1","2$ sm. Xuddi triangulyatsiyadagi kabi (6-maʼruza), masofa ortişi bilan xatolik kvadratik ortadi; uni kamaytiriş uçun bazani yoki fokus masofasini kattalaştiriş kerak. Stereokamera passiv işlaydi, lekin teksturasiz (bir xil rangli) sirtlarda mos nuqtalarni topiş qiyin.

*Strukturalangan yoruğlik kamerasi* obyektga maʼlum naqş (çiziqlar, nuqtalar) proyeksiyalaydi va naqşning buzilişi böyiça triangulyatsiya orqali çuqurlikni hisoblaydi. U teksturasiz sirtlarda ham işlaydi va yaqin masofada yuqori aniqlik beradi, lekin kuçli quyoş nurida yomonlaşadi.

*ToF kamera* har bir pikselda modulyatsiyalangan yoruğlikning borib-qaytiş vaqtini (faza siljişini) ölçaydi (6-maʼruza). U ixçam va tezkor, çuqurlik xaritasini bevosita beradi, lekin ruxsat qobiliyati odatda past.

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Usul], [Prinsip], [Afzalligi], [Çeklovi]),
    [Stereokamera],
    [Ikki tasvirdagi dispersiya],
    [Passiv, taşqarida işlaydi],
    [Teksturasiz sirt, hisoblaş murakkab],
    [Strukturalangan yoruğlik],
    [Proyeksiyalangan naqş triangulyatsiyasi],
    [Yaqin masofada yuqori aniqlik],
    [Quyoş nuriga sezgir],
    [ToF kamera],
    [Yoruğlikning borib-qaytiş vaqti],
    [Ixçam, tez, bevosita çuqurlik],
    [Past ruxsat, köp marta aks etiş xatoligi],
  ),
  caption: [3D kameralarning turlari],
) <tab-3d>

// =====================================================================
= Robotda kamerani joylaştiriş va kalibrlaş
// =====================================================================

Robotga nisbatan kamera ikki xil joylaştiriladi:
- *qözğalmas kamera* (_eye-to-hand_) — robot işçi zonasi tepasida yoki yonida örnatiladi; butun zonani va robotning özini köradi, lekin robot qöli obyektni tösib qolişi mumkin;
- *robot qölidagi kamera* (_eye-in-hand_) — robot bilagi yoki tutqiçiga örnatiladi; obyektga yaqinlaşib, uni katta ruxsat bilan köradi, lekin köriş maydoni tor va kamera harakatlanadi.

TKT natijalarini robot işlata olişi uçun tizim *kalibrlanadi*:
+ *içki kalibrlaş* — kameraning fokus masofalari, boş nuqtasi va distorsiya koeffitsientlarini aniqlaş (odatda şaxmat taxtasi şaklidagi kalibrlaş namunasi yordamida);
+ *taşqi kalibrlaş* — kamera koordinatalar tizimining robot koordinatalar tizimiga nisbatan joylaşuvi va yönalişini aniqlaş (_hand-eye_ kalibrlaş).

Kalibrlaş xatoligi bevosita robot pozitsiyalaş xatoligiga aylanadi, şuning uçun kamera yoki robot qayta örnatilganda, şuningdek muntazam ravişda kalibrlaş tekşiriladi.

// =====================================================================
= Xulosa
// =====================================================================

Texnik köriş tizimi robotga eng boy axborot beradi: obyektlarni tanib oliş, ularning holatini aniqlaş, sifat nazorati va navigatsiya uçun. Uning umumlaşgan tuzilişi yoritiş, optik tizim, videodatçik, raqamlaş, tasvirga işlov beriş, tahlil va robot boşqaruv tizimidan iborat. Tasvir hosil bölişi teşikli kamera modeli bilan tavsiflanadi; köriş maydoni va fazoviy ruxsat matritsa ölçami, obyektiv fokus masofasi va masofaga boğliq. TKT ning işlaş tamoyili tasvirni bosqiçma-bosqiç — oliş, oldindan işlov, segmentatsiya, belgilarni ajratiş, tanib oliş va talqin qiliş orqali — qayta işlaşdan iborat.

Zamonaviy TKT larda asosan CMOS videodatçiklar qöllanadi; ularning ruxsati, piksel ölçami, zatvor turi, kadrlar çastotasi va dinamik diapazoni vazifaga mos tanlanadi. Videokameralar sanoat, aqlli, 3D va termal turlarga bölinadi; çuqurlik axborotini stereokameralar, strukturalangan yoruğlik va ToF kameralari beradi. Robotda kamera qözğalmas yoki robot qöliga örnatiladi va içki hamda taşqi kalibrlaş talab qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Texnik köriş tizimi robototexnikada qanday vazifalarni bajaradi?
  + TKT ning umumlaşgan struktura sxemasini çizing va elementlarining vazifasini tuşuntiring.
  + Yoritiş tizimi TKT da qanday ahamiyatga ega?
  + Teşikli kamera modelini tuşuntiring. Nima uçun bitta kamera masofani bevosita ölçay olmaydi?
  + $w = 8","8$ mm matritsa va $f = 16$ mm obyektiv uçun gorizontal köriş maydonini va 2 m masofadagi sahna kengligini toping.
  + Tasvirga işlov beriş bosqiçlarini sanab bering va har birining natijasini ayting.
  + CCD va CMOS matritsalar qanday farqlanadi?
  + Global va qatorli zatvorlar qanday farqlanadi? Robotlarda qaysi biri afzal va nima uçun?
  + Bayer filtri nima va u tasvir ruxsatiga qanday taʼsir qiladi?
  + Videodatçikning dinamik diapazoni nimani anglatadi?
  + Aqlli kamera oddiy sanoat kamerasidan nimasi bilan farq qiladi?
  + $f = 600$ piksel, $B = 0","1$ m va $d = 20$ piksel bölsa, stereokamera obyektgaça qanday masofani aniqlaydi?
  + Eye-in-hand va eye-to-hand joylaşuvlarning afzallik va kamçiliklari nimada?
]
