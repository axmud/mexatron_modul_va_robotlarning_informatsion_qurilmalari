// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Adaptiv robotning asosiy tashkiliy qismlari bilan tanishish")
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

// Blok formula (raqamlangan)
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №10]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Adaptiv robotning asosiy tashkiliy qismlari bilan tanishish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* zamonaviy robototexnikada noaniq va dinamik oʻzgaruvchan atrof-muhit sharoitlarida mustaqil moslashib ishlovchi adaptiv robotlarning (_adaptive robots_) asosiy tashkiliy-funksional qismlari, axborot-sezgi (_sensory / perception_) tizimlari, adaptiv boshqaruv algoritmlari (MRAC, STR, _impedance control_), ijrochi-mexanik va interfeys modullari hamda ularning oʻzaro hamkorlik tamoyillarini chuqur oʻrganish va hisoblash koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Qattiq dasturlangan (1-avlod) va adaptiv (2- va 3-avlod) robotik tizimlarning tashkiliy va funksional farqlarini tahlil qilish.
+ Adaptiv robotning 4 ta asosiy tashkiliy tizimini (informatsion-sezgi tizimi, adaptiv boshqaruv va qaror qabul qilish tizimi, ijrochi-mexanik va drayverlar tizimi, aloqa va atrof-muhit interfeyslari) oʻrganish.
+ Sezgi tizimida proprioseptiv (ichki holat) va eksteroseptiv (tashqi muhit) sensorlar majmuasi (_vision, tactile, force-torque, proximity_, Lidar) integral funksiyasini tahlil qilish.
+ Adaptiv boshqaruv modellarini: _Model Reference Adaptive Control_ (MRAC), _Self-Tuning Regulators_ (STR) hamda _impedance / admittance_ moslashuvchan boshqaruv tenglamalarini oʻrganish.
+ Adaptiv robotlarda moslashuvchanlik koeffitsientlari, kuch-moment muvozanati hamda vizual servo-boshqaruv (_visual servoing_) boʻyicha muhandislik hisoblash masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* adaptiv va kollaborativ robot stendi (_cobot_ / 6-DoF manipulyator), 6 oʻqli kuch-moment datchigi (FT sensor), 2D/3D vizual kamera datchigi, adaptiv pnevmatik/elektr tutqich (_adaptive gripper_), taktil sezgi matritsasi.
- *Nazorat-oʻlchov va aloqa vositalari:* real vaqtli datchiklar ossillografi, EtherCAT va CAN-bus mantiqiy analizatori, robot drayverlari quvvat manbalari.
- *Dasturiy muhit:* MATLAB / Simulink (Control System & Robotics System Toolbox), ROS 2 (MoveIt 2 / ros2_control), Python (Robotics Toolbox / SciPy / OpenCV).

= Nazariy maʼlumotlar va adaptiv robot tashkiliy tizimlari

== Adaptiv robot tushunchasi va rivojlanish bosqichlari

J.J. Craig, W. Bolton va R.H. Bishop darsliklariga koʻra, *adaptiv robot* deb atrof-muhit parametrlari (obyektlarning shakli, joylashuvi, massasi, ishqalanishi va toʻsiqlar) oldindan aniq berilmagan yoki ekspluatatsiya jarayonida oʻzgarib turadigan sharoitlarda sezgi datchiklaridan olinayotgan axborotlar asosida optimal harakat traektoriyasini, tutish kuchini hamda boshqaruv qonuniyatlarini *real vaqt rejimida* (_in real time_) oʻzgartira oladigan intellektual robotik tizimga aytiladi.

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
      table.header([*№*], [*Robot avlodi*], [*Tashkiliy \ xususiyati*], [*Boshqaruv va \ sezgi imkoniyati*]),
      table.hline(stroke: 0.5pt),
      [1], [*1-avlod:* programmalanuvchi (_rigid_) robotlar],
      [Qattiq dasturlangan, oʻzgarmas traektoriya (_teach pendant_).],
      [Teskari aloqa faqat ichki enkoderlar bilan cheklangan. Tashqi sensorlar yoʻq.],
      [2], [*2-avlod:* adaptiv robotlar (_adaptive robots_)],
      [Tashqi sezgi organlari (_vision, force-torque, proximity_) va moslashuvchan boshqaruv.],
      [Atrof-muhit oʻzgarishiga moslashadi, traektoriya va kuchni avtomatik korreksiya qiladi.],
      [3], [*3-avlod:* intellektual robotlar (_smart / AI robots_)],
      [Neyron tarmoqlar (_deep RL_), kognitiv rejalashtirish va SLAM.],
      [Mustaqil qaror qabul qiladi, noaniq muhitda avtonom vazifalarni bajaradi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Robotik tizimlar avlodlarining tashkiliy va funksional qiyosiy tahlili],
) <tab-gen>

== Adaptiv robotning 4 ta asosiy tashkiliy tizimi

Adaptiv robotning yaxlit ishlashi 4 ta oʻzaro bogʻliq iyerarxik va funksional tizimlarning birgalikdagi harakati orqali taʼminlanadi (@fig-arch).

=== Informatsion-sezgi tizimi (_sensory / perception subsystem_)

Robotning „sezgi organlari“ boʻlib, ikkita asosiy guruhga boʻlinadi:

- *Proprioseptiv datchiklar (ichki holat):* boʻgʻin burchak enkoderlari, motordagi tok va kuchlanish sensorlari, MEMS IMU akselerometr/giroskop.
- *Eksteroseptiv datchiklar (tashqi muhit):* 2D/3D videokameralar (RGB-D), 6 oʻqli kuch-moment (_force-torque_) datchiklari, taktil sezgi matritsalari, ultratovush hamda Lidar masofa oʻlchagichlari.

=== Adaptiv boshqaruv va qaror qabul qilish tizimi (_adaptive control core_)

Datchik maʼlumotlarini tahlil qilib, moslashish algoritmlarini hisoblaydigan „miya“:

- *Model Reference Adaptive Control (MRAC):* etalon model reaksiyasi bilan real reaksiya farqi (xatolik $e$) boʻyicha regulyator koeffitsientlarini oʻzgartiradi (@fig-mrac).
- *Self-Tuning Regulators (STR):* real vaqtda obyekt parametrlarini baholaydi (_Recursive Least Squares_) va PID parametrlarini qayta hisoblaydi.
- *Impedance / admittance control:* robot tutqichining atrof-muhit bilan oʻzaro taʼsirlashuvidagi dinamik bikrlik ($K$) va dempfirlash ($B$) koeffitsientlarini moslashtiradi.

=== Ijrochi-mexanik va drayverlar tizimi (_actuation & drive subsystem_)

Yuqori aniqlikdagi servomotorlar, garmonik reduktorlar (_harmonic drive_) hamda pnevmogidravlik drayverlar majmuasi. Zamonaviy adaptiv robotlarda elastik boʻgʻinli (_flexible joint / series elastic actuator_ --- SEA) ijrochi uskunalar qoʻllaniladi.

=== Aloqa va atrof-muhit bilan oʻzaro taʼsir interfeyslari (_communication & safety_)

EtherCAT, CANopen, ROS 2 micro-XRCE-DDS hamda inson va robot kollaborativ xavfsizligini taʼminlovchi (_Safe Torque Off_ --- STO) mantiqiy bloklar.

= Mavzuga oid chizmalar va sxemalar

== Adaptiv robotning 4 ta asosiy tashkiliy bloki va teskari aloqa halqasi

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let gry = gray.darken(50%)
    let blk(c, body, fill, stroke, w: 3.4, h: 1.8, size: 7pt) = {
      rect(
        (c.at(0) - w / 2, c.at(1) - h / 2),
        (c.at(0) + w / 2, c.at(1) + h / 2),
        fill: fill,
        stroke: stroke,
        radius: 0.15,
      )
      content(c, align(center, text(size: size, weight: "bold", body)))
    }

    let sens = (0, 2.2)
    let ctrl = (5.1, 2.2)
    let act = (10.2, 2.2)
    let env = (10.2, -1.5)
    let comm = (0, -1.5)

    blk(
      sens,
      [1\. INFORMATSION-SEZGI \ TIZIMI \ (Vision, FT sensor, IMU, \ proprio/eksteroseptiv)],
      blue.lighten(93%),
      1pt + blue-c,
    )
    blk(
      ctrl,
      [2\. ADAPTIV BOSHQARUV \ VA QAROR QABUL QILISH \ (MRAC, STR, Impedance, \ traektoriya adaptatsiyasi)],
      orange.lighten(85%),
      1pt + orng,
    )
    blk(
      act,
      [3\. IJROCHI-MEXANIK \ TIZIM \ (Servomotorlar, SEA, \ Harmonic Drive, Gripper)],
      blue.lighten(93%),
      1pt + blue-c,
    )
    blk(env, [ATROF-MUHIT \ VA OBYEKTLAR \ (dinamik muhit)], gray.lighten(85%), 1pt + gry)
    blk(comm, [4\. ALOQA VA XAVFSIZLIK \ INTERFEYSLARI \ (ROS 2, EtherCAT, STO)], blue.lighten(93%), 1pt + blue-c)

    let arr(c) = (end: "stealth", fill: c)
    let arr2(c) = (start: "stealth", end: "stealth", fill: c)

    // Toʻgʻri zanjir
    line((1.7, 2.2), (3.4, 2.2), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((2.55, 2.3), anchor: "south", text(size: 7pt)[Sensor \ data])
    line((6.8, 2.2), (8.5, 2.2), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((7.65, 2.3), anchor: "south", text(size: 7pt)[$u(t)$])
    line((10.2, 1.3), (10.2, -0.6), stroke: 1pt + orng, mark: arr(orng))
    content((10.35, 0.35), anchor: "west", text(size: 7pt)[Mexanik \ taʼsir $F, tau$])

    // Tashqi teskari aloqa
    line((10.2, -2.4), (10.2, -3.2), (-2.3, -3.2), (-2.3, 2.2), (-1.7, 2.2), stroke: 1pt + orng, mark: arr(orng))
    content((4.0, -3.3), anchor: "north", text(size: 7pt)[Tashqi teskari aloqa (kuch, tasvir, masofa)])

    // Aloqa interfeyslari
    line((0, -0.6), (0, 1.3), stroke: 1pt + gry, mark: arr2(gry))
    line((1.7, -0.9), (3.6, 1.3), stroke: 1pt + gry, mark: arr2(gry))
  }),
  caption: [Adaptiv robotning 4 ta asosiy tashkiliy tizimi va teskari aloqali adaptatsiya halqasi],
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
    blk((1.5, 0), [Sozlanuvchi \ regulyator $K(e, t)$], blue.lighten(93%), 1pt + blue-c)
    blk((5.2, 0), [Robot mexanizmi \ $G_p (s)$], blue.lighten(93%), 1pt + blue-c)
    blk((4.5, -2.2), [MOSLASHISH ALGORITMI \ (Lyapunov)], orange.lighten(85%), 1pt + orng, w: 4.2)

    // Kirish
    content((-1.6, 0), anchor: "east", text(size: 8pt, weight: "bold")[Topshiriq $r(t)$])
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
    content((1.35, -1.4), anchor: "east", text(size: 8pt, weight: "bold")[Sozlash $k_1, k_2$])
  }),
  caption: [Model Reference Adaptive Control (MRAC) adaptiv boshqaruv tizimining strukturasi],
) <fig-mrac>

== Kuch-moment va vizual sensorli adaptiv ushlash

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
    )[Robot \ manipulyator \ bilak boʻgʻini]))

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
  caption: [Kuch-moment datchigi va RGB-D kamera yordamida obyektni adaptiv ushlash mexanizmi],
) <fig-gripper>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: qattiq programmalanuvchi va adaptiv robotlar qiyosiy tahlili

Sanoat yigʻuv liniyasidagi qattiq programmalanuvchi va adaptiv robotik modullarni qiyosiy tahlil qiling va @tab-rigid ni toʻldiring.

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
      table.header([*Tashkiliy \ koʻrsatkich*], [*Qattiq programmalanuvchi \ robot*], [*Adaptiv robot \ tizimi*]),
      table.hline(stroke: 0.5pt),
      [*Sezgi tizimi tarkibi*], [Faqat enkoderlar (proprioseptiv).],
      [Enkoder + 6-DoF FT sensor + RGB-D vision + taktil matritsa.],
      [*Boshqaruv algoritmi*], [Standart PID (oʻzgarmas koeffitsientli).],
      [MRAC / STR adaptiv regulyator + impedance control.],
      [*Atrof-muhitga moslashuvi*], [Yoʻq (obyekt oʻrni $1 "mm"$ surilsa xato beradi).],
      [Obyekt siljishi, shakli va massasiga real vaqtda moslashadi.],
      [*Xavfsizlik hamda kollaboratsiya*], [Inson bilan birga ishlash taqiqlanadi (himoya panjarasi ortida ishlaydi).],
      [Kollaborativligi yuqori (inson tegsa toʻxtaydi --- STO).],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Qattiq programmalanuvchi va adaptiv robotik tizimlar tahlili],
) <tab-rigid>

== Topshiriq 2: sanoat yigʻish va qadoqlash liniyasi uchun adaptiv robot tanlash

Quyidagi ikkita sanoat texnologik vazifasi uchun adaptiv robot tashkiliy qismlarini tanlang va asoslang:

+ *1-vazifa:* konveyerdan tartibsiz kelayotgan va shakli oʻzgaruvchan moʻrt mahsulotlarni (masalan, shisha idishlar yoki oziq-ovqat) ushlash va joylash.
+ *2-vazifa:* avtomobil kuzoviga yuqori aniqlikda vallarni oʻrnatish (_assembly with tight tolerance_).

*Tahlil va yechim:*

- *1-vazifa uchun:* _RGB-D 3D vision + soft adaptive pneumatic gripper_. Sababi: 3D vision obyekt shaklini aniqlaydi, yumshoq adaptiv tutqich esa uni deformatsiya qilmasdan ushlaydi.
- *2-vazifa uchun:* _wrist 6-DoF force-torque sensor + impedance control_. Sababi: val oʻrnatilayotganda yonlama qarshilik kuchi $F_"ext"$ ni oʻlchab, robot tutqichi holati va burchagini avtomatik moslashtiradi (_compliance motion_).

= Hisoblash va modellashtirish masalalari

== Masala 1: Model Reference Adaptive Control (MRAC) moslashish hisobi

Adaptiv robot boʻgʻinining dinamik modeli quyidagi differensial tenglama bilan berilgan:

$ dot(y)(t) = -a dot y(t) + b dot u(t) $

bunda $a = 2.0$ va $b = 1.5$ --- nomaʼlum oʻzgaruvchan parametrlar. Etalon model tenglamasi:

$ dot(y)_m (t) = -a_m dot y_m (t) + b_m dot r(t) $

bunda $a_m = 4.0$, $b_m = 4.0$ va $r(t) = 2.0$ --- oʻzgarmas topshiriq. Adaptiv boshqaruv qonuni: $u(t) = k_1(t) dot r(t) - k_2(t) dot y(t)$.

#set enum(numbering: "a)")
+ Tizim etalon modelga toʻliq moslashgan qaror topgan holatda ($e = y_m - y = 0$) adaptiv koeffitsientlar $k_1^*$ va $k_2^*$ ning ideal qiymatlarini hisoblang.
+ Lyapunov usuli boʻyicha moslashish tezligi $gamma = 0.5$ boʻlganda, $e = 0.4$ xatolikdagi koeffitsient oʻzgarish tezligi $dot(k)_1$ ni aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ dot(y) = -(a + b dot k_2) y + b dot k_1 r $

Etalon modelga moslashish sharti:

$ a + b dot k_2^* = a_m quad => quad k_2^* = (a_m - a) / b, quad quad b dot k_1^* = b_m quad => quad k_1^* = b_m / b $

Lyapunov moslashish qonuni ($e = y_m - y$ va $b > 0$ uchun):

$ dot(k)_1 = gamma dot e dot r $

*Hisoblash bosqichlari:*

- Ideal adaptiv koeffitsientlar hisobi:
  $ k_1^* = 4.0 / 1.5 = 8 / 3 approx 2.667 $
  $ k_2^* = (4.0 - 2.0) / 1.5 = 2.0 / 1.5 = 4 / 3 approx 1.333 $
- Moslashish tezligi $dot(k)_1$ ($e = 0.4$, $r = 2.0$, $gamma = 0.5$):
  $ dot(k)_1 = 0.5 times 0.4 times 2.0 = 0.40 "1/s" $
  Musbat ishora: chiqish etalondan kichik ($y < y_m$), shuning uchun $k_1$ ortadi.

== Masala 2: adaptiv robot tutqichining impedance control (moslashuvchanlik) hisobi

Adaptiv robot tutqichi atrof-muhit bilan oʻzaro taʼsirlashganda uning maqsadli dinamik muvozanat tenglamasi (_impedance model_):

$ M dot dot.double(e)(t) + B dot dot(e)(t) + K dot e(t) = F_"ext" (t) $

bunda $e(t) = x_d (t) - x(t)$ --- rejalashtirilgan va real pozitsiya farqi, $M = 2.0 "kg"$ --- virtual massa, $B = 40 "N" dot "s/m"$ --- dempfirlash koeffitsienti, $K = 200 "N/m"$ --- bikrlik koeffitsienti. Tashqi muhit robot tutqichiga $F_"ext" = 10 "N"$ oʻzgarmas qarshilik kuchi berdi.

#set enum(numbering: "a)")
+ Qaror topgan statik holatda ($dot.double(e) = 0$, $dot(e) = 0$) pozitsiya ogʻishi $e_"stat"$ (mm) ni hisoblang.
+ Impedance tizimining xususiy tebranish chastotasi $omega_n$ (rad/s) va soʻnish koeffitsienti $zeta$ ni aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ e_"stat" = F_"ext" / K, quad quad omega_n = sqrt(K / M), quad quad zeta = B / (2 sqrt(M dot K)) $

*Hisoblash bosqichlari:*

- Statik pozitsiya ogʻishi:
  $ e_"stat" = (10 "N") / (200 "N/m") = 0.05 "m" = 50 "mm" $
- Xususiy chastota va soʻnish koeffitsienti:
  $ omega_n = sqrt(200 / 2.0) = sqrt(100) = 10.0 "rad/s" $
  $ zeta = 40 / (2 sqrt(2.0 times 200)) = 40 / (2 sqrt(400)) = 40 / (2 times 20) = 1.0 $
  $zeta = 1$ --- aperiodik chegaraviy rejim (_critical damping_): tizim tebranishsiz, eng tez muvozanatga keladi.

== Masala 3: adaptiv vizual servo-boshqaruvda (visual servoing) tezlik hisobi

Adaptiv robot kamerasida obyektning maqsadli va real tasvir koordinatalari farqi (_visual error vector_):

$ bold(e)_v = mat(20; -10) "piksel" $

Kamera harakati va tasvir xususiyatlari oʻrtasidagi tasvir Yakobian matritsasi (_image Jacobian_ $bold(L)_e$):

$ bold(L)_e = mat(400, 0; 0, 400) "piksel/m" $

Adaptiv proporsional kuchaytirish koeffitsienti $lambda_v = 2.5 "1/s"$.

#set enum(numbering: "a)")
+ Adaptiv vizual boshqaruv qonuni $bold(v)_c = -lambda_v dot bold(L)_e^(-1) dot bold(e)_v$ boʻyicha kameraning zaruriy chiziqli harakat tezliklari $v_x$ va $v_y$ (mm/s) ni hisoblang.
#set enum(numbering: "1.")

*Hisoblash bosqichlari:*

- Teskari Yakobian matritsasi $bold(L)_e^(-1)$:
  $ bold(L)_e^(-1) = mat(1\/400, 0; 0, 1\/400) = mat(0.0025, 0; 0, 0.0025) "m/piksel" $
- Tezliklar vektori $bold(v)_c$:
  $
    bold(v)_c = -2.5 times mat(0.0025, 0; 0, 0.0025) mat(20; -10) = \
    = -2.5 times mat(0.050; -0.025) = mat(-0.125; 0.0625) "m/s"
  $
- Natija: $v_x = -125 "mm/s"$ va $v_y = +62.5 "mm/s"$.

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: adaptiv robot va sensorlar majmuasini oʻrganish.* Laboratoriyadagi adaptiv robot (_cobot_) va uning bilagiga oʻrnatilgan FT sensor hamda RGB-D kamerani koʻzdan kechiring.
+ *2-bosqich: impedance / admittance boshqaruvni sinash.* Robot tutqichiga qoʻl bilan tashqi kuch ($F_"ext"$) bering va FT datchigi koʻrsatkichiga mos ravishda robotning siljishini ossillograf va ROS 2 rqt_plot da kuzating.
+ *3-bosqich: visual servoing (vizual moslashish) tajribasi.* Kamera qarshisidagi obyektni ixtiyoriy tomonga suring. Robot tutqichi obyekt ortidan avtomatik ergashishini va tasvir xatoligi $bold(e)_v -> 0$ ga intilishini yozib oling.
+ *4-bosqich: adaptiv tutqichda moʻrt obyektni ushlash.* Tutqich kuchini avtomatik cheklovchi algoritmni ishga tushirib, turlicha qattiqlikdagi obyektlarni ushlash tajribasini oʻtkazing.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan natijalarni nazariy hisoblar bilan solishtirib, amaliy hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Adaptiv robotning anʼanaviy programmalanuvchi robotlardan asosiy tashkiliy va funksional farqlari nimalardan iborat?
+ Adaptiv robotning 4 ta asosiy tashkiliy tizimini sanang va ularning oʻzaro bogʻliqligini tushuntiring.
+ Proprioseptiv va eksteroseptiv sensorlar adaptiv robotlarda qanday vazifalarni bajaradi?
+ Model Reference Adaptive Control (MRAC) va Self-Tuning Regulators (STR) adaptiv boshqaruv modellarining farqi nimada?
+ Impedance control (moslashuvchanlik boshqaruvi) nima va u robotning tashqi muhit bilan xavfsiz taʼsirlashuvida qanday qoʻllaniladi?
+ 6 oʻqli kuch-moment (_force-torque_) datchigining adaptiv yigʻish va jilolash (_polishing_) ishlaridagi roli qanday?
+ Visual servoing (vizual adaptiv boshqaruv) texnologiyasi va image Jacobian ($bold(L)_e$) matritsasi nimani anglatadi?
+ Kollaborativ robotlarda (_cobots_) inson xavfsizligini taʼminlovchi adaptiv kuch va momentni cheklash (STO) mexanizmi qanday ishlaydi?
+ Adaptiv tutqichlar (_adaptive grippers_) obyekt shakli va massasiga qanday moslashadi?
+ Lyapunov usuli boʻyicha adaptiv boshqaruv tizimining turgʻunligini taʼminlash shartlari nimalardan iborat?
+ ROS 2 (_Robot Operating System 2_) va EtherCAT protokollarining adaptiv robot axborot almashinuvidagi ahamiyati nima?
+ Sanoat 4.0 va IIoT konsepsiyasida Edge AI va adaptiv robotik tizimlarning tutgan oʻrnini izohlang.
