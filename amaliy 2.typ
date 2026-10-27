// ============================================================
//  MMRIQ — 2-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_2.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Robotlarning asosiy turlari bilan tanişiş")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 2  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №2]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Robotlarning asosiy turlari bilan tanişiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* zamonaviy robototexnika tizimlarida qöllaniladigan robotlarning kinematik va konstruktiv strukturasi, harakatlaniş prinsiplari, qöllaniliş sohalari hamda klassifikatsiya belgilarini örganiş; sanoat va mobil robotlarning asosiy turlarini amaliy tahlil qiliş hamda ularning kinematik körsatkiçlarini hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Sanoat va xizmat körsatuvçi robotlarning tasniflanişi hamda xalqaro ISO 8373 standartiga muvofiq taʼriflarini örganiş.
+ Sanoat manipulyatorlarining 6 ta asosiy kinematik turini (Dekart, silindrik, sferik, böğinli/Articulated, SCARA va parallel/Delta) örganiş hamda ularning işçi zonasi (_workspace_) şakllarini tahlil qiliş.
+ Mobil robotlarning ğildirakli (_wheeled_), gusenitsali (_tracked_), oyoqli (_legged_) va uçuvçisiz (UAV) turlari konstruksiyasini örganiş.
+ Robotlarning erkinlik darajalari (DoF --- _Degrees of Freedom_), lokal va global koordinatalar tizimlari hamda gomogen özgartiriş matritsalarining mantiqiy asoslarini tahlil qiliş.
+ Manipulyatorlarning töğri kinematikasi (_Forward Kinematics_) va mobil robotlarning differensial kinematikasi (_Differential Drive Kinematics_) böyiça muhandislik hisoblaşlarini bajariş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* 6-DoF sanoat roboti öquv maketi (Articulated Arm), SCARA laboratoriya manipulyatori, differensial ğildirakli mobil robot platformasi (AGV/AMR).
- *Modellaştiriş va dasturiy taʼminot:* MATLAB / Simulink (Robotics System Toolbox), ROS / ROS 2 (_Robot Operating System_), Gazebo simulyatsiya muhiti, CoppeliaSim (V-REP).
- *Körgazmali va ölçov vositalari:* robotlarning kinematik sxemalari plakatlari, burçak ölçagiçlar (inklinometrlar), optik enkoderli stendlar.

= Nazariy maʼlumotlar va robotlar klassifikatsiyasi

== Robototexnika fani va robot tuşunçasi

ISO 8373 xalqaro standartiga köra, *sanoat roboti* deb avtomatik boşqariladigan, qayta dasturlanadigan, uç yoki undan ortiq öq böyiça dasturlanuvçi, bir neça maqsadda qöllanila oladigan, bir joyga örnatilgan yoki mobil körinişdagi köp funksiyali manipulyatsion tizimga aytiladi.

Robototexnika uçta asosiy fundamental ilmiy sohaning çorrahasida şakllangan:

+ *Mexanika va materialşunoslik:* robot manipulyatori va şassisining kinematik hamda dinamik strukturasini loyihalaş.
+ *Boşqaruv nazariyasi va elektronika:* sensorlar maʼlumotlarini töplaş, motor va aktuatorlarni yopiq zanjirda PID/Fuzzy usullari bilan boşqariş.
+ *Kompyuter ilmlari va sunʼiy intellekt:* trayektoriyani rejalaştiriş (_motion planning_), kompyuter körişi (_computer vision_), SLAM (_Simultaneous Localization and Mapping_) hamda maşinali öqitiş (_machine learning_).

== Sanoat robotlarining kinematik konstruksiyasi böyiça turlari

Sanoat robotlari manipulyatorining böğinlari (_joints_) asosan ikkita turga bölinadi:

- *Aylanma böğin ($R$ --- Revolute Joint):* böğinning burçakli burilişini taʼminlaydi.
- *Ilgarilanma böğin ($P$ --- Prismatic Joint):* çiziqli böylama siljişni taʼminlaydi.

Manipulyatorning dastlabki uçta böğinining joylaşuv kombinatsiyasiga qarab sanoat robotlari 6 ta asosiy kinematik oilaga ajratiladi (@tab-types).

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, 2.8cm, auto, 1fr, 1fr),
      align: (center + horizon, left + horizon, center + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Kinematik turi*], [*Böğinlar*], [*Işçi zonasi (workspace)*], [*Asosiy qöllaniliş sohasi*]),
      table.hline(stroke: 0.5pt),
      [1], [*Dekart* (Cartesian / Gantry)], [$P P P$], [Töğri burçakli parallelepiped],
      [3D printerlar, CNC plazma kesgiçlar, omborxona saralaş.],
      [2], [*Silindrik* (Cylindrical)], [$R P P$], [Silindr (yoki içi böş silindr)],
      [Presslaş sexlari, metall quyiş, detal yuklaş-böşatiş.],
      [3], [*Sferik* (Spherical / Polar)], [$R R P$], [Sferik sektor / şar],
      [Payvandlaş, metallni mexanik qayta işlaş, quyiş.],
      [4], [*Ştangali-böğinli* (Articulated)], [$R R R$], [Murakkab sferik köriniş],
      [Avtomobil payvandlaş, böyoq sepiş, yiğuv liniyalari.],
      [5], [*SCARA*], [$R R P$], [Silindrik tekis qatlamli],
      [Elektron plataga komponent teriş (Pick-and-Place).],
      [6], [*Parallel* (Delta)], [Parallel \ $R$ / $P$], [Gumbazsimon / konussimon],
      [Oziq-ovqat va farmatsevtikada tezkor saralaş.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sanoat robotlarining kinematik turlari va ularning texnik tavsifi],
) <tab-types>

== Sanoat robotlarining kinematik struktura sxemalari

Quyida eng keng tarqalgan uçta sanoat roboti tipining (Dekart, SCARA va ştangali-böğinli) kinematik sxemasi va böğinlar ketma-ketligi keltirilgan (@fig-schemes).

#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let blue-l = blue.darken(10%)
    let orng = orange.darken(15%)
    let small(body) = text(size: 7pt, weight: "bold", body)
    let joint(p, r, lab) = {
      circle(p, radius: r, fill: blue-l, stroke: 0.6pt)
      content(p, text(size: 6pt, fill: white, weight: "bold", lab))
    }
    let tag(p, body) = {
      rect((p.at(0) - 1.35, p.at(1) - 0.38), (p.at(0) + 1.35, p.at(1) + 0.38), fill: blue.lighten(93%), stroke: 0.6pt)
      content(p, align(center, text(size: 7pt, weight: "bold", body)))
    }

    // ---- a) Dekart robot (PPP) ----
    group({
      line((0, 0), (0, 2.2), stroke: 2pt + gray.darken(40%))
      line((2.6, 0), (2.6, 2.2), stroke: 2pt + gray.darken(40%))
      line((0, 2.2), (2.6, 2.2), stroke: 1.6pt + blue-c)
      content((0.1, 2.3), anchor: "south-west", small[X ($P_1$)])
      line((1.2, 2.2), (1.9, 2.85), stroke: 1.6pt + blue-c)
      content((1.95, 2.9), anchor: "west", small[Y ($P_2$)])
      line((1.55, 2.5), (1.55, 0.8), stroke: 2.5pt + orng)
      circle((1.55, 0.8), radius: 0.12, fill: blue-c, stroke: none)
      content((1.7, 1.3), anchor: "west", small[Z ($P_3$)])
      tag((1.3, -0.7))[a) Dekart (PPP) \ töğri burçakli]
    })

    // ---- b) SCARA robot (RRP) ----
    group({
      translate((5.5, 0))
      rect((0, 0), (0.8, 0.4), fill: blue-c, stroke: none)
      line((0.4, 0.4), (0.4, 1.2), stroke: 2.5pt + gray.darken(40%))
      line((0.4, 1.2), (2.0, 1.8), stroke: 1.6pt + blue-c)
      line((2.0, 1.8), (3.2, 1.2), stroke: 1.6pt + blue-c)
      joint((0.4, 1.2), 0.25, $R_1$)
      joint((2.0, 1.8), 0.22, $R_2$)
      line((3.2, 1.2), (3.2, 0.1), stroke: 2.5pt + orng, mark: (end: "stealth", fill: orng))
      content((3.3, 0.5), anchor: "west", small[$P_3$ (Z)])
      tag((1.8, -0.7))[b) SCARA (RRP) \ gorizontal tekislik]
    })

    // ---- c) Boʻgʻinli robot (RRR) ----
    group({
      translate((11.5, 0))
      line((0, 0), (0, 0.8), stroke: 2.5pt + gray.darken(40%))
      line((0, 0.8), (0.8, 2.2), stroke: 1.6pt + blue-c)
      line((0.8, 2.2), (2.2, 2.0), stroke: 1.6pt + blue-c)
      line((2.2, 2.0), (2.8, 1.2), stroke: 1.6pt + orng)
      joint((0, 0.8), 0.3, $R_1$)
      joint((0.8, 2.2), 0.25, $R_2$)
      joint((2.2, 2.0), 0.2, $R_3$)
      circle((2.8, 1.2), radius: 0.1, fill: orng, stroke: none)
      tag((1.2, -0.7))[c) Böğinli (RRR) \ antropomorf qöl]
    })
  }),
  caption: [Sanoat robotlarining asosiy kinematik konstruksiya sxemalari],
) <fig-schemes>

== Mobil robotlarning klassifikatsiyasi va strukturasi

Mobil robotlar harakatlaniş muhiti va mexanizmiga qarab quyidagi turlarga bölinadi.

=== Ğildirakli mobil robotlar (WMR --- Wheeled Mobile Robots)

- *Differensial yuritmali (Differential Drive):* ikkita mustaqil yetakçi ğildirak va bitta/ikkita erkin tayanç (_caster_) ğildirakka ega.
- *Akkerman boşqaruvli (Ackermann Steering):* avtomobil tipidagi old ğildiraklar bilan buriluvçi mobil robot.
- *Omni-ğildirakli va Mecanum (Omnidirectional):* maxsus $45 degree$ yoki $90 degree$ rolikli ğildiraklar yordamida tekislikda xohlagan yönalişda korpusini burmasdan harakatlanuvçi robotlar.

=== Oyoqli mobil robotlar (Legged / Bipedal / Quadrupedal)

Inson yoki hayvonlar harakatini imitatsiya qiluvçi robotlar:

- *Ikki oyoqli (Bipedal / Anthropomorphic):* Boston Dynamics Atlas, Honda ASIMO.
- *Tört oyoqli (Quadrupedal):* Boston Dynamics Spot, Unitree Go1. Qiya va notekis relyeflarda yuqori ötuvçanlikka ega.

=== Uçuvçisiz va maxsus robotlar

- *Uçuvçisiz uçiş apparatlari (UAV / dronlar):* kvadrokopter, geksakopter va qözğalmas qanotli dronlar.
- *Suv osti robotlari (ROV / AUV):* masofadan boşqariladigan va avtonom ğavvoslik robotlari.

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let small(body) = text(size: 7pt, weight: "bold", body)
    let dark = gray.darken(60%)

    // Shassi
    rect((-2, -1.2), (2, 1.2), radius: 0.2, fill: blue.lighten(93%), stroke: 1pt + headingblue)
    content((0, 0.55), text(size: 8pt, weight: "bold", fill: headingblue)[Differensial mobil robot])

    // Gʻildiraklar
    rect((-1.5, 1.2), (-0.5, 1.5), fill: dark, stroke: none)
    content((-1.0, 1.6), anchor: "south", small[Çap ğildirak ($v_L$)])
    rect((-1.5, -1.5), (-0.5, -1.2), fill: dark, stroke: none)
    content((-1.0, -1.6), anchor: "north", small[Öng ğildirak ($v_R$)])

    // Tayanch (caster) gʻildirak
    circle((1.3, 0), radius: 0.25, fill: dark, stroke: none)
    content((1.6, -0.35), anchor: "north-west", small[Caster tayanç])

    // Tezlik vektorlari
    line((0, 0), (1.5, 0), stroke: 2.5pt + orange.darken(15%), mark: (end: "stealth", fill: orange.darken(15%)))
    content((0.75, 0.1), anchor: "south", text(size: 9pt)[$v_"robot"$])
    for y in (1.35, -1.35) {
      line((-1.0, y), (-0.2, y), stroke: 2pt + blue.lighten(20%), mark: (end: "stealth", fill: blue.lighten(20%)))
    }

    // Gʻildiraklar orasidagi masofa L
    line(
      (-1.0, 1.2),
      (-1.0, -1.2),
      stroke: (thickness: 1pt, dash: "dashed"),
      mark: (start: "stealth", end: "stealth", fill: black),
    )
    content((-1.1, -0.35), anchor: "east", small[$L$ (baza)])
  }),
  caption: [Differensial ğildirakli mobil robotning geometrik va kinematik parametrlari],
) <fig-diff>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: sanoat robotlarining kinematik turlarini qiyosiy tahlil qiliş

Har bir robot turining geometrik, dinamik va ekspluatatsion xususiyatlarini tahlil qiling va @tab-compare ni töldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (3cm, 2.8cm, 2.8cm, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Robot turi*], [*Boşqariş murakkabligi*], [*Bikrlik (mustahkamlik)*], [*Asosiy ustunligi va kamçiligi*]
      ),
      table.hline(stroke: 0.5pt),
      [*Dekart* (Cartesian)], [Juda past (çiziqli tenglamalar)], [Yuqori],
      [*Ustunligi:* yuqori aniqlik. \ *Kamçiligi:* katta gabarit va köp joy egallaşi.],
      [*Ştangali-böğinli* (Articulated)], [Yuqori (noçiziqli trigonometriya)], [Örtaça / moslaşuvçan],
      [*Ustunligi:* maksimal harakatçanlik. \ *Kamçiligi:* yuqori narx va murakkab kalibrlaş.],
      [*SCARA*], [Örtaça], [Vertikal yönalişda juda yuqori],
      [*Ustunligi:* Z-öqi böylab yuqori tezlik va qatʼiylik. \ *Kamçiligi:* çeklangan işçi maydoni.],
      [*Parallel* (Delta)], [Yuqori (köp zanjirli dinamika)], [Juda yuqori],
      [*Ustunligi:* ekstremal yuqori tezlik ($> 3 "m/s"$). \ *Kamçiligi:* kiçik yuk kötariş qobiliyati.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sanoat robotlarining kinematik va ekspluatatsion qiyosiy tahlili],
) <tab-compare>

== Topşiriq 2: işlab çiqariş texnologik jarayoni uçun robot turini tanlaş

Quyidagi uçta sanoat moduli uçun mos robot tipini va kerakli sensorlar majmuasini tanlang:

+ *1-stansiya:* avtomobil kuzovini nuqtaviy kontaktli payvandlaş (yuk $> 100 "kg"$).
+ *2-stansiya:* dorixona ampulalarini karton qutilarga öta tezkor saralab joylaş (tezlik $> 120 "dona/min"$).
+ *3-stansiya:* konveyerdan mikrosxemalarni olib, $plus.minus 0.01 "mm"$ aniqlik bilan plataga örnatiş.

*Tahlil va yeçim:*

- *1-stansiya uçun:* _6-DoF Articulated (ştangali-böğinli) robot_. Sababi: yuqori yuk kötariş va murakkab fazoviy buriliş burçaklarini talab etadi. Sensorlar: moment datçigi, optik payvand çokini kuzatuvçi.
- *2-stansiya uçun:* _Delta (parallel) robot_. Sababi: kam yuk va ekstremal yuqori siklik tezlik. Sensorlar: konveyer tezligi enkoderi, maşina körişi (_machine vision_) kamerasi.
- *3-stansiya uçun:* _SCARA roboti_. Sababi: gorizontal tekislikda öta yuqori takrorlanuvçanlik va aniqlik ($X Y$ aniqligi). Sensorlar: taktil mikrosensor va optik joylaşuv datçigi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: 2-DoF tekislikdagi manipulyatorning töğri kinematikasi

Ikkita aylanma böğinga ($R_1, R_2$) ega bölgan planar manipulyator berilgan (@fig-2dof). Böğin elkalari uzunliklari $l_1 = 0.4 "m"$ va $l_2 = 0.3 "m"$. Joriy böğin burçaklari $theta_1 = 30 degree$ va $theta_2 = 45 degree$. Robot tutqiçining (_end-effector_) Dekart koordinatalar tizimidagi $(X, Y)$ örnini va yönaliş burçagi $phi$ ni aniqlang.

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let arr = (end: "stealth", fill: black)
    let dashed = (thickness: 0.8pt, dash: "dashed")
    let c30 = calc.cos(30deg)
    let s30 = calc.sin(30deg)
    let p1 = (2.5 * c30, 2.5 * s30)
    let p2 = (p1.at(0) + 2.0 * calc.cos(75deg), p1.at(1) + 2.0 * calc.sin(75deg))

    // Koordinata oʻqlari
    line((-0.5, 0), (4.5, 0), stroke: 1pt, mark: arr)
    line((0, -0.5), (0, 3.7), stroke: 1pt, mark: arr)
    content((4.6, 0), anchor: "west")[$X$]
    content((0, 3.8), anchor: "south")[$Y$]
    content((-0.1, -0.1), anchor: "north-east")[$O$]

    // θ1 (gorizontaldan)
    line((0, 0), (2, 0), stroke: dashed)
    arc((0.8, 0), start: 0deg, stop: 30deg, radius: 0.8, stroke: 1pt + orng, mark: (end: "stealth", fill: orng))
    content((0.95, 0.2), anchor: "west", text(fill: orng)[$theta_1$])

    // θ2 (1-boʻgʻin davomidan oʻlchanadi)
    line(p1, (p1.at(0) + 1.3 * c30, p1.at(1) + 1.3 * s30), stroke: dashed)
    arc(
      (p1.at(0) + 0.7 * c30, p1.at(1) + 0.7 * s30),
      start: 30deg,
      stop: 75deg,
      radius: 0.7,
      stroke: 1pt + orng,
      mark: (end: "stealth", fill: orng),
    )
    content((p1.at(0) + 0.95 * calc.cos(52deg), p1.at(1) + 0.95 * calc.sin(52deg)), anchor: "south-west", text(
      fill: orng,
    )[$theta_2$])

    // Boʻgʻinlar
    line((0, 0), p1, stroke: 3pt + blue-c)
    line(p1, p2, stroke: 3pt + blue-c)
    content((p1.at(0) / 2 - 0.1, p1.at(1) / 2 + 0.1), anchor: "south-east", text(size: 10pt)[$l_1$])
    content(((p1.at(0) + p2.at(0)) / 2 - 0.12, (p1.at(1) + p2.at(1)) / 2), anchor: "east", text(size: 10pt)[$l_2$])

    circle((0, 0), radius: 0.15, fill: blue.darken(10%), stroke: 0.6pt)
    circle(p1, radius: 0.12, fill: blue.darken(10%), stroke: 0.6pt)
    content((p1.at(0) + 0.15, p1.at(1) - 0.15), anchor: "north-west", text(size: 9pt)[Joint 2])
    circle(p2, radius: 0.12, fill: orng, stroke: 0.6pt)
    content((p2.at(0) + 0.15, p2.at(1) + 0.1), anchor: "south-west", text(size: 10pt, weight: "bold")[$P(X, Y)$])
  }),
  caption: [2-DoF tekislikdagi aylanma manipulyatorning kinematik modeli],
) <fig-2dof>

*Yeçiş va formulalar:*

#eq($ X = l_1 cos(theta_1) + l_2 cos(theta_1 + theta_2) $)
#eq($ Y = l_1 sin(theta_1) + l_2 sin(theta_1 + theta_2) $)
#eq($ phi = theta_1 + theta_2 $)

*Hisoblaş bosqiçlari:*

- Trigonometrik qiymatlarni hisoblaş:
  #eq($ theta_1 = 30 degree, quad theta_1 + theta_2 = 30 degree + 45 degree = 75 degree $)
  #eq(
    $
      cos(30 degree) approx 0.8660, quad sin(30 degree) = 0.5000, quad \
      cos(75 degree) approx 0.2588, quad sin(75 degree) approx 0.9659
    $,
  )
- $X$ va $Y$ koordinatalarini hisoblaş:
  #eq($ X = 0.4 times 0.8660 + 0.3 times 0.2588 = 0.3464 + 0.0776 = \ 0.4240 "m" = 42.4 "cm" $)
  #eq($ Y = 0.4 times 0.5000 + 0.3 times 0.9659 = 0.2000 + 0.2898 =\ 0.4898 "m" = 48.98 "cm" $)
- Orientatsiya burçagi:
  #eq($ phi = 30 degree + 45 degree = 75 degree $)

== Masala 2: differensial ğildirakli mobil robot kinematikasi

Differensial mobil robotning ğildirak radiusi $r = 0.08 "m"$, ğildiraklar orasidagi masofa (baza) $L = 0.4 "m"$. Öng ğildirak burçak tezligi $omega_R = 15 "rad/s"$, çap ğildirak burçak tezligi $omega_L = 10 "rad/s"$.

#set enum(numbering: "a)")
+ Robotning ilgarilanma çiziqli tezligi $v_"robot"$ va burçak aylaniş tezligi $omega_"robot"$ ni toping.
+ Robotning buriliş radiusi $R_"turn"$ nimaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ v_R = r dot omega_R, quad v_L = r dot omega_L $)
#eq(
  $
    v_"robot" = (v_R + v_L) / 2 = (r (omega_R + omega_L)) / 2, quad quad
    omega_"robot" = (v_R - v_L) / L = (r (omega_R - omega_L)) / L
  $,
)
#eq($ R_"turn" = v_"robot" / omega_"robot" $)

*Hisoblaş bosqiçlari:*

- Çiziqli ğildirak tezliklari:
  #eq($ v_R = 0.08 times 15 = 1.2 "m/s", quad v_L = 0.08 times 10 = 0.8 "m/s" $)
- Robotning ilgarilanma tezligi ($v_"robot"$):
  #eq($ v_"robot" = (1.2 + 0.8) / 2 = 1.0 "m/s" $)
- Robotning burçak tezligi ($omega_"robot"$):
  #eq($ omega_"robot" = (1.2 - 0.8) / 0.4 = 0.4 / 0.4 = 1.0 "rad/s" $)
- Buriliş trayektoriyasi radiusi ($R_"turn"$):
  #eq($ R_"turn" = (1.0 "m/s") / (1.0 "rad/s") = 1.0 "m" $)

== Masala 3: SCARA roboti Z-öqi va böğin yuklamalari hisobi

SCARA robotining 1-böğin uzunligi $l_1 = 0.35 "m"$, 2-böğin uzunligi $l_2 = 0.25 "m"$. Robot tutqiçiga $m = 5.0 "kg"$ yuk ilingan ($g = 9.81 "m/s"^2$). Manipulyator töliq çözilgan holatda ($theta_1 = 0 degree, theta_2 = 0 degree$):

#set enum(numbering: "a)")
+ 1-böğin podşipnigi va qöl konstruksiyasiga taʼsir etuvçi statik egiliş momenti $M_1$ ni hisoblang (böğin massalari hisobga olinmaydi).
+ $Z$-öq pnevmosilindri yukni $a = 2.0 "m/s"^2$ tezlaniş bilan yuqoriga kötarganda pnevmosilindr hosil qilişi kerak bölgan $F_z$ kuçini toping.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ L_"total" = l_1 + l_2, quad quad M_1 = m dot g dot L_"total", quad quad F_z = m (g + a) $)

*Hisoblaş bosqiçlari:*

- Umumiy elka: $L_"total" = 0.35 + 0.25 = 0.60 "m"$.
- Statik egiliş momenti ($M_1$):
  #eq($ M_1 = 5.0 times 9.81 times 0.60 = 29.43 "N" dot "m" $)
- Dinamik kötariş kuçi ($F_z$):
  #eq($ F_z = 5.0 times (9.81 + 2.0) = 5.0 times 11.81 = 59.05 "N" $)

_Izoh:_ SCARA robotining $R_1$ va $R_2$ aylaniş öqlari vertikal bölgani uçun oğirlik kuçi bu öqlar atrofida buruvçi moment hosil qilmaydi. $M_1$ yuritma motoriga emas, balki böğin podşipnigi va qöl konstruksiyasiga egiliş yuklamasi sifatida taʼsir qiladi. Aynan şu xususiyat SCARA'ning vertikal yönalişdagi yuqori bikrligini taʼminlaydi.

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: robotlar kinematik maketlarini va turlarini vizual örganiş.* Laboratoriyadagi Articulated, SCARA va mobil robot stendlarini közdan keçiring. Har bir robotning böğinlar soni (DoF) va turlarini ($R$ va $P$) aniqlang.
+ *2-bosqiç: işçi zonani (workspace) tajribaviy ölçaş.* Manipulyatorni qölda boşqariş pulti (_Teach Pendant_) orqali çekka koordinatalarga harakatlantirib, uning erişiş mumkin bölgan çegaralarini ($X_"max", Y_"max", Z_"max"$) aniqlang.
+ *3-bosqiç: differensial mobil robot trayektoriyasini simulyatsiya qiliş.* MATLAB / Simulink yoki Gazebo muhitida differensial mobil robotning çap va öng ğildirak tezliklarini özgartirib, töğri çiziqli va aylanma harakat trayektoriyalarini kuzating.
+ *4-bosqiç: töğri kinematika tenglamalarini dasturlaş.* 5-bölimdagi 1-masala tenglamalarini C++ yoki Python muhitida yozib, berilgan $theta_1, theta_2$ burçaklarda tutqiç $(X, Y)$ koordinatasini hisoblovçi dastur tuzing.
+ *5-bosqiç: hisoblaş natijalarini tahlil qiliş va hisobot tayyorlaş.* Nazariy hisoblangan va simulyatsiyada olingan qiymatlarni soliştiring.

= Nazorat va muhokama savollari

+ ISO 8373 standartiga köra sanoat roboti va avtomatlaştirilgan dasturlanuvçi dastgoh örtasidagi asosiy farq nimada?
+ Sanoat robotlarining 6 ta asosiy kinematik turini sanab bering va ularning işçi zonasi şakllarini izohlang.
+ SCARA roboti qaysi yönalişdagi harakatlarda yuqori aniqlik va qatʼiylikka ega hamda u qaysi sohada keng qöllaniladi?
+ Parallel (Delta) robotlarning ketma-ket (Articulated) robotlarga nisbatan asosiy afzalliklari va kamçiliklari nimalardan iborat?
+ Robotning erkinlik darajasi (DoF) nimani anglatadi va fazoda ixtiyoriy holatni egallaş uçun kamida neçta DoF talab qilinadi?
+ Aylanma ($R$) va ilgarilanma ($P$) böğinlarning mexatronik va sensorik jihatdan farqlarini tuşuntiring.
+ Differensial ğildirakli mobil robot qanday qilib öz öqi atrofida buriladi ($R_"turn" = 0$)?
+ Omni-ğildiraklar va Mecanum ğildiraklarning oddiy pnevmatik ğildiraklardan farqli xususiyati nimada?
+ Töğri kinematika (_Forward Kinematics_) va teskari kinematika (_Inverse Kinematics_) masalalarining mohiyatini tuşuntiring.
+ Mobil robotlarda SLAM (_Simultaneous Localization and Mapping_) texnologiyasi va uning uçun kerakli sensorlarni sanang.
+ Antropomorf (insonsimon) va tört oyoqli robotlarning harakatlaniş barqarorligini taʼminlaşda qanday sensorlar işlatiladi?
+ Sanoat robotlarida xavfsizlik zonalari (_safety zones_) va kollaborativ robotlar (_cobot_) tuşunçasini izohlang.
