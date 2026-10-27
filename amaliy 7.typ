// ============================================================
//  MMRIQ — 7-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_7.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Tezlik va tezlaniş datçiklari. Akustik va siğim datçiklari")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 7  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI № 7]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Tezlik va tezlaniş datçiklari işini örganiş. Akustik datçik, siğim datçiklari işini tahlil qiliş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatronik tizimlar va robototexnika majmualarida keng qöllaniladigan tezlik, tezlaniş (akselerometrlar), akustik (ultratovuş) hamda siğimli datçiklarning fizik-texnik işlaş prinsiplari, konstruktiv tuzilişi, signalni şakllantiriş va qayta işlaş zanjirlarini (_signal conditioning_) çuqur örganiş va hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Çiziqli va burçak tezlik datçiklarining (DC/AC taxogeneratorlar, Hall datçikli va optik enkoderli tezlik ölçagiçlar) fizik-texnik xarakteristikalarini tahlil qiliş.
+ Tezlaniş datçiklarining (MEMS, pyezoelektr va siğimli akselerometrlar) differensial dinamik modelini (_mass-spring-damper system_) va işlaş mexanizmini örganiş.
+ Akustik va ultratovuş (_ultrasonic_) datçiklarning signal tarqaliş vaqti (_Time-of-Flight_, ToF) tamoyili böyiça masofa va tösiqlarni aniqlaş algoritmlarini tahlil qiliş.
+ Siğimli (_capacitive_) datçiklarning geometrik va dielektrik parametrlar özgarişi böyiça işlaş tamoyillarini hamda AC köprikli va siğim-kuçlaniş ($C\/V$) özgartirgiç zanjirlarini örganiş.
+ Sensordan olingan signallarni raqamlaş, harorat va şovqin taʼsirini kompensatsiya qiliş hamda muhandislik hisoblaş masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* kinematik va dinamik datçiklar laboratoriya stendi, tebraniş stendi (_vibration shaker table_), optik va Hall effektli tezlik datçiklari, MEMS IMU 6-DoF moduli (MPU6050 / LSM6DS3), ultratovuş masofa datçigi (HC-SR04 / pyezokeramik özgartirgiç), siğimli siljiş va sath datçiklari.
- *Nazorat-ölçov vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, stroboskopik stend, signal generatori.
- *Boşqaruv va DAQ modullari:* STM32F4/F7 mikrokontrollerli plata, Arduino Mega, National Instruments DAQ platasi.
- *Dasturiy muhit:* MATLAB / Simulink (Simscape), LabVIEW, Proteus.

= Nazariy maʼlumotlar va datçiklar klassifikatsiyasi

== Tezlik datçiklarining işlaş tamoyili va turlari

Mexatron modullarda tezlik ilgarilanma çiziqli tezlik $v$ (m/s) yoki burçak tezlik $omega$ (rad/s, ayl/min) körinişida ölçanadi. W. Bolton va P.P.L. Regtien darsliklariga köra, tezlik datçiklari quyidagi turlarga bölinadi:

+ *Taxogeneratorlar (DC/AC tachogenerators):* elektromagnit induksiya qonuniga ($e = B dot l dot v$) asoslangan. Özgarmas tok taxogeneratori val aylanganda tezlikka mutanosib analog kuçlaniş $V_"out" = K_t dot omega$ beradi.
+ *Impulsli tezlik datçiklari (Hall sensor & optik enkoder):* valga örnatilgan tişli disk yoki magnitlar yordamida çastotasi $f$ bölgan impulslar hosil qiladi:
  #eq($ omega = (2 pi dot f) / N_p $)
  bunda $N_p$ --- diskning bir töliq aylanişidagi impulslar soni.

== Tezlaniş datçiklari (akselerometrlar) va ularning dinamik modeli

Tezlaniş datçiklari inersiya kuçini ($F = m dot a$) ölçaşga asoslangan. Işlaş mexanizmi seysmik massa ($m$), prujina ($k$) va dempfer ($c$) tizimidan iborat (@fig-mems). Akselerometrning harakat differensial tenglamasi:

#eq($ m dot.double(x)(t) + c dot(x)(t) + k x(t) = -m a_"taşqi" (t) $)

bunda $x(t)$ --- seysmik massaning korpusga nisbatan siljişi, $a_"taşqi" (t)$ --- ölçanayotgan obyekt tezlanişi. Past çastotali rejimda ($omega << omega_n = sqrt(k\/m)$) siljiş tezlanişga mutanosib böladi:

#eq($ |x| approx m / k a_"taşqi" = a_"taşqi" / omega_n^2 $)

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.2cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*№*], [*Akselerometr turi*], [*Fizik özgartiriş tamoyili*], [*Xarakterli xususiyati va qöllanilişi*]
      ),
      table.hline(stroke: 0.5pt),
      [1],
      [*Pyezoelektr akselerometr*],
      [Pyezoelementda bosim taʼsirida elektr zaryadi $Q = d_33 dot F$ hosil bölişi.],
      [Keng çastota diapazoni ($1 "Hz" dots 20 "kHz"$); statik ($0 "Hz"$) tezlanişni ölçay olmaydi. Tebraniş diagnostikasi.],
      [2],
      [*MEMS siğimli akselerometr*],
      [Seysmik massa siljiganda taroqsimon mikroelektrodlar orasidagi siğim $Delta C$ ning özgarişi.],
      [Statik ($0 "Hz"$, $g$) va dinamik tezlanişni ölçaydi; kiçik ölçam. Mobil robotlar va dronlar.],
      [3],
      [*Pyezorezistiv akselerometr*],
      [Prujina elementi deformatsiyalanganda tenzorezistor qarşiligi $Delta R$ ning özgarişi.],
      [Yuqori zarbalarga ($> 1000 g$) çidamli, tezkor. Avtomobil kraş-testlari va zarba sinovlari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Tezlaniş datçiklarining (akselerometrlarning) turlari va qiyosiy körsatkiçlari],
) <tab-accel>

== Akustik va ultratovuş datçiklar

Akustik datçiklar havoda yoki qattiq muhitda akustik tölqinlarning (çastotasi $f > 20 "kHz"$ bölgan ultratovuşning) tarqalişi va qaytişiga asoslanadi.

*Time-of-Flight (ToF) böyiça masofa ölçaş prinsipi:* datçik pyezoelektr uzatgiç (_transmitter_) orqali ultratovuş impulsini yuboradi va obyektdan qaytgan aks-sado (_echo_) impulsini qabul qilgiç (_receiver_) orqali uşlaydi (@fig-tof). Obyektgaça bölgan masofa $d$:

#eq($ d = (v_"sod" dot t_"ToF") / 2 $)

bunda $v_"sod"$ --- havodagi tovuş tezligi ($T = 20 degree"C"$ da $v_"sod" approx 343 "m/s"$), $t_"ToF"$ --- impulsning borib-keliş umumiy vaqti. Havoda tovuş tezligining haroratga $T$ ($degree"C"$) boğliqligi:

#eq($ v_"sod" (T) = 331.3 dot sqrt(1 + T / 273.15) approx 331.3 + 0.606 dot T quad "(m/s)" $)

== Siğimli (capacitive) datçiklar

Siğimli datçiklar yassi kondensator siğimi $C$ ning geometrik va fizik parametrlarga boğliqligiga asoslanadi:

#eq($ C = epsilon_0 dot epsilon_r dot A / d $)

bunda $epsilon_0 = 8.854 times 10^(-12) "F/m"$ --- elektr doimiysi, $epsilon_r$ --- muhitning nisbiy dielektrik singdiruvçanligi, $A$ --- qoplamalarning bir-birini yopiş yuzasi, $d$ --- qoplamalar orasidagi masofa.

*Özgartiriş usullariga köra siğimli datçiklar:*

+ *Masofa özgarişi böyiça ($d$ özgaradi):* qoplamalar orasidagi $d$ masofa özgarganda $C(d)$ giperbolik boğliqlikka ega böladi ($Delta C approx -(epsilon A) / d_0^2 Delta d$).
+ *Yopiş yuzasi böyiça ($A$ özgaradi):* qoplamalarning parallel köçişida $A$ yuzasi özgarib, $C(A)$ çiziqli boğliqlikni beradi.
+ *Dielektrik singdiruvçanlik böyiça ($epsilon_r$ özgaradi):* qoplamalar oraliğiga turli suyuqlik yoki material kirganda siğim özgaradi (suyuqlik sathini ölçaş).

= Mavzuga oid çizmalar va sxemalar

== MEMS siğimli akselerometrning prujina-massa-dempfer va elektrodlar modeli

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let small(body) = text(size: 7.5pt, weight: "bold", body)
    let spring(x0, x1, y) = {
      let n = 12
      let pts = (
        ((x0, y),)
          + range(1, n).map(i => (x0 + (x1 - x0) * i / n, y + if calc.odd(i) { 0.22 } else { -0.22 }))
          + ((x1, y),)
      )
      line(..pts, stroke: 1.2pt + blue-c)
    }

    // Korpus
    rect((-4, -2.5), (4, 2.5), radius: 0.2, fill: blue.lighten(95%), stroke: 2pt + blue-c)
    content((-3.8, 2.3), anchor: "north-west", text(size: 9pt, weight: "bold", fill: blue-c)[MEMS akselerometr korpusi])

    // Prujinalar
    spring(-4.0, -1.2, 0)
    spring(1.2, 4.0, 0)
    content((-2.6, 0.3), anchor: "south", small[Prujina ($k$)])
    content((2.6, 0.3), anchor: "south", small[Prujina ($k$)])

    // Dempfer (chap tomonda)
    let yd = -0.8
    line((-4.0, yd), (-2.9, yd), stroke: 1pt)
    line((-2.1, yd + 0.25), (-2.9, yd + 0.25), (-2.9, yd - 0.25), (-2.1, yd - 0.25), stroke: 1pt)
    line((-2.5, yd + 0.18), (-2.5, yd - 0.18), stroke: 1.5pt)
    line((-2.5, yd), (-1.2, yd), stroke: 1pt)
    content((-2.5, yd - 0.35), anchor: "north", small[Dempfer ($c$)])

    // Seysmik massa
    rect((-1.2, -1.0), (1.2, 1.0), radius: 0.1, fill: orange.lighten(75%), stroke: 2pt + orng)
    content((0, 0.1), align(center, text(size: 8.5pt, weight: "bold", fill: orng)[Seysmik \ massa ($m$)]))

    // Qoʻzgʻalmas elektrodlar (differensial kondensator)
    rect((-1.55, 0.25), (-1.4, 0.95), fill: gray.darken(50%), stroke: none)
    rect((1.4, 0.25), (1.55, 0.95), fill: gray.darken(50%), stroke: none)
    content((-1.6, 1.3), anchor: "south-east", small[Stator 1 ($C_1$)])
    content((1.6, 1.3), anchor: "south-west", small[Stator 2 ($C_2$)])

    // Harakat strelkalari
    line((-0.2, 1.8), (1.4, 1.8), stroke: 2.5pt + red, mark: (end: "stealth", fill: red))
    content((1.5, 1.8), anchor: "west", text(size: 9pt, weight: "bold")[Tezlaniş $a_"taşqi"$])
    line((0.2, -1.7), (-1.0, -1.7), stroke: 2.5pt + blue.lighten(10%), mark: (end: "stealth", fill: blue.lighten(10%)))
    content((0.3, -1.7), anchor: "west", text(size: 9pt, weight: "bold")[Siljiş $x$])
  }),
  caption: [MEMS siğimli akselerometrning massa-prujina-dempfer va differensial siğim sxemasi],
) <fig-mems>

== Ultratovuş datçigining Time-of-Flight (ToF) böyiça masofa ölçaş tamoyili

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let wave = blue.lighten(10%)
    let small(body) = text(size: 7.5pt, weight: "bold", body)

    // Datchik moduli
    rect((-4, -1.5), (-1.5, 1.5), radius: 0.15, fill: blue.lighten(93%), stroke: 1pt + blue-c)
    content((-2.75, 1.15), text(size: 8.5pt, weight: "bold", fill: blue-c)[HC-SR04 moduli])
    circle((-1.5, 0.6), radius: 0.4, fill: gray.darken(50%), stroke: none)
    content((-1.5, 0.6), text(size: 7pt, weight: "bold", fill: white)[T])
    content((-2.1, 0.6), anchor: "east", text(size: 7pt)[Transmitter])
    circle((-1.5, -0.6), radius: 0.4, fill: gray.darken(50%), stroke: none)
    content((-1.5, -0.6), text(size: 7pt, weight: "bold", fill: white)[R])
    content((-2.1, -0.6), anchor: "east", text(size: 7pt)[Receiver])

    // Toʻsiq
    rect((3.5, -1.8), (4.5, 1.8), fill: orange.lighten(80%), stroke: 2pt + orng)
    content((4.0, 0), angle: -90deg, text(size: 8.5pt, weight: "bold", fill: orng)[Aks ettiruvçi tösiq])

    // Uzatilgan impuls
    line((-1.0, 0.6), (3.3, 0.6), stroke: 2.5pt + wave, mark: (end: "stealth", fill: wave))
    content((1.15, 0.95), anchor: "south", small[Uzatilgan impuls ($f = 40 "kHz"$)])
    for (x, r) in ((-0.5, 0.35), (0.4, 0.55), (1.3, 0.75)) {
      arc((x, 0.6 + r * calc.sin(30deg)), start: 30deg, stop: -30deg, radius: r, stroke: 1pt + wave)
    }

    // Qaytgan aks-sado
    line((3.3, -0.6), (-1.0, -0.6), stroke: 2.5pt + red, mark: (end: "stealth", fill: red))
    content((1.15, -0.95), anchor: "north", small[Aks-sado (echo) impuls])
    for (x, r) in ((2.8, 0.35), (1.9, 0.55), (1.0, 0.75)) {
      arc((x, -0.6 + r * calc.sin(30deg)), start: 150deg, stop: 210deg, radius: r, stroke: (
        paint: red,
        thickness: 1pt,
        dash: "dashed",
      ))
    }

    // Masofa
    line((-1.5, -2.2), (3.5, -2.2), stroke: 1pt + gray.darken(50%), mark: (
      start: "stealth",
      end: "stealth",
      fill: gray.darken(50%),
    ))
    content((1.0, -2.3), anchor: "north", text(
      size: 9pt,
      weight: "bold",
    )[Ölçanayotgan masofa $d = (v dot t_"ToF") / 2$])
  }),
  caption: [Ultratovuş datçigining Time-of-Flight (ToF) böyiça masofani aniqlaş sxemasi],
) <fig-tof>

== Siğimli datçik va AC köprikli signalni konditsiyalaş zanjiri

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let w = 1pt
    let top = (1.5, 3.5)
    let bot = (1.5, 0.5)
    let a = (0, 2)
    let b = (3, 2)
    let arm(p, q, lab, fill: gray.lighten(85%)) = {
      line(p, q, stroke: w)
      let m = ((p.at(0) + q.at(0)) / 2, (p.at(1) + q.at(1)) / 2)
      rect((m.at(0) - 0.5, m.at(1) - 0.2), (m.at(0) + 0.5, m.at(1) + 0.2), fill: fill, stroke: w)
      content(m, text(size: 7pt, weight: "bold", lab))
    }

    // Koʻprik elkalari
    arm(top, a, $C_2$)
    arm(a, bot, $C_3$)
    arm(top, b, $C_1$)
    arm(b, bot, box(baseline: -100%, [#text(size: 4.5pt)[$C_x$ (datçik)]]), fill: orange.lighten(75%))

    // AC manba va yer
    line(top, (1.5, 4.1), stroke: w)
    content((1.5, 4.2), anchor: "south", text(size: 9pt, weight: "bold")[$V_"AC" sin(omega t)$])
    line(bot, (1.5, 0.0), stroke: w)
    line((1.25, 0.0), (1.75, 0.0), stroke: w)
    line((1.35, -0.08), (1.65, -0.08), stroke: w)
    line((1.45, -0.16), (1.55, -0.16), stroke: w)
    for p in (a, b) { circle(p, radius: 0.05, fill: black) }

    // Differensial chiqish
    line(a, (-0.5, 2), (-0.5, 1.2), (4.0, 1.2), stroke: w)
    line(b, (4.0, 2), stroke: w)
    content((3.5, 2.05), anchor: "south", text(size: 8pt)[$V_"bridge" (t)$])

    // Sinxron demodulyator va LPF
    rect((4.0, 0.8), (6.3, 2.4), radius: 0.12, fill: blue.lighten(90%), stroke: 1.2pt + headingblue)
    content((5.15, 1.6), align(center, text(
      size: 8pt,
      weight: "bold",
      fill: headingblue,
    )[Sinxron \ demodulyator \ va LPF]))
    line((6.3, 1.6), (7.2, 1.6), stroke: 2.5pt + headingblue, mark: (end: "stealth", fill: headingblue))
    content((7.3, 1.6), anchor: "west", text(size: 9pt, weight: "bold")[$V_"DC" prop Delta C$])
  }),
  caption: [Siğimli datçikning AC köprikli va sinxron demodulyatorli ölçov zanjiri],
) <fig-capbridge>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: kinematik, akustik va siğimli datçiklarning qiyosiy tahlili

Har bir datçik guruhining texnik, metrologik va ekspluatatsion xususiyatlarini tahlil qiling va @tab-compare ni töldiring.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (2.8cm, 3.1cm, 2.7cm, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Datçik guruhi*],
        [*Ölçaş diapazoni va çastotasi*],
        [*Ajratiş qobiliyati va aniqligi*],
        [*Asosiy ustunligi va kamçiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Taxogeneratorlar / enkoderlar*],
      [$0 dots 20000 "ayl/min"$, çastotasi $10 "kHz"$ gaça],
      [Yuqori ($0.01 degree$ burçak)],
      [*Ustunligi:* tezlikni bevosita ölçaydi. \ *Kamçiligi:* çötkali taxogeneratorda mexanik kontakt va işqalaniş.],
      [*MEMS akselerometr*],
      [$plus.minus 2 g dots plus.minus 500 g$, çastotasi $0 dots 2 "kHz"$],
      [$0.1 "mg"$ gaça (yuqori ajratişli)],
      [*Ustunligi:* statik va dinamik tezlanişni ölçaydi. \ *Kamçiligi:* harorat va dreyf xatosi.],
      [*Ultratovuş (akustik)*], [Masofa $2 dots 500 "cm"$, $f = 40 "kHz"$], [$2 dots 3 "mm"$ aniqlik],
      [*Ustunligi:* kontaktsiz, çangga çidamli. \ *Kamçiligi:* havo harorati va şamol taʼsiri.],
      [*Siğimli sensor*], [Siljiş $10 thin mu"m" dots 10 "mm"$, $f > 100 "kHz"$], [Öta yuqori ($1 "nm"$ gaça)],
      [*Ustunligi:* kontaktsiz, yuqori sezgirlik. \ *Kamçiligi:* namlik va parazit siğimlar taʼsiri.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Datçiklar guruhlarining qiyosiy texnik va metrologik tahlili],
) <tab-compare>

== Topşiriq 2: robotik ilovalar uçun datçiklar majmuasini tanlaş

Quyidagi ikkita texnologik modul uçun datçik turini tanlang va asoslang:

+ *1-modul:* omborxona avtonom mobil roboti (AGV) uçun tösiqlarni $0.1 dots 4 "m"$ masofada kontaktsiz aniqlaş.
+ *2-modul:* sanoat roboti böğinidagi tebraniş va zarba tezlanişini ($a <= 50 g$, $f <= 5 "kHz"$) ölçaş.

*Tahlil va yeçim:*

- *1-modul uçun:* _ultratovuş (akustik) ToF sensorlar majmuasi (masalan, pyezoözgartirgiçlar massivi)_. Sababi: optik datçiklar yaxşi aniqlay olmaydigan şaffof (şişa/plastik) obyektlarni ham işonçli aniqlaydi va çangli omborxona muhitiga çidamli.
- *2-modul uçun:* _pyezoelektr akselerometr (masalan, ICP/IEPE tipidagi)_. Sababi: yuqori çastotali ($5 "kHz"$) tebraniş va katta zarba tezlanişlarini ($50 g$) aniq va keçikişsiz ölçaydi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: MEMS akselerometr dinamikasi va siğim özgarişi hisobi

MEMS siğimli akselerometrning seysmik massasi $m = 2.5 times 10^(-8) "kg"$, prujina bikrligi $k = 100 "N/m"$. Datçik korpusiga $a_"taşqi" = 5 g = 5 times 9.81 = 49.05 "m/s"^2$ tezlaniş taʼsir qilmoqda. Kondensator qoplamalari orasidagi dastlabki masofa $d_0 = 2.0 thin mu"m"$, qoplama yuzasi $A = 0.5 "mm"^2 = 0.5 times 10^(-6) "m"^2$, $epsilon_r = 1.0$.

#set enum(numbering: "a)")
+ Akselerometrning xususiy (rezonans) çastotasi $f_n$ (Hz) ni aniqlang.
+ Tezlaniş taʼsirida seysmik massaning çiziqli siljişi $x$ (nm) ni hisoblang.
+ Kondensatorning boşlanğiç siğimi $C_0$ va siljiş natijasidagi siğim özgarişi $Delta C$ (fF) ni toping.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq(
  $
    omega_n = sqrt(k / m), quad f_n = omega_n / (2 pi), quad x = (m dot a) / k, quad C_0 = epsilon_0 epsilon_r A / d_0, quad Delta C approx C_0 dot x / d_0
  $,
)

*Hisoblaş bosqiçlari:*

- Rezonans burçak çastotasi va çastota:
  #eq($ omega_n = sqrt(100 / (2.5 times 10^(-8))) = sqrt(4 times 10^9) = 63245.55 "rad/s" $)
  #eq($ f_n = 63245.55 / (2 pi) approx 10065.8 "Hz" approx 10.066 "kHz" $)
- Massaning çiziqli siljişi $x$:
  #eq(
    $
      x = (2.5 times 10^(-8) "kg" times 49.05 "m/s"^2) / (100 "N/m") = (1.22625 times 10^(-6)) / 100 \ = 1.22625 times 10^(-8) "m" = 12.26 "nm"
    $,
  )
- Boşlanğiç siğim $C_0$ ($epsilon_0 = 8.854 times 10^(-12) "F/m"$):
  #eq(
    $
      C_0 = 8.854 times 10^(-12) times 1.0 times (0.5 times 10^(-6) "m"^2) / (2.0 times 10^(-6) "m") = 2.2135 times 10^(-12) "F" =\ 2.2135 "pF"
    $,
  )
- Siğim özgarişi $Delta C$:
  #eq(
    $
      Delta C = 2.2135 "pF" times (12.2625 times 10^(-9) "m") / (2.0 times 10^(-6) "m") = 2.2135 times 0.006131 = \ 0.01357 "pF" = 13.57 "fF"
    $,
  )

== Masala 2: ultratovuş datçigi ToF masofa va harorat kompensatsiyasi hisobi

Ultratovuş datçigi ölçov ötkazayotgan xonadagi havo harorati $T = 35 degree"C"$. Datçik uzatgan impuls va qaytgan aks-sado impulsi orasidagi vaqt $t_"ToF" = 14.5 "ms" = 0.0145 "s"$.

#set enum(numbering: "a)")
+ Uşbu haroratda havodagi tovuş tezligi $v_"sod" (35 degree"C")$ ni hisoblang.
+ Obyektgaça bölgan haqiqiy masofa $d_"amaliy"$ ni aniqlang.
+ Agar datçik haroratni hisobga olmasdan, standart $T_0 = 20 degree"C"$ ($v_0 = 343 "m/s"$) böyiça hisoblasa, yuzaga keladigan nisbiy xatolik $delta_d$ (%) neça foiz böladi?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq(
  $
    v_"sod" (T) = 331.3 + 0.606 dot T quad "(m/s)", quad quad d = (v_"sod" dot t_"ToF") / 2, \ quad quad delta_d = (|d_"taxmin" - d_"amaliy"|) / d_"amaliy" times 100%
  $,
)

*Hisoblaş bosqiçlari:*

- Tovuş tezligi $T = 35 degree"C"$ da:
  #eq($ v_"sod" (35) = 331.3 + 0.606 times 35 = 331.3 + 21.21 = 352.51 "m/s" $)
- Haqiqiy masofa $d_"amaliy"$:
  #eq($ d_"amaliy" = (352.51 "m/s" times 0.0145 "s") / 2 = 5.1114 / 2 = 2.5557 "m" = 255.57 "cm" $)
- Harorat kompensatsiyasiz taxminiy masofa ($v_0 = 343 "m/s"$):
  #eq($ d_"taxmin" = (343 times 0.0145) / 2 = 2.48675 "m" = 248.68 "cm" $)
- Nisbiy xatolik $delta_d$:
  #eq($ delta_d = (|248.68 - 255.57|) / 255.57 times 100% = 6.89 / 255.57 times 100% approx 2.70% $)

== Masala 3: siğimli siljiş datçigi va $C\/V$ özgartirgiç hisobi

Yassi siğimli siljiş datçigining qoplama yuzasi $A = 4.0 "cm"^2 = 4.0 times 10^(-4) "m"^2$, qoplamalar orasidagi dastlabki masofa $d_0 = 1.0 "mm" = 1.0 times 10^(-3) "m"$, $epsilon_r = 1.0$. Datçik siğimi $Delta d = 0.15 "mm"$ siljiş taʼsirida özgardi ($d_1 = d_0 - Delta d = 0.85 "mm"$). Siğimli özgartirgiç zanjirining çiqiş kuçlanişi $V_"out" = K_c dot (C_1 - C_0)$, bunda $K_c = 2.0 "V/pF"$.

#set enum(numbering: "a)")
+ Boşlanğiç siğim $C_0$ va siljişdan keyingi siğim $C_1$ ni hisoblang.
+ Siğim özgarişi $Delta C = C_1 - C_0$ (pF) va özgartirgiç çiqiş kuçlanişi $V_"out"$ (V) ni toping.
#set enum(numbering: "1.")

*Hisoblaş bosqiçlari:*

- Boşlanğiç siğim $C_0$:
  #eq(
    $
      C_0 = 8.854 times 10^(-12) times 1.0 times (4.0 times 10^(-4)) / (1.0 times 10^(-3)) = 3.5416 times 10^(-12) "F" = 3.5416 "pF"
    $,
  )
- Siljişdan keyingi siğim $C_1$ ($d_1 = 0.85 "mm"$):
  #eq(
    $
      C_1 = 8.854 times 10^(-12) times 1.0 times (4.0 times 10^(-4)) / (0.85 times 10^(-3)) = (3.5416 times 10^(-12)) / 0.85 approx \ 4.1666 times 10^(-12) "F" = 4.1666 "pF"
    $,
  )
- Siğim özgarişi $Delta C$:
  #eq($ Delta C = 4.1666 "pF" - 3.5416 "pF" = 0.6250 "pF" $)
- Özgartirgiç çiqiş kuçlanişi $V_"out"$:
  #eq($ V_"out" = 2.0 "V/pF" times 0.6250 "pF" = 1.250 "V" $)

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: datçiklar va stend modullarini közdan keçiriş.* Tezlik, MEMS akselerometr, ultratovuş va siğimli datçiklarning kiriş/çiqiş terminallari va elektr ulanişlarini örganing.
+ *2-bosqiç: MEMS akselerometr signallarini ossillografda kuzatiş.* Akselerometrni tebraniş stendiga örnating. Tebraniş çastotasini $10 dots 500 "Hz"$ oraliğida özgartirib, akselerometr analog çiqiş signalining amplitudasi va çastotasini qayd eting.
+ *3-bosqiç: ultratovuş datçigi ToF impulsini ölçaş.* HC-SR04 datçigining Trigger va Echo liniyalarini ossillografga ulang. Tösiqqaça bölgan masofani $10 dots 200 "cm"$ oraliğida özgartirib, Echo impulsining davomiyligi $t_"ToF"$ ni ölçang va masofani hisoblang.
+ *4-bosqiç: siğimli siljiş datçigini kalibrlaş tajribasi.* Siğimli datçik qoplamalari orasidagi masofani mikrometr yordamida $0.1 "mm"$ qadam bilan özgartirib, $C\/V$ özgartirgiç çiqiş kuçlanişi $V_"out"$ ni yozib oling va $V_"out" (d)$ grafigini çizing.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan natijalarni nazariy hisoblar bilan soliştirib, hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Tezlik datçiklarining (DC taxogenerator va optik/Hall impulsli datçiklar) işlaş prinsiplari va farqlarini tuşuntiring.
+ Akselerometr datçiklarining prujina-massa-dempfer (_mass-spring-damper_) differensial dinamik modelini izohlang.
+ Pyezoelektr va MEMS siğimli akselerometrlarning qaysi biri statik ($0 "Hz"$, oğirlik kuçi $g$) tezlanişni ölçay oladi va nima uçun?
+ Ultratovuş datçiklarida Time-of-Flight (ToF) böyiça masofa ölçaş formulasi qanday va havodagi tovuş tezligiga haroratning taʼsiri qanday?
+ Siğimli datçiklarning $C = epsilon_0 epsilon_r A \/ d$ formulasi böyiça ölçaşning 3 ta usulini tuşuntiring.
+ Siğimli datçiklarda parazit siğimlar (_parasitic capacitance_) va ularni yöqotiş usullari (ekranlaş, _guard ring_) nimadan iborat?
+ MEMS siğimli akselerometrlarda differensial siğim sxemasi ($C_1$ va $C_2$) nima uçun qöllaniladi?
+ Ultratovuş datçiklarida kör zona (_blind zone / dead zone_) paydo bölişining fizik sababi nima?
+ Akselerometr maʼlumotlarini bir va ikki marta integrallaş orqali tezlik ($v$) va siljiş ($S$) ni topişdagi dreyf (_drift_) muammosini tuşuntiring.
+ Siğimli datçiklar uçun AC köprikli va sinxron demodulyatorli signalni konditsiyalaş zanjirining işlaş prinsipi qanday?
+ Hall datçikli tezlik ölçagiçlarning optik enkoderlarga nisbatan çangli va yoğli sanoat muhitidagi afzalliklari nimada?
+ Avtonom mobil robotlarda (AGV/AMR) ultratovuş va siğimli datçiklarning birgalikda qöllaniliş sohalarini izohlang.
