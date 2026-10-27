// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №6. Optik datchiklar va enkoderlar. Temperatura, bosim, tezlik
//             va tezlanishni oʻlchovchi informatsion qurilmalar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №6. Optik datchiklar va enkoderlar. Temperatura, bosim, tezlik va tezlanish kabi kattaliklarni oʻlchovchi informatsion qurilmalar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 6  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №6]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Optik datchiklar va enkoderlar. Temperatura, bosim, tezlik \ va tezlanish kabi kattaliklarni oʻlchovchi informatsion qurilmalar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Optik datchiklarning tuzilishi va fotoqabul qilgichlar.
  + Optik datchiklarning ishlash sxemalari. Optik masofa oʻlchash.
  + Optik enkoderlar: tuzilishi va ruxsat qobiliyatini oshirish.
  + Temperatura datchiklari.
  + Bosim datchiklari.
  + Tezlik datchiklari.
  + Tezlanish datchiklari va giroskoplar.

  *Tayanch iboralar:* nurlantirgich, fotodiod, fototranzistor, optojuft, nur toʻsuvchi, retroreflektiv va diffuz sxemalar, lazer triangulyatsiya, uchish vaqti (ToF), sin/cos enkoder, interpolyatsiya, termorezistor (Pt100), termistor (NTC), termojuft, sovuq uch kompensatsiyasi, absolyut, ortiqcha va differensial bosim, membrana, taxogenerator, seysmik massa, MEMS akselerometr, Koriolis giroskopi, IMU.
]

// =====================================================================
= Optik datchiklarning tuzilishi va fotoqabul qilgichlar
// =====================================================================

*Optik datchiklar* oʻlchanayotgan kattalik haqidagi axborotni yorugʻlik oqimi orqali oladi. Ular kontaktsiz, tezkor va elektromagnit xalaqitlarga chidamli boʻlgani uchun robototexnikada eng keng tarqalgan datchiklar qatoriga kiradi: optik enkoderlar, yaqinlik datchiklari, nur toʻsiqlari, masofa oʻlchagichlar, LiDAR va kameralar shular jumlasidan.

Har qanday optik datchik uchta asosiy qismdan iborat (1-rasm): *nurlantirgich* (yorugʻlik diodi yoki lazer diodi, odatda infraqizil diapazonda), *optik kanal* (yorugʻlik obyekt bilan oʻzaro taʼsirlashadigan muhit: obyekt nurni toʻsadi, aks ettiradi yoki uning xossalarini oʻzgartiradi) va *fotoqabul qilgich* (yorugʻlik oqimini elektr signaliga aylantiradi). Fotoqabul qilgich signali kuchaytiriladi va diskret datchiklarda komparator orqali ikkilik signalga, analog datchiklarda esa masofa yoki holatga mos signalga aylantiriladi.

#figure(
  diagram(
    spacing: (5mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Generator], fill: white, name: <g>),
    node((1, 0), [Nurlan- \ tirgich], name: <n>),
    node((2, 0), [Optik kanal \ va obyekt], fill: lightorange, name: <k>),
    node((3, 0), [Foto- \ qabul qilgich], name: <f>),
    node((4, 0), [Kuchay- \ tirgich], name: <ku>),
    node((5, 0), [Chiqish], fill: white, name: <ch>),
    edge(<g>, <n>, "->"),
    edge(<n>, <k>, "->", [$Phi_0$], label-side: left),
    edge(<k>, <f>, "->", [$Phi$], label-side: left),
    edge(<f>, <ku>, "->", [$I$], label-side: left),
    edge(<ku>, <ch>, "->"),
  ),
  caption: [Optik datchikning umumlashgan tuzilishi],
) <fig-optik>

Sanoat optik datchiklarida nurlantirgich yorugʻligi maʼlum chastotada *modulyatsiya* qilinadi va qabul qilgich faqat shu chastotadagi signalni ajratadi. Bu tashqi yoritish (quyosh, lampalar) taʼsirini keskin kamaytiradi.

*Fotoqabul qilgichlar* orasida eng koʻp qoʻllanadiganlari: *fotodiod* (tezkor va chiziqli, enkoderlar va masofa oʻlchagichlarda), *fototranzistor* (ichki kuchaytirishga ega, lekin sekinroq; oddiy diskret datchiklarda), *fotodiod liniyalari va matritsalari* (CCD, CMOS — triangulyatsion datchiklar va kameralarda). Fotodiod toki tushayotgan yorugʻlik oqimiga proporsional:

#eq($ I = S_lambda dot Phi, $)

bu yerda $S_lambda$ — fotodiodning spektral sezgirligi (A/W), $Phi$ — yorugʻlik oqimi quvvati (W). Nurlantirgich va fotoqabul qilgich bitta korpusda birlashtirilgan qurilma *optojuft* deyiladi; tirqishli optojuftlar oddiy enkoderlar va chegara datchiklarida ishlatiladi.

// =====================================================================
= Optik datchiklarning ishlash sxemalari. Optik masofa oʻlchash
// =====================================================================

== Diskret optik datchiklarning sxemalari

Obyektni aniqlash usuliga koʻra diskret optik datchiklar uchta asosiy sxemada ishlaydi (1-jadval).

#figure(
  btable(
    columns: (auto, 1.4fr, 1fr),
    header: ([Sxema], [Ishlash prinsipi], [Xususiyati]),
    [Nur toʻsuvchi \ (through-beam)],
    [Nurlantirgich va qabul qilgich alohida, bir-biriga qarama-qarshi oʻrnatiladi; obyekt nurni toʻsadi],
    [Eng katta masofa va ishonchlilik; ikki qurilmani oʻrnatish kerak],
    [Retroreflektiv],
    [Nur maxsus aks ettirgichdan qaytadi; obyekt nurni toʻsadi],
    [Bitta qurilma; yaltiroq obyektlarda xato boʻlishi mumkin],
    [Diffuz],
    [Nur obyektning oʻzidan sochilib qaytadi],
    [Oʻrnatish oson; masofa obyekt rangi va sirtiga bogʻliq],
  ),
  caption: [Diskret optik datchiklarning ishlash sxemalari],
) <tab-sxema>

Robototexnikada nur toʻsuvchi sxema robot ishchi zonasini himoyalovchi *yorugʻlik pardalarida* qoʻllanadi: inson parda chizigʻini kesib oʻtsa, robot toʻxtaydi. Diffuz datchiklar konveyerda detal mavjudligini va tutqichda obyekt borligini aniqlashda ishlatiladi.

== Lazer triangulyatsiya

*Triangulyatsion masofa oʻlchagichda* lazer nuri obyektga yoʻnaltiriladi, obyektdagi yorugʻ dogʻ esa nurlantirgichdan $b$ masofada (baza) joylashgan linza orqali fotodiod liniyasiga tushadi (2-rasm). Obyekt masofasi oʻzgarganda dogʻning liniyadagi oʻrni $x$ siljiydi.

#let triang = {
  let st = 1pt + headingblue
  let ln(a, b, s: st) = place(line(start: a, end: b, stroke: s))
  box(width: 11cm, height: 5.2cm, {
    // lazer va baza
    place(dx: 0.2cm, dy: 4.3cm, rect(width: 1.0cm, height: 0.5cm, fill: lightorange, stroke: 1pt))
    place(dx: 0.0cm, dy: 4.85cm, text(size: 9pt)[Lazer])
    // linza va detektor
    place(dx: 3.6cm, dy: 4.15cm, ellipse(width: 0.3cm, height: 0.8cm, fill: lightblue, stroke: 1pt))
    place(dx: 4.0cm, dy: 3.95cm, text(size: 9pt)[Linza])
    ln((3.2cm, 4.95cm), (4.6cm, 4.95cm), s: 3pt + luma(90))
    place(dx: 4.7cm, dy: 4.75cm, text(size: 9pt)[Fotodiod liniyasi])
    // lazer nuri
    ln((0.7cm, 4.3cm), (0.7cm, 0.6cm), s: 1.5pt + rgb("#d9692b"))
    // obyektlar
    ln((0.1cm, 0.6cm), (1.6cm, 0.6cm), s: 2pt + black)
    ln((0.1cm, 2.0cm), (1.6cm, 2.0cm), s: (paint: black, thickness: 2pt, dash: "dashed"))
    place(dx: 1.8cm, dy: 0.35cm, text(size: 9pt)[Obyekt (uzoq)])
    place(dx: 1.8cm, dy: 1.75cm, text(size: 9pt)[Obyekt (yaqin)])
    // aks etgan nurlar
    ln((0.7cm, 0.6cm), (3.75cm, 4.55cm))
    ln((3.75cm, 4.55cm), (3.95cm, 4.95cm))
    ln((0.7cm, 2.0cm), (3.75cm, 4.55cm), s: (paint: headingblue, thickness: 1pt, dash: "dashed"))
    ln((3.75cm, 4.55cm), (4.35cm, 4.95cm), s: (paint: headingblue, thickness: 1pt, dash: "dashed"))
    // baza
    ln((0.7cm, 3.75cm), (3.75cm, 3.75cm), s: 0.6pt + black)
    place(dx: 2.1cm, dy: 3.8cm, text(size: 10pt)[$b$])
    place(dx: 0.85cm, dy: 2.6cm, text(size: 10pt)[$D$])
  })
}

#figure(
  triang,
  caption: [Lazer triangulyatsiya prinsipi],
  placement: auto,
) <fig-triang>

Oʻxshash uchburchaklardan masofa quyidagicha topiladi:

#eq($ D = (f dot b) / x, $)

bu yerda $f$ — linzaning fokus masofasi. *Misol.* $f = 20$ mm, $b = 50$ mm va $x = 2$ mm boʻlsa, $D = 20 dot 50 slash 2 = 500$ mm. (2) ifodani differensiallasak, $|d D slash d x| = D^2 slash (f b)$, yaʼni masofa ortgan sari ruxsat qobiliyati kvadratik ravishda yomonlashadi. Shuning uchun triangulyatsion datchiklar qisqa masofalarda (millimetrlardan bir necha metrgacha) yuqori aniqlik beradi va robotlarda detal sirtini oʻlchash, payvand chokini kuzatish, sifat nazoratida qoʻllanadi.

== Uchish vaqti (ToF) usuli

Katta masofalarda *uchish vaqti* (ToF — _Time of Flight_) usuli qoʻllanadi: lazer impulsi obyektgacha borib qaytgan vaqt $t$ oʻlchanadi:

#eq($ D = (c dot t) / 2, $)

bu yerda $c approx 3 dot 10^8$ m/s — yorugʻlik tezligi. Masalan, 10 m masofa uchun $t approx 66","7$ ns. 1 sm aniqlikka erishish uchun vaqtni taxminan 67 ps aniqlikda oʻlchash kerak, bu esa juda tezkor elektronikani talab qiladi. Shuning uchun koʻp datchiklarda nurlanish amplitudasi $f_m$ chastotada modulyatsiya qilinadi va qaytgan signalning faza siljishi $Delta phi$ oʻlchanadi: $D = c Delta phi slash (4 pi f_m)$. ToF prinsipi LiDAR, ToF kameralari va lazer masofa oʻlchagichlarning asosidir.

// =====================================================================
= Optik enkoderlar: tuzilishi va ruxsat qobiliyatini oshirish
// =====================================================================

Optik enkoderlarning turlari (inkremental va absolyut) va kvadratur signallari 5-maʼruzada koʻrildi. Bu yerda ularning optik tuzilishiga va ruxsat qobiliyatini oshirish usullariga toʻxtalamiz.

Optik enkoder *kodli disk* (shisha yoki metall, ingichka shtrixlar bilan), *yoritgich* (LED va kollimator linza), *skanerlovchi niqob* (diskdagi shtrixlar bilan bir xil qadamli tirqishlar) va #strong[fotoqabul qilgichlar]dan iborat. Disk aylanganda disk va niqob tirqishlari navbatma-navbat ustma-ust tushib, yorugʻlik oqimini modulyatsiya qiladi. Shtrixlar qadami bir necha mikrometrgacha kamaytirilishi mumkin, lekin buni cheksiz davom ettirib boʻlmaydi: difraksiya va diskni yasash texnologiyasi chegara qoʻyadi.

Ruxsat qobiliyatini oshirishning asosiy usuli — *interpolyatsiya*. Yuqori aniqlikdagi enkoderlarda fotoqabul qilgichlardan toʻgʻri burchakli impulslar emas, balki 90° ga siljigan ikkita *sinusoidal signal* (sin va cos) olinadi. Shtrixlar orasidagi holat bu signallar nisbatidan rezolverdagi kabi aniqlanadi: $phi = "arctg"(U_"sin" slash U_"cos")$. Har bir sinus davri $k$ qismga boʻlinsa (interpolyatsiya koeffitsienti), burchak ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / (N dot k). $)

*Misol.* $N = 2048$ ta shtrixli sin/cos enkoder signali $k = 4096$ marta interpolyatsiya qilinsa, bir aylanishda $2048 dot 4096 = 8 388 608 = 2^23$ ta qadam, yaʼni 23 bitli ruxsat olinadi. Shu tarzda zamonaviy robot boʻgʻinlari va dastgohlarda yuqori ruxsatli enkoderlar quriladi. Biroq interpolyatsiya aniqligi sin va cos signallarining sifatiga (amplitudalar tengligi, ofset, faza siljishi) bogʻliq, shuning uchun ruxsat qobiliyati har doim aniqlikka teng emas.

Optik enkoderlarning afzalliklari — yuqori ruxsat va aniqlik, kontaktsizlik, tezkorlik; kamchiliklari — chang, yogʻ, namlik va kondensatga sezgirlik, shisha diskning zarbaga chidamsizligi. Ifloslangan muhitda magnit va induktiv enkoderlar afzalroq.

// =====================================================================
= Temperatura datchiklari
// =====================================================================

Robotlarda temperatura dvigatellar, reduktorlar, quvvat elektronikasi va akkumulyatorlarni haddan tashqari qizishdan himoyalash, shuningdek texnologik jarayonlarni (payvandlash, boʻyash, quyish) nazorat qilish uchun oʻlchanadi.

*Metall termorezistorlar.* Platina termorezistor (Pt100, Pt1000) qarshiligi 0 °C dan yuqori haroratlarda taxminan chiziqli oʻzgaradi:

#eq($ R(T) = R_0 (1 + alpha T), $)

bu yerda $R_0$ — 0 °C dagi qarshilik (Pt100 uchun 100 Ω), $alpha approx 0","00385$ 1/°C. *Misol.* 50 °C da $R = 100 dot (1 + 0","00385 dot 50) = 119","25$ Ω. Pt termorezistorlar yuqori aniqlik va barqarorlikka ega. Ulovchi simlar qarshiligi taʼsirini kamaytirish uchun ular uch yoki toʻrt simli sxemada ulanadi.

*Termistorlar* — yarimoʻtkazgichli termorezistorlar. Keng tarqalgan NTC termistorlarning qarshiligi harorat ortishi bilan nochiziqli kamayadi:

#eq($ R(T) = R_25 dot exp[B (1 / T - 1 / T_25)], $)

bu yerda $R_25$ — 25 °C dagi qarshilik, $B$ — material doimiysi, $T$ va $T_25 = 298","15$ K — absolyut haroratlar. *Misol.* $R_25 = 10$ kΩ, $B = 3950$ K boʻlsa, 50 °C (323,15 K) da $R approx 10 dot e^(-1","025) approx 3","59$ kΩ. Termistorlar juda sezgir va arzon, lekin nochiziqli; ular dvigatel chulgʻamlari va akkumulyatorlarni himoyalashda keng qoʻllanadi.

*Termojuftlar* (4-maʼruza) termo-EYuK hosil qiladi, u issiq uch harorati $T_i$ va sovuq (erkin) uchlar harorati $T_s$ farqiga bogʻliq. Shuning uchun sovuq uchlar haroratini alohida datchik bilan oʻlchab, *sovuq uch kompensatsiyasi* bajariladi:

#eq($ T_i = T_s + E / alpha. $)

*Misol.* K tipidagi termojuft ($alpha approx 41$ µV/°C) $E = 2","05$ mV bersa va sovuq uchlar harorati 25 °C boʻlsa, $T_i approx 25 + 2050 slash 41 = 75$ °C. Termojuftlar −200 °C dan +1200 °C gacha va undan yuqori haroratlarda ishlay oladi.

*Yarimoʻtkazgichli integral datchiklar* (raqamli chiqishli harorat mikrosxemalari) chiziqli va kalibrlangan natija beradi, lekin diapazoni tor (odatda −55…+150 °C). *Kontaktsiz infraqizil datchiklar (pirometrlar)* esa obyekt nurlanishi boʻyicha haroratni masofadan oʻlchaydi.

#figure(
  btable(
    columns: (auto, auto, 1fr, 1fr),
    header: ([Datchik], [Diapazon (taxminan)], [Afzalligi], [Kamchiligi]),
    [Pt100 / Pt1000],
    [−200…+600 °C],
    [Yuqori aniqlik va barqarorlik, chiziqli],
    [Qimmatroq, sekinroq],
    [NTC termistor],
    [−50…+150 °C],
    [Juda sezgir, arzon, kichik],
    [Nochiziqli, tor diapazon],
    [Termojuft],
    [−200…+1200 °C],
    [Juda keng diapazon, chidamli, tez],
    [Kichik signal, sovuq uch kompensatsiyasi kerak],
    [Integral datchik],
    [−55…+150 °C],
    [Chiziqli, kalibrlangan, raqamli chiqish],
    [Tor diapazon],
    [IQ pirometr],
    [Keng],
    [Kontaktsiz, harakatlanuvchi obyektlar],
    [Sirt nurlanish koeffitsientiga bogʻliq],
  ),
  caption: [Temperatura datchiklarini taqqoslash],
) <tab-temp>

// =====================================================================
= Bosim datchiklari
// =====================================================================

Robototexnikada bosim pnevmatik va gidravlik yuritmalarda, vakuumli tutqichlarda, shuningdek taktil datchiklarda oʻlchanadi. Oʻlchanadigan bosim turiga koʻra datchiklar uch guruhga boʻlinadi:
- *absolyut bosim* datchiklari bosimni vakuumga nisbatan oʻlchaydi;
- *ortiqcha (manometrik) bosim* datchiklari atmosfera bosimiga nisbatan oʻlchaydi: $p_"abs" = p_"ort" + p_"atm"$; atmosferadan past bosim *vakuummetrik* bosim deyiladi;
- *differensial bosim* datchiklari ikki nuqta orasidagi bosimlar farqini oʻlchaydi (masalan, filtr ifloslanishini nazorat qilish).

Koʻpchilik bosim datchiklarida sezgir element — *membrana*: bosim taʼsirida u egiladi va bu deformatsiya elektr signaliga aylantiriladi. Aylantirish usuliga koʻra datchiklar *piezorezistiv* (kremniy membranaga tenzorezistorlar diffuziya qilingan; eng keng tarqalgan), *tenzometrik* (metall membranaga yopishtirilgan tenzorezistorlar), *sigʻim* (membrana kondensator elektrodlaridan biri) va *piezoelektrik* (tez oʻzgaruvchi bosim, pulsatsiyalar uchun) turlarga boʻlinadi.

*Misol: vakuumli tutqich.* Diametri 40 mm boʻlgan vakuum soʻrgʻichda bosimlar farqi $Delta p = 0","6$ bar $= 60$ kPa yaratilsa, tutish kuchi:

#eq($ F = Delta p dot S = 60 dot 10^3 dot pi dot 0","02^2 approx 75 "N". $)

Vakuum datchigi tutqichda detal borligini va mahkam ushlanganini nazorat qiladi: detal tushib ketsa yoki soʻrgʻich havo soʻrsa, vakuum pasayadi va robot ogohlantirish oladi. Amaliyotda xavfsizlik koeffitsienti va tezlanish kuchlari hisobga olinadi, shuning uchun ruxsat etilgan yuk hisoblangan kuchdan ancha kichik boʻladi.

// =====================================================================
= Tezlik datchiklari
// =====================================================================

Robot yuritmalarida aylanish tezligi quyidagi datchiklar bilan oʻlchanadi.

*Taxogenerator* — kichik oʻzgarmas tok generatori; uning chiqish kuchlanishi aylanish tezligiga proporsional:

#eq($ U = k_omega dot omega, $)

bu yerda $k_omega$ — taxogenerator koeffitsienti (V·s/rad). Taxogenerator uzluksiz analog signal beradi va past tezliklarda ham ishlaydi, lekin kollektorli turlari yeyiladi va pulsatsiya hosil qiladi. Hozirgi servoyuritmalarda u deyarli butunlay enkoderlar bilan almashtirilgan.

*Enkoderlar* asosida tezlikni hisoblash (M- va T-usullar) 5-maʼruzada koʻrildi. *Xoll datchiklari* kollektorsiz dvigatellarda rotor holatini va tezligini aniqlaydi. *Induksion (magnit) tezlik datchiklari* tishli gʻildirak tishlari oʻtganda impulslar hosil qiladi; ular avtomobillarning gʻildirak tezligi datchiklari va mobil robotlar odometriyasida qoʻllanadi.

Mobil robotlar va avtonom transport vositalarining chiziqli tezligi gʻildirak tezligi (odometriya), GNSS, optik oqim (kamera) yoki Doppler radar yordamida aniqlanadi. Gʻildirak sirpanganda odometriya xato beradi, shuning uchun tezlik odatda bir nechta datchik maʼlumotlarini birlashtirib baholanadi.

// =====================================================================
= Tezlanish datchiklari va giroskoplar
// =====================================================================

== Akselerometrlar

*Akselerometr* chiziqli tezlanishni oʻlchaydi. Uning asosiy qismi — prujinaga osilgan *seysmik (inert) massa* $m$. Korpus $a$ tezlanish bilan harakatlanganda massa inersiya tufayli korpusga nisbatan siljiydi. Xususiy chastotadan ancha past chastotalarda siljish tezlanishga proporsional:

#eq($ x = (m dot a) / k = a / omega_n^2, quad omega_n = sqrt(k / m), $)

bu yerda $k$ — prujina bikrligi, $omega_n$ — xususiy burchak chastotasi. *Misol.* Xususiy chastotasi 5 kHz boʻlgan akselerometrda 1 g ($9","81$ m/s²) tezlanish $x = 9","81 slash (2 pi dot 5000)^2 approx 10$ nm siljish hosil qiladi. Bunday kichik siljishni oʻlchash uchun juda sezgir oʻzgartirgich kerak. (10) ifoda muhim murosani koʻrsatadi: xususiy chastota yuqori boʻlsa, akselerometr tez oʻzgaruvchi tezlanishni oʻlchay oladi, lekin sezgirligi kamayadi.

Siljishni oʻlchash usuliga koʻra akselerometrlar *sigʻim* (MEMS akselerometrlarda: kremniy massa ikki qoʻzgʻalmas elektrod orasida joylashgan differensial kondensator hosil qiladi), *piezoelektrik* (tebranish va zarbalarni oʻlchash; statik tezlanishni oʻlchamaydi) va *piezorezistiv* turlarga boʻlinadi. MEMS akselerometrlar gravitatsiya tezlanishini ham sezgani uchun ular qiyalik burchagini aniqlashda ham ishlatiladi.

== Giroskoplar va IMU

*Giroskop* burchak tezligini oʻlchaydi. Zamonaviy robotlarda asosan *MEMS (tebranuvchi) giroskoplar* qoʻllanadi. Ularda massa doimiy tebranma harakatda boʻladi; korpus $Omega$ burchak tezligi bilan aylanganda massaga tebranish yoʻnalishiga perpendikulyar Koriolis kuchi taʼsir qiladi:

#eq($ F_K = 2 m v Omega, $)

bu yerda $v$ — massaning tebranish tezligi. Koriolis kuchi hosil qilgan siljish sigʻim usulida oʻlchanadi va u burchak tezligiga proporsional boʻladi. Yuqori aniqlik talab qilinadigan navigatsiya tizimlarida optik tolali va lazer giroskoplar ham ishlatiladi.

Uch oʻqli akselerometr va uch oʻqli giroskop (koʻpincha uch oʻqli magnitometr ham) bitta korpusda birlashtirilgan qurilma *inersial oʻlchash bloki* (IMU) deyiladi. IMU mobil robotlar, dronlar, yuruvchi robotlar va avtonom transport vositalarining navigatsiya va muvozanat tizimlarining asosidir. MEMS giroskoplarning nol siljishi vaqt oʻtishi bilan oʻzgaradi (drift), shuning uchun burchak tezligini integrallab olingan yoʻnalish xatoligi asta-sekin ortadi. Bu xatolik akselerometr, magnitometr, GNSS yoki kamera maʼlumotlari bilan birlashtirish (masalan, Kalman filtri) orqali tuzatiladi.

Koʻrib chiqilgan datchiklar 3-jadvalda umumlashtirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1.2fr),
    header: ([Kattalik], [Asosiy datchiklar], [Robotdagi qoʻllanilishi]),
    [Temperatura],
    [Pt100, NTC termistor, termojuft, integral datchik, pirometr],
    [Dvigatel, drayver, akkumulyator himoyasi; texnologik jarayonlar],
    [Bosim],
    [Piezorezistiv, tenzometrik, sigʻim, piezoelektrik],
    [Pnevmo- va gidroyuritmalar, vakuumli tutqichlar],
    [Tezlik],
    [Enkoder, taxogenerator, Xoll va induksion datchiklar],
    [Yuritma tezlik konturi, odometriya],
    [Tezlanish],
    [MEMS, piezoelektrik akselerometrlar],
    [Tebranish nazorati, qiyalik, navigatsiya],
    [Burchak tezligi],
    [MEMS, optik tolali giroskoplar],
    [Dron, mobil va yuruvchi robot muvozanati va navigatsiyasi],
  ),
  caption: [Turli kattaliklarni oʻlchovchi datchiklar],
) <tab-umumiy>

// =====================================================================
= Xulosa
// =====================================================================

Optik datchiklar nurlantirgich, optik kanal va fotoqabul qilgichdan iborat boʻlib, nur toʻsuvchi, retroreflektiv va diffuz sxemalarda ishlaydi. Optik masofa oʻlchashda yaqin masofalar uchun triangulyatsiya, katta masofalar uchun uchish vaqti usuli qoʻllanadi. Optik enkoderlarning ruxsat qobiliyati sin/cos signallarni interpolyatsiya qilish orqali keskin oshiriladi.

Temperatura termorezistorlar, termistorlar, termojuftlar va integral datchiklar bilan; bosim membranali piezorezistiv, sigʻim va piezoelektrik datchiklar bilan oʻlchanadi. Tezlik enkoderlar, taxogeneratorlar, Xoll va induksion datchiklar orqali aniqlanadi. Tezlanish seysmik massali akselerometrlar, burchak tezligi esa Koriolis effektiga asoslangan giroskoplar bilan oʻlchanadi; ular birgalikda IMU ni tashkil etadi. Har bir datchik turi oʻz diapazoni, aniqligi va cheklovlariga ega, shuning uchun robot vazifasi va ish sharoitiga mos tanlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Optik datchik qanday qismlardan iborat? Nurlanish nima uchun modulyatsiya qilinadi?
  + Nur toʻsuvchi, retroreflektiv va diffuz sxemalar qanday farqlanadi?
  + Lazer triangulyatsiya prinsipini tushuntiring. Nima uchun masofa ortishi bilan aniqlik pasayadi?
  + $f = 25$ mm, $b = 40$ mm, $x = 2","5$ mm boʻlsa, obyektgacha masofa qancha?
  + ToF usulida 30 m masofa uchun yorugʻlik qancha vaqtda borib qaytadi?
  + Sin/cos enkoderlarda interpolyatsiya qanday amalga oshiriladi?
  + Pt100 termorezistor 100 °C da qanday qarshilikka ega boʻladi?
  + Termojuftda sovuq uch kompensatsiyasi nima uchun kerak?
  + Absolyut, ortiqcha va differensial bosim qanday farqlanadi?
  + Diametri 30 mm soʻrgʻichda 0,5 bar bosimlar farqi qanday tutish kuchi beradi?
  + Taxogenerator va enkoder bilan tezlikni oʻlchash qanday farqlanadi?
  + Akselerometrning xususiy chastotasi va sezgirligi oʻrtasida qanday bogʻliqlik bor?
  + MEMS giroskop qanday prinsipda ishlaydi va IMU nima?
]
