// ============================================================
//  MMRIQ — 8-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_8.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Videodatçiklar va videokameralar işini tahlil qiliş")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №8]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Videodatçiklar va videokameralar işini tahlil qiliş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatronik tizimlar, sanoat robotlari va avtonom mobil platformalarda qöllaniladigan videodatçiklar, videokameralar hamda kompyuter körişi (_computer vision_) modullarining fizik-texnik işlaş prinsiplari, CCD/CMOS matritsalari, pinhole va stereo-vision geometrik modellari, RGB-D çuqurlik kameralari hamda tasvir maʼlumotlari oqimini hisoblaş va tahlil qiliş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Robototexnika va mexatronikada vizual axborot datçiklarining örni va vazifalarini örganiş.
+ Yarimötkazgiçli fotomatritsalar: CCD (_Charge-Coupled Device_) va CMOS (_Complementary Metal-Oxide-Semiconductor_) matritsalarining tuzilişi hamda signalni öqiş (_readout_) mexanizmlarini tahlil qiliş.
+ Kamera proyeksiya geometriyasi: pinhole kamera modeli (teşikli kamera modeli), kameraning içki va taşqi parametrlari (_intrinsic & extrinsic parameters_), fokus masofasi $f$ hamda optik markaz $(c_x, c_y)$ tuşunçalarini örganiş.
+ 3D vizual sensorlar: stereo vision (stereo kameralar), structured light va Time-of-Flight (ToF) çuqurlik kameralari (RGB-D) orqali obyektlargaça bölgan masofani aniqlaş modellarini tahlil qiliş.
+ Vizual maʼlumotlar oqimi (_data bandwidth_), kadrlar çastotasi (FPS) va tasvir ajratiş qobiliyati (_resolution_) böyiça muhandislik masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* robototexnika uçun kompyuter körişi stendi, sanoat CMOS va CCD videokameralari, stereo vision kamera moduli (Intel RealSense / ZED), RGB-D çuqurlik datçigi (Kinect / ToF kamera), obyektivlar va kalibrlaş uçun şaxmat taxtasi (_checkerboard pattern_).
- *Nazorat-ölçov vositalari:* raqamli ossillograf, lyuksmetr, yoritiş manbalari (halqasimon LED / diffuz yoritiş), USB 3.0 / GigE Vision interfeys kabellari.
- *Dasturiy muhit:* MATLAB / Simulink (Computer Vision Toolbox), OpenCV (_Open Source Computer Vision Library_), Python (NumPy / SciPy / PyTorch / ROS 2 image_transport).

= Nazariy maʼlumotlar va texnik modellar

== Robototexnikada videodatçiklar va kompyuter körişining örni

P.P.L. Regtien va J.J. Craig darsliklariga köra, *videodatçik (videokamera)* deb uç ölçamli (3D) fazodan tarqalayotgan yoki aks etayotgan optik nurlaniş intensivligini ikki ölçamli (2D) elektr signali yoki raqamli piksellar matritsasiga aylantiruvçi fotoelektr özgartirgiçga aytiladi.

Videodatçiklar robotik tizimga quyidagi intellektual imkoniyatlarni beradi:

+ *Obyektlarni lokalizatsiya qiliş va uşlaş (Pick-and-Place):* konveyerdagi detalning şakli, ölçami va fazoviy orientatsiyasini aniqlaş.
+ *Avtonom navigatsiya va vizual SLAM (Visual SLAM):* mobil robotlar va dronlarda atrof-muhitning 3D xaritasini tuziş hamda öz koordinatasini topiş.
+ *Sifat nazorati va defektoskopiya (Industrial Inspection):* mahsulot yuzasidagi mikrodarzlar, böyoq nuqsonlari va ölçam xatolarini vizual aniqlaş.

== CCD va CMOS matritsalarining işlaş tamoyillari va qiyosiy tahlili

Videokameralar tasvir hosil qiluvçi fotosensor matritsasining texnologiyasiga köra ikkita asosiy sinfga bölinadi (@tab-matrix).

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
      [*Signalni öqiş mexanizmi*],
      [Zaryad piksellardan ketma-ket siljitilib (_bucket-brigade_), umumiy çiqiş kuçaytirgiçi va ADC ga uzatiladi.],
      [Har bir pikselda öz kuçaytirgiç tranzistorlari mavjud; signal adreslab öqiladi (odatda ustun ADC lari bilan).],
      [2], [*Tasvir sifati va şovqin*], [Juda yuqori dinamik diapazon (DR), öta kam şovqin va yuqori bir xillik.],
      [Şovqin darajasi örtaça/past, zamonaviy BSI (_back-side illuminated_) sensorlarda yaxşilangan.],
      [3], [*Energiya sarfi va tezlik*], [Yuqori energiya sarfi ($1 dots 3 "W"$), kadrlar çastotasi (FPS) örtaça.],
      [Kam energiya sarfi ($< 0.2 "W"$), yuqori tezlik ($> 500$ FPS).],
      [4], [*Zatvor turi (shutter)*], [Global shutter (barça piksellar bir vaqtda eksponirlanadi).],
      [Rolling shutter (kadr satrma-satr öqiladi) yoki global shutter.],
      [5], [*Qöllaniliş sohasi*], [Ilmiy tadqiqotlar, astronomiya va yuqori aniqlikdagi tibbiyot.],
      [Sanoat robototexnikasi, avtonom transport, smartfonlar va uçuvçisiz dronlar.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [CCD va CMOS matritsalarining qiyosiy texnik xarakteristikalari],
) <tab-matrix>

== Pinhole kamera proyeksiyasining matematik modeli

Idealizatsiyalangan kamera modeli *pinhole kamera modeli* (_pinhole camera model_) hisoblanadi. 3D fazodagi $P(X, Y, Z)$ nuqtaning optik markazdan $f$ (fokus masofasi) uzoqlikdagi 2D tasvir tekisligiga proyeksiyalanişi quyidagi körinişga ega (@fig-pinhole):

$ x = f dot X / Z, quad y = f dot Y / Z $

Raqamli piksel koordinatalar tizimiga ($u, v$) ötganda (optik markaz $(c_x, c_y)$ va piksel ölçamlari $d_x, d_y$):

$ u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y $

bunda $f_x = f \/ d_x$ va $f_y = f \/ d_y$ --- piksellarda ifodalangan fokus masofasi. Gomogen (_homogeneous_) koordinatalarda matritsa şakli:

$ mat(u; v; 1) tilde bold(K) dot mat(bold(R), bold(T)) dot mat(X; Y; Z; 1) $

bunda $bold(K)$ --- içki parametrlar matritsasi (_intrinsic matrix_):

$ bold(K) = mat(f_x, 0, c_x; 0, f_y, c_y; 0, 0, 1) $

$bold(R)$ va $bold(T)$ --- kameraning 3D dunyo koordinatalariga nisbatan buriliş ($3 times 3$) va köçiş ($3 times 1$) taşqi parametrlari (_extrinsic parameters_).

== Stereo vision va 3D çuqurlik kameralari (RGB-D)

Uç ölçamli fazoviy masofani aniqlaş uçun ikkita parallel optik öqqa ega bölgan *stereo kameralar* işlatiladi. Ikkita kamera markazlari orasidagi masofa *baza ($b$)* deb ataladi. Agar obyekt çap va öng kadrda mos ravişda $x_L$ va $x_R$ koordinatada körinsa, *disparitet (disparity $d$)* quyidagiça aniqlanadi (@fig-stereo):

$ d = x_L - x_R $

Obyektdan kameragaça bölgan çuqurlik masofasi $Z$:

$ Z = (f dot b) / d $

bunda $f$ --- kameraning fokus masofasi (piksellarda), $b$ --- stereo baza, $d$ --- piksellardagi disparitet.

= Mavzuga oid çizmalar va sxemalar

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
    content(pr(6.1, 0, 0), anchor: "west", text(size: 9pt)[$Z$ (optik öq)])
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
  caption: [Pinhole kamera modelida 3D fazo nuqtasining 2D tasvir tekisligiga proyeksiyalanişi],
) <fig-pinhole>

== CCD va CMOS piksellarida signalni öqiş arxitekturasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)

    // ---- sizes: change only these ----
    let w = 1.3 // half-width of the normal boxes
    let w3 = 1.7 // half-width of the right-hand (wider) box
    let h = 0.95 // half-height of all boxes
    let gap = 0.9 // arrow length between boxes
    let fs = 7.5pt // text size inside the boxes

    let x0 = 0
    let x1 = x0 + 2 * w + gap
    let x2 = x1 + w + gap + 0.4 + w3

    let blk(c, body, fill, stroke, w: w) = {
      rect((c.at(0) - w, c.at(1) - h), (c.at(0) + w, c.at(1) + h), fill: fill, stroke: stroke)
      content(c, align(center, text(size: fs, weight: "bold", body)))
    }

    // ---- a) CCD ----
    content((x0 - w, h + 0.6), anchor: "west", text(
      size: 9pt,
      weight: "bold",
      fill: blue-c,
    )[a) CCD: zaryadni ketma-ket siljitib öqiş])
    blk((x0, 0), [Fotodiod \ (zaryad)], blue.lighten(93%), 1pt + blue-c)
    blk((x1, 0), [Fotodiod \ (zaryad)], blue.lighten(93%), 1pt + blue-c)
    blk((x2, 0), [Siljitiş registri \ + çiqiş kuçayt. \ va ADC], red.lighten(90%), 1pt + red, w: w3)
    line((x0 + w, 0), (x1 - w, 0), stroke: 1pt + blue-c, mark: (end: "stealth", fill: blue-c))
    line((x1 + w, 0), (x2 - w3, 0), stroke: 1pt + red, mark: (end: "stealth", fill: red))

    // ---- b) CMOS ----
    let y = -(2 * h + 2.2)
    content((x0 - w, y + h + 0.6), anchor: "west", text(
      size: 9pt,
      weight: "bold",
      fill: orng,
    )[b) CMOS: har bir pikselda kuçaytirgiç, adresli öqiş])
    blk((x0, y), [Fotodiod + \ kuçaytirgiç \ tranzistor], orange.lighten(88%), 1pt + orng)
    blk((x1, y), [Fotodiod + \ kuçaytirgiç \ tranzistor], orange.lighten(88%), 1pt + orng)
    blk(
      (x2, y),
      [Ustun ADC lari \ va raqamli şina \ (direct readout)],
      blue.lighten(88%),
      1pt + blue.lighten(10%),
      w: w3,
    )
    let yb = y - h - 0.5
    line((x0, y - h), (x0, yb), stroke: 1pt + orng)
    line((x1, y - h), (x1, yb), stroke: 1pt + orng)
    line((x0, yb), (x2, yb), (x2, y - h), stroke: 1pt + orng, mark: (end: "stealth", fill: orng))
  }),
  caption: [CCD va CMOS fotoelektr piksellarida signalni öqiş (readout) mexanizmi],
) <fig-ccd>
== Stereo vision (ikkita kamera) va disparitet orqali 3D çuqurlik hisobi

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
    for (o, lab, name) in ((oL, $O_L$, [Çap kamera]), (oR, $O_R$, [Öng kamera])) {
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
    content((3.75, 2.1), anchor: "west", text(size: 9pt, weight: "bold")[Çuqurlik $Z = (f dot b) / d$])
  }),
  caption: [Stereo kameralar va disparitet ($d = x_L - x_R$) orqali 3D masofani hisoblaş],
) <fig-stereo>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: videodatçiklar va kameralarning qiyosiy texnik tahlili

Sanoat robototexnikasida işlatiladigan 4 ta asosiy kamera datçigi turining parametrlarini tahlil qiling va @tab-cams ni töldiring.

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
        [*Kamera datçigi turi*],
        [*Diapazoni / \ ajratiş qobiliyati*],
        [*Kadrlar \ çastotasi (FPS)*],
        [*Asosiy ustunligi va kamçiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Sanoat 2D CMOS kameralari*], [$1920 times 1080 dots 4096 times 3072$ piksel], [$60 dots 500$],
      [*Ustunligi:* yuqori tezlik va ajratiş qobiliyati. \ *Kamçiligi:* çuqurlik ($Z$) haqida maʼlumot bermaydi.],
      [*Stereo vision kameralari*], [$0.5 dots 20 "m"$, 1080p], [$30 dots 90$],
      [*Ustunligi:* quyoşli oçiq muhitda (_outdoor_) yaxşi işlaydi. \ *Kamçiligi:* teksturasiz tekis devorlarda masofa xatosi.],
      [*Structured light RGB-D*], [$0.2 dots 3.5 "m"$, VGA/HD], [$30 dots 60$],
      [*Ustunligi:* yopiq muhitda yuqori aniqlik ($approx 1 "mm"$). \ *Kamçiligi:* quyoş nuri ostida yomon işlaydi.],
      [*Time-of-Flight (ToF) 3D*], [$0.1 dots 6 "m"$, VGA], [$30 dots 120$],
      [*Ustunligi:* tezkor 3D masofa xaritasi. \ *Kamçiligi:* ajratiş qobiliyati örtaça.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Videodatçiklar va 3D kameralarning qiyosiy texnik va metrologik tahlili],
) <tab-cams>

== Topşiriq 2: sanoat liniyasi va mobil robot uçun vizual datçik tanlaş

Quyidagi ikkita texnologik vazifa uçun vizual videodatçik va yoritiş tizimini tanlang hamda asoslang:

+ *1-vazifa:* konveyerdan $120 "m/min"$ tezlikda ötayotgan kiçik detallar sirtidagi mikrodarzlarni ($0.1 "mm"$ aniqlik bilan) defektoskopiya qiliş.
+ *2-vazifa:* avtonom mobil robot (AMR) uçun bino içida va taşqarisida SLAM navigatsiyasini amalga oşiriş hamda tösiqlarni 3D köriş.

*Tahlil va yeçim:*

- *1-vazifa uçun:* _sanoat CMOS kamerasi (global shutter, $100+$ FPS, GigE Vision interfeysi)_ va _halqasimon diffuz LED yoritgiç_. Sababi: global shutter tez harakatda rolling shutter beradigan qiyşayiş (_skew_) deformatsiyasini yöqotadi, diffuz LED yoritiş esa yaltiraşni kamaytiradi.
- *2-vazifa uçun:* _stereo vision RGB-D kamera (Intel RealSense / ZED 2)_ va _6-DoF IMU_. Sababi: quyoş nuri bor joyda ham, bino içida ham 3D nuqtalar buluti (_point cloud_) va disparitet xaritasini şakllantiradi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: pinhole kamera modeli va proyeksiya hisobi

Sanoat roboti kamerasining fokus masofasi $f = 12 "mm"$. Piksel ölçamlari $d_x = d_y = 6.0 thin mu"m" = 6.0 times 10^(-3) "mm"$. Tasvir markazi (optik markaz) $c_x = 960$ piksel, $c_y = 540$ piksel (kamera ajratiş qobiliyati $1920 times 1080$). Detal nuqtasi kamera koordinatalar tizimida $P(X, Y, Z) = (150 "mm", -90 "mm", 1200 "mm")$ nuqtada joylaşgan.

#set enum(numbering: "a)")
+ Piksellardagi fokus masofalari $f_x$ va $f_y$ ni aniqlang.
+ Detal nuqtasining 2D tasvirdagi piksel koordinatalari $(u, v)$ ni hisoblang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ f_x = f / d_x, quad f_y = f / d_y, quad u = f_x dot X / Z + c_x, quad v = f_y dot Y / Z + c_y $

*Hisoblaş bosqiçlari:*

- Piksellardagi fokus masofasi:
  $ f_x = f_y = (12 "mm") / (0.006 "mm") = 2000 "piksel" $
- Piksel koordinatalari $u$ va $v$:
  $ u = 2000 times (150 "mm") / (1200 "mm") + 960 = 2000 times 0.125 + 960 =\ 250 + 960 = 1210 "piksel" $
  $ v = 2000 times (-90 "mm") / (1200 "mm") + 540 = 2000 times (-0.075) + 540 = \ -150 + 540 = 390 "piksel" $
- Yakuniy piksel koordinatalari: $(u, v) = (1210, 390)$.

== Masala 2: stereo vision çuqurligi va çuqurlik böyiça ajratiş qobiliyati hisobi

Stereo kamera tizimining fokus masofasi $f = 8.0 "mm"$, stereo bazasi $b = 120 "mm" = 0.12 "m"$, piksel ölçami $d_x = 4.0 thin mu"m" = 0.004 "mm"$. Stereo tasvirlarni moslaştiriş natijasida obyekt uçun disparitet $d = 24$ piksel deb topildi.

#set enum(numbering: "a)")
+ Obyektdan kameragaça bölgan çuqurlik masofasi $Z$ (m) ni hisoblang.
+ Disparitet 1 pikselga özgargandagi çuqurlik xatoligi $Delta Z$ ni $Z = 2.0 "m"$ masofa uçun aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ f_"px" = f / d_x = (8.0 "mm") / (0.004 "mm") = 2000 "piksel" $

$ Z = (f_"px" dot b) / d, quad quad Delta Z approx Z^2 / (f_"px" dot b) dot Delta d $

*Hisoblaş bosqiçlari:*

- $Z$ masofasi ($d = 24$ piksel):
  $ Z = (2000 times 0.12 "m") / 24 = 240 / 24 = 10.0 "m" $
- $Z = 2.0 "m"$ bölgandagi disparitet:
  $ d_(2 "m") = (2000 times 0.12) / 2.0 = 120 "piksel" $
- $Delta d = 1$ piksel bölgandagi çuqurlik xatoligi:
  $ Delta Z = (2.0)^2 / (2000 times 0.12) times 1 = 4.0 / 240 = 0.01667 "m" = 16.67 "mm" $

== Masala 3: videodatçik maʼlumotlar oqimi va interfeys ötkazuvçanligi

Sanoat robotidagi Full HD CMOS videokamera $1920 times 1080$ piksel ajratiş qobiliyatida, 24-bitli RGB formatida (3 bayt/piksel) va $60$ FPS çastotada işlaydi.

#set enum(numbering: "a)")
+ Siqilmagan (_uncompressed raw_) bitta kadr hajmi $M_"kadr"$ ni megabaytlarda (MB) hisoblang.
+ Videokameraning sekundiga uzatadigan maʼlumotlar oqimi $B_"oqim"$ ni MB/s va Gbit/s larda aniqlang.
+ Uşbu kamera uçun GigE Vision ($1 "Gbit/s"$) interfeysi yetarlimi yoki USB 3.0 ($5 "Gbit/s"$) talab qilinadimi?
#set enum(numbering: "1.")

*Yeçiş va formulalar* (önlik prefikslar: $1 "MB" = 10^6$ bayt, $1 "Gbit" = 10^9$ bit):

$ N_"piksel" = 1920 times 1080 = 2073600 "piksel" $

$
  M_"kadr" = N_"piksel" times 3 "bayt", quad quad B_"oqim" = M_"kadr" times "FPS", quad quad \ B_"Gbit/s" = (B_"oqim" ["bayt/s"] times 8) / 10^9
$

*Hisoblaş bosqiçlari:*

- Bitta kadr hajmi:
  $ M_"kadr" = 2073600 times 3 = 6220800 "bayt" approx 6.22 "MB" $
- Sekundiga maʼlumotlar oqimi (60 FPS):
  $ B_"oqim" = 6220800 times 60 = 373248000 "bayt/s" approx 373.2 "MB/s" $
- Gbit/s dagi oqim:
  $ B_"Gbit/s" = (373248000 times 8) / 10^9 approx 2.986 "Gbit/s" $
- Interfeys tahlili: GigE Vision ($1 "Gbit/s"$) yetarli emas ($2.99 "Gbit/s" > 1 "Gbit/s"$). Şuning uçun kamida USB 3.0 ($5 "Gbit/s"$) yoki 10GigE interfeysi talab etiladi.

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: videodatçik va kameralarni ulaş va sozlaş.* CMOS va RGB-D kameralarni USB 3.0 interfeysi orqali kompyuterga ulang. OpenCV yoki MATLAB muhitida video oqimni oçing.
+ *2-bosqiç: kamerani kalibrlaş (camera calibration).* Şaxmat taxtasini kameraga turli burçaklardan 15--20 marta suratga oling. Içki parametrlar matritsasi $bold(K)$ va radial distorsiya koeffitsientlarini ($k_1, k_2$) hisoblang.
+ *3-bosqiç: tasvirni qayta işlaş va konturlarni ajratiş.* Olingan kadrni BGR dan grayscale formatiga ötkazing, Gauss filtri bilan şovqinni kamaytirib, Canny / Sobel operatori yordamida detallarning çegara konturlarini (_edges_) aniqlang.
+ *4-bosqiç: stereo kameralarda disparitet va 3D masofani ölçaş.* Stereo kameradan olingan çap va öng kadrlar asosida disparitet xaritasini (_disparity map_) hosil qiling va ajratilgan obyektgaça bölgan çuqurlik $Z$ ni hisoblang.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Tajriba va hisoblaş natijalarini jamlab, amaliy hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Robototexnika va mexatronikada videodatçiklar va kompyuter körişining (_computer vision_) asosiy vazifalarini sanab bering.
+ CCD va CMOS fotoelektr matritsalarining işlaş prinsipi, signalni öqiş (_readout_) va energiya sarfi böyiça farqlarini tuşuntiring.
+ Global shutter va rolling shutter örtasidagi farq nimada va nima uçun tez harakatlanuvçi sanoat obyektlarida global shutter talab qilinadi?
+ Pinhole kamera modelida 3D fazodagi nuqta 2D tasvir tekisligiga qanday proyeksiyalanadi?
+ Kameraning içki matritsasi ($bold(K)$ --- _intrinsic matrix_) va taşqi parametrlari ($bold(R), bold(T)$) nimani ifodalaydi?
+ Kameradagi radial va tangensial distorsiya tuşunçalari va ularni dasturiy kalibrlaş usullarini ayting.
+ Stereo vision yordamida 3D çuqurlikni ($Z$) aniqlaşda disparitet va baza ($b$) parametrlari qanday rol öynaydi?
+ RGB-D çuqurlik kameralarining Time-of-Flight (ToF) va structured light texnologiyalari böyiça işlaş tamoyilini tuşuntiring.
+ Yuqori kadrlar çastotasidagi ($60+$ FPS) siqilmagan video oqim uçun talab qilinadigan ötkazuvçanlik (_bandwidth_) qanday hisoblanadi?
+ Tasvirlarni dasturiy qayta işlaşda grayscale ga ötkaziş, Gauss filtri va Canny çegara aniqlagiçining (_edge detection_) vazifasi nimadan iborat?
+ Nima uçun quyoş nuri bor oçiq maydonda (_outdoor_) IK nurga asoslangan structured light kameralari örniga stereo vision qöllaniladi?
+ Visual SLAM (_Simultaneous Localization and Mapping_) algoritmlarida videodatçiklarning tutgan örnini izohlang.
