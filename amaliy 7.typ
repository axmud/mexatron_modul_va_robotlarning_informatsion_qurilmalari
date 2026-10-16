// ============================================================
//  MMRIQ — 7-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_7.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Tezlik va tezlanish datchiklari. Akustik va sigʻim datchiklari")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI № 7]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Tezlik va tezlanish datchiklari ishini oʻrganish. Akustik datchik, sigʻim datchiklari ishini tahlil qilish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatronik tizimlar va robototexnika majmualarida keng qoʻllaniladigan tezlik, tezlanish (akselerometrlar), akustik (ultratovush) hamda sigʻimli datchiklarning fizik-texnik ishlash prinsiplari, konstruktiv tuzilishi, signalni shakllantirish va qayta ishlash zanjirlarini (_signal conditioning_) chuqur oʻrganish va hisoblash koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Chiziqli va burchak tezlik datchiklarining (DC/AC taxogeneratorlar, Hall datchikli va optik enkoderli tezlik oʻlchagichlar) fizik-texnik xarakteristikalarini tahlil qilish.
+ Tezlanish datchiklarining (MEMS, pyezoelektr va sigʻimli akselerometrlar) differensial dinamik modelini (_mass-spring-damper system_) va ishlash mexanizmini oʻrganish.
+ Akustik va ultratovush (_ultrasonic_) datchiklarning signal tarqalish vaqti (_Time-of-Flight_, ToF) tamoyili boʻyicha masofa va toʻsiqlarni aniqlash algoritmlarini tahlil qilish.
+ Sigʻimli (_capacitive_) datchiklarning geometrik va dielektrik parametrlar oʻzgarishi boʻyicha ishlash tamoyillarini hamda AC koʻprikli va sigʻim-kuchlanish ($C\/V$) oʻzgartirgich zanjirlarini oʻrganish.
+ Sensordan olingan signallarni raqamlash, harorat va shovqin taʼsirini kompensatsiya qilish hamda muhandislik hisoblash masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* kinematik va dinamik datchiklar laboratoriya stendi, tebranish stendi (_vibration shaker table_), optik va Hall effektli tezlik datchiklari, MEMS IMU 6-DoF moduli (MPU6050 / LSM6DS3), ultratovush masofa datchigi (HC-SR04 / pyezokeramik oʻzgartirgich), sigʻimli siljish va sath datchiklari.
- *Nazorat-oʻlchov vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, stroboskopik stend, signal generatori.
- *Boshqaruv va DAQ modullari:* STM32F4/F7 mikrokontrollerli plata, Arduino Mega, National Instruments DAQ platasi.
- *Dasturiy muhit:* MATLAB / Simulink (Simscape), LabVIEW, Proteus.

= Nazariy maʼlumotlar va datchiklar klassifikatsiyasi

== Tezlik datchiklarining ishlash tamoyili va turlari

Mexatron modullarda tezlik ilgarilanma chiziqli tezlik $v$ (m/s) yoki burchak tezlik $omega$ (rad/s, ayl/min) koʻrinishida oʻlchanadi. W. Bolton va P.P.L. Regtien darsliklariga koʻra, tezlik datchiklari quyidagi turlarga boʻlinadi:

+ *Taxogeneratorlar (DC/AC tachogenerators):* elektromagnit induksiya qonuniga ($e = B dot l dot v$) asoslangan. Oʻzgarmas tok taxogeneratori val aylanganda tezlikka mutanosib analog kuchlanish $V_"out" = K_t dot omega$ beradi.
+ *Impulsli tezlik datchiklari (Hall sensor & optik enkoder):* valga oʻrnatilgan tishli disk yoki magnitlar yordamida chastotasi $f$ boʻlgan impulslar hosil qiladi:
  #eq($ omega = (2 pi dot f) / N_p $)
  bunda $N_p$ --- diskning bir toʻliq aylanishidagi impulslar soni.

== Tezlanish datchiklari (akselerometrlar) va ularning dinamik modeli

Tezlanish datchiklari inersiya kuchini ($F = m dot a$) oʻlchashga asoslangan. Ishlash mexanizmi seysmik massa ($m$), prujina ($k$) va dempfer ($c$) tizimidan iborat (@fig-mems). Akselerometrning harakat differensial tenglamasi:

#eq($ m dot.double(x)(t) + c dot(x)(t) + k x(t) = -m a_"tashqi" (t) $)

bunda $x(t)$ --- seysmik massaning korpusga nisbatan siljishi, $a_"tashqi" (t)$ --- oʻlchanayotgan obyekt tezlanishi. Past chastotali rejimda ($omega << omega_n = sqrt(k\/m)$) siljish tezlanishga mutanosib boʻladi:

#eq($ |x| approx m / k a_"tashqi" = a_"tashqi" / omega_n^2 $)

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
        [*№*], [*Akselerometr turi*], [*Fizik oʻzgartirish tamoyili*], [*Xarakterli xususiyati va qoʻllanilishi*]
      ),
      table.hline(stroke: 0.5pt),
      [1],
      [*Pyezoelektr akselerometr*],
      [Pyezoelementda bosim taʼsirida elektr zaryadi $Q = d_33 dot F$ hosil boʻlishi.],
      [Keng chastota diapazoni ($1 "Hz" dots 20 "kHz"$); statik ($0 "Hz"$) tezlanishni oʻlchay olmaydi. Tebranish diagnostikasi.],
      [2],
      [*MEMS sigʻimli akselerometr*],
      [Seysmik massa siljiganda taroqsimon mikroelektrodlar orasidagi sigʻim $Delta C$ ning oʻzgarishi.],
      [Statik ($0 "Hz"$, $g$) va dinamik tezlanishni oʻlchaydi; kichik oʻlcham. Mobil robotlar va dronlar.],
      [3],
      [*Pyezorezistiv akselerometr*],
      [Prujina elementi deformatsiyalanganda tenzorezistor qarshiligi $Delta R$ ning oʻzgarishi.],
      [Yuqori zarbalarga ($> 1000 g$) chidamli, tezkor. Avtomobil krash-testlari va zarba sinovlari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Tezlanish datchiklarining (akselerometrlarning) turlari va qiyosiy koʻrsatkichlari],
) <tab-accel>

== Akustik va ultratovush datchiklar

Akustik datchiklar havoda yoki qattiq muhitda akustik toʻlqinlarning (chastotasi $f > 20 "kHz"$ boʻlgan ultratovushning) tarqalishi va qaytishiga asoslanadi.

*Time-of-Flight (ToF) boʻyicha masofa oʻlchash prinsipi:* datchik pyezoelektr uzatgich (_transmitter_) orqali ultratovush impulsini yuboradi va obyektdan qaytgan aks-sado (_echo_) impulsini qabul qilgich (_receiver_) orqali ushlaydi (@fig-tof). Obyektgacha boʻlgan masofa $d$:

#eq($ d = (v_"sod" dot t_"ToF") / 2 $)

bunda $v_"sod"$ --- havodagi tovush tezligi ($T = 20 degree"C"$ da $v_"sod" approx 343 "m/s"$), $t_"ToF"$ --- impulsning borib-kelish umumiy vaqti. Havoda tovush tezligining haroratga $T$ ($degree"C"$) bogʻliqligi:

#eq($ v_"sod" (T) = 331.3 dot sqrt(1 + T / 273.15) approx 331.3 + 0.606 dot T quad "(m/s)" $)

== Sigʻimli (capacitive) datchiklar

Sigʻimli datchiklar yassi kondensator sigʻimi $C$ ning geometrik va fizik parametrlarga bogʻliqligiga asoslanadi:

#eq($ C = epsilon_0 dot epsilon_r dot A / d $)

bunda $epsilon_0 = 8.854 times 10^(-12) "F/m"$ --- elektr doimiysi, $epsilon_r$ --- muhitning nisbiy dielektrik singdiruvchanligi, $A$ --- qoplamalarning bir-birini yopish yuzasi, $d$ --- qoplamalar orasidagi masofa.

*Oʻzgartirish usullariga koʻra sigʻimli datchiklar:*

+ *Masofa oʻzgarishi boʻyicha ($d$ oʻzgaradi):* qoplamalar orasidagi $d$ masofa oʻzgarganda $C(d)$ giperbolik bogʻliqlikka ega boʻladi ($Delta C approx -(epsilon A) / d_0^2 Delta d$).
+ *Yopish yuzasi boʻyicha ($A$ oʻzgaradi):* qoplamalarning parallel koʻchishida $A$ yuzasi oʻzgarib, $C(A)$ chiziqli bogʻliqlikni beradi.
+ *Dielektrik singdiruvchanlik boʻyicha ($epsilon_r$ oʻzgaradi):* qoplamalar oraligʻiga turli suyuqlik yoki material kirganda sigʻim oʻzgaradi (suyuqlik sathini oʻlchash).

= Mavzuga oid chizmalar va sxemalar

== MEMS sigʻimli akselerometrning prujina-massa-dempfer va elektrodlar modeli

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
    content((1.5, 1.8), anchor: "west", text(size: 9pt, weight: "bold")[Tezlanish $a_"tashqi"$])
    line((0.2, -1.7), (-1.0, -1.7), stroke: 2.5pt + blue.lighten(10%), mark: (end: "stealth", fill: blue.lighten(10%)))
    content((0.3, -1.7), anchor: "west", text(size: 9pt, weight: "bold")[Siljish $x$])
  }),
  caption: [MEMS sigʻimli akselerometrning massa-prujina-dempfer va differensial sigʻim sxemasi],
) <fig-mems>

== Ultratovush datchigining Time-of-Flight (ToF) boʻyicha masofa oʻlchash tamoyili

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
    content((4.0, 0), angle: -90deg, text(size: 8.5pt, weight: "bold", fill: orng)[Aks ettiruvchi toʻsiq])

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
    )[Oʻlchanayotgan masofa $d = (v dot t_"ToF") / 2$])
  }),
  caption: [Ultratovush datchigining Time-of-Flight (ToF) boʻyicha masofani aniqlash sxemasi],
) <fig-tof>

== Sigʻimli datchik va AC koʻprikli signalni konditsiyalash zanjiri

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
    arm(b, bot, box(baseline: -100%, [#text(size: 4.5pt)[$C_x$ (datchik)]]), fill: orange.lighten(75%))

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
  caption: [Sigʻimli datchikning AC koʻprikli va sinxron demodulyatorli oʻlchov zanjiri],
) <fig-capbridge>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: kinematik, akustik va sigʻimli datchiklarning qiyosiy tahlili

Har bir datchik guruhining texnik, metrologik va ekspluatatsion xususiyatlarini tahlil qiling va @tab-compare ni toʻldiring.

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
        [*Datchik guruhi*],
        [*Oʻlchash diapazoni va chastotasi*],
        [*Ajratish qobiliyati va aniqligi*],
        [*Asosiy ustunligi va kamchiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Taxogeneratorlar / enkoderlar*],
      [$0 dots 20000 "ayl/min"$, chastotasi $10 "kHz"$ gacha],
      [Yuqori ($0.01 degree$ burchak)],
      [*Ustunligi:* tezlikni bevosita oʻlchaydi. \ *Kamchiligi:* choʻtkali taxogeneratorda mexanik kontakt va ishqalanish.],
      [*MEMS akselerometr*],
      [$plus.minus 2 g dots plus.minus 500 g$, chastotasi $0 dots 2 "kHz"$],
      [$0.1 "mg"$ gacha (yuqori ajratishli)],
      [*Ustunligi:* statik va dinamik tezlanishni oʻlchaydi. \ *Kamchiligi:* harorat va dreyf xatosi.],
      [*Ultratovush (akustik)*], [Masofa $2 dots 500 "cm"$, $f = 40 "kHz"$], [$2 dots 3 "mm"$ aniqlik],
      [*Ustunligi:* kontaktsiz, changga chidamli. \ *Kamchiligi:* havo harorati va shamol taʼsiri.],
      [*Sigʻimli sensor*], [Siljish $10 thin mu"m" dots 10 "mm"$, $f > 100 "kHz"$], [Oʻta yuqori ($1 "nm"$ gacha)],
      [*Ustunligi:* kontaktsiz, yuqori sezgirlik. \ *Kamchiligi:* namlik va parazit sigʻimlar taʼsiri.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Datchiklar guruhlarining qiyosiy texnik va metrologik tahlili],
) <tab-compare>

== Topshiriq 2: robotik ilovalar uchun datchiklar majmuasini tanlash

Quyidagi ikkita texnologik modul uchun datchik turini tanlang va asoslang:

+ *1-modul:* omborxona avtonom mobil roboti (AGV) uchun toʻsiqlarni $0.1 dots 4 "m"$ masofada kontaktsiz aniqlash.
+ *2-modul:* sanoat roboti boʻgʻinidagi tebranish va zarba tezlanishini ($a <= 50 g$, $f <= 5 "kHz"$) oʻlchash.

*Tahlil va yechim:*

- *1-modul uchun:* _ultratovush (akustik) ToF sensorlar majmuasi (masalan, pyezooʻzgartirgichlar massivi)_. Sababi: optik datchiklar yaxshi aniqlay olmaydigan shaffof (shisha/plastik) obyektlarni ham ishonchli aniqlaydi va changli omborxona muhitiga chidamli.
- *2-modul uchun:* _pyezoelektr akselerometr (masalan, ICP/IEPE tipidagi)_. Sababi: yuqori chastotali ($5 "kHz"$) tebranish va katta zarba tezlanishlarini ($50 g$) aniq va kechikishsiz oʻlchaydi.

= Hisoblash va modellashtirish masalalari

== Masala 1: MEMS akselerometr dinamikasi va sigʻim oʻzgarishi hisobi

MEMS sigʻimli akselerometrning seysmik massasi $m = 2.5 times 10^(-8) "kg"$, prujina bikrligi $k = 100 "N/m"$. Datchik korpusiga $a_"tashqi" = 5 g = 5 times 9.81 = 49.05 "m/s"^2$ tezlanish taʼsir qilmoqda. Kondensator qoplamalari orasidagi dastlabki masofa $d_0 = 2.0 thin mu"m"$, qoplama yuzasi $A = 0.5 "mm"^2 = 0.5 times 10^(-6) "m"^2$, $epsilon_r = 1.0$.

#set enum(numbering: "a)")
+ Akselerometrning xususiy (rezonans) chastotasi $f_n$ (Hz) ni aniqlang.
+ Tezlanish taʼsirida seysmik massaning chiziqli siljishi $x$ (nm) ni hisoblang.
+ Kondensatorning boshlangʻich sigʻimi $C_0$ va siljish natijasidagi sigʻim oʻzgarishi $Delta C$ (fF) ni toping.
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq(
  $
    omega_n = sqrt(k / m), quad f_n = omega_n / (2 pi), quad x = (m dot a) / k, quad C_0 = epsilon_0 epsilon_r A / d_0, quad Delta C approx C_0 dot x / d_0
  $,
)

*Hisoblash bosqichlari:*

- Rezonans burchak chastotasi va chastota:
  #eq($ omega_n = sqrt(100 / (2.5 times 10^(-8))) = sqrt(4 times 10^9) = 63245.55 "rad/s" $)
  #eq($ f_n = 63245.55 / (2 pi) approx 10065.8 "Hz" approx 10.066 "kHz" $)
- Massaning chiziqli siljishi $x$:
  #eq(
    $
      x = (2.5 times 10^(-8) "kg" times 49.05 "m/s"^2) / (100 "N/m") = (1.22625 times 10^(-6)) / 100 \ = 1.22625 times 10^(-8) "m" = 12.26 "nm"
    $,
  )
- Boshlangʻich sigʻim $C_0$ ($epsilon_0 = 8.854 times 10^(-12) "F/m"$):
  #eq(
    $
      C_0 = 8.854 times 10^(-12) times 1.0 times (0.5 times 10^(-6) "m"^2) / (2.0 times 10^(-6) "m") = 2.2135 times 10^(-12) "F" = 2.2135 "pF"
    $,
  )
- Sigʻim oʻzgarishi $Delta C$:
  #eq(
    $
      Delta C = 2.2135 "pF" times (12.2625 times 10^(-9) "m") / (2.0 times 10^(-6) "m") = 2.2135 times 0.006131 = \ 0.01357 "pF" = 13.57 "fF"
    $,
  )

== Masala 2: ultratovush datchigi ToF masofa va harorat kompensatsiyasi hisobi

Ultratovush datchigi oʻlchov oʻtkazayotgan xonadagi havo harorati $T = 35 degree"C"$. Datchik uzatgan impuls va qaytgan aks-sado impulsi orasidagi vaqt $t_"ToF" = 14.5 "ms" = 0.0145 "s"$.

#set enum(numbering: "a)")
+ Ushbu haroratda havodagi tovush tezligi $v_"sod" (35 degree"C")$ ni hisoblang.
+ Obyektgacha boʻlgan haqiqiy masofa $d_"amaliy"$ ni aniqlang.
+ Agar datchik haroratni hisobga olmasdan, standart $T_0 = 20 degree"C"$ ($v_0 = 343 "m/s"$) boʻyicha hisoblasa, yuzaga keladigan nisbiy xatolik $delta_d$ (%) necha foiz boʻladi?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq(
  $
    v_"sod" (T) = 331.3 + 0.606 dot T quad "(m/s)", quad quad d = (v_"sod" dot t_"ToF") / 2, \ quad quad delta_d = (|d_"taxmin" - d_"amaliy"|) / d_"amaliy" times 100%
  $,
)

*Hisoblash bosqichlari:*

- Tovush tezligi $T = 35 degree"C"$ da:
  #eq($ v_"sod" (35) = 331.3 + 0.606 times 35 = 331.3 + 21.21 = 352.51 "m/s" $)
- Haqiqiy masofa $d_"amaliy"$:
  #eq($ d_"amaliy" = (352.51 "m/s" times 0.0145 "s") / 2 = 5.1114 / 2 = 2.5557 "m" = 255.57 "cm" $)
- Harorat kompensatsiyasiz taxminiy masofa ($v_0 = 343 "m/s"$):
  #eq($ d_"taxmin" = (343 times 0.0145) / 2 = 2.48675 "m" = 248.68 "cm" $)
- Nisbiy xatolik $delta_d$:
  #eq($ delta_d = (|248.68 - 255.57|) / 255.57 times 100% = 6.89 / 255.57 times 100% approx 2.70% $)

== Masala 3: sigʻimli siljish datchigi va $C\/V$ oʻzgartirgich hisobi

Yassi sigʻimli siljish datchigining qoplama yuzasi $A = 4.0 "cm"^2 = 4.0 times 10^(-4) "m"^2$, qoplamalar orasidagi dastlabki masofa $d_0 = 1.0 "mm" = 1.0 times 10^(-3) "m"$, $epsilon_r = 1.0$. Datchik sigʻimi $Delta d = 0.15 "mm"$ siljish taʼsirida oʻzgardi ($d_1 = d_0 - Delta d = 0.85 "mm"$). Sigʻimli oʻzgartirgich zanjirining chiqish kuchlanishi $V_"out" = K_c dot (C_1 - C_0)$, bunda $K_c = 2.0 "V/pF"$.

#set enum(numbering: "a)")
+ Boshlangʻich sigʻim $C_0$ va siljishdan keyingi sigʻim $C_1$ ni hisoblang.
+ Sigʻim oʻzgarishi $Delta C = C_1 - C_0$ (pF) va oʻzgartirgich chiqish kuchlanishi $V_"out"$ (V) ni toping.
#set enum(numbering: "1.")

*Hisoblash bosqichlari:*

- Boshlangʻich sigʻim $C_0$:
  #eq(
    $
      C_0 = 8.854 times 10^(-12) times 1.0 times (4.0 times 10^(-4)) / (1.0 times 10^(-3)) = 3.5416 times 10^(-12) "F" = 3.5416 "pF"
    $,
  )
- Siljishdan keyingi sigʻim $C_1$ ($d_1 = 0.85 "mm"$):
  #eq(
    $
      C_1 = 8.854 times 10^(-12) times 1.0 times (4.0 times 10^(-4)) / (0.85 times 10^(-3)) = (3.5416 times 10^(-12)) / 0.85 approx \ 4.1666 times 10^(-12) "F" = 4.1666 "pF"
    $,
  )
- Sigʻim oʻzgarishi $Delta C$:
  #eq($ Delta C = 4.1666 "pF" - 3.5416 "pF" = 0.6250 "pF" $)
- Oʻzgartirgich chiqish kuchlanishi $V_"out"$:
  #eq($ V_"out" = 2.0 "V/pF" times 0.6250 "pF" = 1.250 "V" $)

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: datchiklar va stend modullarini koʻzdan kechirish.* Tezlik, MEMS akselerometr, ultratovush va sigʻimli datchiklarning kirish/chiqish terminallari va elektr ulanishlarini oʻrganing.
+ *2-bosqich: MEMS akselerometr signallarini ossillografda kuzatish.* Akselerometrni tebranish stendiga oʻrnating. Tebranish chastotasini $10 dots 500 "Hz"$ oraligʻida oʻzgartirib, akselerometr analog chiqish signalining amplitudasi va chastotasini qayd eting.
+ *3-bosqich: ultratovush datchigi ToF impulsini oʻlchash.* HC-SR04 datchigining Trigger va Echo liniyalarini ossillografga ulang. Toʻsiqqacha boʻlgan masofani $10 dots 200 "cm"$ oraligʻida oʻzgartirib, Echo impulsining davomiyligi $t_"ToF"$ ni oʻlchang va masofani hisoblang.
+ *4-bosqich: sigʻimli siljish datchigini kalibrlash tajribasi.* Sigʻimli datchik qoplamalari orasidagi masofani mikrometr yordamida $0.1 "mm"$ qadam bilan oʻzgartirib, $C\/V$ oʻzgartirgich chiqish kuchlanishi $V_"out"$ ni yozib oling va $V_"out" (d)$ grafigini chizing.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan natijalarni nazariy hisoblar bilan solishtirib, hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Tezlik datchiklarining (DC taxogenerator va optik/Hall impulsli datchiklar) ishlash prinsiplari va farqlarini tushuntiring.
+ Akselerometr datchiklarining prujina-massa-dempfer (_mass-spring-damper_) differensial dinamik modelini izohlang.
+ Pyezoelektr va MEMS sigʻimli akselerometrlarning qaysi biri statik ($0 "Hz"$, ogʻirlik kuchi $g$) tezlanishni oʻlchay oladi va nima uchun?
+ Ultratovush datchiklarida Time-of-Flight (ToF) boʻyicha masofa oʻlchash formulasi qanday va havodagi tovush tezligiga haroratning taʼsiri qanday?
+ Sigʻimli datchiklarning $C = epsilon_0 epsilon_r A \/ d$ formulasi boʻyicha oʻlchashning 3 ta usulini tushuntiring.
+ Sigʻimli datchiklarda parazit sigʻimlar (_parasitic capacitance_) va ularni yoʻqotish usullari (ekranlash, _guard ring_) nimadan iborat?
+ MEMS sigʻimli akselerometrlarda differensial sigʻim sxemasi ($C_1$ va $C_2$) nima uchun qoʻllaniladi?
+ Ultratovush datchiklarida koʻr zona (_blind zone / dead zone_) paydo boʻlishining fizik sababi nima?
+ Akselerometr maʼlumotlarini bir va ikki marta integrallash orqali tezlik ($v$) va siljish ($S$) ni topishdagi dreyf (_drift_) muammosini tushuntiring.
+ Sigʻimli datchiklar uchun AC koʻprikli va sinxron demodulyatorli signalni konditsiyalash zanjirining ishlash prinsipi qanday?
+ Hall datchikli tezlik oʻlchagichlarning optik enkoderlarga nisbatan changli va yogʻli sanoat muhitidagi afzalliklari nimada?
+ Avtonom mobil robotlarda (AGV/AMR) ultratovush va sigʻimli datchiklarning birgalikda qoʻllanilish sohalarini izohlang.
