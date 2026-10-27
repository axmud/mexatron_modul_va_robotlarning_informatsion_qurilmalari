// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №4. Informatsion qurilmalarning turlari va xususiyatlari.
//             Birlamchi oʻzgartirgichlar. Informatsion qurilmalarning vazifalari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №4. Informatsion qurilmalarning turlari va ularning xususiyatlari. Birlamçi özgartirgiçlar (datçiklar, sensorlar). Informatsion qurilmalarning asosiy vazifalari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 4  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №4]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Informatsion qurilmalarning turlari va ularning xususiyatlari. Birlamçi özgartirgiçlar (datçiklar, sensorlar). Informatsion qurilmalarning asosiy vazifalari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion qurilmalarning turlari.
  + Birlamçi özgartirgiç tuşunçasi va uning tuzilişi.
  + Parametrik birlamçi özgartirgiçlar.
  + Generatorli birlamçi özgartirgiçlar.
  + Birlamçi özgartirgiçlarning asosiy xususiyatlari.
  + Informatsion qurilmalarning asosiy vazifalari.
  + Birlamçi özgartirgiçni tanlaş: robot böğini misolida.

  *Tayanç iboralar:* informatsion qurilma, birlamçi özgartirgiç, datçik, sensor, sezgir element, oraliq özgartirgiç, normallaştiruvçi özgartirgiç, özgartiriş zanjiri, sezgirlik, rezistiv, siğim, induktiv, termoelektrik, piezoelektrik, Xoll va induksion özgartirgiçlar, statik va dinamik tavsif, vaqt doimiysi, normallaştiriş, signalizatsiya.
]

// =====================================================================
= Informatsion qurilmalarning turlari
// =====================================================================

Oldingi maʼruzada robotning informatsion tizimi informatsion-ölçaş kanallaridan taşkil topişi körsatilgan edi. Kanalning har bir böğini alohida *informatsion qurilma* bölib, öz vazifasini bajaradi. Bajaradigan vazifasi va kanaldagi örniga köra informatsion qurilmalar quyidagi turlarga bölinadi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.4fr, 1.2fr),
    header: ([Qurilma turi], [Vazifasi], [Misollar]),
    [Birlamçi özgartirgiç (datçik)],
    [Ölçanayotgan kattalikni bevosita qabul qilib, uni ölçaş uçun qulay signalga aylantiradi],
    [Tenzorezistor, termojuft, enkoder, fotodiod],

    [Oraliq (normallaştiruvçi) özgartirgiç],
    [Signalni kuçaytiradi, filtrlaydi va standart körinişga keltiradi],
    [Ölçaş köprigi, instrumental kuçaytirgiç, 4–20 mA özgartirgiçi],

    [Analog-raqamli özgartirgiç],
    [Analog signalni raqamli kodga aylantiradi],
    [Mikrokontrollerning ARO moduli, alohida ARO mikrosxemalari],

    [Axborotni uzatiş qurilmasi],
    [Axborotni masofaga uzatadi],
    [CAN, EtherCAT, IO-Link interfeyslari, simsiz modullar],

    [Axborotni qayta işlaş qurilmasi],
    [Axborotni filtrlaydi, kalibrlaydi, tahlil qiladi va qaror qabul qiladi],
    [Mikrokontroller, signal protsessori, PLC, robot kontrolleri],

    [Aks ettiriş va signalizatsiya qurilmasi],
    [Axborotni operatorga körsatadi yoki çegaraviy holat haqida ogohlantiradi],
    [Displey, operator pulti, yoruğlik va tovuş signalizatorlari],
  ),
  caption: [Informatsion qurilmalarning turlari],
) <tab-turlar>

Bu qurilmalardan *birlamçi özgartirgiç* alohida örin tutadi: u ölçanayotgan obyekt bilan bevosita aloqada böladi va butun kanalning imkoniyatlarini belgilaydi. Birlamçi özgartirgiçda yöqotilgan yoki buzilgan axborotni keyingi qurilmalarda tiklab bölmaydi (2-maʼruza). Şu sababli uşbu maʼruzaning asosiy qismi birlamçi özgartirgiçlarga bağişlangan.

// =====================================================================
= Birlamçi özgartirgiç tuşunçasi va uning tuzilişi
// =====================================================================

*Birlamçi özgartirgiç* — ölçaş kanalining birinçi elementi bölib, ölçanayotgan fizik kattalik unga bevosita taʼsir qiladi va u bu kattalikni ölçaş, uzatiş va qayta işlaş uçun qulay boşqa kattalikka (odatda elektr signaliga) aylantiradi.

Amaliyotda «birlamçi özgartirgiç», «datçik» va «sensor» atamalari köpinça bir xil maʼnoda işlatiladi, lekin ular orasida nozik farq bor:
- *birlamçi özgartirgiç* — fizik özgartirişni bajaruvçi element (masalan, tenzorezistorning özi);
- *datçik* — birlamçi özgartirgiç, uni örnatiş uçun korpus va ulaniş elementlari, köpinça oraliq özgartirgiç bilan birga konstruktiv tugallangan qurilma (masalan, kuç datçigi);
- *sensor* — xalqaro adabiyotda kirişi noelektrik, çiqişi elektrik bölgan özgartirgiç; zamonaviy maʼnoda köpinça signalga işlov beriş va raqamli interfeysga ega datçik.

== Özgartiriş zanjiri

Köp hollarda ölçanayotgan kattalik elektr signaliga bir bosqiçda emas, balki bir neçta oraliq kattaliklar orqali aylantiriladi. Birlamçi özgartirgiçning kattalik bevosita taʼsir qiladigan qismi *sezgir element*, keyingi qismlari esa *özgartiriş elementlari* deyiladi. Masalan, robot tutqiçidagi kuç datçigida kuç avval elastik elementning deformatsiyasiga, deformatsiya tenzorezistor qarşiligining özgarişiga, qarşilik özgarişi esa ölçaş köprigida kuçlanişga aylanadi (1-rasm).

#figure(
  diagram(
    spacing: (5mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Kuç \ $F$], fill: white, name: <f>),
    node((1, 0), [Elastik \ element], name: <el>),
    node((2, 0), [Tenzo- \ rezistor], name: <tr>),
    node((3, 0), [Ölçaş \ köprigi], name: <kp>),
    node((4, 0), [Kuçay- \ tirgiç], name: <ku>),
    node((5, 0), [ARO], fill: lightorange, name: <aro>),
    edge(<f>, <el>, "->"),
    edge(<el>, <tr>, "->", [$epsilon$], label-side: left),
    edge(<tr>, <kp>, "->", [$Delta R$], label-side: left),
    edge(<kp>, <ku>, "->", [$U$], label-side: left),
    edge(<ku>, <aro>, "->"),
  ),
  caption: [Kuç datçigidagi özgartiriş zanjiri],
) <fig-zanjir>

Agar zanjirning har bir böğini çiziqli va sezgirligi $S_i$ bölsa, butun zanjirning sezgirligi böğinlar sezgirliklarining köpaytmasiga teng:

#eq($ S = S_1 dot S_2 dot dots dot S_n. $)

(1) ifodadan muhim xulosa kelib çiqadi: har bir böğinning nisbiy xatoligi umumiy natijaga qöşiladi, şuning uçun zanjir qança uzun bölsa, natija şunça köp omillarga boğliq böladi. Zamonaviy datçiklarda zanjirdagi özgartirişlar sonini kamaytirişga va har bir böğinni kalibrlaşga intiladilar.

Birlamçi özgartirgiçlar çiqiş signalining tabiatiga köra ikki katta guruhga bölinadi (3-maʼruza): *parametrik* özgartirgiçlarda kattalik elektr zanjirining parametrini (qarşilik, siğim, induktivlik) özgartiradi va ularni ölçaş uçun taşqi taʼminot manbai kerak; *generatorli* özgartirgiçlar esa ölçanayotgan kattalik taʼsirida özi elektr yurituvçi kuç, zaryad yoki tok hosil qiladi. Quyida har bir guruhning asosiy turlari köriladi.

// =====================================================================
= Parametrik birlamçi özgartirgiçlar
// =====================================================================

== Rezistiv özgartirgiçlar

Rezistiv özgartirgiçlarda ölçanayotgan kattalik ötkazgiç yoki yarimötkazgiçning qarşiligini özgartiradi. Qarşilik $R = rho l slash S$ ifoda bilan aniqlanadi, şuning uçun uni soliştirma qarşilik $rho$, uzunlik $l$ yoki kesim yuzasi $S$ ni özgartiriş orqali boşqariş mumkin.

*Potensiometrik özgartirgiç* — sirpanuvçi kontaktli özgaruvçan rezistor. Uning çiqiş kuçlanişi surgiçning siljişiga proporsional:

#eq($ U_"çiq" = U dot x / L, $)

bu yerda $U$ — taʼminot kuçlanişi, $x$ — surgiç siljişi, $L$ — rezistiv qatlamning töliq uzunligi. Potensiometrlar oddiy va arzon, lekin sirpanuvçi kontakt yeyiladi va şovqin hosil qiladi. Ular öquv robotlari va arzon servoyuritmalarda burçak datçigi sifatida qöllanadi.

*Tenzorezistor* deformatsiyani qarşilik özgarişiga aylantiradi: $Delta R slash R = k dot epsilon$, bu yerda $epsilon$ — nisbiy deformatsiya, $k$ — tenzosezgirlik koeffitsienti (metall tenzorezistorlar uçun $k approx 2$). Qarşilik özgarişi juda kiçik bölgani uçun tenzorezistor ölçaş köprigiga ulanadi. Bitta faol tenzorezistorli (çorak) köprikning çiqiş kuçlanişi:

#eq($ U_"çiq" approx U / 4 dot (Delta R) / R = U / 4 dot k dot epsilon. $)

*Misol.* $U = 5$ V, $k = 2$, $epsilon = 10^(-3)$ bölsa, $U_"çiq" approx 5 slash 4 dot 2 dot 10^(-3) = 2","5$ mV. Bunday kiçik signal albatta kuçaytirilişi kerak. Tenzorezistorlar robotlarning kuç-moment datçiklari, tutqiçlardagi kuç datçiklari va tarozilarning asosini taşkil etadi.

*Termorezistorlar* qarşiligi haroratga boğliq bölgan elementlar: metall termorezistorlar (Pt100) va yarimötkazgiçli termistorlar. Robotlarda ular dvigatellar, drayverlar va akkumulyatorlar haroratini nazorat qilişda qöllanadi.

== Siğim özgartirgiçlar

Siğim özgartirgiç — elektrodlaridan biri ölçanayotgan kattalik taʼsirida siljiydigan kondensator. Yassi kondensatorning siğimi:

#eq($ C = (epsilon_0 epsilon_r S) / d, $)

bu yerda $epsilon_0 = 8","854 dot 10^(-12)$ F/m — elektr doimiysi, $epsilon_r$ — muhitning nisbiy dielektrik singdiruvçanligi, $S$ — elektrodlar yuzasi, $d$ — ular orasidagi masofa. Siğimni $d$, $S$ yoki $epsilon_r$ ni özgartiriş orqali boşqariş mumkin.

*Misol.* $S = 1$ sm², $d = 0","1$ mm, havo ($epsilon_r approx 1$) uçun $C approx 8","85$ pF. Siğim juda kiçik bölgani uçun siğim özgartirgiçlarga maxsus ölçaş sxemalari kerak, lekin ular juda sezgir böladi. Siğim özgartirgiçlar MEMS akselerometr va giroskoplarda, kontaktsiz yaqinlik datçiklarida va robotlarning taktil qoplamalarida keng qöllanadi.

== Induktiv özgartirgiçlar

Induktiv özgartirgiçlarda ölçanayotgan kattalik ğaltakning induktivligini yoki ikki ğaltak orasidagi özaro induktivlikni özgartiradi. Havo tirqişli magnit ötkazgiçli ğaltakning induktivligi taxminan:

#eq($ L approx (w^2 mu_0 S) / delta, $)

bu yerda $w$ — öramlar soni, $mu_0$ — magnit doimiysi, $S$ — tirqiş kesimi, $delta$ — havo tirqişi uzunligi. Yakor siljişi $delta$ ni özgartiradi va induktivlik özgaradi.

Robototexnikada induktiv özgartirgiçlarning quyidagi turlari keng tarqalgan: *induktiv yaqinlik datçiklari* (metall obyektni kontaktsiz seziş), *çiziqli differensial transformator* (LVDT, aniq çiziqli siljiş) va *rezolverlar* (burçak ölçaş uçun aylanuvçi transformator). Ular kontaktsiz, mexanik yeyilmaydi va oğir şaroitlarga çidamli.

// =====================================================================
= Generatorli birlamçi özgartirgiçlar
// =====================================================================

*Termoelektrik özgartirgiç (termojuft)* — ikki xil metalldan yasalgan va bir uçi payvandlangan ötkazgiçlar juftligi. Issiq va sovuq uçlar haroratlari farqi termo-EYuK hosil qiladi (Zeebek effekti):

#eq($ E = alpha (T_1 - T_2), $)

bu yerda $alpha$ — termojuft sezgirligi. K tipidagi termojuft uçun $alpha approx 41$ µV/°C, demak 100 °C farq taxminan 4,1 mV beradi. Termojuftlar keng harorat diapazonida işlaydi va robotlaştirilgan payvandlaş, quyiş kabi jarayonlarda qöllanadi.

*Piezoelektrik özgartirgiç* mexanik kuç taʼsirida yuzasida elektr zaryad hosil qiluvçi kristall (kvars) yoki keramikadan iborat:

#eq($ q = d dot F, $)

bu yerda $d$ — piezomodul. Kvars uçun $d approx 2","3$ pC/N, demak 100 N kuç taxminan 230 pC zaryad hosil qiladi. Zaryad vaqt ötişi bilan oqib ketgani uçun piezoelektrik özgartirgiçlar asosan özgaruvçan (dinamik) kuç, tebraniş, zarba va tezlanişni ölçaşga yaroqli, statik kuçni esa uzoq vaqt ölçay olmaydi. Ular ultratovuş lokatorlarida ham nurlantirgiç va qabul qilgiç sifatida işlatiladi.

*Xoll özgartirgiçi* — magnit maydonga joylaştirilgan, tok ötayotgan yarimötkazgiç plastinka. Unda tok va maydonga perpendikulyar yönalişda Xoll kuçlanişi hosil böladi:

#eq($ U_H = (R_H dot I dot B) / h, $)

bu yerda $R_H$ — Xoll doimiysi, $I$ — plastinkadagi tok, $B$ — magnit induksiyasi, $h$ — plastinka qalinligi. Xoll özgartirgiçi taʼminot tokini talab qilgani uçun qatʼiy aytganda generatorli emas, lekin çiqişda bevosita kuçlaniş beradi. Robotlarda Xoll datçiklari kollektorsiz dvigatellarda rotor holatini aniqlaş, magnit enkoderlar, kontaktsiz çegara datçiklari va tok datçiklarida qöllanadi.

*Induksion özgartirgiç* elektromagnit induksiya qonuniga asoslanadi: ğaltak bilan boğliq magnit oqimi özgarganda unda EYuK hosil böladi:

#eq($ e = -w (d Phi) / (d t). $)

Hosil bölgan EYuK oqimning özgariş tezligiga proporsional bölgani uçun induksion özgartirgiçlar tezlikni ölçaşda qöllanadi: taxogeneratorlar, ğildirak aylaniş tezligi datçiklari (masalan, avtomobil ABS tizimida).

*Fotoelektrik özgartirgiçlar* (fotodiodlar, fototranzistorlar) yoruğlik oqimini tokka aylantiradi. Ular optik enkoderlar, yoruğlik pardalari, optik yaqinlik datçiklari va kameralarning asosidir.

Körib çiqilgan birlamçi özgartirgiçlar 2-jadvalda umumlaştirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1.3fr),
    header: ([Özgartirgiç], [Çiqiş kattaligi], [Robotdagi qöllanilişi]),
    [Potensiometrik],
    [Qarşilik (kuçlaniş bölgiç)],
    [Burçak va çiziqli siljiş],
    [Tenzorezistiv],
    [Qarşilik özgarişi],
    [Kuç-moment datçiklari, tutqiç kuçi],
    [Termorezistiv],
    [Qarşilik],
    [Dvigatel va drayver harorati],
    [Siğim],
    [Siğim],
    [MEMS akselerometrlar, yaqinlik, taktil qoplama],
    [Induktiv],
    [Induktivlik, özaro induktivlik],
    [LVDT, rezolver, induktiv yaqinlik datçigi],
    [Termoelektrik],
    [Termo-EYuK],
    [Texnologik jarayon harorati],
    [Piezoelektrik],
    [Elektr zaryad],
    [Tebraniş, zarba, ultratovuş lokatori],
    [Xoll],
    [Kuçlaniş],
    [BLDC rotor holati, magnit enkoder, tok],
    [Induksion],
    [EYuK],
    [Tezlik datçiklari, taxogenerator],
    [Fotoelektrik],
    [Tok],
    [Optik enkoder, yoruğlik pardasi, kamera],
  ),
  caption: [Asosiy birlamçi özgartirgiçlar],
) <tab-oz>

// =====================================================================
= Birlamçi özgartirgiçlarning asosiy xususiyatlari
// =====================================================================

Birlamçi özgartirgiçning sifati bir qator xususiyatlar (tavsiflar) bilan baholanadi. Ularni uç guruhga ajratiş mumkin.

*Statik xususiyatlar* kiriş kattaligi özgarmas yoki sekin özgarganda çiqiş va kiriş orasidagi boğliqlikni tavsiflaydi: ölçaş diapazoni, statik tavsif (özgartiriş funksiyasi) va uning çiziqliligi, sezgirlik $S = Delta y slash Delta x$, ruxsat qobiliyati, gisterezis, takrorlanuvçanlik, nol siljişi va harorat drifti.

*Dinamik xususiyatlar* kiriş kattaligi tez özgarganda özgartirgiçning xatti-harakatini tavsiflaydi. Köp özgartirgiçlar (termojuft, termorezistor, past çastotali filtrli datçiklar) birinçi tartibli differensial tenglama bilan yetarli aniqlikda tavsiflanadi:

#eq($ tau (d y) / (d t) + y = S dot x, $)

bu yerda $tau$ — vaqt doimiysi. Poğonali kiriş taʼsirida çiqiş $tau$ vaqtda barqaror qiymatning 63 % iga, taxminan $3 tau$ vaqtda esa 95 % iga yetadi. Massa va elastik elementga ega özgartirgiçlar (akselerometrlar, kuç datçiklari) esa ikkinçi tartibli tizim sifatida xususiy çastota va söniş koeffitsienti bilan tavsiflanadi; ular xususiy çastotadan ança past çastotalarda işlatilişi kerak.

*Ekspluatatsion xususiyatlar:* işonçlilik va xizmat muddati, taşqi taʼsirlarga (harorat, namlik, vibratsiya, elektromagnit maydon) çidamlilik, ölçami va massasi, taʼminot talablari, çiqiş signalining turi va interfeysi, narxi.

Statik va dinamik xususiyatlarni aniqlaş va xatoliklarni hisoblaş amaliy maşğulotlarda batafsil örganiladi.

// =====================================================================
= Informatsion qurilmalarning asosiy vazifalari
// =====================================================================

Informatsion qurilmalar robot informatsion tizimida axborot bilan boğliq quyidagi asosiy vazifalarni (funksiyalarni) bajaradi (2-rasm).

#figure(
  diagram(
    spacing: (8mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Qabul qiliş \ va özgartiriş], name: <a>),
    node((1, 0), [Normal- \ laştiriş], name: <b>),
    node((2, 0), [Raqamga \ aylantiriş], name: <c>),
    node((3, 0), [Uzatiş], name: <d>),
    node((3, 1), [Qayta \ işlaş], name: <e>),
    node((1.5, 1), [Saqlaş, \ aks ettiriş], fill: lightorange, name: <f>),
    node((3, 2), [Nazorat, signalizatsiya, \ diagnostika], fill: lightorange, name: <g>),
    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <d>, "->"),
    edge(<d>, <e>, "->"),
    edge(<e>, <f>, "->"),
    edge(<e>, <g>, "->"),
  ),
  caption: [Informatsion qurilmalarning asosiy vazifalari],
) <fig-vazifa>

+ *Axborotni qabul qiliş va özgartiriş* — fizik kattalikni elektr signaliga aylantiriş. Bu vazifani birlamçi özgartirgiç bajaradi.
+ *Normallaştiriş* — signalni kuçaytiriş, filtrlaş, çiziqlaştiriş va standart diapazonga (masalan, 0–10 V yoki 4–20 mA) keltiriş. Standart signal turli datçiklarni bir xil kiriş qurilmalariga ulaş imkonini beradi.
+ *Raqamga aylantiriş* — signalni diskretlaş va kvantlaş (2-maʼruza).
+ *Uzatiş* — axborotni datçikdan boşqaruv tizimiga xalaqitlardan himoyalangan holda yetkaziş. Tok signali (4–20 mA) va raqamli şinalar uzun masofada kuçlaniş signaliga nisbatan xalaqitga çidamliroq.
+ *Qayta işlaş* — raqamli filtrlaş, kalibrlaş tavsifi böyiça tuzatiş, harorat kompensatsiyasi, bir neçta datçik maʼlumotlarini birlaştiriş, belgilarni ajratiş.
+ *Saqlaş va aks ettiriş* — ölçaş natijalarini xotirada saqlaş (jurnal, diagnostika uçun) va operatorga displey yoki pultda körsatiş.
+ *Nazorat, signalizatsiya va diagnostika* — ölçangan qiymatni çegaraviy qiymatlar bilan soliştiriş, çegaradan çiqilganda ogohlantiriş yoki himoyani işga tuşiriş (masalan, dvigatel qizib ketganda töxtatiş), datçikning özi sozligini tekşiriş.

Anʼanaviy tizimlarda bu vazifalar alohida qurilmalarda bajarilgan. Intellektual datçiklarda esa ularning köpçiligi — özgartiriş, normallaştiriş, raqamga aylantiriş, qayta işlaş, öz-özini diagnostika qiliş va raqamli uzatiş — bitta qurilmada birlaştiriladi.

// =====================================================================
= Birlamçi özgartirgiçni tanlaş: robot böğini misolida
// =====================================================================

Bir xil kattalikni turli birlamçi özgartirgiçlar bilan ölçaş mumkin. Töğri tanlov robot vazifasi, iş şaroiti, talab qilinadigan aniqlik va narxga boğliq. Misol tariqasida robot böğini burçagini ölçaş uçun keng qöllanadigan tört xil özgartirgiçni taqqoslaymiz (3-jadval).

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Körsatkiç], [Potensiometr], [Rezolver], [Optik enkoder]),
    [Fizik prinsip],
    [Rezistiv],
    [Induktiv],
    [Fotoelektrik],
    [Kontakt],
    [Sirpanuvçi kontakt],
    [Kontaktsiz],
    [Kontaktsiz],
    [Çiqiş signali],
    [Analog kuçlaniş],
    [Analog sin/cos],
    [Raqamli impuls yoki kod],
    [Ruxsat qobiliyati],
    [Past–örtaça],
    [Yuqori (özgartirgiçga boğliq)],
    [Juda yuqori],
    [Oğir şaroitga çidamlilik],
    [Past (yeyiliş)],
    [Juda yuqori],
    [Örtaça (çang, namlik)],
    [Narxi],
    [Past],
    [Yuqori],
    [Örtaça–yuqori],
    [Odatiy qöllanilişi],
    [Öquv robotlari, oddiy servolar],
    [Oğir şaroitdagi yuritmalar],
    [Sanoat va kollaborativ robotlar],
  ),
  caption: [Robot böğini burçak datçiklarini taqqoslaş],
) <tab-tanlash>

Bulardan taşqari, *magnit enkoderlar* (Xoll yoki magnitorezistiv prinsip asosida) ham keng tarqalgan: ular optik enkoderlarga qaraganda ixçamroq, çang va namlikka çidamliroq, lekin odatda ruxsat qobiliyati pastroq. Tanlovda quyidagi tartibga amal qiliş tavsiya etiladi:
+ ölçanadigan kattalik, diapazon va talab qilinadigan aniqlikni aniqlaş;
+ dinamik talablarni (tezlik, ötkaziş polosasi) aniqlaş;
+ iş şaroitini (harorat, çang, namlik, vibratsiya, elektromagnit maydon) baholaş;
+ örnatiş joyi, ölçam, massa va taʼminot çeklovlarini hisobga oliş;
+ boşqaruv tizimi interfeysiga mos çiqiş signalini tanlaş;
+ narx va işonçlilikni soliştirib, yakuniy qaror qabul qiliş.

// =====================================================================
= Xulosa
// =====================================================================

Informatsion qurilmalar ölçaş kanalidagi örniga köra birlamçi özgartirgiçlar, oraliq özgartirgiçlar, analog-raqamli özgartirgiçlar, uzatiş, qayta işlaş va aks ettiriş qurilmalariga bölinadi. Ular orasida birlamçi özgartirgiç eng muhim böğin hisoblanadi, çunki u butun kanalning imkoniyatlarini belgilaydi.

Birlamçi özgartirgiçlar parametrik (rezistiv, siğim, induktiv) va generatorli (termoelektrik, piezoelektrik, induksion, fotoelektrik) turlarga bölinadi; har bir tur özining fizik qonuniyati, afzalliklari va çeklovlariga ega. Ularning sifati statik, dinamik va ekspluatatsion xususiyatlar bilan baholanadi. Informatsion qurilmalar axborotni qabul qiliş, normallaştiriş, raqamga aylantiriş, uzatiş, qayta işlaş, saqlaş va aks ettiriş hamda nazorat va diagnostika vazifalarini bajaradi. Muayyan robot uçun özgartirgiç vazifa, şaroit, aniqlik va narx talablarini birgalikda hisobga olib tanlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Informatsion qurilmalar ölçaş kanalidagi örniga köra qanday turlarga bölinadi?
  + Birlamçi özgartirgiç, datçik va sensor tuşunçalari qanday farqlanadi?
  + Özgartiriş zanjiri nima? Kuç datçigi misolida tuşuntiring.
  + Zanjirning umumiy sezgirligi qanday aniqlanadi?
  + Parametrik va generatorli birlamçi özgartirgiçlar qanday farqlanadi?
  + Tenzorezistor nima uçun ölçaş köprigiga ulanadi?
  + $U = 10$ V, $k = 2$, $epsilon = 5 dot 10^(-4)$ bölganda çorak köprikning çiqiş kuçlanişini toping.
  + Siğim özgartirgiçning siğimi qanday kattaliklarga boğliq? Robotlarda qayerda qöllanadi?
  + Nima uçun piezoelektrik özgartirgiç statik kuçni ölçaşga yaroqsiz?
  + Xoll özgartirgiçi robotlarda qanday maqsadlarda qöllanadi?
  + Birinçi tartibli özgartirgiçning vaqt doimiysi nimani anglatadi?
  + Informatsion qurilmalarning asosiy vazifalarini sanab bering va har biriga robotdan misol keltiring.
  + Robot böğini uçun potensiometr, rezolver va optik enkoderni taqqoslang.
]
