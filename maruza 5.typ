// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №5. Kinestetik va taktil datchiklar. Holat va siljish datchiklari.
//             Diskret va analog datchiklar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №5. Kinestetik va taktil datçiklar. Holat va siljiş datçiklari. Diskret va analog datçiklar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 5  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №5]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Kinestetik va taktil datçiklar. Holat va siljiş datçiklari. \ Diskret va analog datçiklar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Kinestetik datçiklar va ularning robotdagi örni.
  + Holat va siljiş datçiklarining sinflanişi.
  + Rezistiv va elektromagnit holat datçiklari.
  + Fotoelektrik va magnit holat datçiklari (enkoderlar).
  + Holat datçiklari asosida tezlikni ölçaş.
  + Taktil va kuç-moment datçiklari.
  + Diskret va analog datçiklar.

  *Tayanç iboralar:* kinestetik datçik, holat datçigi, siljiş datçigi, potensiometr, yuklama xatoligi, LVDT, rezolver, inkremental enkoder, absolyut enkoder, kvadratur signallar, magnit enkoder, taktil datçik, taktil matritsa, sirpaniş, kuç-moment datçigi, diskret datçik, yaqinlik datçigi, PNP va NPN çiqiş, analog datçik, 4–20 mA tok signali.
]

// =====================================================================
= Kinestetik datçiklar va ularning robotdagi örni
// =====================================================================

*Kinestetik datçiklar* — robotning öz mexanizmi holatini ölçaydigan içki (proprioseptiv) datçiklar. Ular inson muşak-böğin sezgisining texnik analogi bölib, quyidagi kattaliklarni ölçaydi:
- böğinlarning burçak va çiziqli holati (siljişi);
- böğinlar va dvigatellarning tezligi va tezlanişi;
- böğinlardagi moment va yuritmalardagi kuç;
- dvigatel toki (u moment haqida bilvosita axborot beradi).

Kinestetik datçiklar har qanday robotda mavjud, çunki ularsiz yuritmalarning qayta aloqa konturlarini qurib bölmaydi. Robot böğinida ular odatda 1-rasmda körsatilgan joylarga örnatiladi.

#figure(
  diagram(
    spacing: (10mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Drayver], fill: lightorange, name: <dr>),
    node((1, 0), [Dvigatel], name: <dv>),
    node((2, 0), [Reduktor], name: <rd>),
    node((3, 0), [Böğin \ (zveno)], name: <bg>),
    node((0, 1), [Tok \ datçigi], fill: white, name: <td>),
    node((1, 1), [Enkoder 1 \ (dvigatel valida)], fill: white, name: <e1>),
    node((2, 1), [Moment \ datçigi], fill: white, name: <md>),
    node((3, 1), [Enkoder 2 \ (çiqiş valida)], fill: white, name: <e2>),
    edge(<dr>, <dv>, "->"),
    edge(<dv>, <rd>, "->"),
    edge(<rd>, <bg>, "->"),
    edge(<td>, <dr>, "--"),
    edge(<e1>, <dv>, "--"),
    edge(<md>, <rd>, "--"),
    edge(<e2>, <bg>, "--"),
  ),
  caption: [Robot böğinida kinestetik datçiklarning joylaşuvi],
) <fig-bogin>

Dvigatel validagi enkoder yuqori ruxsat qobiliyati bilan tezlik va pozitsiya konturlarini taʼminlaydi, lekin reduktor lyufti va elastikligini sezmaydi. Çiqiş validagi enkoder böğinning haqiqiy burçagini ölçaydi. Moment datçigi va tok datçigi esa robot muhit bilan kontaktga kirganini aniqlaş va kuçni çeklaş imkonini beradi — bu kollaborativ robotlar uçun ayniqsa muhim.

// =====================================================================
= Holat va siljiş datçiklarining sinflanişi
// =====================================================================

Holat va siljiş datçiklari kinestetik datçiklarning asosiy guruhini taşkil etadi. Ular quyidagi belgilar böyiça sinflanadi:
- *harakat turi böyiça:* çiziqli siljiş datçiklari va burçak (aylaniş) datçiklari;
- *ölçaş usuli böyiça:* *absolyut* datçiklar har bir paytda holatning töliq qiymatini beradi va taʼminot öçib yonganda ham holatni «biladi»; *inkremental* datçiklar faqat siljiş orttirmalarini (qadamlarni) beradi, holat esa ularni sanaş orqali topiladi va işga tuşirişda boşlanğiç nuqtaga qaytiş (referenslaş) talab qilinadi;
- *fizik prinsip böyiça:* rezistiv, elektromagnit (induktiv, transformatorli), fotoelektrik va magnit datçiklar;
- *çiqiş signali böyiça:* analog (kuçlaniş, sin/cos signallar) va raqamli (impulslar, parallel yoki ketma-ket kod).

// =====================================================================
= Rezistiv va elektromagnit holat datçiklari
// =====================================================================

== Potensiometrik datçiklar va yuklama xatoligi

Potensiometrning çiqiş kuçlanişi ideal holda surgiç holatiga proporsional (4-maʼruza). Lekin çiqişga qarşiligi $R_L$ bölgan yuklama (masalan, ARO kirişi) ulanganda tavsif çiziqlilikdan çetlaşadi. Nisbiy holat $alpha = x slash L$ ($0 <= alpha <= 1$) va potensiometrning töliq qarşiligi $R_p$ bölsa, çiqiş kuçlanişi:

#eq($ U_"çiq" = (U_0 dot alpha) / (1 + (R_p / R_L) dot alpha (1 - alpha)). $)

$R_L -> infinity$ bölganda (1) ideal tavsifga $U_"çiq" = U_0 alpha$ aylanadi.

*Misol.* $R_p slash R_L = 0","1$ va $alpha = 0","5$ bölsa, $U_"çiq" = 0","5 U_0 slash 1","025 approx 0","488 U_0$. Xatolik töliq diapazonning taxminan 1,2 % ini taşkil etadi. Şuning uçun potensiometr çiqişiga kiriş qarşiligi juda katta bölgan kuçaytirgiç (kuçlaniş takrorlagiçi) ulanadi.

== Elektromagnit datçiklar: LVDT va rezolver

*Çiziqli differensial transformator (LVDT)* bitta birlamçi va ikkita qarama-qarşi ulangan ikkilamçi çulğamdan hamda ular içida harakatlanuvçi ferromagnit özakdan iborat. Özak örtada bölganda ikkilamçi çulğamlar kuçlanişlari bir-birini yöqotadi; özak siljiganda çiqiş kuçlanişining amplitudasi siljişga proporsional ortadi, fazasi esa siljiş yönalişini körsatadi. LVDT kontaktsiz, juda yuqori ruxsat qobiliyatiga ega va oğir şaroitlarda işlaydi.

*Rezolver* — aylanuvçi transformator. Rotor çulğami $U_0 sin omega t$ yuqori çastotali kuçlaniş bilan taʼminlanadi, statordagi ikkita özaro perpendikulyar çulğamda esa rotor burçagi $theta$ ga boğliq signallar hosil böladi:

#eq($ U_"sin" = k U_0 sin omega t dot sin theta, quad U_"cos" = k U_0 sin omega t dot cos theta. $)

Burçak bu ikki signalning nisbatidan topiladi: $theta = "arctg"(U_"sin" slash U_"cos")$ (kvadrantni hisobga olgan holda). Signallar nisbati taʼminot kuçlanişi va harorat özgarişiga deyarli boğliq emas. Rezolverlar elektronika yöq, çulğam va temirdan iborat bölgani uçun yuqori harorat, vibratsiya va radiatsiyaga çidamli; ular oğir şaroitdagi robot yuritmalari, avtomobil va aviatsiyada qöllanadi. Rezolver signallarini raqamga aylantiriş uçun maxsus özgartirgiç (RDC — _Resolver-to-Digital Converter_) işlatiladi.

// =====================================================================
= Fotoelektrik va magnit holat datçiklari
// =====================================================================

== Inkremental enkoder

*Optik inkremental enkoder* tiniq va notiniq bölaklar galma-gal joylaşgan diskdan, yoruğlik manbaidan va fotoqabul qilgiçlardan iborat. Disk aylanganda fotoqabul qilgiçlarda impulslar hosil böladi. Harakat yönalişini aniqlaş uçun ikkita kanal — A va B — bir-biriga nisbatan çorak davrga ($90 degree$) siljitilgan, uçinçi kanal Z esa har aylanişda bitta referens impuls beradi (2-rasm).

#let kvadratur = {
  let u = 0.62cm
  let h = 0.55cm
  let gap = 1.25cm
  let st = 1pt + headingblue
  let wave(pts, y0) = for i in range(pts.len() - 1) {
    let (x1, v1) = pts.at(i)
    let (x2, v2) = pts.at(i + 1)
    place(line(start: (x1 * u + 1.2cm, y0 - v1 * h), end: (x2 * u + 1.2cm, y0 - v2 * h), stroke: st))
  }
  let a = (
    (0, 0),
    (0, 1),
    (2, 1),
    (2, 0),
    (4, 0),
    (4, 1),
    (6, 1),
    (6, 0),
    (8, 0),
    (8, 1),
    (10, 1),
    (10, 0),
    (12, 0),
    (12, 1),
    (14, 1),
    (14, 0),
    (16, 0),
  )
  let b = (
    (0, 0),
    (1, 0),
    (1, 1),
    (3, 1),
    (3, 0),
    (5, 0),
    (5, 1),
    (7, 1),
    (7, 0),
    (9, 0),
    (9, 1),
    (11, 1),
    (11, 0),
    (13, 0),
    (13, 1),
    (15, 1),
    (15, 0),
    (16, 0),
  )
  let z = ((0, 0), (8, 0), (8, 1), (9, 1), (9, 0), (16, 0))
  box(width: 11.4cm, height: 4.4cm, {
    wave(a, 1cm)
    wave(b, 1cm + gap)
    wave(z, 1cm + 2 * gap)
    place(dx: 0cm, dy: 0.45cm, text(size: 10pt, weight: "bold")[A])
    place(dx: 0cm, dy: 0.45cm + gap, text(size: 10pt, weight: "bold")[B])
    place(dx: 0cm, dy: 0.45cm + 2 * gap, text(size: 10pt, weight: "bold")[Z])
    for k in range(17) {
      place(line(start: (k * u + 1.2cm, 0.2cm), end: (k * u + 1.2cm, 4.0cm), stroke: (
        paint: luma(200),
        thickness: 0.4pt,
        dash: "dotted",
      )))
    }
    place(dx: 1.2cm, dy: 4.0cm, text(size: 9pt)[har bir çiziq — bitta kvadratur hodisa (fronti), 1 davrda 4 ta])
  })
}

#figure(
  kvadratur,
  caption: [Inkremental enkoderning kvadratur signallari],
) <fig-kvadratur>

A kanal B kanaldan oldinda bölsa, disk bir yönalişda, aks holda teskari yönalişda aylanmoqda. Ikkala kanalning barça frontlarini sanaş (×4 rejim) ruxsat qobiliyatini tört marta oşiradi. Diskda $N$ ta çiziq (bir aylanişdagi impulslar soni) bölsa, ×4 rejimdagi burçak ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / (4 N). $)

Masalan, $N = 2500$ uçun $Delta theta = 0","036 degree$. Inkremental enkoder sodda va arzon, lekin u holatning faqat özgarişini beradi: taʼminot öçsa, holat yöqoladi va robot işga tuşganda har bir böğinni referens nuqtaga keltiriş kerak.

== Absolyut enkoder

*Absolyut enkoder* diskida $n$ ta konsentrik yölakça bor va har bir burçak holatiga noyob $n$ razryadli kod mos keladi. Kod odatda Grey kodida yoziladi (2-maʼruza), çunki qöşni holatlar faqat bitta razryad bilan farq qiladi. Ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / 2^n. $)

Zamonaviy robotlarda 17–23 bitli absolyut enkoderlar keng tarqalgan; masalan, 17 bit uçun $Delta theta approx 0","0027 degree approx 10''$. Absolyut enkoder taʼminot qayta yoqilganda holatni darhol beradi, natija esa odatda ketma-ket raqamli interfeys (SSI, BiSS, EnDat va boşqalar) orqali uzatiladi. Köp aylanişli (_multi-turn_) absolyut enkoderlar aylanişlar sonini ham hisoblaydi.

Çiziqli siljişni ölçaş uçun xuddi şu prinsiplarda işlaydigan *çiziqli optik şkalalar* (inkremental va absolyut) qöllanadi.

== Magnit enkoderlar

*Magnit enkoderlarda* optik disk örniga köp qutbli magnit halqa yoki diametral magnitlangan magnit, fotoqabul qilgiç örniga esa Xoll yoki magnitorezistiv özgartirgiçlar işlatiladi. Ular optik enkoderlarga qaraganda ixçam, çang, namlik va yoğga çidamliroq, lekin odatda ruxsat qobiliyati va aniqligi pastroq. Magnit enkoderlar mobil robotlar, kollaborativ robot böğinlari va kiçik servoyuritmalarda keng qöllanadi.

Körib çiqilgan holat datçiklari 1-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, auto, auto, 1fr),
    header: ([Datçik], [Usul], [Çiqiş], [Asosiy xususiyati]),
    [Potensiometr],
    [Absolyut],
    [Analog],
    [Oddiy va arzon; kontaktli, yeyiladi],
    [LVDT],
    [Absolyut],
    [Analog (AC)],
    [Kontaktsiz, yuqori ruxsat, çiziqli siljiş],
    [Rezolver],
    [Absolyut \ (1 aylanişda)],
    [Analog sin/cos],
    [Oğir şaroitga juda çidamli],
    [Inkremental enkoder],
    [Inkremental],
    [Impulslar A/B/Z],
    [Arzon, yuqori ruxsat; referenslaş kerak],
    [Absolyut enkoder],
    [Absolyut],
    [Raqamli kod],
    [Taʼminot qayta yoqilganda holat saqlanadi],
    [Magnit enkoder],
    [Inkremental \ yoki absolyut],
    [Impuls yoki kod],
    [Ixçam, ifloslanişga çidamli],
  ),
  caption: [Holat va siljiş datçiklarini taqqoslaş],
) <tab-holat>

// =====================================================================
= Holat datçiklari asosida tezlikni ölçaş
// =====================================================================

Robotlarda tezlik köpinça alohida datçik bilan emas, balki holat datçigi signali asosida aniqlanadi. Inkremental enkoder uçun ikki asosiy usul qöllanadi.

*M-usul (impulslarni sanaş):* belgilangan vaqt oraliği $T_0$ içida sanalgan impulslar soni $Delta P$ böyiça:

#eq($ omega = (2 pi dot Delta P) / (4 N dot T_0). $)

Bu usul yuqori tezliklarda aniq, lekin past tezliklarda $T_0$ içida impulslar juda kam böladi. Bitta impulsga mos eng kiçik ölçanadigan tezlik $omega_min = 2 pi slash (4 N T_0)$. Masalan, $N = 2500$, $T_0 = 1$ ms uçun $omega_min approx 0","63$ rad/s (taxminan 6 ayl/min), yaʼni bundan sekinroq aylanişni bu usul bilan farqlab bölmaydi.

*T-usul (davrni ölçaş):* ikki qöşni impuls orasidagi vaqt yuqori çastotali taymer bilan ölçanadi. Bu usul past tezliklarda aniq, yuqori tezliklarda esa impulslar orasidagi vaqt juda qisqarib, aniqlik pasayadi. Amaliyotda ikkala usulni birlaştirgan aralaş usullar qöllanadi.

Tezlanişni ölçaş uçun esa alohida datçiklar — MEMS akselerometrlar işlatiladi, çunki holat signalini ikki marta differensiallaş şovqinni kuçli oşiradi.

// =====================================================================
= Taktil va kuç-moment datçiklari
// =====================================================================

== Taktil datçiklarning vazifalari

*Taktil datçiklar* robot va obyekt orasidagi kontaktni sezadi. Ular inson terisining texnik analogi bölib, quyidagi vazifalarni bajaradi:
- kontakt bor yoki yöqligini aniqlaş;
- kontakt kuçi va bosimning sirt böylab taqsimlanişini ölçaş;
- obyektning şakli, ölçami va joylaşuvini aniqlaş;
- obyekt tutqiçdan sirpanib çiqayotganini (sirpanişni) seziş;
- obyektning qattiqligi, ğadir-budurligi va haroratini baholaş.

Taktil datçiklar ayniqsa nozik, mört yoki notaniş obyektlarni uşlaşda, yiğiş işlarida va inson bilan xavfsiz hamkorlikda zarur.

== Taktil datçiklarning turlari

Taktil datçiklar 4-maʼruzada körilgan turli fizik prinsiplar asosida quriladi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.3fr, 1fr),
    header: ([Turi], [Işlaş prinsipi], [Xususiyati]),
    [Kontaktli kalitlar],
    [Mikrokalit yoki membranali kontakt],
    [Diskret: faqat kontakt bor-yöqligi],
    [Rezistiv (FSR, piezorezistiv)],
    [Bosim ostida ötkazuvçi polimer yoki yarimötkazgiç qarşiligi özgaradi],
    [Oddiy, arzon; gisterezis va drift bor],
    [Siğim],
    [Elastik dielektrik siqilganda elektrodlar orasidagi masofa kamayadi],
    [Yuqori sezgirlik, matritsa qiliş oson],
    [Piezoelektrik],
    [Bosim özgarişida zaryad hosil böladi],
    [Dinamik hodisalar: sirpaniş, tebraniş],
    [Optik],
    [Elastik qatlam deformatsiyasi yoruğlik oqimini özgartiradi yoki kamera bilan kuzatiladi],
    [Elektromagnit xalaqitga çidamli, yuqori ruxsat],
    [Magnit],
    [Elastomerdagi magnit siljişini Xoll özgartirgiçi sezadi],
    [Kuç yönalişini ham ölçay oladi],
  ),
  caption: [Taktil datçiklarning turlari],
) <tab-taktil>

== Taktil matritsalar

Kuçning sirt böylab taqsimlanişini ölçaş uçun köplab sezgir elementlar (taksellar) $m$ qator va $n$ ustundan iborat *taktil matritsa* körinişida joylaştiriladi. Elementlar soni va ularni ulaş uçun kerakli simlar soni:

#eq($ N = m dot n, quad N_"sim" = m + n. $)

Qator va ustunlar navbatma-navbat ulanib, elementlar ketma-ket söraladi (skanerlanadi). Bitta elementni söraş vaqti $t_e$ bölsa, butun matritsani söraş vaqti $t_"kadr" = m dot n dot t_e$.

*Misol.* $16 times 16$ matritsada 256 ta element bor, ular atigi 32 ta sim bilan ulanadi. $t_e = 10$ µs bölsa, $t_"kadr" = 256 dot 10$ µs $= 2","56$ ms, yaʼni matritsa sekundiga taxminan 390 marta töliq yangilanadi. Elementlar soni ortsa, skanerlaş vaqti ortadi — taktil matritsani loyihalaşda ruxsat qobiliyati va tezkorlik örtasida murosa topiş kerak.

== Kuç-moment datçiklari

Robot bilagi va asbob orasiga örnatiladigan *olti komponentli kuç-moment datçigi* uçta kuç ($F_x, F_y, F_z$) va uçta moment ($M_x, M_y, M_z$) komponentini ölçaydi. Uning elastik elementiga bir neçta tenzorezistor köprigi joylaştiriladi. Har bir köprik signali bir neçta komponentga boğliq bölgani uçun kuç va momentlar kalibrlaş matritsasi $bold(C)$ yordamida hisoblanadi:

#eq($ mat(F_x; F_y; F_z; M_x; M_y; M_z) = bold(C) dot mat(u_1; u_2; dots.v; u_k), $)

bu yerda $u_1, dots, u_k$ — tenzoköpriklar signallari ($k >= 6$). Kuç-moment datçiklari silliqlaş, yiğiş, yuzani kuzatib boriş va robotni qöl bilan örgatiş (_hand guiding_) vazifalarida qöllanadi.

// =====================================================================
= Diskret va analog datçiklar
// =====================================================================

Çiqiş signalining turiga köra datçiklar *diskret* va *analog* turlarga bölinadi. Raqamli interfeysli datçiklarni alohida uçinçi guruh sifatida köriş mumkin.

== Diskret datçiklar

*Diskret* (ikkilik, binar) datçiklar faqat ikki holatni — «bor» yoki «yöq», «yoqilgan» yoki «öçirilgan» — farqlaydi. Ular ölçanayotgan kattalik belgilangan çegaradan ötganini qayd etadi. Robototexnikada eng köp qöllanadigan diskret datçiklar:
- *mexanik çegara kalitlari* — harakatlanuvçi qism kontaktga tegib, kalitni ulaydi;
- *induktiv yaqinlik datçiklari* — metall obyekt yaqinlaşganini kontaktsiz sezadi;
- *siğim yaqinlik datçiklari* — metall bölmagan obyektlarni ham (plastik, suyuqlik, yoğoç) sezadi;
- *optik datçiklar* — yoruğlik nuri tösilganini yoki aks etganini sezadi (nur tösiqlari, yoruğlik pardalari).

Diskret datçiklar robot böğinlarining çekka holatlarini çeklaş, boşlanğiç (referens) holatni aniqlaş, detal mavjudligini tekşiriş va xavfsizlik zonalarini nazorat qilişda işlatiladi.

Kontaktsiz diskret datçiklarning ulaniş nuqtasida *gisterezis* ataylab kiritiladi: datçik yoqiladigan va öçadigan masofalar biroz farq qiladi. Aks holda obyekt çegara yaqinida turganda datçik tez-tez yoqilib-öçib («titrab») qolardi. Sanoat datçiklarining çiqişi odatda tranzistorli böladi: *PNP* çiqiş faol holatda yuklamani taʼminot musbat qutbiga (+24 V) ulaydi, *NPN* çiqiş esa yuklamani manfiy qutbga (umumiy simga) ulaydi. Datçik turi kontroller kirişining turiga mos tanlanişi kerak.

== Analog datçiklar

*Analog* datçiklar ölçanayotgan kattalikka uzluksiz boğliq bölgan signal beradi. Sanoatda standart analog signallar qöllanadi: kuçlaniş (0–10 V, ±10 V) va tok (4–20 mA). Tok signali uzun aloqa liniyalarida xalaqitga çidamliroq, çunki liniya qarşiligi tokka taʼsir qilmaydi. Signalning quyi çegarasi 0 emas, 4 mA bölişi («tirik nol») liniya uzilişini aniqlaş imkonini beradi: tok 4 mA dan sezilarli kamaysa, bu nosozlik belgisi. Tok qiymatidan ölçanayotgan kattalik quyidagiça topiladi:

#eq($ x = x_min + (I - 4 "mA") / (16 "mA") dot (x_max - x_min). $)

*Misol.* Diapazoni 0…500 mm bölgan siljiş datçigi 12 mA tok bersa, $x = (12 - 4) slash 16 dot 500 = 250$ mm.

Diskret va analog datçiklarning asosiy farqlari 3-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Körsatkiç], [Diskret datçik], [Analog datçik]),
    [Çiqiş signali],
    [Ikki holat: 0 yoki 1],
    [Uzluksiz: kuçlaniş yoki tok],
    [Beradigan axborot],
    [Çegaradan ötgan-ötmagani (1 bit)],
    [Kattalikning qiymati],
    [Kontrollerga ulanişi],
    [Diskret kiriş],
    [Analog kiriş (ARO)],
    [Xalaqitga çidamlilik],
    [Yuqori],
    [Past–örtaça (tok signalida yuqoriroq)],
    [Narxi va soddaligi],
    [Arzon va sodda],
    [Qimmatroq, kalibrlaş talab qiladi],
    [Robotdagi misollar],
    [Çegara kalitlari, yaqinlik datçiklari, nur tösiqlari],
    [Potensiometr, LVDT, tenzodatçik, analog bosim datçigi],
  ),
  caption: [Diskret va analog datçiklarni taqqoslaş],
) <tab-diskret>

Zamonaviy robotlarda köplab datçiklar raqamli interfeys (IO-Link, CAN, EtherCAT, SSI) orqali ulanadi. Bunday datçiklar içida analog signal ARO yordamida raqamga aylantiriladi, kontrollerga esa tayyor raqamli qiymat va diagnostika axboroti uzatiladi.

// =====================================================================
= Xulosa
// =====================================================================

Kinestetik datçiklar robot mexanizmining holati, tezligi, momenti va toki haqida axborot beradi va yuritmalarning qayta aloqa konturlari asosini taşkil etadi. Holat va siljiş datçiklari absolyut va inkremental, çiziqli va burçak turlariga bölinadi; ular orasida potensiometrlar, LVDT, rezolverlar, optik va magnit enkoderlar keng qöllanadi. Inkremental enkoderning kvadratur signallari harakat yönalişini aniqlaş va ruxsat qobiliyatini tört marta oşiriş imkonini beradi, absolyut enkoder esa taʼminot qayta yoqilganda holatni saqlaydi.

Taktil datçiklar kontakt, kuç taqsimoti va sirpanişni sezadi; kuç-moment datçiklari esa robot asbobiga taʼsir qilayotgan kuç va momentlarni töliq ölçaydi. Çiqiş signaliga köra datçiklar diskret va analog turlarga bölinadi: diskret datçiklar çegaraviy holatlarni qayd etadi, analog datçiklar esa kattalik qiymatini uzluksiz beradi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Kinestetik datçiklar qanday kattaliklarni ölçaydi va ular robot böğinida qayerga örnatiladi?
  + Absolyut va inkremental holat datçiklari qanday farqlanadi?
  + Potensiometrning yuklama xatoligi qanday yuzaga keladi va qanday kamaytiriladi?
  + LVDT va rezolverning işlaş prinsipini tuşuntiring.
  + Inkremental enkoderda harakat yönalişi qanday aniqlanadi?
  + $N = 1024$ çiziqli enkoderning ×4 rejimdagi ruxsat qobiliyatini toping.
  + Neça bitli absolyut enkoder $0","01 degree$ dan yaxşiroq ruxsat qobiliyatini taʼminlaydi?
  + M-usul va T-usul bilan tezlikni ölçaşning afzallik va kamçiliklari nimada?
  + Taktil datçiklar qanday vazifalarni bajaradi? Ularning turlarini sanab bering.
  + $32 times 32$ taktil matritsa uçun neçta sim kerak? $t_e = 5$ µs bölsa, kadr vaqti qança?
  + Olti komponentli kuç-moment datçigi qanday kattaliklarni ölçaydi?
  + Diskret datçiklarda gisterezis nima uçun kerak? PNP va NPN çiqişlar qanday farqlanadi?
  + 4–20 mA tok signalining afzalliklari nimada? 0…10 bar datçik 16 mA bersa, bosim qança?
]
