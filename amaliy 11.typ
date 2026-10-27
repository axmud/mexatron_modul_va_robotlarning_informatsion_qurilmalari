// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot (Texnik koʻrish tizimi) — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10_tkt.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Texnik köriş tizimi, uning asosiy qismlari bilan tanişiş")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 11  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №11]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Texnik köriş tizimi, uning asosiy qismlari bilan tanişiş. Texnik köriş tizimi strukturasini tahlil qiliş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatronik tizimlar, sanoat robotlari va avtomatlaştirilgan işlab çiqariş liniyalarida qöllaniladigan texnik köriş tizimlarining (TKT / _machine vision systems_) funksional vazifalari, uning apparat va dasturiy taşkiliy qismlari (yoritiş tizimi, optik obyektiv, CCD/CMOS videokamera, _frame grabber_, tasvirni qayta işlaş protsessori hamda kiritiş-çiqariş interfeyslari), TKT strukturaviy arxitekturasi hamda tasvir maʼlumotlarini qabul qiliş va tahlil qiliş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Texnik köriş tizimining robototexnikadagi örni, vizual sezgi (_visual perception_) va kognitiv (_cognition_) funksiyalarini örganiş.
+ TKT apparat taʼminoti tarkibiy qismlarini (yoritiş usullari, obyektiv, kamera matritsasi, _frame grabber_, kommunikatsiya interfeyslari) strukturaviy tahlil qiliş.
+ TKT dasturiy va konseptual konveyerini (_image acquisition_ $->$ _preprocessing_ $->$ _segmentation_ $->$ _feature extraction_ $->$ _decision making / robot control_) örganiş.
+ Obyektivning fokus masofasi ($f$), işçi masofa ($"WD"$), köriş maydoni ($"FOV"$), sensor ölçamlari va pikselli ajratiş qobiliyati ($Delta x$) örtasidagi matematik boğliqliklarni tahlil qiliş.
+ Sanoat sifat nazorati va robotni yönaltiriş (_robot guidance_) böyiça texnik köriş tizimi parametrlarini hisoblaş va optimallaştiriş masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* texnik va kompyuter körişi laboratoriya stendi, sanoat CMOS/CCD videokameralari, almaştiriladigan obyektivlar töplami ($f = 6, 12, 25, 50 "mm"$), modullanuvçi LED yoritiş manbalari (_ring light, backlight, coaxial light, dome light_), kalibrlaş uçun şaxmat taxtasi va ölçov namunalari.
- *Nazorat-ölçov va interfeys vositalari:* USB 3.0 / GigE Vision kadr uşlab qoluvçi adapterlar (_frame grabber_), lyuksmetr, raqamli ossillograf, optik skamya.
- *Dasturiy muhit:* MATLAB / Simulink (Image Processing & Computer Vision Toolbox), OpenCV (Python/C++), LabVIEW Vision Development Module, ROS 2 (image_pipeline / cv_bridge).

= Nazariy maʼlumotlar va TKT strukturaviy arxitekturasi

== Texnik köriş tizimi tuşunçasi va robototexnikadagi örni

J.J. Craig, W. Bolton va G.E. Regtien darsliklariga köra, *texnik köriş tizimi (TKT)* --- bu optik-elektron va kompyuter vositalari majmuasi bölib, atrofdagi 3D fazodan olingan vizual axborotni avtomatik ravişda qabul qiladi, raqamli şaklga ötkazadi, matematik va mantiqiy işlov beradi hamda olingan natijalar asosida robotik ijroçi mexanizmlar uçun boşqaruv qarorlarini şakllantirib beradi. Inson közidan farqli ölaroq, TKT sanoatda öta yuqori aniqlik ($1 thin mu"m"$ gaça), tezkorlik ($1000+$ FPS) va 24/7 rejimda çarçamasdan ölçaş va saralaş imkonini beradi.

== Texnik köriş tizimining apparat tarkibiy qismlari

Texnik köriş tizimi 6 ta asosiy apparat qismidan taşkil topgan (@fig-tkt):

+ *Yoritiş manbai va tizimi (_illumination system_):* obyekt va fon örtasida maksimal kontrast hosil qiluvçi va keraksiz soyalarni yöqotuvçi maxsus LED yoritgiçlar (_frontlight, backlight, diffuse ring light, coaxial light_).
+ *Optik obyektiv (_optical lens_):* obyektdan qaytayotgan nur oqimini yiğib, kamera fotosensori yuzasiga aniq va distorsiyasiz fokuslab beruvçi linzalar majmuasi.
+ *Videokamera (_image sensor / camera_):* optik tasvirni piksel zaryadlariga va elektr signaliga aylantiruvçi CCD yoki CMOS matritsali datçik.
+ *Kadr uşlab qoluvçi va uzatuvçi modul (_frame grabber / bus interface_):* kameradan kelayotgan yuqori tezlikdagi analog yoki raqamli video oqimni (GigE Vision, USB 3.0, Camera Link) qabul qilib, operativ xotiraga (RAM) buferlaydi.
+ *Tasvirni qayta işlaş protsessori (_image processor / industrial PC_):* GPU, FPGA yoki köp yadroli CPU asosidagi hisoblaş qurilmasi bölib, algoritmlarni (filtrlaş, segmentatsiya, kontur ajratiş, naqşlarni tanib oliş) bajaradi.
+ *Kiritiş-çiqariş va boşqaruv interfeyslari (_industrial I/O & communication_):* PLC, robot kontrolleri va pnevmoijroçilarga signal uzatuvçi raqamli kiriş-çiqişlar (_digital I/O_), EtherNet/IP, PROFINET, Modbus yoki EtherCAT modullari.

== TKT obyektivi va geometriya parametrlari

Obyektivni töğri tanlaş TKT da tasvir sifatini belgilovçi eng muhim bosqiçdir (@tab-optics). Bu yerda $h$ --- sensorning mos yönalişdagi ölçami, $N_x$ --- şu yönalişdagi piksellar soni.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.3cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, center + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 6pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Optik parametr*], [*Matematik \ formulasi*], [*Fizik maʼnosi \ va taʼsiri*]),
      table.hline(stroke: 0.5pt),
      [1], [*Fokus masofasi* ($f$)], [$display(f = (h dot "WD") / ("FOV" + h) approx (h dot "WD") / "FOV")$],
      [Obyektiv optik markazi va fotosensor orasidagi masofa (mm).],
      [2], [*Işçi masofa* ($"WD"$)], [$display("WD" = f dot ("FOV" / h + 1))$],
      [Obyektivdan nazorat obyektigaça bölgan masofa.],
      [3], [*Köriş maydoni* ($"FOV"$)], [$display("FOV"_x approx (h_x dot "WD") / f)$],
      [Kamera va obyektiv tasvirlay oladigan maydon (mm $times$ mm).],
      [4], [*Optik kattalaştiriş* ($M$)], [$display(M = h / "FOV" = f / ("WD" - f))$],
      [Sensor ölçami ($h$) va $"FOV"$ nisbati.],
      [5], [*Pikselli ajratiş qobiliyati*], [$display(Delta x = "FOV"_x / N_x)$ (mm/piksel)],
      [Bitta pikselga töğri keluvçi real masofa ölçami.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Texnik köriş tizimi optik-geometrik parametrlarining boğliqligi],
) <tab-optics>

== TKT axborotni qayta işlaş dasturiy konveyeri (_pipeline_)

Texnik köriş tizimida olingan kadr böyiça boşqaruv qarorini qabul qiliş 5 bosqiçli iyerarxik konveyer orqali amalga oşiriladi (@fig-pipeline):

$
  "Xom tasvir" attach(stretch(->, size: #2.2em), t: "I") "Filtrlangan tasvir" attach(stretch(->, size: #2.2em), t: "II") "Binar / segmentlangan" \
  attach(stretch(->, size: #2.2em), t: "III") "Ajratilgan xususiyatlar" attach(stretch(->, size: #2.2em), t: "IV") "Boşqaruv qarori"
$

- *I bosqiç: dastlabki işlov beriş (_preprocessing_):* şovqinlarni yöqotiş (Gauss / median filtri), kontrastni oşiriş (_histogram equalization_).
- *II bosqiç: segmentatsiya (_binarization & segmentation_):* Otsu algoritmi yoki çegaraviy bösağa (_thresholding_) orqali obyektni fondan ajratiş.
- *III bosqiç: xususiyatlarni ajratiş (_feature extraction_):* konturlarni aniqlaş (Canny / Sobel), obyekt yuzasi (_area_), perimetri, oğirlik markazi $(X_c, Y_c)$ va tasvir momentlarini hisoblaş.
- *IV bosqiç: obyektni tanib oliş va pozitsiyani baholaş (_pattern recognition & pose estimation_):* obyekt turini sinflaş hamda robot tutqiçi uçun pozitsiya va orientatsiyani $(X, Y, Z, theta)$ aniqlaş.
- *V bosqiç: ijroçi signalni şakllantiriş (_action / control_):* robot kontrolleriga traektoriya koordinatasini uzatiş yoki nuqsonli mahsulotni saralovçi pnevmosilindrni faollaştiriş.

= Mavzuga oid çizmalar va sxemalar

== Texnik köriş tizimining apparat va funksional strukturasi

#figure(
  cetz.canvas(length: 0.88cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let blk(c, body, fill, stroke, w: 2.4, h: 1.3, size: 7pt) = {
      rect(
        (c.at(0) - w / 2, c.at(1) - h / 2),
        (c.at(0) + w / 2, c.at(1) + h / 2),
        fill: fill,
        stroke: stroke,
        radius: 0.12,
      )
      content(c, align(center, text(size: size, weight: "bold", body)))
    }
    let arr(c) = (end: "stealth", fill: c)

    blk((0, 2.3), [LED yoritiş \ tizimi \ (ring / backlight)], yellow.lighten(75%), 1pt + orng)
    blk((0, 0), [Nazorat obyekti \ (konveyer / detal)], red.lighten(88%), 1pt + red)
    blk((3.6, 0), [Optik obyektiv \ ($f$, WD, FOV)], blue.lighten(93%), 1pt + blue-c)
    blk((7.2, 0), [CCD / CMOS \ videokamera], blue.lighten(93%), 1pt + blue-c)
    blk((10.8, 0), [Frame grabber \ (GigE / USB 3.0)], blue.lighten(93%), 1pt + blue-c)
    blk(
      (7.2, -2.9),
      [TKT SANOAT KOMPYUTERI / PROTSESSORI \ (OpenCV / LabVIEW / MATLAB) \ segmentatsiya, kontur, 3D pozitsiya],
      orange.lighten(85%),
      1pt + orng,
      w: 6.4,
      h: 1.5,
      size: 6.5pt,
    )
    blk((0, -2.9), [Robot kontrolleri / \ pnevmosaralagiç], blue.lighten(80%), 1pt + blue-c, w: 2.8)

    line((0, 1.65), (0, 0.65), stroke: (paint: orng, thickness: 1pt, dash: "dashed"), mark: arr(orng))
    content((0.15, 1.15), anchor: "west", text(size: 6.5pt)[Yoruğlik oqimi])

    line((1.2, 0), (2.4, 0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((1.8, 0.1), anchor: "south", text(size: 6pt)[Optik \ tasvir])
    line((4.8, 0), (6.0, 0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((5.4, 0.1), anchor: "south", text(size: 6pt)[Fokus- \ langan])
    line((8.4, 0), (9.6, 0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((9.0, 0.1), anchor: "south", text(size: 6pt)[Raw \ video])

    line((10.8, -0.65), (10.8, -2.9), (10.4, -2.9), stroke: 1pt + blue-c, mark: arr(blue-c))
    line((4.0, -2.9), (1.4, -2.9), stroke: 1pt + orng, mark: arr(orng))
    content((2.7, -2.8), anchor: "south", text(size: 6pt, weight: "bold")[Digital I/O \ EtherCAT])
  }),
  caption: [Texnik köriş tizimining apparat va axborot oqimlari strukturaviy sxemasi],
) <fig-tkt>

== Sanoat TKT da qöllaniladigan asosiy yoritiş usullari

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let arr(c) = (end: "stealth", fill: c)

    // ---- a) Frontlight ----
    content((1.5, 2.9), align(center, text(
      size: 8pt,
      weight: "bold",
      fill: blue-c,
    )[a) Töğridan yoritiş \ (frontlight)]))
    rect((0, 0), (3, 0.4), fill: gray.lighten(80%), stroke: 1pt)
    content((1.5, 0.2), text(size: 6.5pt, weight: "bold")[Obyekt])
    for p in ((0.3, 1.5), (2.7, 1.5)) {
      circle(p, radius: 0.28, fill: yellow.lighten(60%), stroke: 1pt + orng)
      content(p, text(size: 5pt, weight: "bold")[LED])
    }
    line((0.45, 1.25), (1.0, 0.42), stroke: 1pt + orng, mark: arr(orng))
    line((2.55, 1.25), (2.0, 0.42), stroke: 1pt + orng, mark: arr(orng))
    line((1.5, 0.4), (1.5, 2.0), stroke: 1pt + blue-c, mark: arr(blue-c))
    content((1.5, 2.05), anchor: "south", text(size: 6.5pt, weight: "bold")[Kameraga])

    // ---- b) Backlight ----
    let s = 7.0
    content((s + 1.5, 2.9), align(center, text(
      size: 8pt,
      weight: "bold",
      fill: blue-c,
    )[b) Orqa fonli yoritiş \ (backlight)]))
    rect((s, 0), (s + 3, 0.4), fill: yellow.lighten(60%), stroke: 1pt + orng)
    content((s + 1.5, 0.2), text(size: 6pt, weight: "bold")[Yoritgiç paneli])
    rect((s + 1, 0.4), (s + 2, 0.8), fill: gray.darken(40%), stroke: 1pt)
    content((s + 1.5, 0.6), text(size: 6pt, weight: "bold", fill: white)[Obyekt])
    line((s + 0.5, 0.4), (s + 0.5, 2.0), stroke: 1pt + orng, mark: arr(orng))
    line((s + 2.5, 0.4), (s + 2.5, 2.0), stroke: 1pt + orng, mark: arr(orng))
    content((s + 1.5, 1.3), text(size: 6.5pt, weight: "bold", fill: red)[Siluet])
    content((s + 1.5, 2.05), anchor: "south", text(size: 6.5pt, weight: "bold")[Kameraga])
  }),
  caption: [TKT da sirt detallarini (a) va obyekt siluetini (b) aniqlaş uçun yoritiş usullari],
) <fig-light>

== TKT axborotni qayta işlaş va boşqaruv qarorini qabul qiliş konveyeri

#figure(
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let labels = (
      [1\. Tasvirni \ qabul qiliş \ (acquisition)],
      [2\. Dastlabki \ işlov beriş \ (filtr, kontrast)],
      [3\. Segmentatsiya \ (threshold / \ Otsu)],
      [4\. Xususiyat \ ajratiş (kontur, \ yuza, markaz)],
      [5\. Boşqaruv \ qarori ($X, Y, theta$ \ / brak)],
    )
    for (i, lab) in labels.enumerate() {
      let x = i * 3.2
      let last = i == labels.len() - 1
      rect(
        (x - 1.35, -0.75),
        (x + 1.35, 0.75),
        fill: if last { orange.lighten(85%) } else { blue.lighten(93%) },
        stroke: 1pt + if last { orng } else { blue-c },
        radius: 0.12,
      )
      content((x, 0), align(center, text(size: 6.5pt, weight: "bold", lab)))
      if i > 0 {
        let c = if last { orng } else { blue-c }
        line((x - 1.85, 0), (x - 1.35, 0), stroke: 1pt + c, mark: (end: "stealth", fill: c))
      }
    }
  }),
  caption: [Texnik köriş tizimida tasvir maʼlumotlarini bosqiçma-bosqiç qayta işlaş algoritmi],
) <fig-pipeline>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: texnik köriş tizimi komponentlarining qiyosiy tahlili

TKT apparat tarkibiy qismlarining vazifalari va tanlaş mezonlarini tahlil qiling hamda @tab-comp ni töldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 2.8cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*№*], [*TKT \ komponenti*], [*Asosiy texnik \ parametrlari*], [*Tizim aniqligi va \ tezligiga taʼsiri*]
      ),
      table.hline(stroke: 0.5pt),
      [1], [*LED yoritgiç*], [Spektr (oq, IK, qizil), yoritiş şakli (ring, coaxial, backlight).],
      [Fon va detal örtasidagi kontrastni taʼminlaydi; segmentatsiya xatoliklarini sezilarli kamaytiradi.],
      [2], [*Optik obyektiv*], [Fokus masofasi $f$, diafragma soni $F\/\#$, distorsiya koeffitsienti.],
      [Tasvir ravşanligi va $"FOV"$ köriş maydonini belgilaydi.],
      [3], [*CMOS kamera*], [Matritsa ajratiş qobiliyati (piksellar), FPS, zatvor turi (global / rolling).],
      [Pikselli ölçaş aniqligini va harakatdagi obyekt tasvirining xiralaşmasligini taʼminlaydi.],
      [4], [*Frame grabber*], [Ötkazuvçanlik (Gbit/s), interfeys (GigE Vision, USB 3.0, Camera Link).],
      [Tasvir oqimini kiçik keçikiş bilan ($< 1 "ms"$) RAM ga uzatişni taʼminlaydi.],
      [5], [*Tasvir protsessori*], [CPU yadrolari va çastotasi, GPU CUDA yadrolari, FPGA.],
      [Tasvirni qayta işlaş va obyektni tanib oliş algoritmlari tezligini belgilaydi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Texnik köriş tizimi apparat qismlarining texnik körsatkiçlari tahlili],
) <tab-comp>

== Topşiriq 2: sanoat roboti uçun texnik köriş tizimini komplektlaş

Sanoat manipulyatori konveyerdan ötayotgan turli diametrli şarikopodşipniklarni ($D = 20 dots 50 "mm"$) uşlab saralaşi kerak.

- Nazorat maydoni $"FOV" = 300 "mm" times 200 "mm"$, işçi masofa $"WD" approx 600 "mm"$.
- Ölçaş aniqligi talabi: $Delta x <= 0.2 "mm/piksel"$.
- Konveyer tezligi $v = 0.5 "m/s"$.

*Tahlil va TKT komplektatsiyasi:*

#set enum(numbering: "a)")
+ *Kamera va matritsa tanlovi:*
  $ N_x >= 300 / 0.2 = 1500 "piksel", quad quad N_y >= 200 / 0.2 = 1000 "piksel" $
  Full HD ($1920 times 1080$, global shutter CMOS) kamera tanlanadi. Piksel ölçami $6.0 thin mu"m"$ deb olinsa, sensor ölçamlari $h_x = 11.52 "mm"$, $h_y = 6.48 "mm"$.
+ *Obyektiv fokus masofasi $f$:*
  $
    f = (h_x dot "WD") / ("FOV"_x + h_x) = (11.52 times 600) / (300 + 11.52) approx 22.19 "mm" quad => quad f_"std" = 25 "mm"
  $
  $f = 25 "mm"$ da $"WD" = 600 "mm"$ saqlansa, maydon talabdan kiçik böladi ($"FOV"_x approx 265 "mm" < 300 "mm"$). Sensor 16:9, maydon esa 3:2 bölgani uçun çeklovçi öq --- vertikal ($y$):
  $ "WD" = f dot ("FOV"_y / h_y + 1) = 25 times (200 / 6.48 + 1) approx 797 "mm" $
  Bunda $"FOV"_x approx 356 "mm"$ va $Delta x = Delta y approx 0.185 "mm/piksel" <= 0.2$ --- talab bajariladi. ($f = 16 "mm"$ tanlansa, $Delta x approx 0.22 "mm/piksel"$ bölib, aniqlik talabi bajarilmaydi.)
+ *Yoritiş usuli:* metall sirtdagi yaltiraşni yöqotiş uçun _diffuse coaxial LED light_ qöllaniladi.
+ *Ekspozitsiya vaqti:* harakat sababli xiralaşiş bir pikseldan oşmasligi uçun
  $ t_"exp" <= (Delta x) / v = (0.185 "mm") / (500 "mm/s") approx 0.37 "ms" $
#set enum(numbering: "1.")

= Hisoblaş va modellaştiriş masalalari

== Masala 1: obyektiv fokus masofasi, işçi masofa va FOV hisobi

Sanoat TKT kamerasining fotosensor ölçamlari $h_x = 8.8 "mm"$, $h_y = 6.6 "mm"$ ($1\/1.8''$ sensor). Nazorat qilinayotgan texnologik maydon ölçamlari $"FOV"_x = 400 "mm"$, $"FOV"_y = 300 "mm"$. Kamera obyektdan $"WD" = 800 "mm"$ işçi masofada örnatilgan.

#set enum(numbering: "a)")
+ Obyektivning talab qilingan fokus masofasi $f$ (mm) ni hisoblang va eng yaqin standart obyektivni ($f_"std" in {8, 12, 16, 25, 35, 50} "mm"$) tanlang.
+ Tanlangan standart fokus masofasi $f_"std" = 16 "mm"$ bölgandagi yangi işçi masofa $"WD"_"yangi"$ (mm) ni toping.
+ TKT ning optik kattalaştiriş koeffitsienti $M$ ni hisoblang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$
  f = (h_x dot "WD") / ("FOV"_x + h_x), quad quad "WD"_"yangi" = f_"std" dot ("FOV"_x / h_x + 1), quad quad M = h_x / "FOV"_x
$

*Hisoblaş bosqiçlari:*

- Fokus masofasini hisoblaş:
  $ f = (8.8 "mm" times 800 "mm") / (400 "mm" + 8.8 "mm") = 7040 / 408.8 approx 17.22 "mm" $
  Standart obyektivlar qatoridan eng yaqini $f_"std" = 16 "mm"$ tanlanadi.
- Yangi işçi masofa $"WD"_"yangi"$ ($f_"std" = 16 "mm"$ uçun):
  $ "WD"_"yangi" = 16.0 times (400 / 8.8 + 1) = 16.0 times (45.454 + 1) =\ 16.0 times 46.454 approx 743.27 "mm" $
- Optik kattalaştiriş $M$:
  $ M = (8.8 "mm") / (400 "mm") = 0.022 quad ("yoki" 1 : 45.45) $

== Masala 2: pikselli ajratiş qobiliyati va sub-piksel defektoskopiya aniqligi hisobi

Texnik köriş tizimi $"FOV" = 120 "mm" times 90 "mm"$ maydonda mikrodarzlarni (_crack_) aniqlaşi kerak. TKT kamerasining ajratiş qobiliyati $2048 times 1536$ piksel (3.1 Mpx).

#set enum(numbering: "a)")
+ TKT ning fazoviy pikselli ajratiş qobiliyati $Delta x$ ni mm/piksel va $mu$m/piksel da hisoblang.
+ Agar tasvirni qayta işlaş algoritmi $1\/4$ sub-piksel aniqlikni (_sub-pixel accuracy_) taʼminlasa, TKT ölçay oladigan eng kiçik nuqson ölçami $Delta x_"sub"$ ($mu$m) qançaga teng?
+ Uzunligi $L = 15.4 "mm"$ bölgan detal tasvirda neça piksel $N_"pix"$ joyni egallaydi?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ Delta x = "FOV"_x / N_x, quad quad Delta x_"sub" = (Delta x) / 4, quad quad N_"pix" = L / (Delta x) $

*Hisoblaş bosqiçlari:*

- Fazoviy pikselli ajratiş qobiliyati $Delta x$:
  $ Delta x = (120 "mm") / (2048 "piksel") approx 0.05859 "mm/piksel" = 58.59 thin mu"m/piksel" $
- Sub-piksel aniqligi $Delta x_"sub"$ ($1\/4$ sub-piksel):
  $ Delta x_"sub" = (58.59 thin mu"m") / 4 approx 14.65 thin mu"m" $
- Detalning piksellardagi ölçami $N_"pix"$:
  $ N_"pix" = (15.4 "mm") / (0.05859 "mm/piksel") approx 262.8 "piksel" $

== Masala 3: TKT video oqimi va tasvirga işlov beriş tezligi hisobi

Sanoat TKT videokamerasi $2560 times 1440$ piksel (QHD) ajratiş qobiliyatida, 8 bitli grayscale formatida (1 bayt/piksel) va $120$ FPS kadrlar çastotasida işlaydi.

#set enum(numbering: "a)")
+ Bitta kadr tasvirining xotiradagi hajmi $M_"kadr"$ (MB) ni hisoblang.
+ Kamera va frame grabber örtasidagi maʼlumotlar oqimi $B_"oqim"$ ni MB/s va Gbit/s da hisoblang.
+ Tasvirni qayta işlaş algoritmi bitta kadr uçun $t_"proc" = 6.2 "ms"$ vaqt sarflaydi. TKT real vaqt rejimida barça kadrlarni keçikişsiz qayta işlay oladimi?
#set enum(numbering: "1.")

*Yeçiş va formulalar* (xotira hajmi uçun ikkilik prefiks: $1 "MB" = 2^20$ bayt; bit oqimi uçun önlik prefiks: $1 "Gbit" = 10^9$ bit):

$
  M_"kadr" = (W times H times 1 "bayt") / 2^20, quad quad B_"oqim" = M_"kadr" times "FPS", quad quad t_"kadr" = (1000 "ms") / "FPS"
$

*Hisoblaş bosqiçlari:*

- Bitta kadr hajmi $M_"kadr"$:
  $ N_"pix" = 2560 times 1440 = 3686400 "piksel" $
  $ M_"kadr" = (3686400 "bayt") / 1048576 approx 3.516 "MB" $
- Maʼlumotlar oqimi $B_"oqim"$ (120 FPS da):
  $ B_"oqim" = 3.516 "MB" times 120 approx 421.9 "MB/s" $
  $ B_"Gbit/s" = (3686400 times 120 times 8) / 10^9 approx 3.54 "Gbit/s" $
  Demak, GigE Vision ($1 "Gbit/s"$) yetarli emas --- USB 3.0 ($5 "Gbit/s"$), 10GigE yoki CoaXPress talab etiladi.
- Real vaqt rejimini baholaş:
  $ t_"kadr" = (1000 "ms") / 120 approx 8.33 "ms", quad quad t_"proc" = 6.20 "ms" $
  $t_"proc" < t_"kadr"$ ($6.2 "ms" < 8.33 "ms"$) bölganligi sababli, TKT real vaqt rejimida kadrlarni yöqotmasdan (_zero frame drop_) töliq qayta işlay oladi.

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: texnik köriş stendini va optik tizimni yiğiş.* Videokamerani optik skamya ustiga örnating, $f = 16 "mm"$ obyektivni burab kiriting va USB 3.0 / GigE kabeli orqali sanoat kompyuteriga ulang.
+ *2-bosqiç: yoritiş usulini va optik fokusni sozlaş.* Nazorat obyekti uçun backlight va diffuse ring light yoritgiçlarini navbatma-navbat qöllab, ikkala holatdagi tasvir kontrastini (gistogrammasini) dasturda taqqoslang.
+ *3-bosqiç: TKT kamerasini kalibrlaş va $Delta x$ ni aniqlaş.* Kalibrlaş şaxmat taxtasi (_checkerboard_) yordamida $"FOV"$ ölçamlarini dasturda aniqlang va pikselli ajratiş qobiliyati $Delta x$ (mm/piksel) ni hisoblang.
+ *4-bosqiç: tasvirni segmentatsiya qiliş va konturlarni ajratiş.* OpenCV / MATLAB muhitida Otsu algoritmi bilan binarizatsiya qiling, Canny filtri bilan konturlarni toping va detal oğirlik markazi koordinatalarini $(X_c, Y_c)$ aniqlang.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan amaliy natijalarni nazariy hisoblar bilan taqqoslab, hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Texnik köriş tizimining (TKT) robototexnikadagi asosiy funksional vazifalarini va afzalliklarini sanab bering.
+ TKT apparat taʼminotining 6 ta asosiy tarkibiy qismini sanang va ularning vazifalarini tuşuntiring.
+ TKT da yoritiş usullari (frontlight, backlight, diffuse ring light, coaxial light) bir-biridan qanday farqlanadi?
+ Obyektivning fokus masofasi ($f$), işçi masofa ($"WD"$) va köriş maydoni ($"FOV"$) örtasidagi matematik boğliqlikni izohlang.
+ CCD va CMOS videokamera matritsalarining signalni öqiş (_readout_), tezkorlik va energiya sarfi böyiça farqi nimada?
+ Frame grabber (kadr uşlab qoluvçi adapter) qanday vazifani bajaradi va GigE Vision hamda USB 3.0 interfeyslarining ötkazuvçanligi qanday?
+ TKT tasvir maʼlumotlarini qayta işlaş konveyerining (_acquisition_ $->$ _preprocessing_ $->$ _segmentation_ $->$ _feature extraction_ $->$ _decision_) 5 bosqiçini tuşuntiring.
+ Pikselli ajratiş qobiliyati ($Delta x$) va sub-piksel aniqlik (_sub-pixel accuracy_) nimani anglatadi?
+ Global shutter va rolling shutter zatvor mexanizmlarining harakatlanayotgan sanoat obyektlari tasviriga taʼsiri qanday?
+ Otsu binarizatsiya algoritmi va Canny kontur aniqlaş operatorining TKT dagi roli nimadan iborat?
+ TKT real vaqt rejimida işlaşi uçun kadrlar keliş vaqti ($t_"kadr"$) va algoritm vaqti ($t_"proc"$) örtasida qanday şart bajarilişi kerak?
+ Sanoat manipulyatorini 3D yönaltirişda (_robot guidance_) stereo vision va TKT ning birga qöllaniliş afzalliklarini izohlang.
