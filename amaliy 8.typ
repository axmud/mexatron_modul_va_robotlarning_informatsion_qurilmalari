// ============================================================
//  MMRIQ — 8-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_8.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Videodatchiklar va videokameralar ishini tahlil qilish")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 8  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №8]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Videodatchiklar va videokameralar ishini tahlil qilish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatronik tizimlar, sanoat robotlari va avtonom mobil platformalarda qoʻllaniladigan videodatchiklar, videokameralar hamda kompyuter koʻrishi (_computer vision_) modullarining fizik-texnik ishlash prinsiplari, CCD/CMOS matritsalari, pinhole va stereo-vision geometrik modellari, RGB-D chuqurlik kameralari hamda tasvir maʼlumotlari oqimini hisoblash va tahlil qilish koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Robototexnika va mexatronikada vizual axborot datchiklarining oʻrni va vazifalarini oʻrganish.
+ Yarimoʻtkazgichli fotomatritsalar: CCD (_Charge-Coupled Device_) va CMOS (_Complementary Metal-Oxide-Semiconductor_) matritsalarining tuzilishi hamda signalni oʻqish (_readout_) mexanizmlarini tahlil qilish.
+ Kamera proyeksiya geometriyasi: pinhole kamera modeli (teshikli kamera modeli), kameraning ichki va tashqi parametrlari (_intrinsic & extrinsic parameters_), fokus masofasi $f$ hamda optik markaz $(c_x, c_y)$ tushunchalarini oʻrganish.
+ 3D vizual sensorlar: stereo vision (stereo kameralar), structured light va Time-of-Flight (ToF) chuqurlik kameralari (RGB-D) orqali obyektlargacha boʻlgan masofani aniqlash modellarini tahlil qilish.
+ Vizual maʼlumotlar oqimi (_data bandwidth_), kadrlar chastotasi (FPS) va tasvir ajratish qobiliyati (_resolution_) boʻyicha muhandislik masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* robototexnika uchun kompyuter koʻrishi stendi, sanoat CMOS va CCD videokameralari, stereo vision kamera moduli (Intel RealSense / ZED), RGB-D chuqurlik datchigi (Kinect / ToF kamera), obyektivlar va kalibrlash uchun shaxmat taxtasi (_checkerboard pattern_).
- *Nazorat-oʻlchov vositalari:* raqamli ossillograf, lyuksmetr, yoritish manbalari (halqasimon LED / diffuz yoritish), USB 3.0 / GigE Vision interfeys kabellari.
- *Dasturiy muhit:* MATLAB / Simulink (Computer Vision Toolbox), OpenCV (_Open Source Computer Vision Library_), Python (NumPy / SciPy / PyTorch / ROS 2 image_transport).

= Nazariy maʼlumotlar va texnik modellar

== Robototexnikada videodatchiklar va kompyuter koʻrishining oʻrni

P.P.L. Regtien va J.J. Craig darsliklariga koʻra, *videodatchik (videokamera)* deb uch oʻlchamli (3D) fazodan tarqalayotgan yoki aks etayotgan optik nurlanish intensivligini ikki oʻlchamli (2D) elektr signali yoki raqamli piksellar matritsasiga aylantiruvchi fotoelektr oʻzgartirgichga aytiladi.

Videodatchiklar robotik tizimga quyidagi intellektual imkoniyatlarni beradi:

+ *Obyektlarni lokalizatsiya qilish va ushlash (Pick-and-Place):* konveyerdagi detalning shakli, oʻlchami va fazoviy orientatsiyasini aniqlash.
+ *Avtonom navigatsiya va vizual SLAM (Visual SLAM):* mobil robotlar va dronlarda atrof-muhitning 3D xaritasini tuzish hamda oʻz koordinatasini topish.
+ *Sifat nazorati va defektoskopiya (Industrial Inspection):* mahsulot yuzasidagi mikrodarzlar, boʻyoq nuqsonlari va oʻlcham xatolarini vizual aniqlash.

== CCD va CMOS matritsalarining ishlash tamoyillari va qiyosiy tahlili

Videokameralar tasvir hosil qiluvchi fotosensor matritsasining texnologiyasiga koʻra ikkita asosiy sinfga boʻlinadi (@tab-matrix).

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
      table.header([*№*], [*Texnik parametr*], [*CCD* \ (Charge-Coupled Device)], [*CMOS* \ (Complementary MOS)]),
      table.hline(stroke: 0.5pt),
      [1],
      [*Signalni oʻqish mexanizmi*],
      [Zaryad piksellardan ketma-ket siljitilib (_bucket-brigade_), umumiy chiqish kuchaytirgichi va ADC ga uzatiladi.],
      [Har bir pikselda oʻz kuchaytirgich tranzistorlari mavjud; signal adreslab oʻqiladi (odatda ustun ADC lari bilan).],
      [2], [*Tasvir sifati va shovqin*], [Juda yuqori dinamik diapazon (DR), oʻta kam shovqin va yuqori bir xillik.],
      [Shovqin darajasi oʻrtacha/past, zamonaviy BSI (_back-side illuminated_) sensorlarda yaxshilangan.],
      [3], [*Energiya sarfi va tezlik*], [Yuqori energiya sarfi ($1 dots 3 "W"$), kadrlar chastotasi (FPS) oʻrtacha.],
      [Kam energiya sarfi ($< 0.2 "W"$), yuqori tezlik ($> 500$ FPS).],
      [4], [*Zatvor turi (shutter)*], [Global shutter (barcha piksellar bir vaqtda eksponirlanadi).],
      [Rolling shutter (kadr satrma-satr oʻqiladi) yoki global shutter.],
      [5], [*Qoʻllanilish sohasi*], [Ilmiy tadqiqotlar, astronomiya va yuqori aniqlikdagi tibbiyot.],
      [Sanoat robototexnikasi, avtonom transport, smartfonlar va uchuvchisiz dronlar.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [CCD va CMOS matritsalarining qiyosiy texnik xarakteristikalari],
) <tab-matrix>

== Pinhole kamera proyeksiyasining matematik modeli

Idealizatsiyalangan kamera modeli *pinhole kamera modeli* (_pinhole camera model_) hisoblanadi. 3D fazodagi $P(X, Y, Z)$ nuqtaning optik markazdan $f$ (fokus masofasi) uzoqlikdagi 2D tasvir tekisligiga proyeksiyalanishi quyidagi koʻrinishga ega (@fig-pinhole):

$ x = f dot X / Z, quad y = f dot Y / Z $

Raqamli piksel koordinatalar tizimiga ($u, v$) oʻtganda (optik markaz $(c_x, c_y)$ va piksel oʻlchamlari $d_x, d_y$):

$ u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y $

bunda $f_x = f \/ d_x$ va $f_y = f \/ d_y$ --- piksellarda ifodalangan fokus masofasi. Gomogen (_homogeneous_) koordinatalarda matritsa shakli:

$ mat(u; v; 1) tilde bold(K) dot mat(bold(R), bold(T)) dot mat(X; Y; Z; 1) $

bunda $bold(K)$ --- ichki parametrlar matritsasi (_intrinsic matrix_):

$ bold(K) = mat(f_x, 0, c_x; 0, f_y, c_y; 0, 0, 1) $

$bold(R)$ va $bold(T)$ --- kameraning 3D dunyo koordinatalariga nisbatan burilish ($3 times 3$) va koʻchish ($3 times 1$) tashqi parametrlari (_extrinsic parameters_).

== Stereo vision va 3D chuqurlik kameralari (RGB-D)

Uch oʻlchamli fazoviy masofani aniqlash uchun ikkita parallel optik oʻqqa ega boʻlgan *stereo kameralar* ishlatiladi. Ikkita kamera markazlari orasidagi masofa *baza ($b$)* deb ataladi. Agar obyekt chap va oʻng kadrda mos ravishda $x_L$ va $x_R$ koordinatada koʻrinsa, *disparitet (disparity $d$)* quyidagicha aniqlanadi (@fig-stereo):

$ d = x_L - x_R $

Obyektdan kameragacha boʻlgan chuqurlik masofasi $Z$:

$ Z = (f dot b) / d $

bunda $f$ --- kameraning fokus masofasi (piksellarda), $b$ --- stereo baza, $d$ --- piksellardagi disparitet.

= Mavzuga oid chizmalar va sxemalar

== Pinhole kamera proyeksiyasining geometrik modeli (3D $->$ 2D)

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // Qiyshiq (kabinet) proyeksiya: (a, b, c) -> (a - 0.385c, b - 0.385c)
    let pr(a, b, c) = (a - 0.385 * c, b - 0.385 * c)
    let arr = (end: "stealth", fill: gray.darken(50%))
    let blue-c = headingblue
    let orng = orange.darken(15%)

    // Tasvir tekisligi (Z = f)
    line(
      pr(2, -2, -2),
      pr(2, 2.5, -2),
      pr(2, 2.5, 2),
      pr(2, -2, 2),
      close: true,
      fill: blue.lighten(90%).transparentize(30%),
      stroke: 1pt + blue-c,
    )
    content(pr(2.1, 2.45, -1.8), anchor: "south-west", text(
      size: 8pt,
      weight: "bold",
      fill: blue-c,
    )[Tasvir tekisligi ($Z = f$)])

    // Koordinata oʻqlari
    line(pr(0, 0, 0), pr(6, 0, 0), stroke: 1pt + gray.darken(50%), mark: arr)
    line(pr(0, 0, 0), pr(0, 3.5, 0), stroke: 1pt + gray.darken(50%), mark: arr)
    line(pr(0, 0, 0), pr(0, 0, 3.5), stroke: 1pt + gray.darken(50%), mark: arr)
    content(pr(6.1, 0, 0), anchor: "west", text(size: 9pt)[$Z$ (optik oʻq)])
    content(pr(0, 3.6, 0), anchor: "south", text(size: 9pt)[$Y$])
    content(pr(0, 0, 3.6), anchor: "north-east", text(size: 9pt)[$X$])

    // Proyeksiya nuri
    let P = pr(5.0, 2.0, 1.2)
    let p = pr(2.0, 0.8, 0.48)
    line(pr(0, 0, 0), P, stroke: 2pt + orng)
    circle(P, radius: 0.1, fill: orng, stroke: none)
    content((P.at(0) + 0.15, P.at(1) + 0.1), anchor: "south-west", text(
      size: 9pt,
      weight: "bold",
      fill: orng,
    )[$P(X, Y, Z)$])
    circle(p, radius: 0.08, fill: blue-c, stroke: none)
    content((p.at(0) - 0.12, p.at(1) + 0.1), anchor: "south-east", text(
      size: 8pt,
      weight: "bold",
      fill: blue-c,
    )[$p(u, v)$])

    // Optik markaz
    circle(pr(0, 0, 0), radius: 0.08, fill: red, stroke: none)
    content((-0.15, 0.15), anchor: "south-east", text(size: 9pt, weight: "bold", fill: red)[Optik markaz $O$])

    // Fokus masofasi
    line(pr(0, -2.4, 0), pr(2, -2.4, 0), stroke: 1pt + blue.lighten(10%), mark: (
      start: "stealth",
      end: "stealth",
      fill: blue.lighten(10%),
    ))
    content(pr(1, -2.5, 0), anchor: "north", text(size: 8pt, weight: "bold")[Fokus masofasi $f$])
  }),
  caption: [Pinhole kamera modelida 3D fazo nuqtasining 2D tasvir tekisligiga proyeksiyalanishi],
) <fig-pinhole>

== CCD va CMOS piksellarida signalni oʻqish arxitekturasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let blk(c, body, fill, stroke) = {
      rect((c.at(0) - 1.0, c.at(1) - 0.7), (c.at(0) + 1.0, c.at(1) + 0.7), fill: fill, stroke: stroke)
      content(c, align(center, text(size: 7pt, weight: "bold", body)))
    }

    // ---- a) CCD ----
    content((-1.0, 1.35), anchor: "west", text(
      size: 9pt,
      weight: "bold",
      fill: blue-c,
    )[a) CCD: zaryadni ketma-ket siljitib oʻqish])
    blk((0, 0), [Fotodiod \ (zaryad)], blue.lighten(93%), 1pt + blue-c)
    blk((2.8, 0), [Fotodiod \ (zaryad)], blue.lighten(93%), 1pt + blue-c)
    blk((6.0, 0), [Siljitish registri \ + chiqish kuchayt. \ va ADC], red.lighten(90%), 1pt + red)
    line((1.0, 0), (1.8, 0), stroke: 1pt + blue-c, mark: (end: "stealth", fill: blue-c))
    line((3.8, 0), (5.0, 0), stroke: 1pt + red, mark: (end: "stealth", fill: red))

    // ---- b) CMOS ----
    let y = -3.4
    content((-1.0, y + 1.35), anchor: "west", text(
      size: 9pt,
      weight: "bold",
      fill: orng,
    )[b) CMOS: har bir pikselda kuchaytirgich, adresli oʻqish])
    blk((0, y), [Fotodiod + \ kuchaytirgich \ tranzistor], orange.lighten(88%), 1pt + orng)
    blk((2.8, y), [Fotodiod + \ kuchaytirgich \ tranzistor], orange.lighten(88%), 1pt + orng)
    blk((6.0, y), [Ustun ADC lari \ va raqamli shina \ (direct readout)], blue.lighten(88%), 1pt + blue.lighten(10%))
    let yb = y - 1.2
    line((0, y - 0.7), (0, yb), stroke: 1pt + orng)
    line((2.8, y - 0.7), (2.8, yb), stroke: 1pt + orng)
    line((0, yb), (6.0, yb), (6.0, y - 0.72), stroke: 1pt + orng, mark: (end: "stealth", fill: orng))
  }),
  caption: [CCD va CMOS fotoelektr piksellarida signalni oʻqish (readout) mexanizmi],
) <fig-ccd>

== Stereo vision (ikkita kamera) va disparitet orqali 3D chuqurlik hisobi

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let oL = (-2, 0)
    let oR = (2, 0)
    let P = (0.6, 4.2)
    let yi = 1.2
    // Nurlarning tasvir tekisligi bilan kesishish nuqtalari
    let xl = oL.at(0) + (P.at(0) - oL.at(0)) * yi / P.at(1)
    let xr = oR.at(0) + (P.at(0) - oR.at(0)) * yi / P.at(1)

    // Tasvir tekisliklari
    line((-3.2, yi), (-0.8, yi), stroke: 1.2pt + blue-c)
    line((0.8, yi), (3.2, yi), stroke: 1.2pt + blue-c)
    content((-3.25, yi), anchor: "east", text(size: 7pt)[Tasvir tekisligi])

    // Proyeksiya nurlari
    line(oL, P, stroke: 1pt + red)
    line(oR, P, stroke: 1pt + red)
    circle(P, radius: 0.1, fill: red, stroke: none)
    content((P.at(0), P.at(1) + 0.15), anchor: "south", text(size: 9pt, weight: "bold", fill: red)[$P(X, Y, Z)$])

    // Proyeksiya nuqtalari
    circle((xl, yi), radius: 0.07, fill: blue.lighten(10%), stroke: none)
    circle((xr, yi), radius: 0.07, fill: blue.lighten(10%), stroke: none)
    content((xl - 0.1, yi - 0.1), anchor: "north-east", text(size: 8pt)[$x_L$])
    content((xr + 0.1, yi - 0.1), anchor: "north-west", text(size: 8pt)[$x_R$])

    // Stereo baza
    line(oL, oR, stroke: 1.5pt + orng, mark: (start: "stealth", end: "stealth", fill: orng))
    content((0, 0.1), anchor: "south", text(size: 9pt, weight: "bold")[Stereo baza ($b$)])

    // Kameralar
    for (o, lab, name) in ((oL, $O_L$, [Chap kamera]), (oR, $O_R$, [Oʻng kamera])) {
      circle(o, radius: 0.3, fill: blue.lighten(93%), stroke: 1pt + blue-c)
      content(o, text(size: 7pt, weight: "bold", lab))
      content((o.at(0), o.at(1) - 0.4), anchor: "north", text(size: 7pt, weight: "bold", name))
    }

    // Chuqurlik Z
    line((3.6, 0), (3.6, 4.2), stroke: 1pt + gray.darken(50%), mark: (
      start: "stealth",
      end: "stealth",
      fill: gray.darken(50%),
    ))
    content((3.75, 2.1), anchor: "west", text(size: 9pt, weight: "bold")[Chuqurlik $Z = (f dot b) / d$])
  }),
  caption: [Stereo kameralar va disparitet ($d = x_L - x_R$) orqali 3D masofani hisoblash],
) <fig-stereo>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: videodatchiklar va kameralarning qiyosiy texnik tahlili

Sanoat robototexnikasida ishlatiladigan 4 ta asosiy kamera datchigi turining parametrlarini tahlil qiling va @tab-cams ni toʻldiring.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (2.7cm, 3cm, 2.2cm, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Kamera datchigi turi*],
        [*Diapazoni / \ ajratish qobiliyati*],
        [*Kadrlar \ chastotasi (FPS)*],
        [*Asosiy ustunligi va kamchiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Sanoat 2D CMOS kameralari*], [$1920 times 1080 dots 4096 times 3072$ piksel], [$60 dots 500$],
      [*Ustunligi:* yuqori tezlik va ajratish qobiliyati. \ *Kamchiligi:* chuqurlik ($Z$) haqida maʼlumot bermaydi.],
      [*Stereo vision kameralari*], [$0.5 dots 20 "m"$, 1080p], [$30 dots 90$],
      [*Ustunligi:* quyoshli ochiq muhitda (_outdoor_) yaxshi ishlaydi. \ *Kamchiligi:* teksturasiz tekis devorlarda masofa xatosi.],
      [*Structured light RGB-D*], [$0.2 dots 3.5 "m"$, VGA/HD], [$30 dots 60$],
      [*Ustunligi:* yopiq muhitda yuqori aniqlik ($approx 1 "mm"$). \ *Kamchiligi:* quyosh nuri ostida yomon ishlaydi.],
      [*Time-of-Flight (ToF) 3D*], [$0.1 dots 6 "m"$, VGA], [$30 dots 120$],
      [*Ustunligi:* tezkor 3D masofa xaritasi. \ *Kamchiligi:* ajratish qobiliyati oʻrtacha.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Videodatchiklar va 3D kameralarning qiyosiy texnik va metrologik tahlili],
) <tab-cams>

== Topshiriq 2: sanoat liniyasi va mobil robot uchun vizual datchik tanlash

Quyidagi ikkita texnologik vazifa uchun vizual videodatchik va yoritish tizimini tanlang hamda asoslang:

+ *1-vazifa:* konveyerdan $120 "m/min"$ tezlikda oʻtayotgan kichik detallar sirtidagi mikrodarzlarni ($0.1 "mm"$ aniqlik bilan) defektoskopiya qilish.
+ *2-vazifa:* avtonom mobil robot (AMR) uchun bino ichida va tashqarisida SLAM navigatsiyasini amalga oshirish hamda toʻsiqlarni 3D koʻrish.

*Tahlil va yechim:*

- *1-vazifa uchun:* _sanoat CMOS kamerasi (global shutter, $100+$ FPS, GigE Vision interfeysi)_ va _halqasimon diffuz LED yoritgich_. Sababi: global shutter tez harakatda rolling shutter beradigan qiyshayish (_skew_) deformatsiyasini yoʻqotadi, diffuz LED yoritish esa yaltirashni kamaytiradi.
- *2-vazifa uchun:* _stereo vision RGB-D kamera (Intel RealSense / ZED 2)_ va _6-DoF IMU_. Sababi: quyosh nuri bor joyda ham, bino ichida ham 3D nuqtalar buluti (_point cloud_) va disparitet xaritasini shakllantiradi.

= Hisoblash va modellashtirish masalalari

== Masala 1: pinhole kamera modeli va proyeksiya hisobi

Sanoat roboti kamerasining fokus masofasi $f = 12 "mm"$. Piksel oʻlchamlari $d_x = d_y = 6.0 thin mu"m" = 6.0 times 10^(-3) "mm"$. Tasvir markazi (optik markaz) $c_x = 960$ piksel, $c_y = 540$ piksel (kamera ajratish qobiliyati $1920 times 1080$). Detal nuqtasi kamera koordinatalar tizimida $P(X, Y, Z) = (150 "mm", -90 "mm", 1200 "mm")$ nuqtada joylashgan.

#set enum(numbering: "a)")
+ Piksellardagi fokus masofalari $f_x$ va $f_y$ ni aniqlang.
+ Detal nuqtasining 2D tasvirdagi piksel koordinatalari $(u, v)$ ni hisoblang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ f_x = f / d_x, quad f_y = f / d_y, quad u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y $

*Hisoblash bosqichlari:*

- Piksellardagi fokus masofasi:
  $ f_x = f_y = (12 "mm") / (0.006 "mm") = 2000 "piksel" $
- Piksel koordinatalari $u$ va $v$:
  $ u = 2000 times (150 "mm") / (1200 "mm") + 960 = 2000 times 0.125 + 960 = 250 + 960 = 1210 "piksel" $
  $ v = 2000 times (-90 "mm") / (1200 "mm") + 540 = 2000 times (-0.075) + 540 = \ -150 + 540 = 390 "piksel" $
- Yakuniy piksel koordinatalari: $(u, v) = (1210, 390)$.

== Masala 2: stereo vision chuqurligi va chuqurlik boʻyicha ajratish qobiliyati hisobi

Stereo kamera tizimining fokus masofasi $f = 8.0 "mm"$, stereo bazasi $b = 120 "mm" = 0.12 "m"$, piksel oʻlchami $d_x = 4.0 thin mu"m" = 0.004 "mm"$. Stereo tasvirlarni moslashtirish natijasida obyekt uchun disparitet $d = 24$ piksel deb topildi.

#set enum(numbering: "a)")
+ Obyektdan kameragacha boʻlgan chuqurlik masofasi $Z$ (m) ni hisoblang.
+ Disparitet 1 pikselga oʻzgargandagi chuqurlik xatoligi $Delta Z$ ni $Z = 2.0 "m"$ masofa uchun aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ f_"px" = f / d_x = (8.0 "mm") / (0.004 "mm") = 2000 "piksel" $

$ Z = (f_"px" dot b) / d, quad quad Delta Z approx Z^2 / (f_"px" dot b) dot Delta d $

*Hisoblash bosqichlari:*

- $Z$ masofasi ($d = 24$ piksel):
  $ Z = (2000 times 0.12 "m") / 24 = 240 / 24 = 10.0 "m" $
- $Z = 2.0 "m"$ boʻlgandagi disparitet:
  $ d_(2 "m") = (2000 times 0.12) / 2.0 = 120 "piksel" $
- $Delta d = 1$ piksel boʻlgandagi chuqurlik xatoligi:
  $ Delta Z = (2.0)^2 / (2000 times 0.12) times 1 = 4.0 / 240 = 0.01667 "m" = 16.67 "mm" $

== Masala 3: videodatchik maʼlumotlar oqimi va interfeys oʻtkazuvchanligi

Sanoat robotidagi Full HD CMOS videokamera $1920 times 1080$ piksel ajratish qobiliyatida, 24-bitli RGB formatida (3 bayt/piksel) va $60$ FPS chastotada ishlaydi.

#set enum(numbering: "a)")
+ Siqilmagan (_uncompressed raw_) bitta kadr hajmi $M_"kadr"$ ni megabaytlarda (MB) hisoblang.
+ Videokameraning sekundiga uzatadigan maʼlumotlar oqimi $B_"oqim"$ ni MB/s va Gbit/s larda aniqlang.
+ Ushbu kamera uchun GigE Vision ($1 "Gbit/s"$) interfeysi yetarlimi yoki USB 3.0 ($5 "Gbit/s"$) talab qilinadimi?
#set enum(numbering: "1.")

*Yechish va formulalar* (oʻnlik prefikslar: $1 "MB" = 10^6$ bayt, $1 "Gbit" = 10^9$ bit):

$ N_"piksel" = 1920 times 1080 = 2073600 "piksel" $

$
  M_"kadr" = N_"piksel" times 3 "bayt", quad quad B_"oqim" = M_"kadr" times "FPS", quad quad \ B_"Gbit/s" = (B_"oqim" ["bayt/s"] times 8) / 10^9
$

*Hisoblash bosqichlari:*

- Bitta kadr hajmi:
  $ M_"kadr" = 2073600 times 3 = 6220800 "bayt" approx 6.22 "MB" $
- Sekundiga maʼlumotlar oqimi (60 FPS):
  $ B_"oqim" = 6220800 times 60 = 373248000 "bayt/s" approx 373.2 "MB/s" $
- Gbit/s dagi oqim:
  $ B_"Gbit/s" = (373248000 times 8) / 10^9 approx 2.986 "Gbit/s" $
- Interfeys tahlili: GigE Vision ($1 "Gbit/s"$) yetarli emas ($2.99 "Gbit/s" > 1 "Gbit/s"$). Shuning uchun kamida USB 3.0 ($5 "Gbit/s"$) yoki 10GigE interfeysi talab etiladi.

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: videodatchik va kameralarni ulash va sozlash.* CMOS va RGB-D kameralarni USB 3.0 interfeysi orqali kompyuterga ulang. OpenCV yoki MATLAB muhitida video oqimni oching.
+ *2-bosqich: kamerani kalibrlash (camera calibration).* Shaxmat taxtasini kameraga turli burchaklardan 15--20 marta suratga oling. Ichki parametrlar matritsasi $bold(K)$ va radial distorsiya koeffitsientlarini ($k_1, k_2$) hisoblang.
+ *3-bosqich: tasvirni qayta ishlash va konturlarni ajratish.* Olingan kadrni BGR dan grayscale formatiga oʻtkazing, Gauss filtri bilan shovqinni kamaytirib, Canny / Sobel operatori yordamida detallarning chegara konturlarini (_edges_) aniqlang.
+ *4-bosqich: stereo kameralarda disparitet va 3D masofani oʻlchash.* Stereo kameradan olingan chap va oʻng kadrlar asosida disparitet xaritasini (_disparity map_) hosil qiling va ajratilgan obyektgacha boʻlgan chuqurlik $Z$ ni hisoblang.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Tajriba va hisoblash natijalarini jamlab, amaliy hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Robototexnika va mexatronikada videodatchiklar va kompyuter koʻrishining (_computer vision_) asosiy vazifalarini sanab bering.
+ CCD va CMOS fotoelektr matritsalarining ishlash prinsipi, signalni oʻqish (_readout_) va energiya sarfi boʻyicha farqlarini tushuntiring.
+ Global shutter va rolling shutter oʻrtasidagi farq nimada va nima uchun tez harakatlanuvchi sanoat obyektlarida global shutter talab qilinadi?
+ Pinhole kamera modelida 3D fazodagi nuqta 2D tasvir tekisligiga qanday proyeksiyalanadi?
+ Kameraning ichki matritsasi ($bold(K)$ --- _intrinsic matrix_) va tashqi parametrlari ($bold(R), bold(T)$) nimani ifodalaydi?
+ Kameradagi radial va tangensial distorsiya tushunchalari va ularni dasturiy kalibrlash usullarini ayting.
+ Stereo vision yordamida 3D chuqurlikni ($Z$) aniqlashda disparitet va baza ($b$) parametrlari qanday rol oʻynaydi?
+ RGB-D chuqurlik kameralarining Time-of-Flight (ToF) va structured light texnologiyalari boʻyicha ishlash tamoyilini tushuntiring.
+ Yuqori kadrlar chastotasidagi ($60+$ FPS) siqilmagan video oqim uchun talab qilinadigan oʻtkazuvchanlik (_bandwidth_) qanday hisoblanadi?
+ Tasvirlarni dasturiy qayta ishlashda grayscale ga oʻtkazish, Gauss filtri va Canny chegara aniqlagichining (_edge detection_) vazifasi nimadan iborat?
+ Nima uchun quyosh nuri bor ochiq maydonda (_outdoor_) IK nurga asoslangan structured light kameralari oʻrniga stereo vision qoʻllaniladi?
+ Visual SLAM (_Simultaneous Localization and Mapping_) algoritmlarida videodatchiklarning tutgan oʻrnini izohlang.
