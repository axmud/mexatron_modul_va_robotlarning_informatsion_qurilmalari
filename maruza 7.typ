// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №7. Akustik, sigʻim, induktiv va Xoll datchiklari.
//             Intellektual datchiklar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №7. Akustik datçiklar, siğim datçiklari, induktiv datçiklar va Xoll datçiklari. Intellektual datçiklar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 7  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №7]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Akustik datçiklar, siğim datçiklari, induktiv datçiklar \ va Xoll datçiklari. Intellektual datçiklar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Akustik (ultratovuş) datçiklar.
  + Siğim datçiklari va ularning ölçaş sxemalari.
  + Induktiv datçiklar. Induktiv yaqinlik datçiklari.
  + Xoll datçiklari va ularning robototexnikadagi qöllanilişi.
  + Yaqinlik va masofa datçiklarini taqqoslaş.
  + Intellektual datçiklar: tuzilişi, funksiyalari va interfeyslari.

  *Tayanç iboralar:* ultratovuş, piezoelektrik özgartirgiç, aks-sado, tovuş tezligi, ölik zona, siğim datçigi, differensial kondensator, RC-generator, yaqinlik datçigi, uyurma toklar, LC-kontur, işga tuşiş masofasi, tuzatiş koeffitsienti, Xoll kaliti, çiziqli Xoll datçigi, kommutatsiya, tok datçigi, intellektual datçik, TEDS, IO-Link, öz-özini diagnostika.
]

// =====================================================================
= Akustik (ultratovuş) datçiklar
// =====================================================================

*Akustik datçiklar* tovuş tölqinlari yordamida axborot oladi. Robototexnikada ularning eng keng tarqalgan turi — çastotasi 20 kHz dan yuqori bölgan *ultratovuş* tölqinlaridan foydalanadigan masofa ölçagiçlar va yaqinlik datçiklari. Bundan taşqari, mikrofonlar ovozli buyruqlarni qabul qiliş va tovuş manbaini aniqlaşda, akustik emissiya datçiklari esa mexanizmlardagi nosozliklarni (podşipnik yeyilişi, yoriqlar) aniqlaşda qöllanadi.

== Işlaş prinsipi

Ultratovuş datçigida piezoelektrik özgartirgiç qisqa ultratovuş impulsini (odatda 40 kHz atrofida) nurlantiradi, keyin qabul qilgiç rejimiga ötib, obyektdan qaytgan aks-sadoni kutadi. Impuls yuborilgandan aks-sado qabul qilingunga qadar ötgan vaqt $t$ ölçanadi va masofa topiladi:

#eq($ D = (v dot t) / 2, $)

bu yerda $v$ — havoda tovuş tezligi. Tovuş tezligi harorat $T$ (°C) ga sezilarli boğliq:

#eq($ v approx 331","3 + 0","606 dot T quad ["m/s"]. $)

*Misol.* 20 °C da $v approx 343","4$ m/s. Aks-sado $t = 5","83$ ms dan keyin qaytsa, $D = 343","4 dot 0","00583 slash 2 approx 1","0$ m. Agar datçik 20 °C uçun sozlangan bölib, havo harorati 30 °C ($v approx 349","5$ m/s) bölsa, masofa taxminan 1,8 % ga kam ölçanadi. Şuning uçun aniq ultratovuş datçiklarida harorat datçigi orqali tovuş tezligi kompensatsiya qilinadi.

Ultratovuş tölqin uzunligi:

#eq($ lambda = v / f. $)

40 kHz uçun $lambda = 343 slash 40 000 approx 8","6$ mm. Tölqin uzunligidan ança kiçik obyektlar yaxşi aks ettirmaydi, tölqin uzunligi esa datçikning köndalang ruxsat qobiliyatini ham çeklaydi.

== Xususiyatlari va çeklovlari

Ultratovuş datçiklarining muhim xususiyatlari:
- *ölik zona* — nurlantirgiç impulsdan keyin bir muddat tebranişda davom etadi va bu vaqtda aks-sadoni qabul qila olmaydi; şuning uçun datçik juda yaqin obyektlarni (odatda bir neça santimetrgaça) körmaydi;
- *nurlaniş konusi* — ultratovuş keng konus (bir neça ön gradus) böylab tarqaladi; bu katta zonani qamrab oliş imkonini beradi, lekin obyektning aniq yönalişini aniqlaşni qiyinlaştiradi;
- *aks ettiriş xususiyatlari* — silliq sirt tölqinni közgudek aks ettiradi va qiya joylaşsa, aks-sado datçikka qaytmaydi; yumşoq ğovak materiallar (mato, porolon) tovuşni yutadi;
- *tezkorlik* — tovuş sekin tarqalgani uçun ölçaş sikli yoruğlikka asoslangan datçiklarga qaraganda ança uzun: 5 m masofa uçun bitta ölçaş taxminan 30 ms davom etadi;
- *özaro xalaqit* — bir neçta ultratovuş datçigi bir vaqtda işlasa, biri ikkinçisining signalini qabul qilib qolişi mumkin; şuning uçun ular navbatma-navbat işga tuşiriladi.

Ultratovuş datçiklari optik datçiklardan farqli ravişda obyekt rangi va şaffofligiga boğliq emas: şişa, şaffof plastik va suyuqlik sathini işonçli aniqlaydi, çang va tutunda ham işlaydi. Ular arzon va sodda bölgani uçun mobil robotlarda yaqin tösiqlarni aniqlaş, avtomobillarda parkovka tizimlari va sanoatda sath ölçaş uçun keng qöllanadi.

// =====================================================================
= Siğim datçiklari va ularning ölçaş sxemalari
// =====================================================================

== Siğim özgartirgiçlarning turlari

Yassi kondensator siğimi $C = epsilon_0 epsilon_r S slash d$ (4-maʼruza) uçta parametrga boğliq, şunga köra siğim datçiklarining uç turi mavjud:
- *tirqişi özgaruvçan* — elektrodlar orasidagi masofa $d$ özgaradi; sezgirlik yuqori, lekin tavsif noçiziqli ($C ~ 1 slash d$);
- *yuzasi özgaruvçan* — elektrodlarning ustma-ust tuşgan yuzasi $S$ özgaradi; tavsif çiziqli, katta siljişlarni ölçaş mumkin (siğim enkoderlari, çiziqli şkalalar);
- *dielektrigi özgaruvçan* — elektrodlar orasidagi muhit $epsilon_r$ özgaradi; suyuqlik va soçiluvçan materiallar sathi, namlik, metall bölmagan obyektlar yaqinligini aniqlaş.

== Differensial siğim datçigi

Tirqişi özgaruvçan datçikning noçiziqliligini yöqotiş uçun *differensial* sxema qöllanadi: harakatlanuvçi elektrod ikkita qözğalmas elektrod örtasida joylaşadi. U $x$ ga siljiganda bir kondensator tirqişi kamayadi, ikkinçisiniki ortadi:

#eq($ C_1 = (epsilon S) / (d - x), quad C_2 = (epsilon S) / (d + x), quad (C_1 - C_2) / (C_1 + C_2) = x / d. $)

Şunday qilib, siğimlar ayirmasining yiğindisiga nisbati siljişga *qatʼiy çiziqli* boğliq, bundan taşqari harorat va dielektrik singdiruvçanlik özgarişining taʼsiri ham kamayadi. Masalan, $d = 1$ mm, $x = 0","1$ mm bölsa, nisbat aniq 0,1 ga teng. Aynan şu sxema MEMS akselerometr va giroskoplarda (6-maʼruza) qöllanadi.

== Ölçaş sxemalari

Siğim datçiklarining siğimi va uning özgarişi juda kiçik (pikofaradlar va undan kam), şuning uçun maxsus sxemalar kerak:
- *RC- yoki LC-generatorlar* — siğim generator çastotasini belgilaydi, çastota esa raqamli usulda oson va aniq ölçanadi;
- *özgaruvçan tok köprigi* — differensial datçiklar uçun;
- *zaryadni köçiriş (charge transfer) va sigma-delta özgartirgiçlar* — zamonaviy siğim ölçaş mikrosxemalari bilvosita siğimni raqamga aylantiradi.

Ulovçi kabellarning parazit siğimi datçik siğimi bilan soliştirarli bölişi mumkin, şuning uçun ölçaş elektronikasi datçikka iloji boriça yaqin joylaştiriladi va ekranlanadi.

== Robototexnikada qöllanilişi

*Siğim yaqinlik datçiklari* metall va metall bölmagan obyektlarni kontaktsiz sezadi. *Sensorli (touch) panellar* va *robotlarning siğim «terisi»* insonning yaqinlaşişi yoki tegişini sezadi: inson tanasi elektrodlar siğimini özgartiradi. Kollaborativ robotlarda bunday qoplama robot insonga tegişidan oldin uni sekinlaştiriş imkonini beradi. Siğim prinsipi MEMS inersial datçiklar, bosim datçiklari va taktil matritsalarning ham asosidir.

// =====================================================================
= Induktiv datçiklar. Induktiv yaqinlik datçiklari
// =====================================================================

== Induktiv datçiklarning turlari

Induktiv datçiklar magnit maydon va elektromagnit induksiya hodisalariga asoslanadi. Ularning asosiy turlari:
- *magnit qarşiligi özgaruvçan datçiklar* — yakor siljiganda magnit zanjir tirqişi va ğaltak induktivligi özgaradi (4-maʼruza); noçiziqlilikni kamaytiriş uçun differensial sxemada quriladi;
- *transformatorli datçiklar* — LVDT va rezolverlar (5-maʼruza);
- *uyurma tokli datçiklar* — yuqori çastotali maydon ötkazuvçi obyektda uyurma toklar hosil qiladi; ular ğaltak parametrlarini özgartiradi; metall obyektgaça masofa va tebranişlarni kontaktsiz, mikrometr aniqlikda ölçaydi;
- *induksion datçiklar* — magnit oqim özgarganda EYuK hosil qiladi; tezlik va tişli ğildirak tişlarini sanaş uçun (6-maʼruza).

== Induktiv yaqinlik datçigi

*Induktiv yaqinlik datçigi* robototexnika va sanoat avtomatikasidagi eng köp işlatiladigan diskret datçiklardan biri. U LC-generator, uning ğaltagi joylaşgan oçiq ferrit özak, demodulyator, komparator (Şmitt triggeri) va çiqiş kaliti (PNP yoki NPN) dan iborat. Generator ğaltagi datçik oldida yuqori çastotali magnit maydon hosil qiladi. Rezonans çastotasi:

#eq($ f_0 = 1 / (2 pi sqrt(L C)). $)

Metall obyekt maydonga kirganda unda uyurma toklar hosil böladi va ular generator energiyasini söradi: tebraniş amplitudasi kamayadi. Amplituda belgilangan çegaradan pastga tuşganda komparator çiqiş kalitini ulaydi.

Datçikning pasportida körsatilgan *nominal işga tuşiş masofasi* $S_n$ standart pölat namuna uçun belgilanadi. Boşqa metallar uyurma toklarga boşqaça javob bergani uçun haqiqiy masofa kiçikroq böladi:

#eq($ S_r = k_m dot S_n, $)

bu yerda $k_m$ — material tuzatiş koeffitsienti. Uning taxminiy qiymatlari 1-jadvalda keltirilgan (aniq qiymatlar datçik turiga boğliq va uning pasportida beriladi).

#figure(
  btable(
    columns: (1fr, auto),
    align: (left, center),
    header: ([Obyekt materiali], [Tuzatiş koeffitsienti $k_m$ (taxminan)]),
    [Konstruksion pölat],
    [1,0],
    [Zanglamaydigan pölat],
    [0,6…0,9],
    [Latun],
    [0,35…0,5],
    [Alyuminiy],
    [0,3…0,45],
    [Mis],
    [0,25…0,4],
  ),
  caption: [Induktiv yaqinlik datçigi uçun material tuzatiş koeffitsientlari],
) <tab-km>

*Misol.* $S_n = 8$ mm bölgan datçik alyuminiy detalni ($k_m approx 0","4$) taxminan $S_r approx 3","2$ mm masofadan sezadi. Datçikni örnatişda bu albatta hisobga olinişi kerak. Induktiv yaqinlik datçiklari robot böğinlarining çekka va boşlanğiç holatlarini aniqlaş, metall detallar mavjudligini tekşiriş va tişli ğildirak orqali tezlikni ölçaşda qöllanadi. Ular kontaktsiz, çang, yoğ va namlikka juda çidamli.

// =====================================================================
= Xoll datçiklari va ularning robototexnikadagi qöllanilişi
// =====================================================================

== Xoll datçiklarining turlari

Xoll effekti va Xoll kuçlanişi formulasi 4-maʼruzada körildi. Xoll elementining kuçlanişi juda kiçik (millivoltlar) bölgani uçun amaliyotda bitta kristallda Xoll elementi, kuçaytirgiç, harorat kompensatsiyasi va çiqiş bosqiçi birlaştirilgan *integral Xoll datçiklari* qöllanadi. Çiqiş signaliga köra ular ikki turga bölinadi:
- *çiziqli (analog) Xoll datçiklari* — çiqiş kuçlanişi magnit induksiyasiga proporsional; masofa, burçak va tokni ölçaş uçun;
- *Xoll kalitlari (raqamli)* — magnit induksiyasi belgilangan çegaradan oşganda çiqiş holatini özgartiradi. Ular gisterezisga ega: yoqiliş va öçiş induksiyalari farq qiladi. Bir qutbli kalitlar bitta qutbga, *latch* (uşlab qoluvçi) turlari esa navbatma-navbat şimoliy va janubiy qutblarga javob beradi.

== Kollektorsiz dvigatellarda rotor holatini aniqlaş

Kollektorsiz özgarmas tok dvigatellarida (BLDC) çulğamlarni töğri navbatda ulaş (kommutatsiya) uçun rotor holatini biliş kerak. Buning uçun stator içiga elektr burçak böyiça 120° ga siljitilgan uçta Xoll kaliti örnatiladi. Rotor magniti aylanganda ular har 60° elektr burçakda bitta razryadi özgaradigan uç bitli kod hosil qiladi (2-jadval).

#figure(
  btable(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: center,
    header: ([Sektor], [1], [2], [3], [4], [5], [6]),
    [Elektr burçak],
    [0…60°],
    [60…120°],
    [120…180°],
    [180…240°],
    [240…300°],
    [300…360°],
    [Kod $H_1 H_2 H_3$],
    [101],
    [100],
    [110],
    [010],
    [011],
    [001],
  ),
  caption: [Uçta Xoll datçigi kodlarining ketma-ketligi (bitta yönaliş uçun misol)],
) <tab-xoll>

Har bir kodga çulğamlarning maʼlum ulaniş kombinatsiyasi mos keladi. 000 va 111 kodlari normal işlaşda heç qaçon uçramaydi, şuning uçun ular paydo bölsa, drayver Xoll datçiklari yoki ularning ulanişi nosozligini aniqlaydi — bu oddiy, lekin samarali diagnostika usuli. Sektorlarning faza çulğamlariga aniq mosligi dvigatel konstruksiyasiga boğliq va drayver hujjatlarida beriladi.

== Tok va burçak datçiklari

*Xoll tok datçigida* ölçanayotgan tok ötkazgiçi tirqişli ferromagnit özak içidan ötadi, Xoll elementi esa tirqişga joylaştiriladi. Tirqişdagi magnit induksiyasi tokka proporsional:

#eq($ B approx (mu_0 dot I) / delta, $)

bu yerda $delta$ — tirqiş uzunligi (özakning magnit qarşiligi tirqişnikidan ança kiçik deb olingan). *Misol.* $delta = 2$ mm, $I = 50$ A bölsa, $B approx 4 pi dot 10^(-7) dot 50 slash 0","002 approx 31$ mT. Bunday datçik tok zanjiriga galvanik ulanmasdan özgarmas va özgaruvçan tokni ölçaydi. Robot drayverlarida dvigatel toki (demak, moment) şu tarzda nazorat qilinadi.

*Xoll burçak datçiklari (magnit enkoderlar)* valga örnatilgan diametral magnit maydonining ikki perpendikulyar komponentini ölçaydi; burçak sin/cos signallar nisbatidan topiladi. Ular ixçam, kontaktsiz va ifloslanişga çidamli. Şuningdek, Xoll datçiklari kontaktsiz çegara kalitlari, joystiklar va pnevmosilindr porşenining holatini aniqlaşda (porşendagi magnit orqali) keng qöllanadi.

Xoll datçiklariga yaqin vazifalarni *magnitorezistiv* datçiklar ham bajaradi: ularda magnit maydon taʼsirida qarşilik özgaradi. Ular sezgirroq va magnit enkoderlar hamda elektron kompaslarda (magnitometrlarda) qöllanadi.

// =====================================================================
= Yaqinlik va masofa datçiklarini taqqoslaş
// =====================================================================

Körib çiqilgan datçiklar va optik datçiklar (6-maʼruza) robotlarda obyekt yaqinligi va masofasini aniqlaşda bir-birini töldiradi. Ularning asosiy xususiyatlari 3-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Datçik], [Sezadigan obyektlar], [Afzalligi], [Çeklovi]),
    [Induktiv],
    [Faqat metallar],
    [Juda çidamli, ifloslanişga sezgir emas],
    [Kiçik masofa, material taʼsir qiladi],
    [Siğim],
    [Deyarli barça materiallar, suyuqliklar],
    [Metall bölmagan obyektlar, devor orqali sath],
    [Namlik va ifloslanişga sezgir],
    [Xoll],
    [Magnitlar],
    [Kontaktsiz holat va tok, ixçam],
    [Obyektda magnit bölişi kerak],
    [Ultratovuş],
    [Tovuşni aks ettiruvçi obyektlar],
    [Rang va şaffoflikka boğliq emas, arzon],
    [Sekin, keng konus, ölik zona],
    [Optik],
    [Yoruğlikni aks ettiruvçi yoki tösuvçi obyektlar],
    [Katta masofa, tezkor, aniq],
    [Şaffof va qora obyektlar, çang],
  ),
  caption: [Yaqinlik va masofa datçiklarini taqqoslaş],
) <tab-taqqos>

// =====================================================================
= Intellektual datçiklar: tuzilişi, funksiyalari va interfeyslari
// =====================================================================

== Tuzilişi

*Intellektual (smart) datçik* — birlamçi özgartirgiç, signalga işlov beriş sxemasi, analog-raqamli özgartirgiç, mikroprotsessor, xotira va raqamli aloqa interfeysi bitta qurilmada birlaştirilgan datçik (1-rasm). U faqat ölçab qolmay, natijani qayta işlaydi, özining holatini nazorat qiladi va boşqaruv tizimi bilan raqamli tarmoq orqali muloqot qiladi.

#figure(
  diagram(
    spacing: (6mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Sezgir \ element], name: <se>),
    node((1, 0), [Analog \ qism], name: <aq>),
    node((2, 0), [ARO], name: <aro>),
    node((3, 0), [Mikro- \ protsessor], fill: lightorange, name: <mp>),
    node((4, 0), [Raqamli \ interfeys], name: <if>),
    node((1, 1), [Harorat \ datçigi], fill: white, name: <td>),
    node((3, 1), [Xotira: kalibrlaş, \ TEDS, jurnal], fill: white, name: <xt>),
    node((4.6, 1), [Boşqaruv \ tizimi], fill: white, name: <bt>),
    edge(<se>, <aq>, "->"),
    edge(<aq>, <aro>, "->"),
    edge(<aro>, <mp>, "->"),
    edge(<mp>, <if>, "<->"),
    edge(<td>, <aro>, "->"),
    edge(<xt>, <mp>, "<->"),
    edge(<if>, <bt>, "<->"),
  ),
  caption: [Intellektual datçikning tuzilişi],
) <fig-smart>

== Funksiyalari

Intellektual datçik quyidagi funksiyalarni bajaradi:
- *raqamli kalibrlaş va çiziqlaştiriş* — xotiradagi kalibrlaş koeffitsientlari yordamida noçiziqli tavsifni tuzatiş;
- *harorat kompensatsiyasi* — içki harorat datçigi orqali nol siljişi va sezgirlikning haroratga boğliqligini tuzatiş;
- *raqamli filtrlaş va örtaçalaş* — şovqinni kamaytiriş;
- *ölçov birliklariga ötkaziş* — natijani bevosita fizik birliklarda (°C, bar, mm) beriş;
- *çegaraviy qiymatlarni nazorat qiliş* — çegaradan çiqilganda signal beriş;
- *öz-özini diagnostika qiliş* — sezgir element uzilişi yoki qisqa tutaşuvi, taʼminot buzilişi, ifloslaniş, iş resursi tugaşini aniqlaş;
- *identifikatsiya* — işlab çiqaruvçi, model, seriya raqami va kalibrlaş maʼlumotlarini xotirada saqlaş (masalan, IEEE 1451 standartidagi TEDS — _Transducer Electronic Data Sheet_ — elektron pasport);
- *parametrlaş* — ölçaş diapazoni, filtr, çegaralar kabi sozlamalarni masofadan özgartiriş.

Raqamli kalibrlaşda çiqiş signali $y$ va içki harorat $T$ böyiça ölçanayotgan kattalikning bahosi köpinça ikki özgaruvçili polinom bilan hisoblanadi:

#eq($ hat(x) = sum_(i=0)^n sum_(j=0)^m a_(i j) dot y^i dot T^j, $)

bu yerda $a_(i j)$ — har bir datçik uçun işlab çiqarişda alohida aniqlanib, uning xotirasiga yozilgan kalibrlaş koeffitsientlari. Şu tufayli arzon, lekin noçiziqli va haroratga sezgir sezgir element bilan ham yuqori aniqlikka erişiladi.

== Interfeyslar

Intellektual datçiklar boşqaruv tizimiga raqamli interfeyslar orqali ulanadi:
- *I²C va SPI* — plata içidagi qisqa masofali aloqa; MEMS akselerometrlar, giroskoplar, magnitometrlar, harorat va bosim datçiklari;
- *IO-Link* (IEC 61131-9) — datçik va boşqaruv tizimi orasidagi «nuqta-nuqta» raqamli aloqa; oddiy ekranlanmagan uç simli kabel orqali (20 m gaça) ölçaş natijasi, parametrlar va diagnostika uzatiladi;
- *CAN, EtherCAT, PROFINET* kabi sanoat tarmoqlari — robot böğinlari, enkoderlar va kuç-moment datçiklarini real vaqtda ulaş;
- *SSI, BiSS, EnDat* — enkoderlar uçun maxsus ketma-ket interfeyslar (5-maʼruza).

== Afzalliklari

Anʼanaviy analog datçiklarga nisbatan intellektual datçiklar quyidagi afzalliklarga ega: yuqori aniqlik (raqamli kalibrlaş va kompensatsiya tufayli), uzatişda xalaqitga çidamlilik, kabellar sonining kamayişi (bir neçta datçik bitta tarmoqqa ulanadi), örnatiş va almaştirişning soddaligi (parametrlar avtomatik yuklanadi), nosozliklarni oldindan aniqlaş va başorat qiliş imkoniyati. Bu Sanoat 4.0 konsepsiyasidagi uskunalarni uzluksiz kuzatiş va başoratli texnik xizmat körsatişning asosidir. Kamçiliklari — narxning yuqoriligi va qöşimça keçikiş (raqamli işlov va uzatiş vaqti), bu tez boşqaruv konturlarida hisobga olinişi kerak.

// =====================================================================
= Xulosa
// =====================================================================

Ultratovuş datçiklari aks-sado vaqti böyiça masofani ölçaydi; ular obyekt rangi va şaffofligiga boğliq emas, lekin tovuş tezligining haroratga boğliqligi, ölik zona va sekinlik ularning çeklovlaridir. Siğim datçiklari tirqiş, yuza yoki dielektrik özgarişiga asoslanadi; differensial sxema ularning tavsifini çiziqli qiladi. Induktiv yaqinlik datçiklari uyurma toklar hisobiga metall obyektlarni sezadi, ularning işga tuşiş masofasi obyekt materialiga boğliq. Xoll datçiklari kollektorsiz dvigatellarda rotor holatini aniqlaş, tokni galvanik ajratilgan holda ölçaş va kontaktsiz burçak datçiklarida keng qöllanadi.

Intellektual datçiklar ölçaş, raqamli kalibrlaş, kompensatsiya, filtrlaş, diagnostika va raqamli aloqani bitta qurilmada birlaştiradi. Ular zamonaviy robotlarning informatsion tizimini soddaroq, aniqroq va işonçliroq qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Ultratovuş datçigi qanday prinsipda masofani ölçaydi?
  + Nima uçun ultratovuş datçigida harorat kompensatsiyasi kerak? 0 °C da $t = 10$ ms aks-sado qanday masofaga mos keladi?
  + Ultratovuş datçigining ölik zonasi va nurlaniş konusi nimani anglatadi?
  + Siğim datçiklarining qanday turlari bor? Ularning tavsiflari qanday farqlanadi?
  + Differensial siğim datçigi nima uçun çiziqli tavsifga ega?
  + Siğim datçiklarida parazit siğimning taʼsiri qanday kamaytiriladi?
  + Induktiv yaqinlik datçigi qanday işlaydi?
  + $S_n = 10$ mm bölgan induktiv datçik mis detalni ($k_m = 0","3$) qanday masofadan sezadi?
  + Çiziqli Xoll datçigi va Xoll kaliti qanday farqlanadi?
  + BLDC dvigatelda uçta Xoll datçigi qanday vazifani bajaradi? 000 kodi nimani bildiradi?
  + Xoll tok datçigining afzalligi nimada?
  + Intellektual datçik qanday qismlardan iborat va qanday funksiyalarni bajaradi?
  + IO-Link interfeysining afzalliklari nimada?
]
