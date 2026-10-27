// ============================================================
//  MMRIQ — 6-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_6.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Birlamçi özgartirgiçlar işini tahlil qiliş. Optik hamda temperatura datçiklari")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 6  // amaliyot raqami
#set document(keywords: (info.fan,))
#set page(header: context {
  set text(size: 9pt, fill: luma(110))
  grid(
    columns: (3fr, auto, 1fr),
    align: (left, center, right),
    info.fan, info.semestr, [Amaliyot №#raqam],
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + luma(170))
})
// ===================
#set text(size: 12pt, lang: "uz", font: info.font)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)", supplement: none)
#show link: set text(fill: blue.darken(20%))
#show heading: set text(fill: headingblue)
#show heading.where(level: 1): set block(above: 1.4em, below: 0.9em)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: image): set figure(supplement: "Rasm")
#show figure.where(kind: table): set figure(supplement: "Jadval")

// Raqamlanmagan formula
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №6]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Birlamçi özgartirgiçlar işini tahlil qiliş. Optik hamda temperatura datçigining işlaş tamoyilini örganiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatron modullar va robotik tizimlarda qöllaniladigan birlamçi özgartirgiçlarning (_primary transducers_) işlaş prinsiplari, optik (fotorezistor, fotodiod, fototranzistor, optopara, enkoder) va temperatura datçiklarining (termopara, RTD Pt100, NTC/PTC termistor, yarimötkazgiçli IC sensorlar) fizik-texnik xarakteristikalari, signalni şakllantiriş va ölçaş zanjirlarini hisoblaş hamda tahlil qiliş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Birlamçi özgartirgiçlar (sezgir element) va ikkilamçi özgartirgiçlar (signalni konditsiyalaş/kuçaytiriş) örtasidagi funksional va strukturaviy boğliqlikni örganiş.
+ Optik datçiklarning işlaşidagi fizik hodisalarni (içki va taşqi fotoeffekt, yarimötkazgiçli $p$-$n$ ötişdagi fotoeffekt, foto-EYuK va fototok) hamda optoelektron modullarni tahlil qiliş.
+ Temperatura (harorat) datçiklarining işlaş tamoyillarini (Seebeck termo-EYuK effekti, metall va yarimötkazgiçlar qarşiligining haroratga boğliqligi) örganiş.
+ Vitston köprigi (_Wheatstone bridge_), operatsion kuçaytirgiçli transimpedans kuçaytirgiç (TIA) hamda instrumental kuçaytirgiçlarning hisoblaş modellarini tuziş.
+ Optik va harorat ölçov zanjirlarini modellaştiriş hamda tajriba natijalarini matematik qayta işlaş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* birlamçi özgartirgiçlar va sensorli modullar laboratoriya stendi, optoelektron stend (yoruğlik manbai, fotodiod, fotorezistor, optopara, optik diskli enkoder), harorat ölçov stendi (termostat, Pt100 RTD, K-tip termopara, NTC termistor, LM35 / DS18B20 IC datçiklar).
- *Nazorat-ölçov va manba vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, özgarmas tok manbai ($0 dots 30 "V DC"$), etalon yoritilganlik ölçagiç (lyuksmetr).
- *Boşqaruv va DAQ modullari:* STM32F4/F7 mikrokontrollerli plata, Arduino Mega, National Instruments DAQ platasi.
- *Dasturiy muhit:* MATLAB / Simulink (Simscape Electrical), LabVIEW, Proteus.

= Nazariy maʼlumotlar va konseptual tizimlar

== Birlamçi özgartirgiçlar (primary transducers) tuşunçasi va örni

P.P.L. Regtien va W. Bolton darsliklariga köra, *birlamçi özgartirgiç (datçik/sensor)* deb ölçanayotgan fizik kattalikni (harorat, yoritilganlik, bosim, siljiş) bevosita qabul qilib, uni keyingi qayta işlaş uçun qulay bölgan elektr signaliga (kuçlaniş, tok, qarşilik, siğim, çastota) aylantiruvçi elementga aytiladi.

Birlamçi özgartirgiçlar fizik hodisalarga tayangan holda ikkita katta guruhga bölinadi:

+ *Generatorli (aktiv) özgartirgiçlar:* taşqi energiya manbaisiz fizik energiyani bevosita elektr energiyasiga (EYuK yoki tok) aylantiradi. Misol: termopara (termo-EYuK), pyezoelektr datçik, fotoelement (fotogalvanik rejim).
+ *Parametrik (passiv) özgartirgiçlar:* ölçanayotgan kattalik taʼsirida özining elektr parametrini (qarşilik $R$, siğim $C$, induktivlik $L$) özgartiradi va işlaşi uçun taşqi quvvat manbaini talab qiladi. Misol: termistor, RTD Pt100, fotorezistor, tenzorezistor, LVDT.

_Izoh:_ uşbu nomlaş rus tilidagi adabiyot anʼanasiga mos. Ingliz tilidagi ayrim manbalarda (masalan, J. Fraden) aksinça: taşqi manbasiz işlovçi datçiklar _passive_, manba talab qiluvçilar esa _active_ deb ataladi.

== Optik datçiklarning işlaş tamoyillari va turlari

Optik datçiklar elektromagnit nurlanişni (körinuvçi, infraqizil va ultrabinafşa diapazonlar) elektr signaliga aylantiradi (@tab-optical).

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*№*], [*Optik datçik turi*], [*Fizik hodisasi / tamoyili*], [*Asosiy xarakteristikasi va qöllanilişi*]
      ),
      table.hline(stroke: 0.5pt),
      [1], [*Fotorezistor (LDR)*], [Içki fotoeffekt: yoruğlik tuşganda qarşilik $R_"LDR"$ keskin kamayadi.],
      [Noçiziqli $R(E)$ boğliqlik; sezgirligi yuqori, lekin inersiyasi katta ($10 dots 100 "ms"$). Yoruğlik kalitlari.],
      [2], [*Fotodiod* (Photodiode)], [$p$-$n$ ötiş teskari siljitilganda fototok $I_"ph"$ hosil bölişi.],
      [Yuqori tezkorlik (ns tartibida); çiziqli $I_"ph" (E)$ tavsifi. Optik enkoder va optik tola aloqasi.],
      [3], [*Fototranzistor*], [Fotodiod va tranzistor kuçaytirgiçining birikmasi.],
      [Sezgirligi fotodiodga nisbatan $100 dots 500$ baravar yuqori, lekin çastotasi pastroq. Optopara (optocoupler).],
      [4], [*Optik enkoder*], [Diskdagi tirqişlar orqali nur ötişini sanaş (inkremental/absolyut).],
      [Yuqori ajratiş qobiliyati ($1024 dots 65536 "ppr"$). Robot böğinlari va motor vallari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Optik datçiklarning turlari va fizik-texnik körsatkiçlari],
) <tab-optical>

== Temperatura (harorat) datçiklarining işlaş tamoyillari

Harorat mexatronik tizimlarda termodinamik holatni va xavfsizlikni nazorat qiluvçi eng muhim parametrlardan biridir. Asosiy harorat datçiklari @tab-temp da keltirilgan.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, 2.6cm, 3.8cm, 2.3cm, 1fr),
      align: (center + horizon, left + horizon, left + horizon, center + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Datçik turi*], [*Işlaş tamoyili / formula*], [*Diapazoni*], [*Afzalligi va kamçiligi*]),
      table.hline(stroke: 0.5pt),
      [1],
      [*Termopara* (Thermocouple)],
      [Seebeck effekti: \ $E = S dot (T_"hot" - T_"cold")$],
      [$-200 dots +1800 degree"C"$],
      [Juda keng diapazon, metall konstruksiya; signal kiçik (mV).],
      [2], [*RTD Pt100*], [Metall qarşiligi: \ $R(T) = R_0 (1 + alpha T)$], [$-200 dots +850 degree"C"$],
      [Yuqori aniqlik va çiziqlilik; sezgirligi örtaça ($0.385 thin Omega\/degree"C"$).],
      [3],
      [*NTC termistor*],
      [Yarimötkazgiç qarşiligi: \ $R(T) = R_0 e^(beta (1\/T - 1\/T_0))$ \ ($T$ --- kelvinda)],
      [$-50 dots +150 degree"C"$],
      [Yuqori sezgirlik; keskin noçiziqli tavsif.],
      [4],
      [*IC sensor* (LM35)],
      [$p$-$n$ ötiş kuçlanişi: \ $V_"out" = 10 "mV"\/degree"C"$],
      [$-55 dots +150 degree"C"$],
      [Tayyor çiziqli kuçlaniş çiqişi; diapazoni kiçik.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Harorat datçiklarining qiyosiy texnik xarakteristikalari],
) <tab-temp>

= Mavzuga oid çizmalar va sxemalar

== Birlamçi va ikkilamçi özgartirgiçlarning ketma-ket funksional zanjiri

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let small(body) = text(size: 7pt, body)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (6mm, 10mm),
      edge-stroke: 2pt + headingblue,

      node((0, 0), b[Fizik kattalik \ ($T, E, x, P$)], width: 2.3cm, height: 1.3cm),
      node((1, 0), b[*Birlamçi* \ *özgartirgiç* \ (Pt100, fotodiod)], width: 2.5cm, height: 1.3cm),
      node((2, 0), b[*Ikkilamçi* \ *özgartirgiç* \ (Vitston köprigi / TIA)], width: 2.5cm, height: 1.5cm),
      node((3, 0), b[Signalni \ konditsiyalaş \ (Op-Amp / LPF)], width: 2.5cm, height: 1.3cm),
      node((4, 0), b[ADC va MCU \ (STM32 / DSP)], width: 2.5cm, height: 1.3cm),

      edge((0, 0), (1, 0), "-|>", label: small[Fizik taʼsir], stroke: 1pt, label-sep: 19pt),
      edge((1, 0), (2, 0), "-|>", label: small[$R, I, E$], stroke: 1pt, label-sep: 19pt),
      edge((2, 0), (3, 0), "-|>", label: small[mV signal], stroke: 1pt, label-sep: 19pt),
      edge((3, 0), (4, 0), "-|>", label: small[$0 dots 3.3 "V"$], stroke: 1pt, label-sep: 19pt),
    )
  },
  caption: [Birlamçi va ikkilamçi özgartirgiçlarning axborot şakllantiriş zanjiri],
) <fig-chain>

== Fotodiod va transimpedans kuçaytirgiçli (TIA) optik ölçov zanjiri

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let w = 1pt
    let orng = orange.darken(15%)
    let small(body) = text(size: 8pt, body)
    let gnd(p) = {
      line(p, (p.at(0), p.at(1) - 0.15), stroke: w)
      line((p.at(0) - 0.25, p.at(1) - 0.15), (p.at(0) + 0.25, p.at(1) - 0.15), stroke: w)
      line((p.at(0) - 0.15, p.at(1) - 0.23), (p.at(0) + 0.15, p.at(1) - 0.23), stroke: w)
      line((p.at(0) - 0.05, p.at(1) - 0.31), (p.at(0) + 0.05, p.at(1) - 0.31), stroke: w)
    }

    // LED yorugʻlik manbai va fotonlar
    circle((-3.2, 1), radius: 0.4, fill: orange.lighten(80%), stroke: 1pt + orng)
    content((-3.2, 1), text(size: 7pt, weight: "bold")[LED])
    line((-2.6, 1.2), (-1.3, 1.2), stroke: 2pt + orng, mark: (end: "stealth", fill: orng))
    line((-2.6, 0.8), (-1.3, 0.8), stroke: 2pt + orng, mark: (end: "stealth", fill: orng))
    content((-1.95, 1.3), anchor: "south", small[Fotonlar ($h nu$)])

    // Fotodiod: anod — GND, katod — kuchaytirgichning (−) kirishiga
    line((-1.0, 0.55), (-1.0, 1.45), (-0.2, 1.0), close: true, fill: white, stroke: w)
    line((-0.2, 0.55), (-0.2, 1.45), stroke: 1.5pt)
    line((-1.0, 1.0), (-1.3, 1.0), (-1.3, 0.2), stroke: w)
    gnd((-1.3, 0.2))
    content((-0.6, 0.45), anchor: "north", text(size: 7pt)[$I_"ph"$])
    line((-0.2, 1.0), (1.2, 1.0), stroke: w)

    // Operatsion kuchaytirgich
    line((1.5, 0.2), (3.0, 1.0), (1.5, 1.8), close: true, fill: blue.lighten(93%), stroke: 1.2pt)
    content((1.72, 1.4), text(size: 10pt)[$-$])
    content((1.72, 0.6), text(size: 10pt)[$+$])
    line((1.2, 1.0), (1.2, 1.4), (1.5, 1.4), stroke: w)
    line((1.5, 0.6), (1.0, 0.6), (1.0, 0.2), stroke: w)
    gnd((1.0, 0.2))

    // Qayta aloqa qarshiligi R_f
    line((1.2, 1.4), (1.2, 2.4), (1.8, 2.4), stroke: w)
    rect((1.8, 2.2), (2.6, 2.6), fill: gray.lighten(85%), stroke: w)
    content((2.2, 2.4), text(size: 8pt, weight: "bold")[$R_f$])
    line((2.6, 2.4), (3.4, 2.4), (3.4, 1.0), stroke: w)
    circle((1.2, 1.0), radius: 0.04, fill: black)
    circle((3.4, 1.0), radius: 0.04, fill: black)

    // Chiqish
    line((3.0, 1.0), (4.0, 1.0), stroke: w)
    content((4.05, 1.0), anchor: "west", text(size: 9pt, weight: "bold")[$V_"out" = I_"ph" dot R_f$])
  }),
  caption: [Fotodiod va transimpedans kuçaytirgiçli (TIA) optik ölçov zanjiri],
) <fig-tia>

== Pt100 RTD datçigi uçun Vitston köprigi va instrumental kuçaytirgiç

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let w = 1pt
    let orng = orange.darken(15%)
    let top = (1.5, 3.5)
    let bot = (1.5, 0.5)
    let a = (0, 2)
    let b = (3, 2)
    let res(p, q, lab, fill: gray.lighten(85%)) = {
      line(p, q, stroke: w)
      let m = ((p.at(0) + q.at(0)) / 2, (p.at(1) + q.at(1)) / 2)
      rect((m.at(0) - 0.45, m.at(1) - 0.2), (m.at(0) + 0.45, m.at(1) + 0.2), fill: fill, stroke: w)
      content(m, text(size: 7pt, weight: "bold", lab))
    }

    // Koʻprik elkalari
    res(top, a, $R_2$)
    res(a, bot, box(baseline: -100%)[$R_3$])
    res(top, b, $R_1$)
    res(b, bot, box(baseline: -100%)[#text(size: 4pt)[Pt100 ($R_T$)]], fill: orange.lighten(75%))

    // Manba va yer
    line(top, (1.5, 4.1), stroke: w)
    content((1.5, 4.2), anchor: "south", text(size: 9pt, weight: "bold")[$+V_"ex" = 5 "V"$])
    line(bot, (1.5, 0.0), stroke: w)
    line((1.25, 0.0), (1.75, 0.0), stroke: w)
    line((1.35, -0.08), (1.65, -0.08), stroke: w)
    line((1.45, -0.16), (1.55, -0.16), stroke: w)

    // Tugunlar
    for p in (a, b) { circle(p, radius: 0.05, fill: black) }
    content((-0.1, 2.15), anchor: "south-east", text(size: 8pt)[A])
    content((3.1, 2.15), anchor: "south-west", text(size: 8pt)[B])

    // Differensial chiqish kuchaytirgichga
    line(a, (-0.5, 2), (-0.5, 1.2), (4.0, 1.2), stroke: w)
    line(b, (4.0, 2), stroke: w)
    content((3.6, 1.6), anchor: "south", text(size: 8pt)[$V_"bridge"$])

    // Instrumental kuchaytirgich
    rect((4.0, 0.8), (6.5, 2.4), radius: 0.12, fill: blue.lighten(90%), stroke: 1.2pt + headingblue)
    content((5.25, 1.6), align(center, text(
      size: 8pt,
      weight: "bold",
      fill: headingblue,
    )[Instrumental \ kuçaytirgiç \ ($G = 40$)]))
    line((6.5, 1.6), (7.4, 1.6), stroke: 2.5pt + headingblue, mark: (end: "stealth", fill: headingblue))
    content((7.5, 1.6), anchor: "west", text(size: 9pt, weight: "bold")[$V_"out" = G dot V_"bridge"$])
  }),
  caption: [Pt100 RTD datçigi va Vitston köprigi asosidagi harorat ölçaş sxemasi],
) <fig-bridge>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: optik va temperatura datçiklarini qiyosiy tahlil qiliş

Har bir datçik turining fizik, metrologik va ekspluatatsion xususiyatlarini tahlil qiling va @tab-compare ni töldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (2.8cm, 2.8cm, 3cm, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Datçik turi*], [*Reaksiya tezligi (dinamika)*], [*Çiziqlilik va sezgirlik*], [*Asosiy ustunligi va kamçiligi*]
      ),
      table.hline(stroke: 0.5pt),
      [*Fotorezistor (LDR)*], [Sekin ($10 dots 100 "ms"$)], [Noçiziqli; yuqori sezgirlik],
      [*Ustunligi:* arzon, sodda. \ *Kamçiligi:* inersion, haroratga boğliq.],
      [*Fotodiod*], [Öta tez ($< 1 thin mu"s"$)], [Yuqori çiziqlilik; sezgirligi örtaça],
      [*Ustunligi:* aniq va tezkor. \ *Kamçiligi:* fototok kiçik (nA $dots$ µA).],
      [*RTD Pt100*], [Örtaça ($0.5 dots 2 "s"$)], [Yuqori çiziqlilik ($0.385 thin Omega\/degree"C"$)],
      [*Ustunligi:* etalon darajadagi aniqlik. \ *Kamçiligi:* öz-özini qizdiriş xatosi.],
      [*Termopara (K-tip)*],
      [Örtaça / tez ($0.1 dots 1 "s"$)],
      [Sezilarli noçiziqli ($approx 41 thin mu"V"\/degree"C"$)],
      [*Ustunligi:* juda yuqori haroratlarda işlaydi. \ *Kamçiligi:* sovuq tutaşuv kompensatsiyasi şart.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Birlamçi optik va harorat özgartirgiçlarining qiyosiy tahlili],
) <tab-compare>

== Topşiriq 2: sanoat peçi va robot tutqiçi uçun datçik tanlaş

Quyidagi ikkita texnologik modul uçun birlamçi özgartirgiç va signalni konditsiyalaş zanjirini tanlang hamda asoslang:

+ *1-modul:* $800 degree"C"$ haroratli metall eritiş peçi haroratini ölçaş.
+ *2-modul:* robot tutqiçida obyekt bor-yöqligini $2 "mm"$ masofadan kontaktsiz aniqlaş (javob vaqti $< 1 "ms"$).

*Tahlil va yeçim:*

- *1-modul uçun:* _K-tip (xromel–alyumel) termopara_. Sababi: yuqori harorat diapazoni ($1200 degree"C"$ gaça) va çidamliligi. Signalni konditsiyalaş: sovuq tutaşuv kompensatsiyasiga ega MAX31855 ADC mikrosxemasi.
- *2-modul uçun:* _fotodiodli optopara / reflektiv optik sensor_. Sababi: mikrosekund darajasidagi tezkorlik va kontaktsizlik. Signalni konditsiyalaş: komparator (LM393) va LED drayveri.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: Pt100 RTD va Vitston köprigi ölçov zanjiri hisobi

Pt100 datçigining $T = 0 degree"C"$ dagi qarşiligi $R_0 = 100.0 thin Omega$, harorat koeffitsienti $alpha = 0.00385 thin degree"C"^(-1)$. Datçik Vitston köprigining bitta elkasiga ulangan ($R_1 = R_2 = R_3 = 100.0 thin Omega$, @fig-bridge). Köprik manba kuçlanişi $V_"ex" = 5.0 "V"$.

#set enum(numbering: "a)")
+ Harorat $T = 80 degree"C"$ bölganda Pt100 qarşiligi $R_T$ neçaga teng böladi?
+ Köprik diagonalidagi kuçlaniş $V_"bridge"$ ni hisoblang.
+ Agar instrumental kuçaytirgiçning kuçaytiriş koeffitsienti $G = 40$ bölsa, çiqiş kuçlanişi $V_"out"$ neçaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ R_T = R_0 (1 + alpha T) $)
#eq($ V_"bridge" = V_B - V_A = V_"ex" (R_T / (R_1 + R_T) - R_3 / (R_2 + R_3)) $)
#eq($ V_"out" = G dot V_"bridge" $)

*Hisoblaş bosqiçlari:*

- $T = 80 degree"C"$ da Pt100 qarşiligi:
  #eq($ R_T = 100.0 times (1 + 0.00385 times 80) = 100.0 times (1 + 0.308) = 130.8 thin Omega $)
- Köprik kuçlanişi ($R_1 = R_2 = R_3 = 100 thin Omega$):
  #eq(
    $
      R_3 / (R_2 + R_3) = 100 / 200 = 0.500, quad quad R_T / (R_1 + R_T) = 130.8 / (100 + 130.8) = 130.8 / 230.8 approx 0.56672
    $,
  )
  #eq($ V_"bridge" = 5.0 times (0.56672 - 0.50000) = 5.0 times 0.06672 = 0.3336 "V" = 333.6 "mV" $)
- Kuçaytirgiç çiqiş kuçlanişi ($G = 40$):
  #eq($ V_"out" = 40 times 0.3336 "V" = 13.344 "V" $)

_Izoh:_ bu sxemada Pt100 orqali taxminan $5 "V" \/ 230.8 thin Omega approx 21.7 "mA"$ tok oqadi. Pt100 uçun odatda $lt.eq 1 "mA"$ tavsiya etiladi, aks holda öz-özini qizdiriş sezilarli xatolik beradi. Şuningdek, $13.3 "V"$ çiqiş kamida $plus.minus 15 "V"$ taʼminotli kuçaytirgiçni talab qiladi. $0 dots 3.3 "V"$ ADC kirişi uçun $G approx 9.9$ yetarli bölardi.

== Masala 2: termopara termo-EYuK va sovuq tutaşuv kompensatsiyasi hisobi

K-tip termoparaning Seebeck koeffitsienti $S = 41.2 thin mu"V"\/degree"C"$ ga teng. Termoparaning sovuq tutaşuvi (_cold junction_) joylaşgan xonadagi harorat $T_"cold" = 25 degree"C"$. Issiq tutaşuv (_hot junction_) harorati $T_"hot" = 450 degree"C"$.

#set enum(numbering: "a)")
+ Termoparada hosil böladigan sof termo-EYuK kuçlanişi $E_"raw"$ ni hisoblang.
+ Sovuq tutaşuv kompensatsiyasi amalga oşirilgandan keyingi kompensatsiyalangan umumiy kuçlaniş $E_"comp"$ ni toping.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ E_"raw" = S dot (T_"hot" - T_"cold"), quad quad E_"comp" = S dot T_"hot" = E_"raw" + S dot T_"cold" $)

*Hisoblaş bosqiçlari:*

- Termoparaning sof kuçlanişi:
  #eq($ Delta T = 450 degree"C" - 25 degree"C" = 425 degree"C" $)
  #eq($ E_"raw" = 41.2 thin mu"V"\/degree"C" times 425 degree"C" = 17510 thin mu"V" = 17.51 "mV" $)
- Kompensatsiya kuçlanişi ($T_"cold" = 25 degree"C"$ uçun):
  #eq($ E_"cj" = 41.2 times 25 = 1030 thin mu"V" = 1.03 "mV" $)
  #eq($ E_"comp" = 17.51 "mV" + 1.03 "mV" = 18.54 "mV" $)

== Masala 3: fotodiod va transimpedans kuçaytirgiç (TIA) hisobi

Fotodiodning monoxromatik nurlanişga spektral sezgirligi (_responsivity_) $R_"photo" = 0.55 "A/W"$. Optik nurlaniş quvvati $P_"opt" = 120 thin mu"W"$ bölganda:

#set enum(numbering: "a)")
+ Fotodiodda hosil böladigan fototok $I_"ph"$ ni hisoblang.
+ TIA kuçaytirgiçining qayta aloqa qarşiligi $R_f = 22 "k"Omega$ bölsa, çiqiş kuçlanişi $V_"out"$ neçaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ I_"ph" = R_"photo" dot P_"opt", quad quad V_"out" = I_"ph" dot R_f $)

*Hisoblaş bosqiçlari:*

- Fototok hisobi:
  #eq($ I_"ph" = 0.55 "A/W" times 120 times 10^(-6) "W" = 66 times 10^(-6) "A" = 66 thin mu"A" $)
- TIA çiqiş kuçlanişi:
  #eq($ V_"out" = 66 times 10^(-6) "A" times 22000 thin Omega = 1.452 "V" $)

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: birlamçi optik va harorat datçiklarini vizual va elektr jihatdan örganiş.* Stenddagi datçiklarning (Pt100, K-termopara, LM35, fotodiod, LDR) çiqiş kontaktlarini va ularning drayver modullarini örganing.
+ *2-bosqiç: optik datçik xarakteristikasini tajribada oliş.* Yoruğlik manbai (LED) tokini özgartirib, LDR qarşiligi $R_"LDR"$ va fotodiod fototoki $I_"ph"$ ning yoritilganlikka (lk) boğliqligini multimetrda qayd eting va grafigini quring.
+ *3-bosqiç: harorat datçigini statsionar kalibrlaş tajribasi.* Pt100 va K-termoparani termostatik idişga tuşirib, haroratni $20 degree"C"$ dan $100 degree"C"$ gaça $10 degree"C"$ qadam bilan oşirib, $R_T$ ($Omega$) va $E_"termopara"$ (mV) qiymatlarini yozib oling.
+ *4-bosqiç: Vitston köprigi va kuçaytirgiç çiqişini ossillografda tahlil qiliş.* Pt100 datçigi ulangan Vitston köprigi va instrumental kuçaytirgiç çiqiş kuçlanişi $V_"out"$ ni ossillografda ölçang.
+ *5-bosqiç: natijalarni tahlil qiliş va hisobot tayyorlaş.* Nazariy hisoblangan va tajribada olingan qiymatlarni soliştiring.

= Nazorat va muhokama savollari

+ Birlamçi özgartirgiç (datçik) va ikkilamçi özgartirgiçlar örtasidagi funksional farqni tuşuntiring.
+ Generatorli (aktiv) va parametrik (passiv) datçiklarning işlaş prinsipi va misollarini ayting.
+ Fotorezistor (LDR) va fotodiodning fotoeffekt hodisasi va reaksiya tezligi böyiça farqi nimada?
+ Transimpedans kuçaytirgiç (TIA) optik ölçov zanjirlarida qanday vazifani bajaradi?
+ Termopara datçiklarida Seebeck effekti va sovuq tutaşuv kompensatsiyasi (_cold-junction compensation_) nimani anglatadi?
+ RTD Pt100 datçigining $R_0 = 100 thin Omega$ va $alpha = 0.00385 thin degree"C"^(-1)$ parametrlari nimani ifodalaydi?
+ Vitston köprigi (_Wheatstone bridge_) nima uçun parametrik datçiklarni (Pt100, tenzometr) ölçaşda keng qöllaniladi?
+ NTC va PTC termistorlarning qarşilik-harorat tavsifidagi farqi nimada?
+ Optopara (_optocoupler_) modullari mexatronikada galvanik ajratiş (_galvanic isolation_) uçun qanday işlatiladi?
+ Optik enkoderlarda inkremental va absolyut turlarning metrologik farqini tuşuntiring.
+ Nima uçun termopara signalini kuçaytiriş uçun instrumental kuçaytirgiç (_instrumentation amplifier_) talab qilinadi?
+ Yarimötkazgiçli IC harorat datçiklarining (LM35 / DS18B20) RTD va termoparaga nisbatan afzalliklari nimalardan iborat?
