// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Adaptiv robotning asosiy taşkiliy qismlari bilan tanişiş")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 10  // amaliyot raqami
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

// Blok formula (raqamlangan)
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №10]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Adaptiv robotning asosiy taşkiliy qismlari bilan tanişiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* zamonaviy robototexnikada noaniq va dinamik özgaruvçan atrof-muhit şaroitlarida mustaqil moslaşib işlovçi adaptiv robotlarning (_adaptive robots_) asosiy taşkiliy-funksional qismlari, axborot-sezgi (_sensory / perception_) tizimlari, adaptiv boşqaruv algoritmlari (MRAC, STR, _impedance control_), ijroçi-mexanik va interfeys modullari hamda ularning özaro hamkorlik tamoyillarini çuqur örganiş va hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Qattiq dasturlangan (1-avlod) va adaptiv (2- va 3-avlod) robotik tizimlarning taşkiliy va funksional farqlarini tahlil qiliş.
+ Adaptiv robotning 4 ta asosiy taşkiliy tizimini (informatsion-sezgi tizimi, adaptiv boşqaruv va qaror qabul qiliş tizimi, ijroçi-mexanik va drayverlar tizimi, aloqa va atrof-muhit interfeyslari) örganiş.
+ Sezgi tizimida proprioseptiv (içki holat) va eksteroseptiv (taşqi muhit) sensorlar majmuasi (_vision, tactile, force-torque, proximity_, Lidar) integral funksiyasini tahlil qiliş.
+ Adaptiv boşqaruv modellarini: _Model Reference Adaptive Control_ (MRAC), _Self-Tuning Regulators_ (STR) hamda _impedance / admittance_ moslaşuvçan boşqaruv tenglamalarini örganiş.
+ Adaptiv robotlarda moslaşuvçanlik koeffitsientlari, kuç-moment muvozanati hamda vizual servo-boşqaruv (_visual servoing_) böyiça muhandislik hisoblaş masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* adaptiv va kollaborativ robot stendi (_cobot_ / 6-DoF manipulyator), 6 öqli kuç-moment datçigi (FT sensor), 2D/3D vizual kamera datçigi, adaptiv pnevmatik/elektr tutqiç (_adaptive gripper_), taktil sezgi matritsasi.
- *Nazorat-ölçov va aloqa vositalari:* real vaqtli datçiklar ossillografi, EtherCAT va CAN-bus mantiqiy analizatori, robot drayverlari quvvat manbalari.
- *Dasturiy muhit:* MATLAB / Simulink (Control System & Robotics System Toolbox), ROS 2 (MoveIt 2 / ros2_control), Python (Robotics Toolbox / SciPy / OpenCV).

= Nazariy maʼlumotlar va adaptiv robot taşkiliy tizimlari

== Adaptiv robot tuşunçasi va rivojlaniş bosqiçlari

J.J. Craig, W. Bolton va R.H. Bishop darsliklariga köra, *adaptiv robot* deb atrof-muhit parametrlari (obyektlarning şakli, joylaşuvi, massasi, işqalanişi va tösiqlar) oldindan aniq berilmagan yoki ekspluatatsiya jarayonida özgarib turadigan şaroitlarda sezgi datçiklaridan olinayotgan axborotlar asosida optimal harakat traektoriyasini, tutiş kuçini hamda boşqaruv qonuniyatlarini *real vaqt rejimida* (_in real time_) özgartira oladigan intellektual robotik tizimga aytiladi.

Robotik tizimlarning evolyutsion avlodlari @tab-gen da keltirilgan.

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
      table.header([*№*], [*Robot avlodi*], [*Taşkiliy \ xususiyati*], [*Boşqaruv va \ sezgi imkoniyati*]),
      table.hline(stroke: 0.5pt),
      [1], [*1-avlod:* programmalanuvçi (_rigid_) robotlar],
      [Qattiq dasturlangan, özgarmas traektoriya (_teach pendant_).],
      [Teskari aloqa faqat içki enkoderlar bilan çeklangan. Taşqi sensorlar yöq.],
      [2], [*2-avlod:* adaptiv robotlar (_adaptive robots_)],
      [Taşqi sezgi organlari (_vision, force-torque, proximity_) va moslaşuvçan boşqaruv.],
      [Atrof-muhit özgarişiga moslaşadi, traektoriya va kuçni avtomatik korreksiya qiladi.],
      [3], [*3-avlod:* intellektual robotlar (_smart / AI robots_)],
      [Neyron tarmoqlar (_deep RL_), kognitiv rejalaştiriş va SLAM.],
      [Mustaqil qaror qabul qiladi, noaniq muhitda avtonom vazifalarni bajaradi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Robotik tizimlar avlodlarining taşkiliy va funksional qiyosiy tahlili],
) <tab-gen>

== Adaptiv robotning 4 ta asosiy taşkiliy tizimi

Adaptiv robotning yaxlit işlaşi 4 ta özaro boğliq iyerarxik va funksional tizimlarning birgalikdagi harakati orqali taʼminlanadi (@fig-arch).

=== Informatsion-sezgi tizimi (_sensory / perception subsystem_)

Robotning „sezgi organlari“ bölib, ikkita asosiy guruhga bölinadi:

- *Proprioseptiv datçiklar (içki holat):* böğin burçak enkoderlari, motordagi tok va kuçlaniş sensorlari, MEMS IMU akselerometr/giroskop.
- *Eksteroseptiv datçiklar (taşqi muhit):* 2D/3D videokameralar (RGB-D), 6 öqli kuç-moment (_force-torque_) datçiklari, taktil sezgi matritsalari, ultratovuş hamda Lidar masofa ölçagiçlari.

=== Adaptiv boşqaruv va qaror qabul qiliş tizimi (_adaptive control core_)

Datçik maʼlumotlarini tahlil qilib, moslaşiş algoritmlarini hisoblaydigan „miya“:

- *Model Reference Adaptive Control (MRAC):* etalon model reaksiyasi bilan real reaksiya farqi (xatolik $e$) böyiça regulyator koeffitsientlarini özgartiradi (@fig-mrac).
- *Self-Tuning Regulators (STR):* real vaqtda obyekt parametrlarini baholaydi (_Recursive Least Squares_) va PID parametrlarini qayta hisoblaydi.
- *Impedance / admittance control:* robot tutqiçining atrof-muhit bilan özaro taʼsirlaşuvidagi dinamik bikrlik ($K$) va dempfirlaş ($B$) koeffitsientlarini moslaştiradi.

=== Ijroçi-mexanik va drayverlar tizimi (_actuation & drive subsystem_)

Yuqori aniqlikdagi servomotorlar, garmonik reduktorlar (_harmonic drive_) hamda pnevmogidravlik drayverlar majmuasi. Zamonaviy adaptiv robotlarda elastik böğinli (_flexible joint / series elastic actuator_ --- SEA) ijroçi uskunalar qöllaniladi.

=== Aloqa va atrof-muhit bilan özaro taʼsir interfeyslari (_communication & safety_)

EtherCAT, CANopen, ROS 2 micro-XRCE-DDS hamda inson va robot kollaborativ xavfsizligini taʼminlovçi (_Safe Torque Off_ --- STO) mantiqiy bloklar.

= Mavzuga oid çizmalar va sxemalar

== Adaptiv robotning 4 ta asosiy taşkiliy bloki va teskari aloqa halqasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let gry = gray.darken(50%)

    // ---- sizes: change only these ----
    let W = 4.4 // box width
    let H = 2.0 // box height
    let gap = 1.7 // horizontal arrow length between boxes
    let vgap = 1.9 // vertical distance between the two rows
    let fs = 7.5pt // text size inside the boxes

    // derived positions
    let dx = W + gap
    let yt = 0
    let yb = -(H + vgap)
    let yl = yb - H / 2 - 0.8 // bottom of the feedback loop
    let xl = -W / 2 - 0.6 // left side of the feedback loop

    let blk(c, body, fill, stroke, w: W, h: H, size: fs) = {
      rect(
        (c.at(0) - w / 2, c.at(1) - h / 2),
        (c.at(0) + w / 2, c.at(1) + h / 2),
        fill: fill,
        stroke: stroke,
        radius: 0.15,
      )
      content(c, align(center, text(size: size, weight: "bold", body)))
    }

    let sens = (0, yt)
    let ctrl = (dx, yt)
    let act = (2 * dx, yt)
    let env = (2 * dx, yb)
    let comm = (0, yb)

    blk(
      sens,
      [1\. INFORMATSION-SEZGI \ TIZIMI \ (Vision, FT sensor, IMU, \ proprio/eksteroseptiv)],
      blue.lighten(93%),
      1pt + blue-c,
    )
    blk(
      ctrl,
      [2\. ADAPTIV BOŞQARUV \ VA QAROR QABUL QILIŞ \ (MRAC, STR, Impedance, \ traektoriya adaptatsiyasi)],
      orange.lighten(85%),
      1pt + orng,
    )
    blk(
      act,
      [3\. IJROÇI-MEXANIK \ TIZIM \ (Servomotorlar, SEA, \ Harmonic Drive, Gripper)],
      blue.lighten(93%),
      1pt + blue-c,
    )
    blk(env, [ATROF-MUHIT \ VA OBYEKTLAR \ (dinamik muhit)], gray.lighten(85%), 1pt + gry)
    blk(comm, [4\. ALOQA VA XAVFSIZLIK \ INTERFEYSLARI \ (ROS 2, EtherCAT, STO)], blue.lighten(93%), 1pt + blue-c)

    let arr(c) = (end: "stealth", fill: c)
    let arr2(c) = (start: "stealth", end: "stealth", fill: c)

    // Toʻgʻri zanjir
    line((W / 2, yt), (dx - W / 2, yt), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((dx / 2, yt + 0.1), anchor: "south", text(size: 7pt)[Sensor \ data])
    line((dx + W / 2, yt), (2 * dx - W / 2, yt), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((1.5 * dx, yt + 0.1), anchor: "south", text(size: 7pt)[$u(t)$])
    line((2 * dx, yt - H / 2), (2 * dx, yb + H / 2), stroke: 1pt + orng, mark: arr(orng))
    content((2 * dx + 0.15, (yt + yb) / 2), anchor: "west", text(size: 7pt)[Mexanik \ taʼsir $F, tau$])

    // Tashqi teskari aloqa
    line(
      (2 * dx, yb - H / 2),
      (2 * dx, yl),
      (xl, yl),
      (xl, yt),
      (-W / 2, yt),
      stroke: 1pt + orng,
      mark: arr(orng),
    )
    content((dx, yl - 0.1), anchor: "north", text(size: 7pt)[Taşqi teskari aloqa (kuç, tasvir, masofa)])

    // Aloqa interfeyslari
    line((0, yb + H / 2), (0, yt - H / 2), stroke: 1pt + gry, mark: arr2(gry))
    line((W / 2, yb + H / 2 - 0.3), (dx - W / 2 + 0.3, yt - H / 2), stroke: 1pt + gry, mark: arr2(gry))
  }),
  caption: [Adaptiv robotning 4 ta asosiy taşkiliy tizimi va teskari aloqali adaptatsiya halqasi],
) <fig-arch>

== Model Reference Adaptive Control (MRAC) blok-sxemasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let blk(c, body, fill, stroke, w: 2.6, h: 1.2) = {
      rect(
        (c.at(0) - w / 2, c.at(1) - h / 2),
        (c.at(0) + w / 2, c.at(1) + h / 2),
        fill: fill,
        stroke: stroke,
        radius: 0.12,
      )
      content(c, align(center, text(size: 7.5pt, weight: "bold", body)))
    }
    let arr(c) = (end: "stealth", fill: c)

    blk((1.5, 2.2), [Etalon model \ $W_m (s)$], blue.lighten(93%), 1pt + blue-c)
    blk((1.5, 0), [Sozlanuvçi \ regulyator $K(e, t)$], blue.lighten(93%), 1pt + blue-c)
    blk((5.2, 0), [Robot mexanizmi \ $G_p (s)$], blue.lighten(93%), 1pt + blue-c)
    blk((4.5, -2.2), [MOSLAŞIŞ ALGORITMI \ (Lyapunov)], orange.lighten(85%), 1pt + orng, w: 4.2)

    // Kirish
    content((-1.6, 0), anchor: "east", text(size: 8pt, weight: "bold")[Topşiriq $r(t)$])
    line((-1.5, 0), (0.2, 0), stroke: 1pt, mark: arr(black))
    circle((-0.8, 0), radius: 0.06, fill: black)
    line((-0.8, 0), (-0.8, 2.2), (0.2, 2.2), stroke: 1pt, mark: arr(black))

    // Yoʻnaltirilgan zanjir
    line((2.8, 0), (3.9, 0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((3.35, 0.1), anchor: "south", text(size: 8pt)[$u(t)$])
    line((6.5, 0), (8.8, 0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((8.1, 0.1), anchor: "south", text(size: 8pt, weight: "bold")[$y(t)$])

    // Taqqoslash tuguni
    circle((7.5, 2.2), radius: 0.3, fill: red.lighten(90%), stroke: 1pt + red)
    line((2.8, 2.2), (7.2, 2.2), stroke: 1pt, mark: arr(black))
    content((5.0, 2.3), anchor: "south", text(size: 8pt)[$y_m (t)$])
    content((6.95, 2.35), anchor: "south", text(size: 8pt)[$+$])
    circle((7.5, 0), radius: 0.06, fill: black)
    line((7.5, 0), (7.5, 1.9), stroke: 1pt, mark: arr(black))
    content((7.35, 1.65), anchor: "east", text(size: 8pt)[$-$])

    // Xatolik va sozlash
    line((7.8, 2.2), (9.6, 2.2), (9.6, -2.2), (6.6, -2.2), stroke: 1pt + red, mark: arr(red))
    content((9.75, 0.9), anchor: "west", text(size: 8pt, weight: "bold")[$e = y_m - y$])
    line((2.4, -2.2), (1.5, -2.2), (1.5, -0.6), stroke: 1pt + orng, mark: arr(orng))
    content((1.35, -1.4), anchor: "east", text(size: 8pt, weight: "bold")[Sozlaş $k_1, k_2$])
  }),
  caption: [Model Reference Adaptive Control (MRAC) adaptiv boşqaruv tizimining strukturasi],
) <fig-mrac>

== Kuç-moment va vizual sensorli adaptiv uşlaş

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)

    // Robot bilak boʻgʻini
    rect((-3, -1), (-1, 1), fill: blue.lighten(93%), stroke: 1pt + blue-c, radius: 0.12)
    content((-2, 0), align(center, text(
      size: 7pt,
      weight: "bold",
      fill: blue-c,
    )[Robot \ manipulyator \ bilak böğini]))

    // 6-DoF kuch-moment sensori
    rect((-1, -0.8), (-0.3, 0.8), fill: orange.lighten(75%), stroke: 1pt + orng)
    content((-0.65, 0), angle: -90deg, text(size: 7pt, weight: "bold", fill: orng)[FT sensor])

    // Tutqich asosi
    rect((-0.3, -0.75), (0.8, 0.75), fill: blue.lighten(93%), stroke: 1pt + blue-c)
    content((0.25, 0), align(center, text(size: 6.5pt, weight: "bold")[Gripper \ base]))

    // Kamera
    rect((0.0, 0.75), (0.8, 1.3), fill: blue.lighten(80%), stroke: 1pt + blue-c)
    content((0.4, 1.02), text(size: 6.5pt, weight: "bold", fill: blue-c)[RGB-D])

    // Barmoqlar
    rect((0.8, 0.5), (2.5, 0.68), fill: gray.darken(40%), stroke: none)
    rect((0.8, -0.68), (2.5, -0.5), fill: gray.darken(40%), stroke: none)

    // Obyekt
    circle((2.2, 0), radius: 0.5, fill: red.lighten(85%), stroke: 1pt + red)
    content((2.2, 0), text(size: 7pt, weight: "bold", fill: red)[Obyekt])

    // Tutish kuchlari
    line((2.2, 1.35), (2.2, 0.72), stroke: 1pt + red, mark: (end: "stealth", fill: red))
    line((2.2, -1.35), (2.2, -0.72), stroke: 1pt + red, mark: (end: "stealth", fill: red))
    content((2.3, 1.1), anchor: "west", text(size: 8pt, weight: "bold", fill: red)[$F_"grip"$])
    content((2.3, -1.1), anchor: "west", text(size: 8pt, weight: "bold", fill: red)[$F_"grip"$])

    // Vizual nur
    line(
      (0.8, 1.2),
      (2.75, 0.1),
      stroke: (paint: blue-c, thickness: 1pt, dash: "dashed"),
      mark: (end: "stealth", fill: blue-c),
    )
    content((1.2, 1.35), anchor: "south-west", text(size: 7pt)[Vizual nur])
  }),
  caption: [Kuç-moment datçigi va RGB-D kamera yordamida obyektni adaptiv uşlaş mexanizmi],
) <fig-gripper>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: qattiq programmalanuvçi va adaptiv robotlar qiyosiy tahlili

Sanoat yiğuv liniyasidagi qattiq programmalanuvçi va adaptiv robotik modullarni qiyosiy tahlil qiling va @tab-rigid ni töldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (3.3cm, 1fr, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Taşkiliy \ körsatkiç*], [*Qattiq programmalanuvçi \ robot*], [*Adaptiv robot \ tizimi*]),
      table.hline(stroke: 0.5pt),
      [*Sezgi tizimi tarkibi*], [Faqat enkoderlar (proprioseptiv).],
      [Enkoder + 6-DoF FT sensor + RGB-D vision + taktil matritsa.],
      [*Boşqaruv algoritmi*], [Standart PID (özgarmas koeffitsientli).],
      [MRAC / STR adaptiv regulyator + impedance control.],
      [*Atrof-muhitga moslaşuvi*], [Yöq (obyekt örni $1 "mm"$ surilsa xato beradi).],
      [Obyekt siljişi, şakli va massasiga real vaqtda moslaşadi.],
      [*Xavfsizlik hamda kollaboratsiya*], [Inson bilan birga işlaş taqiqlanadi (himoya panjarasi ortida işlaydi).],
      [Kollaborativligi yuqori (inson tegsa töxtaydi --- STO).],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Qattiq programmalanuvçi va adaptiv robotik tizimlar tahlili],
) <tab-rigid>

== Topşiriq 2: sanoat yiğiş va qadoqlaş liniyasi uçun adaptiv robot tanlaş

Quyidagi ikkita sanoat texnologik vazifasi uçun adaptiv robot taşkiliy qismlarini tanlang va asoslang:

+ *1-vazifa:* konveyerdan tartibsiz kelayotgan va şakli özgaruvçan mört mahsulotlarni (masalan, şişa idişlar yoki oziq-ovqat) uşlaş va joylaş.
+ *2-vazifa:* avtomobil kuzoviga yuqori aniqlikda vallarni örnatiş (_assembly with tight tolerance_).

*Tahlil va yeçim:*

- *1-vazifa uçun:* _RGB-D 3D vision + soft adaptive pneumatic gripper_. Sababi: 3D vision obyekt şaklini aniqlaydi, yumşoq adaptiv tutqiç esa uni deformatsiya qilmasdan uşlaydi.
- *2-vazifa uçun:* _wrist 6-DoF force-torque sensor + impedance control_. Sababi: val örnatilayotganda yonlama qarşilik kuçi $F_"ext"$ ni ölçab, robot tutqiçi holati va burçagini avtomatik moslaştiradi (_compliance motion_).

= Hisoblaş va modellaştiriş masalalari

== Masala 1: Model Reference Adaptive Control (MRAC) moslaşiş hisobi

Adaptiv robot böğinining dinamik modeli quyidagi differensial tenglama bilan berilgan:

$ dot(y)(t) = -a dot y(t) + b dot u(t) $

bunda $a = 2.0$ va $b = 1.5$ --- nomaʼlum özgaruvçan parametrlar. Etalon model tenglamasi:

$ dot(y)_m (t) = -a_m dot y_m (t) + b_m dot r(t) $

bunda $a_m = 4.0$, $b_m = 4.0$ va $r(t) = 2.0$ --- özgarmas topşiriq. Adaptiv boşqaruv qonuni: $u(t) = k_1(t) dot r(t) - k_2(t) dot y(t)$.

#set enum(numbering: "a)")
+ Tizim etalon modelga töliq moslaşgan qaror topgan holatda ($e = y_m - y = 0$) adaptiv koeffitsientlar $k_1^*$ va $k_2^*$ ning ideal qiymatlarini hisoblang.
+ Lyapunov usuli böyiça moslaşiş tezligi $gamma = 0.5$ bölganda, $e = 0.4$ xatolikdagi koeffitsient özgariş tezligi $dot(k)_1$ ni aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ dot(y) = -(a + b dot k_2) y + b dot k_1 r $

Etalon modelga moslaşiş şarti:

$ a + b dot k_2^* = a_m quad => quad k_2^* = (a_m - a) / b, quad quad b dot k_1^* = b_m quad => quad k_1^* = b_m / b $

Lyapunov moslaşiş qonuni ($e = y_m - y$ va $b > 0$ uçun):

$ dot(k)_1 = gamma dot e dot r $

*Hisoblaş bosqiçlari:*

- Ideal adaptiv koeffitsientlar hisobi:
  $ k_1^* = 4.0 / 1.5 = 8 / 3 approx 2.667 $
  $ k_2^* = (4.0 - 2.0) / 1.5 = 2.0 / 1.5 = 4 / 3 approx 1.333 $
- Moslaşiş tezligi $dot(k)_1$ ($e = 0.4$, $r = 2.0$, $gamma = 0.5$):
  $ dot(k)_1 = 0.5 times 0.4 times 2.0 = 0.40 "1/s" $
  Musbat işora: çiqiş etalondan kiçik ($y < y_m$), şuning uçun $k_1$ ortadi.

== Masala 2: adaptiv robot tutqiçining impedance control (moslaşuvçanlik) hisobi

Adaptiv robot tutqiçi atrof-muhit bilan özaro taʼsirlaşganda uning maqsadli dinamik muvozanat tenglamasi (_impedance model_):

$ M dot dot.double(e)(t) + B dot dot(e)(t) + K dot e(t) = F_"ext" (t) $

bunda $e(t) = x_d (t) - x(t)$ --- rejalaştirilgan va real pozitsiya farqi, $M = 2.0 "kg"$ --- virtual massa, $B = 40 "N" dot "s/m"$ --- dempfirlaş koeffitsienti, $K = 200 "N/m"$ --- bikrlik koeffitsienti. Taşqi muhit robot tutqiçiga $F_"ext" = 10 "N"$ özgarmas qarşilik kuçi berdi.

#set enum(numbering: "a)")
+ Qaror topgan statik holatda ($dot.double(e) = 0$, $dot(e) = 0$) pozitsiya oğişi $e_"stat"$ (mm) ni hisoblang.
+ Impedance tizimining xususiy tebraniş çastotasi $omega_n$ (rad/s) va söniş koeffitsienti $zeta$ ni aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ e_"stat" = F_"ext" / K, quad quad omega_n = sqrt(K / M), quad quad zeta = B / (2 sqrt(M dot K)) $

*Hisoblaş bosqiçlari:*

- Statik pozitsiya oğişi:
  $ e_"stat" = (10 "N") / (200 "N/m") = 0.05 "m" = 50 "mm" $
- Xususiy çastota va söniş koeffitsienti:
  $ omega_n = sqrt(200 / 2.0) = sqrt(100) = 10.0 "rad/s" $
  $ zeta = 40 / (2 sqrt(2.0 times 200)) = 40 / (2 sqrt(400)) = 40 / (2 times 20) = 1.0 $
  $zeta = 1$ --- aperiodik çegaraviy rejim (_critical damping_): tizim tebranişsiz, eng tez muvozanatga keladi.

== Masala 3: adaptiv vizual servo-boşqaruvda (visual servoing) tezlik hisobi

Adaptiv robot kamerasida obyektning maqsadli va real tasvir koordinatalari farqi (_visual error vector_):

$ bold(e)_v = mat(20; -10) "piksel" $

Kamera harakati va tasvir xususiyatlari örtasidagi tasvir Yakobian matritsasi (_image Jacobian_ $bold(L)_e$):

$ bold(L)_e = mat(400, 0; 0, 400) "piksel/m" $

Adaptiv proporsional kuçaytiriş koeffitsienti $lambda_v = 2.5 "1/s"$.

#set enum(numbering: "a)")
+ Adaptiv vizual boşqaruv qonuni $bold(v)_c = -lambda_v dot bold(L)_e^(-1) dot bold(e)_v$ böyiça kameraning zaruriy çiziqli harakat tezliklari $v_x$ va $v_y$ (mm/s) ni hisoblang.
#set enum(numbering: "1.")

*Hisoblaş bosqiçlari:*

- Teskari Yakobian matritsasi $bold(L)_e^(-1)$:
  $ bold(L)_e^(-1) = mat(1\/400, 0; 0, 1\/400) = mat(0.0025, 0; 0, 0.0025) "m/piksel" $
- Tezliklar vektori $bold(v)_c$:
  $
    bold(v)_c = -2.5 times mat(0.0025, 0; 0, 0.0025) mat(20; -10) = \
    = -2.5 times mat(0.050; -0.025) = mat(-0.125; 0.0625) "m/s"
  $
- Natija: $v_x = -125 "mm/s"$ va $v_y = +62.5 "mm/s"$.

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: adaptiv robot va sensorlar majmuasini örganiş.* Laboratoriyadagi adaptiv robot (_cobot_) va uning bilagiga örnatilgan FT sensor hamda RGB-D kamerani közdan keçiring.
+ *2-bosqiç: impedance / admittance boşqaruvni sinaş.* Robot tutqiçiga qöl bilan taşqi kuç ($F_"ext"$) bering va FT datçigi körsatkiçiga mos ravişda robotning siljişini ossillograf va ROS 2 rqt_plot da kuzating.
+ *3-bosqiç: visual servoing (vizual moslaşiş) tajribasi.* Kamera qarşisidagi obyektni ixtiyoriy tomonga suring. Robot tutqiçi obyekt ortidan avtomatik ergaşişini va tasvir xatoligi $bold(e)_v -> 0$ ga intilişini yozib oling.
+ *4-bosqiç: adaptiv tutqiçda mört obyektni uşlaş.* Tutqiç kuçini avtomatik çeklovçi algoritmni işga tuşirib, turliça qattiqlikdagi obyektlarni uşlaş tajribasini ötkazing.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan natijalarni nazariy hisoblar bilan soliştirib, amaliy hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Adaptiv robotning anʼanaviy programmalanuvçi robotlardan asosiy taşkiliy va funksional farqlari nimalardan iborat?
+ Adaptiv robotning 4 ta asosiy taşkiliy tizimini sanang va ularning özaro boğliqligini tuşuntiring.
+ Proprioseptiv va eksteroseptiv sensorlar adaptiv robotlarda qanday vazifalarni bajaradi?
+ Model Reference Adaptive Control (MRAC) va Self-Tuning Regulators (STR) adaptiv boşqaruv modellarining farqi nimada?
+ Impedance control (moslaşuvçanlik boşqaruvi) nima va u robotning taşqi muhit bilan xavfsiz taʼsirlaşuvida qanday qöllaniladi?
+ 6 öqli kuç-moment (_force-torque_) datçigining adaptiv yiğiş va jilolaş (_polishing_) işlaridagi roli qanday?
+ Visual servoing (vizual adaptiv boşqaruv) texnologiyasi va image Jacobian ($bold(L)_e$) matritsasi nimani anglatadi?
+ Kollaborativ robotlarda (_cobots_) inson xavfsizligini taʼminlovçi adaptiv kuç va momentni çeklaş (STO) mexanizmi qanday işlaydi?
+ Adaptiv tutqiçlar (_adaptive grippers_) obyekt şakli va massasiga qanday moslaşadi?
+ Lyapunov usuli böyiça adaptiv boşqaruv tizimining turğunligini taʼminlaş şartlari nimalardan iborat?
+ ROS 2 (_Robot Operating System 2_) va EtherCAT protokollarining adaptiv robot axborot almaşinuvidagi ahamiyati nima?
+ Sanoat 4.0 va IIoT konsepsiyasida Edge AI va adaptiv robotik tizimlarning tutgan örnini izohlang.
