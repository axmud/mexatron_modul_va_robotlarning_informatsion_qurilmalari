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
  title: "Maʼruza №5. Kinestetik va taktil datchiklar. Holat va siljish datchiklari. Diskret va analog datchiklar",
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №5]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Kinestetik va taktil datchiklar. Holat va siljish datchiklari. \ Diskret va analog datchiklar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Kinestetik datchiklar va ularning robotdagi oʻrni.
  + Holat va siljish datchiklarining sinflanishi.
  + Rezistiv va elektromagnit holat datchiklari.
  + Fotoelektrik va magnit holat datchiklari (enkoderlar).
  + Holat datchiklari asosida tezlikni oʻlchash.
  + Taktil va kuch-moment datchiklari.
  + Diskret va analog datchiklar.

  *Tayanch iboralar:* kinestetik datchik, holat datchigi, siljish datchigi, potensiometr, yuklama xatoligi, LVDT, rezolver, inkremental enkoder, absolyut enkoder, kvadratur signallar, magnit enkoder, taktil datchik, taktil matritsa, sirpanish, kuch-moment datchigi, diskret datchik, yaqinlik datchigi, PNP va NPN chiqish, analog datchik, 4–20 mA tok signali.
]

// =====================================================================
= Kinestetik datchiklar va ularning robotdagi oʻrni
// =====================================================================

*Kinestetik datchiklar* — robotning oʻz mexanizmi holatini oʻlchaydigan ichki (proprioseptiv) datchiklar. Ular inson mushak-boʻgʻin sezgisining texnik analogi boʻlib, quyidagi kattaliklarni oʻlchaydi:
- boʻgʻinlarning burchak va chiziqli holati (siljishi);
- boʻgʻinlar va dvigatellarning tezligi va tezlanishi;
- boʻgʻinlardagi moment va yuritmalardagi kuch;
- dvigatel toki (u moment haqida bilvosita axborot beradi).

Kinestetik datchiklar har qanday robotda mavjud, chunki ularsiz yuritmalarning qayta aloqa konturlarini qurib boʻlmaydi. Robot boʻgʻinida ular odatda 1-rasmda koʻrsatilgan joylarga oʻrnatiladi.

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
    node((3, 0), [Boʻgʻin \ (zveno)], name: <bg>),
    node((0, 1), [Tok \ datchigi], fill: white, name: <td>),
    node((1, 1), [Enkoder 1 \ (dvigatel valida)], fill: white, name: <e1>),
    node((2, 1), [Moment \ datchigi], fill: white, name: <md>),
    node((3, 1), [Enkoder 2 \ (chiqish valida)], fill: white, name: <e2>),
    edge(<dr>, <dv>, "->"),
    edge(<dv>, <rd>, "->"),
    edge(<rd>, <bg>, "->"),
    edge(<td>, <dr>, "--"),
    edge(<e1>, <dv>, "--"),
    edge(<md>, <rd>, "--"),
    edge(<e2>, <bg>, "--"),
  ),
  caption: [Robot boʻgʻinida kinestetik datchiklarning joylashuvi],
) <fig-bogin>

Dvigatel validagi enkoder yuqori ruxsat qobiliyati bilan tezlik va pozitsiya konturlarini taʼminlaydi, lekin reduktor lyufti va elastikligini sezmaydi. Chiqish validagi enkoder boʻgʻinning haqiqiy burchagini oʻlchaydi. Moment datchigi va tok datchigi esa robot muhit bilan kontaktga kirganini aniqlash va kuchni cheklash imkonini beradi — bu kollaborativ robotlar uchun ayniqsa muhim.

// =====================================================================
= Holat va siljish datchiklarining sinflanishi
// =====================================================================

Holat va siljish datchiklari kinestetik datchiklarning asosiy guruhini tashkil etadi. Ular quyidagi belgilar boʻyicha sinflanadi:
- *harakat turi boʻyicha:* chiziqli siljish datchiklari va burchak (aylanish) datchiklari;
- *oʻlchash usuli boʻyicha:* *absolyut* datchiklar har bir paytda holatning toʻliq qiymatini beradi va taʼminot oʻchib yonganda ham holatni «biladi»; *inkremental* datchiklar faqat siljish orttirmalarini (qadamlarni) beradi, holat esa ularni sanash orqali topiladi va ishga tushirishda boshlangʻich nuqtaga qaytish (referenslash) talab qilinadi;
- *fizik prinsip boʻyicha:* rezistiv, elektromagnit (induktiv, transformatorli), fotoelektrik va magnit datchiklar;
- *chiqish signali boʻyicha:* analog (kuchlanish, sin/cos signallar) va raqamli (impulslar, parallel yoki ketma-ket kod).

// =====================================================================
= Rezistiv va elektromagnit holat datchiklari
// =====================================================================

== Potensiometrik datchiklar va yuklama xatoligi

Potensiometrning chiqish kuchlanishi ideal holda surgich holatiga proporsional (4-maʼruza). Lekin chiqishga qarshiligi $R_L$ boʻlgan yuklama (masalan, ARO kirishi) ulanganda tavsif chiziqlilikdan chetlashadi. Nisbiy holat $alpha = x slash L$ ($0 <= alpha <= 1$) va potensiometrning toʻliq qarshiligi $R_p$ boʻlsa, chiqish kuchlanishi:

#eq($ U_"chiq" = (U_0 dot alpha) / (1 + (R_p / R_L) dot alpha (1 - alpha)). $)

$R_L -> infinity$ boʻlganda (1) ideal tavsifga $U_"chiq" = U_0 alpha$ aylanadi.

*Misol.* $R_p slash R_L = 0","1$ va $alpha = 0","5$ boʻlsa, $U_"chiq" = 0","5 U_0 slash 1","025 approx 0","488 U_0$. Xatolik toʻliq diapazonning taxminan 1,2 % ini tashkil etadi. Shuning uchun potensiometr chiqishiga kirish qarshiligi juda katta boʻlgan kuchaytirgich (kuchlanish takrorlagichi) ulanadi.

== Elektromagnit datchiklar: LVDT va rezolver

*Chiziqli differensial transformator (LVDT)* bitta birlamchi va ikkita qarama-qarshi ulangan ikkilamchi chulgʻamdan hamda ular ichida harakatlanuvchi ferromagnit oʻzakdan iborat. Oʻzak oʻrtada boʻlganda ikkilamchi chulgʻamlar kuchlanishlari bir-birini yoʻqotadi; oʻzak siljiganda chiqish kuchlanishining amplitudasi siljishga proporsional ortadi, fazasi esa siljish yoʻnalishini koʻrsatadi. LVDT kontaktsiz, juda yuqori ruxsat qobiliyatiga ega va ogʻir sharoitlarda ishlaydi.

*Rezolver* — aylanuvchi transformator. Rotor chulgʻami $U_0 sin omega t$ yuqori chastotali kuchlanish bilan taʼminlanadi, statordagi ikkita oʻzaro perpendikulyar chulgʻamda esa rotor burchagi $theta$ ga bogʻliq signallar hosil boʻladi:

#eq($ U_"sin" = k U_0 sin omega t dot sin theta, quad U_"cos" = k U_0 sin omega t dot cos theta. $)

Burchak bu ikki signalning nisbatidan topiladi: $theta = "arctg"(U_"sin" slash U_"cos")$ (kvadrantni hisobga olgan holda). Signallar nisbati taʼminot kuchlanishi va harorat oʻzgarishiga deyarli bogʻliq emas. Rezolverlar elektronika yoʻq, chulgʻam va temirdan iborat boʻlgani uchun yuqori harorat, vibratsiya va radiatsiyaga chidamli; ular ogʻir sharoitdagi robot yuritmalari, avtomobil va aviatsiyada qoʻllanadi. Rezolver signallarini raqamga aylantirish uchun maxsus oʻzgartirgich (RDC — _Resolver-to-Digital Converter_) ishlatiladi.

// =====================================================================
= Fotoelektrik va magnit holat datchiklari
// =====================================================================

== Inkremental enkoder

*Optik inkremental enkoder* tiniq va notiniq boʻlaklar galma-gal joylashgan diskdan, yorugʻlik manbaidan va fotoqabul qilgichlardan iborat. Disk aylanganda fotoqabul qilgichlarda impulslar hosil boʻladi. Harakat yoʻnalishini aniqlash uchun ikkita kanal — A va B — bir-biriga nisbatan chorak davrga ($90 degree$) siljitilgan, uchinchi kanal Z esa har aylanishda bitta referens impuls beradi (2-rasm).

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
    place(dx: 1.2cm, dy: 4.0cm, text(size: 9pt)[har bir chiziq — bitta kvadratur hodisa (fronti), 1 davrda 4 ta])
  })
}

#figure(
  kvadratur,
  caption: [Inkremental enkoderning kvadratur signallari],
) <fig-kvadratur>

A kanal B kanaldan oldinda boʻlsa, disk bir yoʻnalishda, aks holda teskari yoʻnalishda aylanmoqda. Ikkala kanalning barcha frontlarini sanash (×4 rejim) ruxsat qobiliyatini toʻrt marta oshiradi. Diskda $N$ ta chiziq (bir aylanishdagi impulslar soni) boʻlsa, ×4 rejimdagi burchak ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / (4 N). $)

Masalan, $N = 2500$ uchun $Delta theta = 0","036 degree$. Inkremental enkoder sodda va arzon, lekin u holatning faqat oʻzgarishini beradi: taʼminot oʻchsa, holat yoʻqoladi va robot ishga tushganda har bir boʻgʻinni referens nuqtaga keltirish kerak.

== Absolyut enkoder

*Absolyut enkoder* diskida $n$ ta konsentrik yoʻlakcha bor va har bir burchak holatiga noyob $n$ razryadli kod mos keladi. Kod odatda Grey kodida yoziladi (2-maʼruza), chunki qoʻshni holatlar faqat bitta razryad bilan farq qiladi. Ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / 2^n. $)

Zamonaviy robotlarda 17–23 bitli absolyut enkoderlar keng tarqalgan; masalan, 17 bit uchun $Delta theta approx 0","0027 degree approx 10''$. Absolyut enkoder taʼminot qayta yoqilganda holatni darhol beradi, natija esa odatda ketma-ket raqamli interfeys (SSI, BiSS, EnDat va boshqalar) orqali uzatiladi. Koʻp aylanishli (_multi-turn_) absolyut enkoderlar aylanishlar sonini ham hisoblaydi.

Chiziqli siljishni oʻlchash uchun xuddi shu prinsiplarda ishlaydigan *chiziqli optik shkalalar* (inkremental va absolyut) qoʻllanadi.

== Magnit enkoderlar

*Magnit enkoderlarda* optik disk oʻrniga koʻp qutbli magnit halqa yoki diametral magnitlangan magnit, fotoqabul qilgich oʻrniga esa Xoll yoki magnitorezistiv oʻzgartirgichlar ishlatiladi. Ular optik enkoderlarga qaraganda ixcham, chang, namlik va yogʻga chidamliroq, lekin odatda ruxsat qobiliyati va aniqligi pastroq. Magnit enkoderlar mobil robotlar, kollaborativ robot boʻgʻinlari va kichik servoyuritmalarda keng qoʻllanadi.

Koʻrib chiqilgan holat datchiklari 1-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, auto, auto, 1fr),
    header: ([Datchik], [Usul], [Chiqish], [Asosiy xususiyati]),
    [Potensiometr],
    [Absolyut],
    [Analog],
    [Oddiy va arzon; kontaktli, yeyiladi],
    [LVDT],
    [Absolyut],
    [Analog (AC)],
    [Kontaktsiz, yuqori ruxsat, chiziqli siljish],
    [Rezolver],
    [Absolyut \ (1 aylanishda)],
    [Analog sin/cos],
    [Ogʻir sharoitga juda chidamli],
    [Inkremental enkoder],
    [Inkremental],
    [Impulslar A/B/Z],
    [Arzon, yuqori ruxsat; referenslash kerak],
    [Absolyut enkoder],
    [Absolyut],
    [Raqamli kod],
    [Taʼminot qayta yoqilganda holat saqlanadi],
    [Magnit enkoder],
    [Inkremental \ yoki absolyut],
    [Impuls yoki kod],
    [Ixcham, ifloslanishga chidamli],
  ),
  caption: [Holat va siljish datchiklarini taqqoslash],
) <tab-holat>

// =====================================================================
= Holat datchiklari asosida tezlikni oʻlchash
// =====================================================================

Robotlarda tezlik koʻpincha alohida datchik bilan emas, balki holat datchigi signali asosida aniqlanadi. Inkremental enkoder uchun ikki asosiy usul qoʻllanadi.

*M-usul (impulslarni sanash):* belgilangan vaqt oraligʻi $T_0$ ichida sanalgan impulslar soni $Delta P$ boʻyicha:

#eq($ omega = (2 pi dot Delta P) / (4 N dot T_0). $)

Bu usul yuqori tezliklarda aniq, lekin past tezliklarda $T_0$ ichida impulslar juda kam boʻladi. Bitta impulsga mos eng kichik oʻlchanadigan tezlik $omega_min = 2 pi slash (4 N T_0)$. Masalan, $N = 2500$, $T_0 = 1$ ms uchun $omega_min approx 0","63$ rad/s (taxminan 6 ayl/min), yaʼni bundan sekinroq aylanishni bu usul bilan farqlab boʻlmaydi.

*T-usul (davrni oʻlchash):* ikki qoʻshni impuls orasidagi vaqt yuqori chastotali taymer bilan oʻlchanadi. Bu usul past tezliklarda aniq, yuqori tezliklarda esa impulslar orasidagi vaqt juda qisqarib, aniqlik pasayadi. Amaliyotda ikkala usulni birlashtirgan aralash usullar qoʻllanadi.

Tezlanishni oʻlchash uchun esa alohida datchiklar — MEMS akselerometrlar ishlatiladi, chunki holat signalini ikki marta differensiallash shovqinni kuchli oshiradi.

// =====================================================================
= Taktil va kuch-moment datchiklari
// =====================================================================

== Taktil datchiklarning vazifalari

*Taktil datchiklar* robot va obyekt orasidagi kontaktni sezadi. Ular inson terisining texnik analogi boʻlib, quyidagi vazifalarni bajaradi:
- kontakt bor yoki yoʻqligini aniqlash;
- kontakt kuchi va bosimning sirt boʻylab taqsimlanishini oʻlchash;
- obyektning shakli, oʻlchami va joylashuvini aniqlash;
- obyekt tutqichdan sirpanib chiqayotganini (sirpanishni) sezish;
- obyektning qattiqligi, gʻadir-budurligi va haroratini baholash.

Taktil datchiklar ayniqsa nozik, moʻrt yoki notanish obyektlarni ushlashda, yigʻish ishlarida va inson bilan xavfsiz hamkorlikda zarur.

== Taktil datchiklarning turlari

Taktil datchiklar 4-maʼruzada koʻrilgan turli fizik prinsiplar asosida quriladi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.3fr, 1fr),
    header: ([Turi], [Ishlash prinsipi], [Xususiyati]),
    [Kontaktli kalitlar],
    [Mikrokalit yoki membranali kontakt],
    [Diskret: faqat kontakt bor-yoʻqligi],
    [Rezistiv (FSR, piezorezistiv)],
    [Bosim ostida oʻtkazuvchi polimer yoki yarimoʻtkazgich qarshiligi oʻzgaradi],
    [Oddiy, arzon; gisterezis va drift bor],
    [Sigʻim],
    [Elastik dielektrik siqilganda elektrodlar orasidagi masofa kamayadi],
    [Yuqori sezgirlik, matritsa qilish oson],
    [Piezoelektrik],
    [Bosim oʻzgarishida zaryad hosil boʻladi],
    [Dinamik hodisalar: sirpanish, tebranish],
    [Optik],
    [Elastik qatlam deformatsiyasi yorugʻlik oqimini oʻzgartiradi yoki kamera bilan kuzatiladi],
    [Elektromagnit xalaqitga chidamli, yuqori ruxsat],
    [Magnit],
    [Elastomerdagi magnit siljishini Xoll oʻzgartirgichi sezadi],
    [Kuch yoʻnalishini ham oʻlchay oladi],
  ),
  caption: [Taktil datchiklarning turlari],
) <tab-taktil>

== Taktil matritsalar

Kuchning sirt boʻylab taqsimlanishini oʻlchash uchun koʻplab sezgir elementlar (taksellar) $m$ qator va $n$ ustundan iborat *taktil matritsa* koʻrinishida joylashtiriladi. Elementlar soni va ularni ulash uchun kerakli simlar soni:

#eq($ N = m dot n, quad N_"sim" = m + n. $)

Qator va ustunlar navbatma-navbat ulanib, elementlar ketma-ket soʻraladi (skanerlanadi). Bitta elementni soʻrash vaqti $t_e$ boʻlsa, butun matritsani soʻrash vaqti $t_"kadr" = m dot n dot t_e$.

*Misol.* $16 times 16$ matritsada 256 ta element bor, ular atigi 32 ta sim bilan ulanadi. $t_e = 10$ µs boʻlsa, $t_"kadr" = 256 dot 10$ µs $= 2","56$ ms, yaʼni matritsa sekundiga taxminan 390 marta toʻliq yangilanadi. Elementlar soni ortsa, skanerlash vaqti ortadi — taktil matritsani loyihalashda ruxsat qobiliyati va tezkorlik oʻrtasida murosa topish kerak.

== Kuch-moment datchiklari

Robot bilagi va asbob orasiga oʻrnatiladigan *olti komponentli kuch-moment datchigi* uchta kuch ($F_x, F_y, F_z$) va uchta moment ($M_x, M_y, M_z$) komponentini oʻlchaydi. Uning elastik elementiga bir nechta tenzorezistor koʻprigi joylashtiriladi. Har bir koʻprik signali bir nechta komponentga bogʻliq boʻlgani uchun kuch va momentlar kalibrlash matritsasi $bold(C)$ yordamida hisoblanadi:

#eq($ mat(F_x; F_y; F_z; M_x; M_y; M_z) = bold(C) dot mat(u_1; u_2; dots.v; u_k), $)

bu yerda $u_1, dots, u_k$ — tenzokoʻpriklar signallari ($k >= 6$). Kuch-moment datchiklari silliqlash, yigʻish, yuzani kuzatib borish va robotni qoʻl bilan oʻrgatish (_hand guiding_) vazifalarida qoʻllanadi.

// =====================================================================
= Diskret va analog datchiklar
// =====================================================================

Chiqish signalining turiga koʻra datchiklar *diskret* va *analog* turlarga boʻlinadi. Raqamli interfeysli datchiklarni alohida uchinchi guruh sifatida koʻrish mumkin.

== Diskret datchiklar

*Diskret* (ikkilik, binar) datchiklar faqat ikki holatni — «bor» yoki «yoʻq», «yoqilgan» yoki «oʻchirilgan» — farqlaydi. Ular oʻlchanayotgan kattalik belgilangan chegaradan oʻtganini qayd etadi. Robototexnikada eng koʻp qoʻllanadigan diskret datchiklar:
- *mexanik chegara kalitlari* — harakatlanuvchi qism kontaktga tegib, kalitni ulaydi;
- *induktiv yaqinlik datchiklari* — metall obyekt yaqinlashganini kontaktsiz sezadi;
- *sigʻim yaqinlik datchiklari* — metall boʻlmagan obyektlarni ham (plastik, suyuqlik, yogʻoch) sezadi;
- *optik datchiklar* — yorugʻlik nuri toʻsilganini yoki aks etganini sezadi (nur toʻsiqlari, yorugʻlik pardalari).

Diskret datchiklar robot boʻgʻinlarining chekka holatlarini cheklash, boshlangʻich (referens) holatni aniqlash, detal mavjudligini tekshirish va xavfsizlik zonalarini nazorat qilishda ishlatiladi.

Kontaktsiz diskret datchiklarning ulanish nuqtasida *gisterezis* ataylab kiritiladi: datchik yoqiladigan va oʻchadigan masofalar biroz farq qiladi. Aks holda obyekt chegara yaqinida turganda datchik tez-tez yoqilib-oʻchib («titrab») qolardi. Sanoat datchiklarining chiqishi odatda tranzistorli boʻladi: *PNP* chiqish faol holatda yuklamani taʼminot musbat qutbiga (+24 V) ulaydi, *NPN* chiqish esa yuklamani manfiy qutbga (umumiy simga) ulaydi. Datchik turi kontroller kirishining turiga mos tanlanishi kerak.

== Analog datchiklar

*Analog* datchiklar oʻlchanayotgan kattalikka uzluksiz bogʻliq boʻlgan signal beradi. Sanoatda standart analog signallar qoʻllanadi: kuchlanish (0–10 V, ±10 V) va tok (4–20 mA). Tok signali uzun aloqa liniyalarida xalaqitga chidamliroq, chunki liniya qarshiligi tokka taʼsir qilmaydi. Signalning quyi chegarasi 0 emas, 4 mA boʻlishi («tirik nol») liniya uzilishini aniqlash imkonini beradi: tok 4 mA dan sezilarli kamaysa, bu nosozlik belgisi. Tok qiymatidan oʻlchanayotgan kattalik quyidagicha topiladi:

#eq($ x = x_min + (I - 4 "mA") / (16 "mA") dot (x_max - x_min). $)

*Misol.* Diapazoni 0…500 mm boʻlgan siljish datchigi 12 mA tok bersa, $x = (12 - 4) slash 16 dot 500 = 250$ mm.

Diskret va analog datchiklarning asosiy farqlari 3-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Koʻrsatkich], [Diskret datchik], [Analog datchik]),
    [Chiqish signali],
    [Ikki holat: 0 yoki 1],
    [Uzluksiz: kuchlanish yoki tok],
    [Beradigan axborot],
    [Chegaradan oʻtgan-oʻtmagani (1 bit)],
    [Kattalikning qiymati],
    [Kontrollerga ulanishi],
    [Diskret kirish],
    [Analog kirish (ARO)],
    [Xalaqitga chidamlilik],
    [Yuqori],
    [Past–oʻrtacha (tok signalida yuqoriroq)],
    [Narxi va soddaligi],
    [Arzon va sodda],
    [Qimmatroq, kalibrlash talab qiladi],
    [Robotdagi misollar],
    [Chegara kalitlari, yaqinlik datchiklari, nur toʻsiqlari],
    [Potensiometr, LVDT, tenzodatchik, analog bosim datchigi],
  ),
  caption: [Diskret va analog datchiklarni taqqoslash],
) <tab-diskret>

Zamonaviy robotlarda koʻplab datchiklar raqamli interfeys (IO-Link, CAN, EtherCAT, SSI) orqali ulanadi. Bunday datchiklar ichida analog signal ARO yordamida raqamga aylantiriladi, kontrollerga esa tayyor raqamli qiymat va diagnostika axboroti uzatiladi.

// =====================================================================
= Xulosa
// =====================================================================

Kinestetik datchiklar robot mexanizmining holati, tezligi, momenti va toki haqida axborot beradi va yuritmalarning qayta aloqa konturlari asosini tashkil etadi. Holat va siljish datchiklari absolyut va inkremental, chiziqli va burchak turlariga boʻlinadi; ular orasida potensiometrlar, LVDT, rezolverlar, optik va magnit enkoderlar keng qoʻllanadi. Inkremental enkoderning kvadratur signallari harakat yoʻnalishini aniqlash va ruxsat qobiliyatini toʻrt marta oshirish imkonini beradi, absolyut enkoder esa taʼminot qayta yoqilganda holatni saqlaydi.

Taktil datchiklar kontakt, kuch taqsimoti va sirpanishni sezadi; kuch-moment datchiklari esa robot asbobiga taʼsir qilayotgan kuch va momentlarni toʻliq oʻlchaydi. Chiqish signaliga koʻra datchiklar diskret va analog turlarga boʻlinadi: diskret datchiklar chegaraviy holatlarni qayd etadi, analog datchiklar esa kattalik qiymatini uzluksiz beradi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Kinestetik datchiklar qanday kattaliklarni oʻlchaydi va ular robot boʻgʻinida qayerga oʻrnatiladi?
  + Absolyut va inkremental holat datchiklari qanday farqlanadi?
  + Potensiometrning yuklama xatoligi qanday yuzaga keladi va qanday kamaytiriladi?
  + LVDT va rezolverning ishlash prinsipini tushuntiring.
  + Inkremental enkoderda harakat yoʻnalishi qanday aniqlanadi?
  + $N = 1024$ chiziqli enkoderning ×4 rejimdagi ruxsat qobiliyatini toping.
  + Necha bitli absolyut enkoder $0","01 degree$ dan yaxshiroq ruxsat qobiliyatini taʼminlaydi?
  + M-usul va T-usul bilan tezlikni oʻlchashning afzallik va kamchiliklari nimada?
  + Taktil datchiklar qanday vazifalarni bajaradi? Ularning turlarini sanab bering.
  + $32 times 32$ taktil matritsa uchun nechta sim kerak? $t_e = 5$ µs boʻlsa, kadr vaqti qancha?
  + Olti komponentli kuch-moment datchigi qanday kattaliklarni oʻlchaydi?
  + Diskret datchiklarda gisterezis nima uchun kerak? PNP va NPN chiqishlar qanday farqlanadi?
  + 4–20 mA tok signalining afzalliklari nimada? 0…10 bar datchik 16 mA bersa, bosim qancha?
]
