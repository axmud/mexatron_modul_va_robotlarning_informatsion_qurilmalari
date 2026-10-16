// ============================================================
//  MMRIQ — 6-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_6.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Birlamchi oʻzgartirgichlar ishini tahlil qilish. Optik hamda temperatura datchiklari")
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
#set text(size: 12pt, lang: "uz")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №6]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Birlamchi oʻzgartirgichlar ishini tahlil qilish. Optik hamda temperatura datchigining ishlash tamoyilini oʻrganish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatron modullar va robotik tizimlarda qoʻllaniladigan birlamchi oʻzgartirgichlarning (_primary transducers_) ishlash prinsiplari, optik (fotorezistor, fotodiod, fototranzistor, optopara, enkoder) va temperatura datchiklarining (termopara, RTD Pt100, NTC/PTC termistor, yarimoʻtkazgichli IC sensorlar) fizik-texnik xarakteristikalari, signalni shakllantirish va oʻlchash zanjirlarini hisoblash hamda tahlil qilish koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Birlamchi oʻzgartirgichlar (sezgir element) va ikkilamchi oʻzgartirgichlar (signalni konditsiyalash/kuchaytirish) oʻrtasidagi funksional va strukturaviy bogʻliqlikni oʻrganish.
+ Optik datchiklarning ishlashidagi fizik hodisalarni (ichki va tashqi fotoeffekt, yarimoʻtkazgichli $p$-$n$ oʻtishdagi fotoeffekt, foto-EYuK va fototok) hamda optoelektron modullarni tahlil qilish.
+ Temperatura (harorat) datchiklarining ishlash tamoyillarini (Seebeck termo-EYuK effekti, metall va yarimoʻtkazgichlar qarshiligining haroratga bogʻliqligi) oʻrganish.
+ Vitston koʻprigi (_Wheatstone bridge_), operatsion kuchaytirgichli transimpedans kuchaytirgich (TIA) hamda instrumental kuchaytirgichlarning hisoblash modellarini tuzish.
+ Optik va harorat oʻlchov zanjirlarini modellashtirish hamda tajriba natijalarini matematik qayta ishlash.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* birlamchi oʻzgartirgichlar va sensorli modullar laboratoriya stendi, optoelektron stend (yorugʻlik manbai, fotodiod, fotorezistor, optopara, optik diskli enkoder), harorat oʻlchov stendi (termostat, Pt100 RTD, K-tip termopara, NTC termistor, LM35 / DS18B20 IC datchiklar).
- *Nazorat-oʻlchov va manba vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, oʻzgarmas tok manbai ($0 dots 30 "V DC"$), etalon yoritilganlik oʻlchagich (lyuksmetr).
- *Boshqaruv va DAQ modullari:* STM32F4/F7 mikrokontrollerli plata, Arduino Mega, National Instruments DAQ platasi.
- *Dasturiy muhit:* MATLAB / Simulink (Simscape Electrical), LabVIEW, Proteus.

= Nazariy maʼlumotlar va konseptual tizimlar

== Birlamchi oʻzgartirgichlar (primary transducers) tushunchasi va oʻrni

P.P.L. Regtien va W. Bolton darsliklariga koʻra, *birlamchi oʻzgartirgich (datchik/sensor)* deb oʻlchanayotgan fizik kattalikni (harorat, yoritilganlik, bosim, siljish) bevosita qabul qilib, uni keyingi qayta ishlash uchun qulay boʻlgan elektr signaliga (kuchlanish, tok, qarshilik, sigʻim, chastota) aylantiruvchi elementga aytiladi.

Birlamchi oʻzgartirgichlar fizik hodisalarga tayangan holda ikkita katta guruhga boʻlinadi:

+ *Generatorli (aktiv) oʻzgartirgichlar:* tashqi energiya manbaisiz fizik energiyani bevosita elektr energiyasiga (EYuK yoki tok) aylantiradi. Misol: termopara (termo-EYuK), pyezoelektr datchik, fotoelement (fotogalvanik rejim).
+ *Parametrik (passiv) oʻzgartirgichlar:* oʻlchanayotgan kattalik taʼsirida oʻzining elektr parametrini (qarshilik $R$, sigʻim $C$, induktivlik $L$) oʻzgartiradi va ishlashi uchun tashqi quvvat manbaini talab qiladi. Misol: termistor, RTD Pt100, fotorezistor, tenzorezistor, LVDT.

_Izoh:_ ushbu nomlash rus tilidagi adabiyot anʼanasiga mos. Ingliz tilidagi ayrim manbalarda (masalan, J. Fraden) aksincha: tashqi manbasiz ishlovchi datchiklar _passive_, manba talab qiluvchilar esa _active_ deb ataladi.

== Optik datchiklarning ishlash tamoyillari va turlari

Optik datchiklar elektromagnit nurlanishni (koʻrinuvchi, infraqizil va ultrabinafsha diapazonlar) elektr signaliga aylantiradi (@tab-optical).

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
        [*№*], [*Optik datchik turi*], [*Fizik hodisasi / tamoyili*], [*Asosiy xarakteristikasi va qoʻllanilishi*]
      ),
      table.hline(stroke: 0.5pt),
      [1], [*Fotorezistor (LDR)*], [Ichki fotoeffekt: yorugʻlik tushganda qarshilik $R_"LDR"$ keskin kamayadi.],
      [Nochiziqli $R(E)$ bogʻliqlik; sezgirligi yuqori, lekin inersiyasi katta ($10 dots 100 "ms"$). Yorugʻlik kalitlari.],
      [2], [*Fotodiod* (Photodiode)], [$p$-$n$ oʻtish teskari siljitilganda fototok $I_"ph"$ hosil boʻlishi.],
      [Yuqori tezkorlik (ns tartibida); chiziqli $I_"ph" (E)$ tavsifi. Optik enkoder va optik tola aloqasi.],
      [3], [*Fototranzistor*], [Fotodiod va tranzistor kuchaytirgichining birikmasi.],
      [Sezgirligi fotodiodga nisbatan $100 dots 500$ baravar yuqori, lekin chastotasi pastroq. Optopara (optocoupler).],
      [4], [*Optik enkoder*], [Diskdagi tirqishlar orqali nur oʻtishini sanash (inkremental/absolyut).],
      [Yuqori ajratish qobiliyati ($1024 dots 65536 "ppr"$). Robot boʻgʻinlari va motor vallari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Optik datchiklarning turlari va fizik-texnik koʻrsatkichlari],
) <tab-optical>

== Temperatura (harorat) datchiklarining ishlash tamoyillari

Harorat mexatronik tizimlarda termodinamik holatni va xavfsizlikni nazorat qiluvchi eng muhim parametrlardan biridir. Asosiy harorat datchiklari @tab-temp da keltirilgan.

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
      table.header([*№*], [*Datchik turi*], [*Ishlash tamoyili / formula*], [*Diapazoni*], [*Afzalligi va kamchiligi*]),
      table.hline(stroke: 0.5pt),
      [1],
      [*Termopara* (Thermocouple)],
      [Seebeck effekti: \ $E = S dot (T_"hot" - T_"cold")$],
      [$-200 dots +1800 degree"C"$],
      [Juda keng diapazon, metall konstruksiya; signal kichik (mV).],
      [2], [*RTD Pt100*], [Metall qarshiligi: \ $R(T) = R_0 (1 + alpha T)$], [$-200 dots +850 degree"C"$],
      [Yuqori aniqlik va chiziqlilik; sezgirligi oʻrtacha ($0.385 thin Omega\/degree"C"$).],
      [3],
      [*NTC termistor*],
      [Yarimoʻtkazgich qarshiligi: \ $R(T) = R_0 e^(beta (1\/T - 1\/T_0))$ \ ($T$ --- kelvinda)],
      [$-50 dots +150 degree"C"$],
      [Yuqori sezgirlik; keskin nochiziqli tavsif.],
      [4],
      [*IC sensor* (LM35)],
      [$p$-$n$ oʻtish kuchlanishi: \ $V_"out" = 10 "mV"\/degree"C"$],
      [$-55 dots +150 degree"C"$],
      [Tayyor chiziqli kuchlanish chiqishi; diapazoni kichik.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Harorat datchiklarining qiyosiy texnik xarakteristikalari],
) <tab-temp>

= Mavzuga oid chizmalar va sxemalar

== Birlamchi va ikkilamchi oʻzgartirgichlarning ketma-ket funksional zanjiri

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
      node((1, 0), b[*Birlamchi* \ *oʻzgartirgich* \ (Pt100, fotodiod)], width: 2.3cm, height: 1.3cm),
      node((2, 0), b[*Ikkilamchi* \ *oʻzgartirgich* \ (Vitston koʻprigi / TIA)], width: 2.5cm, height: 1.3cm),
      node((3, 0), b[Signalni \ konditsiyalash \ (Op-Amp / LPF)], width: 2.3cm, height: 1.3cm),
      node((4, 0), b[ADC va MCU \ (STM32 / DSP)], width: 2.3cm, height: 1.3cm),

      edge((0, 0), (1, 0), "-|>", label: small[Fizik taʼsir], stroke: 1pt, label-sep: 19pt),
      edge((1, 0), (2, 0), "-|>", label: small[$R, I, E$], stroke: 1pt, label-sep: 19pt),
      edge((2, 0), (3, 0), "-|>", label: small[mV signal], stroke: 1pt, label-sep: 19pt),
      edge((3, 0), (4, 0), "-|>", label: small[$0 dots 3.3 "V"$], stroke: 1pt, label-sep: 19pt),
    )
  },
  caption: [Birlamchi va ikkilamchi oʻzgartirgichlarning axborot shakllantirish zanjiri],
) <fig-chain>

== Fotodiod va transimpedans kuchaytirgichli (TIA) optik oʻlchov zanjiri

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
  caption: [Fotodiod va transimpedans kuchaytirgichli (TIA) optik oʻlchov zanjiri],
) <fig-tia>

== Pt100 RTD datchigi uchun Vitston koʻprigi va instrumental kuchaytirgich

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
    res(a, bot, $R_3$)
    res(top, b, $R_1$)
    res(b, bot, [#text(size: 5pt)[Pt100 ($R_T$)]], fill: orange.lighten(75%))

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
    content((3.5, 2.05), anchor: "south", text(size: 8pt)[$V_"bridge"$])

    // Instrumental kuchaytirgich
    rect((4.0, 0.8), (6.5, 2.4), radius: 0.12, fill: blue.lighten(90%), stroke: 1.2pt + headingblue)
    content((5.25, 1.6), align(center, text(
      size: 8pt,
      weight: "bold",
      fill: headingblue,
    )[Instrumental \ kuchaytirgich \ ($G = 40$)]))
    line((6.5, 1.6), (7.4, 1.6), stroke: 2.5pt + headingblue, mark: (end: "stealth", fill: headingblue))
    content((7.5, 1.6), anchor: "west", text(size: 9pt, weight: "bold")[$V_"out" = G dot V_"bridge"$])
  }),
  caption: [Pt100 RTD datchigi va Vitston koʻprigi asosidagi harorat oʻlchash sxemasi],
) <fig-bridge>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: optik va temperatura datchiklarini qiyosiy tahlil qilish

Har bir datchik turining fizik, metrologik va ekspluatatsion xususiyatlarini tahlil qiling va @tab-compare ni toʻldiring.

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
        [*Datchik turi*],
        [*Reaksiya tezligi (dinamika)*],
        [*Chiziqlilik va sezgirlik*],
        [*Asosiy ustunligi va kamchiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Fotorezistor (LDR)*], [Sekin ($10 dots 100 "ms"$)], [Nochiziqli; yuqori sezgirlik],
      [*Ustunligi:* arzon, sodda. \ *Kamchiligi:* inersion, haroratga bogʻliq.],
      [*Fotodiod*], [Oʻta tez ($< 1 thin mu"s"$)], [Yuqori chiziqlilik; sezgirligi oʻrtacha],
      [*Ustunligi:* aniq va tezkor. \ *Kamchiligi:* fototok kichik (nA $dots$ µA).],
      [*RTD Pt100*], [Oʻrtacha ($0.5 dots 2 "s"$)], [Yuqori chiziqlilik ($0.385 thin Omega\/degree"C"$)],
      [*Ustunligi:* etalon darajadagi aniqlik. \ *Kamchiligi:* oʻz-oʻzini qizdirish xatosi.],
      [*Termopara (K-tip)*],
      [Oʻrtacha / tez ($0.1 dots 1 "s"$)],
      [Sezilarli nochiziqli ($approx 41 thin mu"V"\/degree"C"$)],
      [*Ustunligi:* juda yuqori haroratlarda ishlaydi. \ *Kamchiligi:* sovuq tutashuv kompensatsiyasi shart.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Birlamchi optik va harorat oʻzgartirgichlarining qiyosiy tahlili],
) <tab-compare>

== Topshiriq 2: sanoat pechi va robot tutqichi uchun datchik tanlash

Quyidagi ikkita texnologik modul uchun birlamchi oʻzgartirgich va signalni konditsiyalash zanjirini tanlang hamda asoslang:

+ *1-modul:* $800 degree"C"$ haroratli metall eritish pechi haroratini oʻlchash.
+ *2-modul:* robot tutqichida obyekt bor-yoʻqligini $2 "mm"$ masofadan kontaktsiz aniqlash (javob vaqti $< 1 "ms"$).

*Tahlil va yechim:*

- *1-modul uchun:* _K-tip (xromel–alyumel) termopara_. Sababi: yuqori harorat diapazoni ($1200 degree"C"$ gacha) va chidamliligi. Signalni konditsiyalash: sovuq tutashuv kompensatsiyasiga ega MAX31855 ADC mikrosxemasi.
- *2-modul uchun:* _fotodiodli optopara / reflektiv optik sensor_. Sababi: mikrosekund darajasidagi tezkorlik va kontaktsizlik. Signalni konditsiyalash: komparator (LM393) va LED drayveri.

= Hisoblash va modellashtirish masalalari

== Masala 1: Pt100 RTD va Vitston koʻprigi oʻlchov zanjiri hisobi

Pt100 datchigining $T = 0 degree"C"$ dagi qarshiligi $R_0 = 100.0 thin Omega$, harorat koeffitsienti $alpha = 0.00385 thin degree"C"^(-1)$. Datchik Vitston koʻprigining bitta elkasiga ulangan ($R_1 = R_2 = R_3 = 100.0 thin Omega$, @fig-bridge). Koʻprik manba kuchlanishi $V_"ex" = 5.0 "V"$.

#set enum(numbering: "a)")
+ Harorat $T = 80 degree"C"$ boʻlganda Pt100 qarshiligi $R_T$ nechaga teng boʻladi?
+ Koʻprik diagonalidagi kuchlanish $V_"bridge"$ ni hisoblang.
+ Agar instrumental kuchaytirgichning kuchaytirish koeffitsienti $G = 40$ boʻlsa, chiqish kuchlanishi $V_"out"$ nechaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ R_T = R_0 (1 + alpha T) $)
#eq($ V_"bridge" = V_B - V_A = V_"ex" (R_T / (R_1 + R_T) - R_3 / (R_2 + R_3)) $)
#eq($ V_"out" = G dot V_"bridge" $)

*Hisoblash bosqichlari:*

- $T = 80 degree"C"$ da Pt100 qarshiligi:
  #eq($ R_T = 100.0 times (1 + 0.00385 times 80) = 100.0 times (1 + 0.308) = 130.8 thin Omega $)
- Koʻprik kuchlanishi ($R_1 = R_2 = R_3 = 100 thin Omega$):
  #eq(
    $
      R_3 / (R_2 + R_3) = 100 / 200 = 0.500, quad quad R_T / (R_1 + R_T) = 130.8 / (100 + 130.8) = 130.8 / 230.8 approx 0.56672
    $,
  )
  #eq($ V_"bridge" = 5.0 times (0.56672 - 0.50000) = 5.0 times 0.06672 = 0.3336 "V" = 333.6 "mV" $)
- Kuchaytirgich chiqish kuchlanishi ($G = 40$):
  #eq($ V_"out" = 40 times 0.3336 "V" = 13.344 "V" $)

_Izoh:_ bu sxemada Pt100 orqali taxminan $5 "V" \/ 230.8 thin Omega approx 21.7 "mA"$ tok oqadi. Pt100 uchun odatda $lt.eq 1 "mA"$ tavsiya etiladi, aks holda oʻz-oʻzini qizdirish sezilarli xatolik beradi. Shuningdek, $13.3 "V"$ chiqish kamida $plus.minus 15 "V"$ taʼminotli kuchaytirgichni talab qiladi. $0 dots 3.3 "V"$ ADC kirishi uchun $G approx 9.9$ yetarli boʻlardi.

== Masala 2: termopara termo-EYuK va sovuq tutashuv kompensatsiyasi hisobi

K-tip termoparaning Seebeck koeffitsienti $S = 41.2 thin mu"V"\/degree"C"$ ga teng. Termoparaning sovuq tutashuvi (_cold junction_) joylashgan xonadagi harorat $T_"cold" = 25 degree"C"$. Issiq tutashuv (_hot junction_) harorati $T_"hot" = 450 degree"C"$.

#set enum(numbering: "a)")
+ Termoparada hosil boʻladigan sof termo-EYuK kuchlanishi $E_"raw"$ ni hisoblang.
+ Sovuq tutashuv kompensatsiyasi amalga oshirilgandan keyingi kompensatsiyalangan umumiy kuchlanish $E_"comp"$ ni toping.
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ E_"raw" = S dot (T_"hot" - T_"cold"), quad quad E_"comp" = S dot T_"hot" = E_"raw" + S dot T_"cold" $)

*Hisoblash bosqichlari:*

- Termoparaning sof kuchlanishi:
  #eq($ Delta T = 450 degree"C" - 25 degree"C" = 425 degree"C" $)
  #eq($ E_"raw" = 41.2 thin mu"V"\/degree"C" times 425 degree"C" = 17510 thin mu"V" = 17.51 "mV" $)
- Kompensatsiya kuchlanishi ($T_"cold" = 25 degree"C"$ uchun):
  #eq($ E_"cj" = 41.2 times 25 = 1030 thin mu"V" = 1.03 "mV" $)
  #eq($ E_"comp" = 17.51 "mV" + 1.03 "mV" = 18.54 "mV" $)

== Masala 3: fotodiod va transimpedans kuchaytirgich (TIA) hisobi

Fotodiodning monoxromatik nurlanishga spektral sezgirligi (_responsivity_) $R_"photo" = 0.55 "A/W"$. Optik nurlanish quvvati $P_"opt" = 120 thin mu"W"$ boʻlganda:

#set enum(numbering: "a)")
+ Fotodiodda hosil boʻladigan fototok $I_"ph"$ ni hisoblang.
+ TIA kuchaytirgichining qayta aloqa qarshiligi $R_f = 22 "k"Omega$ boʻlsa, chiqish kuchlanishi $V_"out"$ nechaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ I_"ph" = R_"photo" dot P_"opt", quad quad V_"out" = I_"ph" dot R_f $)

*Hisoblash bosqichlari:*

- Fototok hisobi:
  #eq($ I_"ph" = 0.55 "A/W" times 120 times 10^(-6) "W" = 66 times 10^(-6) "A" = 66 thin mu"A" $)
- TIA chiqish kuchlanishi:
  #eq($ V_"out" = 66 times 10^(-6) "A" times 22000 thin Omega = 1.452 "V" $)

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: birlamchi optik va harorat datchiklarini vizual va elektr jihatdan oʻrganish.* Stenddagi datchiklarning (Pt100, K-termopara, LM35, fotodiod, LDR) chiqish kontaktlarini va ularning drayver modullarini oʻrganing.
+ *2-bosqich: optik datchik xarakteristikasini tajribada olish.* Yorugʻlik manbai (LED) tokini oʻzgartirib, LDR qarshiligi $R_"LDR"$ va fotodiod fototoki $I_"ph"$ ning yoritilganlikka (lk) bogʻliqligini multimetrda qayd eting va grafigini quring.
+ *3-bosqich: harorat datchigini statsionar kalibrlash tajribasi.* Pt100 va K-termoparani termostatik idishga tushirib, haroratni $20 degree"C"$ dan $100 degree"C"$ gacha $10 degree"C"$ qadam bilan oshirib, $R_T$ ($Omega$) va $E_"termopara"$ (mV) qiymatlarini yozib oling.
+ *4-bosqich: Vitston koʻprigi va kuchaytirgich chiqishini ossillografda tahlil qilish.* Pt100 datchigi ulangan Vitston koʻprigi va instrumental kuchaytirgich chiqish kuchlanishi $V_"out"$ ni ossillografda oʻlchang.
+ *5-bosqich: natijalarni tahlil qilish va hisobot tayyorlash.* Nazariy hisoblangan va tajribada olingan qiymatlarni solishtiring.

= Nazorat va muhokama savollari

+ Birlamchi oʻzgartirgich (datchik) va ikkilamchi oʻzgartirgichlar oʻrtasidagi funksional farqni tushuntiring.
+ Generatorli (aktiv) va parametrik (passiv) datchiklarning ishlash prinsipi va misollarini ayting.
+ Fotorezistor (LDR) va fotodiodning fotoeffekt hodisasi va reaksiya tezligi boʻyicha farqi nimada?
+ Transimpedans kuchaytirgich (TIA) optik oʻlchov zanjirlarida qanday vazifani bajaradi?
+ Termopara datchiklarida Seebeck effekti va sovuq tutashuv kompensatsiyasi (_cold-junction compensation_) nimani anglatadi?
+ RTD Pt100 datchigining $R_0 = 100 thin Omega$ va $alpha = 0.00385 thin degree"C"^(-1)$ parametrlari nimani ifodalaydi?
+ Vitston koʻprigi (_Wheatstone bridge_) nima uchun parametrik datchiklarni (Pt100, tenzometr) oʻlchashda keng qoʻllaniladi?
+ NTC va PTC termistorlarning qarshilik-harorat tavsifidagi farqi nimada?
+ Optopara (_optocoupler_) modullari mexatronikada galvanik ajratish (_galvanic isolation_) uchun qanday ishlatiladi?
+ Optik enkoderlarda inkremental va absolyut turlarning metrologik farqini tushuntiring.
+ Nima uchun termopara signalini kuchaytirish uchun instrumental kuchaytirgich (_instrumentation amplifier_) talab qilinadi?
+ Yarimoʻtkazgichli IC harorat datchiklarining (LM35 / DS18B20) RTD va termoparaga nisbatan afzalliklari nimalardan iborat?
