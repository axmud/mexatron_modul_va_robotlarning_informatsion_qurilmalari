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
  title: "Maʼruza №6. Optik datçiklar va enkoderlar. Temperatura, bosim, tezlik va tezlaniş kabi kattaliklarni ölçovçi informatsion qurilmalar",
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №6]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Optik datçiklar va enkoderlar. Temperatura, bosim, tezlik \ va tezlaniş kabi kattaliklarni ölçovçi informatsion qurilmalar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Optik datçiklarning tuzilişi va fotoqabul qilgiçlar.
  + Optik datçiklarning işlaş sxemalari. Optik masofa ölçaş.
  + Optik enkoderlar: tuzilişi va ruxsat qobiliyatini oşiriş.
  + Temperatura datçiklari.
  + Bosim datçiklari.
  + Tezlik datçiklari.
  + Tezlaniş datçiklari va giroskoplar.

  *Tayanç iboralar:* nurlantirgiç, fotodiod, fototranzistor, optojuft, nur tösuvçi, retroreflektiv va diffuz sxemalar, lazer triangulyatsiya, uçiş vaqti (ToF), sin/cos enkoder, interpolyatsiya, termorezistor (Pt100), termistor (NTC), termojuft, sovuq uç kompensatsiyasi, absolyut, ortiqça va differensial bosim, membrana, taxogenerator, seysmik massa, MEMS akselerometr, Koriolis giroskopi, IMU.
]

// =====================================================================
= Optik datçiklarning tuzilişi va fotoqabul qilgiçlar
// =====================================================================

*Optik datçiklar* ölçanayotgan kattalik haqidagi axborotni yoruğlik oqimi orqali oladi. Ular kontaktsiz, tezkor va elektromagnit xalaqitlarga çidamli bölgani uçun robototexnikada eng keng tarqalgan datçiklar qatoriga kiradi: optik enkoderlar, yaqinlik datçiklari, nur tösiqlari, masofa ölçagiçlar, LiDAR va kameralar şular jumlasidan.

Har qanday optik datçik uçta asosiy qismdan iborat (1-rasm): *nurlantirgiç* (yoruğlik diodi yoki lazer diodi, odatda infraqizil diapazonda), *optik kanal* (yoruğlik obyekt bilan özaro taʼsirlaşadigan muhit: obyekt nurni tösadi, aks ettiradi yoki uning xossalarini özgartiradi) va *fotoqabul qilgiç* (yoruğlik oqimini elektr signaliga aylantiradi). Fotoqabul qilgiç signali kuçaytiriladi va diskret datçiklarda komparator orqali ikkilik signalga, analog datçiklarda esa masofa yoki holatga mos signalga aylantiriladi.

#figure(
  diagram(
    spacing: (5mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Generator], fill: white, name: <g>),
    node((1, 0), [Nurlan- \ tirgiç], name: <n>),
    node((2, 0), [Optik kanal \ va obyekt], fill: lightorange, name: <k>),
    node((3, 0), [Foto- \ qabul qilgiç], name: <f>),
    node((4, 0), [Kuçay- \ tirgiç], name: <ku>),
    node((5, 0), [Çiqiş], fill: white, name: <ch>),
    edge(<g>, <n>, "->"),
    edge(<n>, <k>, "->", [$Phi_0$], label-side: left),
    edge(<k>, <f>, "->", [$Phi$], label-side: left),
    edge(<f>, <ku>, "->", [$I$], label-side: left),
    edge(<ku>, <ch>, "->"),
  ),
  caption: [Optik datçikning umumlaşgan tuzilişi],
) <fig-optik>

Sanoat optik datçiklarida nurlantirgiç yoruğligi maʼlum çastotada *modulyatsiya* qilinadi va qabul qilgiç faqat şu çastotadagi signalni ajratadi. Bu taşqi yoritiş (quyoş, lampalar) taʼsirini keskin kamaytiradi.

*Fotoqabul qilgiçlar* orasida eng köp qöllanadiganlari: *fotodiod* (tezkor va çiziqli, enkoderlar va masofa ölçagiçlarda), *fototranzistor* (içki kuçaytirişga ega, lekin sekinroq; oddiy diskret datçiklarda), *fotodiod liniyalari va matritsalari* (CCD, CMOS — triangulyatsion datçiklar va kameralarda). Fotodiod toki tuşayotgan yoruğlik oqimiga proporsional:

#eq($ I = S_lambda dot Phi, $)

bu yerda $S_lambda$ — fotodiodning spektral sezgirligi (A/W), $Phi$ — yoruğlik oqimi quvvati (W). Nurlantirgiç va fotoqabul qilgiç bitta korpusda birlaştirilgan qurilma *optojuft* deyiladi; tirqişli optojuftlar oddiy enkoderlar va çegara datçiklarida işlatiladi.

// =====================================================================
= Optik datçiklarning işlaş sxemalari. Optik masofa ölçaş
// =====================================================================

== Diskret optik datçiklarning sxemalari

Obyektni aniqlaş usuliga köra diskret optik datçiklar uçta asosiy sxemada işlaydi (1-jadval).

#figure(
  btable(
    columns: (auto, 1.4fr, 1fr),
    header: ([Sxema], [Işlaş prinsipi], [Xususiyati]),
    [Nur tösuvçi \ (through-beam)],
    [Nurlantirgiç va qabul qilgiç alohida, bir-biriga qarama-qarşi örnatiladi; obyekt nurni tösadi],
    [Eng katta masofa va işonçlilik; ikki qurilmani örnatiş kerak],
    [Retroreflektiv],
    [Nur maxsus aks ettirgiçdan qaytadi; obyekt nurni tösadi],
    [Bitta qurilma; yaltiroq obyektlarda xato bölişi mumkin],
    [Diffuz],
    [Nur obyektning özidan soçilib qaytadi],
    [Örnatiş oson; masofa obyekt rangi va sirtiga boğliq],
  ),
  caption: [Diskret optik datçiklarning işlaş sxemalari],
) <tab-sxema>

Robototexnikada nur tösuvçi sxema robot işçi zonasini himoyalovçi *yoruğlik pardalarida* qöllanadi: inson parda çiziğini kesib ötsa, robot töxtaydi. Diffuz datçiklar konveyerda detal mavjudligini va tutqiçda obyekt borligini aniqlaşda işlatiladi.

== Lazer triangulyatsiya

*Triangulyatsion masofa ölçagiçda* lazer nuri obyektga yönaltiriladi, obyektdagi yoruğ doğ esa nurlantirgiçdan $b$ masofada (baza) joylaşgan linza orqali fotodiod liniyasiga tuşadi (2-rasm). Obyekt masofasi özgarganda doğning liniyadagi örni $x$ siljiydi.

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

Öxşaş uçburçaklardan masofa quyidagiça topiladi:

#eq($ D = (f dot b) / x, $)

bu yerda $f$ — linzaning fokus masofasi. *Misol.* $f = 20$ mm, $b = 50$ mm va $x = 2$ mm bölsa, $D = 20 dot 50 slash 2 = 500$ mm. (2) ifodani differensiallasak, $|d D slash d x| = D^2 slash (f b)$, yaʼni masofa ortgan sari ruxsat qobiliyati kvadratik ravişda yomonlaşadi. Şuning uçun triangulyatsion datçiklar qisqa masofalarda (millimetrlardan bir neça metrgaça) yuqori aniqlik beradi va robotlarda detal sirtini ölçaş, payvand çokini kuzatiş, sifat nazoratida qöllanadi.

== Uçiş vaqti (ToF) usuli

Katta masofalarda *uçiş vaqti* (ToF — _Time of Flight_) usuli qöllanadi: lazer impulsi obyektgaça borib qaytgan vaqt $t$ ölçanadi:

#eq($ D = (c dot t) / 2, $)

bu yerda $c approx 3 dot 10^8$ m/s — yoruğlik tezligi. Masalan, 10 m masofa uçun $t approx 66","7$ ns. 1 sm aniqlikka erişiş uçun vaqtni taxminan 67 ps aniqlikda ölçaş kerak, bu esa juda tezkor elektronikani talab qiladi. Şuning uçun köp datçiklarda nurlaniş amplitudasi $f_m$ çastotada modulyatsiya qilinadi va qaytgan signalning faza siljişi $Delta phi$ ölçanadi: $D = c Delta phi slash (4 pi f_m)$. ToF prinsipi LiDAR, ToF kameralari va lazer masofa ölçagiçlarning asosidir.

// =====================================================================
= Optik enkoderlar: tuzilişi va ruxsat qobiliyatini oşiriş
// =====================================================================

Optik enkoderlarning turlari (inkremental va absolyut) va kvadratur signallari 5-maʼruzada körildi. Bu yerda ularning optik tuzilişiga va ruxsat qobiliyatini oşiriş usullariga töxtalamiz.

Optik enkoder *kodli disk* (şişa yoki metall, ingiçka ştrixlar bilan), *yoritgiç* (LED va kollimator linza), *skanerlovçi niqob* (diskdagi ştrixlar bilan bir xil qadamli tirqişlar) va #strong[fotoqabul qilgiçlar]dan iborat. Disk aylanganda disk va niqob tirqişlari navbatma-navbat ustma-ust tuşib, yoruğlik oqimini modulyatsiya qiladi. Ştrixlar qadami bir neça mikrometrgaça kamaytirilişi mumkin, lekin buni çeksiz davom ettirib bölmaydi: difraksiya va diskni yasaş texnologiyasi çegara qöyadi.

Ruxsat qobiliyatini oşirişning asosiy usuli — *interpolyatsiya*. Yuqori aniqlikdagi enkoderlarda fotoqabul qilgiçlardan töğri burçakli impulslar emas, balki 90° ga siljigan ikkita *sinusoidal signal* (sin va cos) olinadi. Ştrixlar orasidagi holat bu signallar nisbatidan rezolverdagi kabi aniqlanadi: $phi = "arctg"(U_"sin" slash U_"cos")$. Har bir sinus davri $k$ qismga bölinsa (interpolyatsiya koeffitsienti), burçak ruxsat qobiliyati:

#eq($ Delta theta = (360 degree) / (N dot k). $)

*Misol.* $N = 2048$ ta ştrixli sin/cos enkoder signali $k = 4096$ marta interpolyatsiya qilinsa, bir aylanişda $2048 dot 4096 = 8 388 608 = 2^23$ ta qadam, yaʼni 23 bitli ruxsat olinadi. Şu tarzda zamonaviy robot böğinlari va dastgohlarda yuqori ruxsatli enkoderlar quriladi. Biroq interpolyatsiya aniqligi sin va cos signallarining sifatiga (amplitudalar tengligi, ofset, faza siljişi) boğliq, şuning uçun ruxsat qobiliyati har doim aniqlikka teng emas.

Optik enkoderlarning afzalliklari — yuqori ruxsat va aniqlik, kontaktsizlik, tezkorlik; kamçiliklari — çang, yoğ, namlik va kondensatga sezgirlik, şişa diskning zarbaga çidamsizligi. Ifloslangan muhitda magnit va induktiv enkoderlar afzalroq.

// =====================================================================
= Temperatura datçiklari
// =====================================================================

Robotlarda temperatura dvigatellar, reduktorlar, quvvat elektronikasi va akkumulyatorlarni haddan taşqari qizişdan himoyalaş, şuningdek texnologik jarayonlarni (payvandlaş, böyaş, quyiş) nazorat qiliş uçun ölçanadi.

*Metall termorezistorlar.* Platina termorezistor (Pt100, Pt1000) qarşiligi 0 °C dan yuqori haroratlarda taxminan çiziqli özgaradi:

#eq($ R(T) = R_0 (1 + alpha T), $)

bu yerda $R_0$ — 0 °C dagi qarşilik (Pt100 uçun 100 Ω), $alpha approx 0","00385$ 1/°C. *Misol.* 50 °C da $R = 100 dot (1 + 0","00385 dot 50) = 119","25$ Ω. Pt termorezistorlar yuqori aniqlik va barqarorlikka ega. Ulovçi simlar qarşiligi taʼsirini kamaytiriş uçun ular uç yoki tört simli sxemada ulanadi.

*Termistorlar* — yarimötkazgiçli termorezistorlar. Keng tarqalgan NTC termistorlarning qarşiligi harorat ortişi bilan noçiziqli kamayadi:

#eq($ R(T) = R_25 dot exp[B (1 / T - 1 / T_25)], $)

bu yerda $R_25$ — 25 °C dagi qarşilik, $B$ — material doimiysi, $T$ va $T_25 = 298","15$ K — absolyut haroratlar. *Misol.* $R_25 = 10$ kΩ, $B = 3950$ K bölsa, 50 °C (323,15 K) da $R approx 10 dot e^(-1","025) approx 3","59$ kΩ. Termistorlar juda sezgir va arzon, lekin noçiziqli; ular dvigatel çulğamlari va akkumulyatorlarni himoyalaşda keng qöllanadi.

*Termojuftlar* (4-maʼruza) termo-EYuK hosil qiladi, u issiq uç harorati $T_i$ va sovuq (erkin) uçlar harorati $T_s$ farqiga boğliq. Şuning uçun sovuq uçlar haroratini alohida datçik bilan ölçab, *sovuq uç kompensatsiyasi* bajariladi:

#eq($ T_i = T_s + E / alpha. $)

*Misol.* K tipidagi termojuft ($alpha approx 41$ µV/°C) $E = 2","05$ mV bersa va sovuq uçlar harorati 25 °C bölsa, $T_i approx 25 + 2050 slash 41 = 75$ °C. Termojuftlar −200 °C dan +1200 °C gaça va undan yuqori haroratlarda işlay oladi.

*Yarimötkazgiçli integral datçiklar* (raqamli çiqişli harorat mikrosxemalari) çiziqli va kalibrlangan natija beradi, lekin diapazoni tor (odatda −55…+150 °C). *Kontaktsiz infraqizil datçiklar (pirometrlar)* esa obyekt nurlanişi böyiça haroratni masofadan ölçaydi.

#figure(
  btable(
    columns: (auto, auto, 1fr, 1fr),
    header: ([Datçik], [Diapazon (taxminan)], [Afzalligi], [Kamçiligi]),
    [Pt100 / Pt1000],
    [−200…+600 °C],
    [Yuqori aniqlik va barqarorlik, çiziqli],
    [Qimmatroq, sekinroq],
    [NTC termistor],
    [−50…+150 °C],
    [Juda sezgir, arzon, kiçik],
    [Noçiziqli, tor diapazon],
    [Termojuft],
    [−200…+1200 °C],
    [Juda keng diapazon, çidamli, tez],
    [Kiçik signal, sovuq uç kompensatsiyasi kerak],
    [Integral datçik],
    [−55…+150 °C],
    [Çiziqli, kalibrlangan, raqamli çiqiş],
    [Tor diapazon],
    [IQ pirometr],
    [Keng],
    [Kontaktsiz, harakatlanuvçi obyektlar],
    [Sirt nurlaniş koeffitsientiga boğliq],
  ),
  caption: [Temperatura datçiklarini taqqoslaş],
) <tab-temp>

// =====================================================================
= Bosim datçiklari
// =====================================================================

Robototexnikada bosim pnevmatik va gidravlik yuritmalarda, vakuumli tutqiçlarda, şuningdek taktil datçiklarda ölçanadi. Ölçanadigan bosim turiga köra datçiklar uç guruhga bölinadi:
- *absolyut bosim* datçiklari bosimni vakuumga nisbatan ölçaydi;
- *ortiqça (manometrik) bosim* datçiklari atmosfera bosimiga nisbatan ölçaydi: $p_"abs" = p_"ort" + p_"atm"$; atmosferadan past bosim *vakuummetrik* bosim deyiladi;
- *differensial bosim* datçiklari ikki nuqta orasidagi bosimlar farqini ölçaydi (masalan, filtr ifloslanişini nazorat qiliş).

Köpçilik bosim datçiklarida sezgir element — *membrana*: bosim taʼsirida u egiladi va bu deformatsiya elektr signaliga aylantiriladi. Aylantiriş usuliga köra datçiklar *piezorezistiv* (kremniy membranaga tenzorezistorlar diffuziya qilingan; eng keng tarqalgan), *tenzometrik* (metall membranaga yopiştirilgan tenzorezistorlar), *siğim* (membrana kondensator elektrodlaridan biri) va *piezoelektrik* (tez özgaruvçi bosim, pulsatsiyalar uçun) turlarga bölinadi.

*Misol: vakuumli tutqiç.* Diametri 40 mm bölgan vakuum sörğiçda bosimlar farqi $Delta p = 0","6$ bar $= 60$ kPa yaratilsa, tutiş kuçi:

#eq($ F = Delta p dot S = 60 dot 10^3 dot pi dot 0","02^2 approx 75 "N". $)

Vakuum datçigi tutqiçda detal borligini va mahkam uşlanganini nazorat qiladi: detal tuşib ketsa yoki sörğiç havo sörsa, vakuum pasayadi va robot ogohlantiriş oladi. Amaliyotda xavfsizlik koeffitsienti va tezlaniş kuçlari hisobga olinadi, şuning uçun ruxsat etilgan yuk hisoblangan kuçdan ança kiçik böladi.

// =====================================================================
= Tezlik datçiklari
// =====================================================================

Robot yuritmalarida aylaniş tezligi quyidagi datçiklar bilan ölçanadi.

*Taxogenerator* — kiçik özgarmas tok generatori; uning çiqiş kuçlanişi aylaniş tezligiga proporsional:

#eq($ U = k_omega dot omega, $)

bu yerda $k_omega$ — taxogenerator koeffitsienti (V·s/rad). Taxogenerator uzluksiz analog signal beradi va past tezliklarda ham işlaydi, lekin kollektorli turlari yeyiladi va pulsatsiya hosil qiladi. Hozirgi servoyuritmalarda u deyarli butunlay enkoderlar bilan almaştirilgan.

*Enkoderlar* asosida tezlikni hisoblaş (M- va T-usullar) 5-maʼruzada körildi. *Xoll datçiklari* kollektorsiz dvigatellarda rotor holatini va tezligini aniqlaydi. *Induksion (magnit) tezlik datçiklari* tişli ğildirak tişlari ötganda impulslar hosil qiladi; ular avtomobillarning ğildirak tezligi datçiklari va mobil robotlar odometriyasida qöllanadi.

Mobil robotlar va avtonom transport vositalarining çiziqli tezligi ğildirak tezligi (odometriya), GNSS, optik oqim (kamera) yoki Doppler radar yordamida aniqlanadi. Ğildirak sirpanganda odometriya xato beradi, şuning uçun tezlik odatda bir neçta datçik maʼlumotlarini birlaştirib baholanadi.

// =====================================================================
= Tezlaniş datçiklari va giroskoplar
// =====================================================================

== Akselerometrlar

*Akselerometr* çiziqli tezlanişni ölçaydi. Uning asosiy qismi — prujinaga osilgan *seysmik (inert) massa* $m$. Korpus $a$ tezlaniş bilan harakatlanganda massa inersiya tufayli korpusga nisbatan siljiydi. Xususiy çastotadan ança past çastotalarda siljiş tezlanişga proporsional:

#eq($ x = (m dot a) / k = a / omega_n^2, quad omega_n = sqrt(k / m), $)

bu yerda $k$ — prujina bikrligi, $omega_n$ — xususiy burçak çastotasi. *Misol.* Xususiy çastotasi 5 kHz bölgan akselerometrda 1 g ($9","81$ m/s²) tezlaniş $x = 9","81 slash (2 pi dot 5000)^2 approx 10$ nm siljiş hosil qiladi. Bunday kiçik siljişni ölçaş uçun juda sezgir özgartirgiç kerak. (10) ifoda muhim murosani körsatadi: xususiy çastota yuqori bölsa, akselerometr tez özgaruvçi tezlanişni ölçay oladi, lekin sezgirligi kamayadi.

Siljişni ölçaş usuliga köra akselerometrlar *siğim* (MEMS akselerometrlarda: kremniy massa ikki qözğalmas elektrod orasida joylaşgan differensial kondensator hosil qiladi), *piezoelektrik* (tebraniş va zarbalarni ölçaş; statik tezlanişni ölçamaydi) va *piezorezistiv* turlarga bölinadi. MEMS akselerometrlar gravitatsiya tezlanişini ham sezgani uçun ular qiyalik burçagini aniqlaşda ham işlatiladi.

== Giroskoplar va IMU

*Giroskop* burçak tezligini ölçaydi. Zamonaviy robotlarda asosan *MEMS (tebranuvçi) giroskoplar* qöllanadi. Ularda massa doimiy tebranma harakatda böladi; korpus $Omega$ burçak tezligi bilan aylanganda massaga tebraniş yönalişiga perpendikulyar Koriolis kuçi taʼsir qiladi:

#eq($ F_K = 2 m v Omega, $)

bu yerda $v$ — massaning tebraniş tezligi. Koriolis kuçi hosil qilgan siljiş siğim usulida ölçanadi va u burçak tezligiga proporsional böladi. Yuqori aniqlik talab qilinadigan navigatsiya tizimlarida optik tolali va lazer giroskoplar ham işlatiladi.

Uç öqli akselerometr va uç öqli giroskop (köpinça uç öqli magnitometr ham) bitta korpusda birlaştirilgan qurilma *inersial ölçaş bloki* (IMU) deyiladi. IMU mobil robotlar, dronlar, yuruvçi robotlar va avtonom transport vositalarining navigatsiya va muvozanat tizimlarining asosidir. MEMS giroskoplarning nol siljişi vaqt ötişi bilan özgaradi (drift), şuning uçun burçak tezligini integrallab olingan yönaliş xatoligi asta-sekin ortadi. Bu xatolik akselerometr, magnitometr, GNSS yoki kamera maʼlumotlari bilan birlaştiriş (masalan, Kalman filtri) orqali tuzatiladi.

Körib çiqilgan datçiklar 3-jadvalda umumlaştirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1.2fr),
    header: ([Kattalik], [Asosiy datçiklar], [Robotdagi qöllanilişi]),
    [Temperatura],
    [Pt100, NTC termistor, termojuft, integral datçik, pirometr],
    [Dvigatel, drayver, akkumulyator himoyasi; texnologik jarayonlar],
    [Bosim],
    [Piezorezistiv, tenzometrik, siğim, piezoelektrik],
    [Pnevmo- va gidroyuritmalar, vakuumli tutqiçlar],
    [Tezlik],
    [Enkoder, taxogenerator, Xoll va induksion datçiklar],
    [Yuritma tezlik konturi, odometriya],
    [Tezlaniş],
    [MEMS, piezoelektrik akselerometrlar],
    [Tebraniş nazorati, qiyalik, navigatsiya],
    [Burçak tezligi],
    [MEMS, optik tolali giroskoplar],
    [Dron, mobil va yuruvçi robot muvozanati va navigatsiyasi],
  ),
  caption: [Turli kattaliklarni ölçovçi datçiklar],
) <tab-umumiy>

// =====================================================================
= Xulosa
// =====================================================================

Optik datçiklar nurlantirgiç, optik kanal va fotoqabul qilgiçdan iborat bölib, nur tösuvçi, retroreflektiv va diffuz sxemalarda işlaydi. Optik masofa ölçaşda yaqin masofalar uçun triangulyatsiya, katta masofalar uçun uçiş vaqti usuli qöllanadi. Optik enkoderlarning ruxsat qobiliyati sin/cos signallarni interpolyatsiya qiliş orqali keskin oşiriladi.

Temperatura termorezistorlar, termistorlar, termojuftlar va integral datçiklar bilan; bosim membranali piezorezistiv, siğim va piezoelektrik datçiklar bilan ölçanadi. Tezlik enkoderlar, taxogeneratorlar, Xoll va induksion datçiklar orqali aniqlanadi. Tezlaniş seysmik massali akselerometrlar, burçak tezligi esa Koriolis effektiga asoslangan giroskoplar bilan ölçanadi; ular birgalikda IMU ni taşkil etadi. Har bir datçik turi öz diapazoni, aniqligi va çeklovlariga ega, şuning uçun robot vazifasi va iş şaroitiga mos tanlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Optik datçik qanday qismlardan iborat? Nurlaniş nima uçun modulyatsiya qilinadi?
  + Nur tösuvçi, retroreflektiv va diffuz sxemalar qanday farqlanadi?
  + Lazer triangulyatsiya prinsipini tuşuntiring. Nima uçun masofa ortişi bilan aniqlik pasayadi?
  + $f = 25$ mm, $b = 40$ mm, $x = 2","5$ mm bölsa, obyektgaça masofa qança?
  + ToF usulida 30 m masofa uçun yoruğlik qança vaqtda borib qaytadi?
  + Sin/cos enkoderlarda interpolyatsiya qanday amalga oşiriladi?
  + Pt100 termorezistor 100 °C da qanday qarşilikka ega böladi?
  + Termojuftda sovuq uç kompensatsiyasi nima uçun kerak?
  + Absolyut, ortiqça va differensial bosim qanday farqlanadi?
  + Diametri 30 mm sörğiçda 0,5 bar bosimlar farqi qanday tutiş kuçi beradi?
  + Taxogenerator va enkoder bilan tezlikni ölçaş qanday farqlanadi?
  + Akselerometrning xususiy çastotasi va sezgirligi örtasida qanday boğliqlik bor?
  + MEMS giroskop qanday prinsipda işlaydi va IMU nima?
]
