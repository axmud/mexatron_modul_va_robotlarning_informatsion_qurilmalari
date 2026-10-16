// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot (Texnik koʻrish tizimi) — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10_tkt.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Texnik koʻrish tizimi, uning asosiy qismlari bilan tanishish")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №11]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Texnik koʻrish tizimi, uning asosiy qismlari bilan tanishish. Texnik koʻrish tizimi strukturasini tahlil qilish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatronik tizimlar, sanoat robotlari va avtomatlashtirilgan ishlab chiqarish liniyalarida qoʻllaniladigan texnik koʻrish tizimlarining (TKT / _machine vision systems_) funksional vazifalari, uning apparat va dasturiy tashkiliy qismlari (yoritish tizimi, optik obyektiv, CCD/CMOS videokamera, _frame grabber_, tasvirni qayta ishlash protsessori hamda kiritish-chiqarish interfeyslari), TKT strukturaviy arxitekturasi hamda tasvir maʼlumotlarini qabul qilish va tahlil qilish koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Texnik koʻrish tizimining robototexnikadagi oʻrni, vizual sezgi (_visual perception_) va kognitiv (_cognition_) funksiyalarini oʻrganish.
+ TKT apparat taʼminoti tarkibiy qismlarini (yoritish usullari, obyektiv, kamera matritsasi, _frame grabber_, kommunikatsiya interfeyslari) strukturaviy tahlil qilish.
+ TKT dasturiy va konseptual konveyerini (_image acquisition_ $->$ _preprocessing_ $->$ _segmentation_ $->$ _feature extraction_ $->$ _decision making / robot control_) oʻrganish.
+ Obyektivning fokus masofasi ($f$), ishchi masofa ($"WD"$), koʻrish maydoni ($"FOV"$), sensor oʻlchamlari va pikselli ajratish qobiliyati ($Delta x$) oʻrtasidagi matematik bogʻliqliklarni tahlil qilish.
+ Sanoat sifat nazorati va robotni yoʻnaltirish (_robot guidance_) boʻyicha texnik koʻrish tizimi parametrlarini hisoblash va optimallashtirish masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* texnik va kompyuter koʻrishi laboratoriya stendi, sanoat CMOS/CCD videokameralari, almashtiriladigan obyektivlar toʻplami ($f = 6, 12, 25, 50 "mm"$), modullanuvchi LED yoritish manbalari (_ring light, backlight, coaxial light, dome light_), kalibrlash uchun shaxmat taxtasi va oʻlchov namunalari.
- *Nazorat-oʻlchov va interfeys vositalari:* USB 3.0 / GigE Vision kadr ushlab qoluvchi adapterlar (_frame grabber_), lyuksmetr, raqamli ossillograf, optik skamya.
- *Dasturiy muhit:* MATLAB / Simulink (Image Processing & Computer Vision Toolbox), OpenCV (Python/C++), LabVIEW Vision Development Module, ROS 2 (image_pipeline / cv_bridge).

= Nazariy maʼlumotlar va TKT strukturaviy arxitekturasi

== Texnik koʻrish tizimi tushunchasi va robototexnikadagi oʻrni

J.J. Craig, W. Bolton va G.E. Regtien darsliklariga koʻra, *texnik koʻrish tizimi (TKT)* --- bu optik-elektron va kompyuter vositalari majmuasi boʻlib, atrofdagi 3D fazodan olingan vizual axborotni avtomatik ravishda qabul qiladi, raqamli shaklga oʻtkazadi, matematik va mantiqiy ishlov beradi hamda olingan natijalar asosida robotik ijrochi mexanizmlar uchun boshqaruv qarorlarini shakllantirib beradi. Inson koʻzidan farqli oʻlaroq, TKT sanoatda oʻta yuqori aniqlik ($1 thin mu"m"$ gacha), tezkorlik ($1000+$ FPS) va 24/7 rejimda charchamasdan oʻlchash va saralash imkonini beradi.

== Texnik koʻrish tizimining apparat tarkibiy qismlari

Texnik koʻrish tizimi 6 ta asosiy apparat qismidan tashkil topgan (@fig-tkt):

+ *Yoritish manbai va tizimi (_illumination system_):* obyekt va fon oʻrtasida maksimal kontrast hosil qiluvchi va keraksiz soyalarni yoʻqotuvchi maxsus LED yoritgichlar (_frontlight, backlight, diffuse ring light, coaxial light_).
+ *Optik obyektiv (_optical lens_):* obyektdan qaytayotgan nur oqimini yigʻib, kamera fotosensori yuzasiga aniq va distorsiyasiz fokuslab beruvchi linzalar majmuasi.
+ *Videokamera (_image sensor / camera_):* optik tasvirni piksel zaryadlariga va elektr signaliga aylantiruvchi CCD yoki CMOS matritsali datchik.
+ *Kadr ushlab qoluvchi va uzatuvchi modul (_frame grabber / bus interface_):* kameradan kelayotgan yuqori tezlikdagi analog yoki raqamli video oqimni (GigE Vision, USB 3.0, Camera Link) qabul qilib, operativ xotiraga (RAM) buferlaydi.
+ *Tasvirni qayta ishlash protsessori (_image processor / industrial PC_):* GPU, FPGA yoki koʻp yadroli CPU asosidagi hisoblash qurilmasi boʻlib, algoritmlarni (filtrlash, segmentatsiya, kontur ajratish, naqshlarni tanib olish) bajaradi.
+ *Kiritish-chiqarish va boshqaruv interfeyslari (_industrial I/O & communication_):* PLC, robot kontrolleri va pnevmoijrochilarga signal uzatuvchi raqamli kirish-chiqishlar (_digital I/O_), EtherNet/IP, PROFINET, Modbus yoki EtherCAT modullari.

== TKT obyektivi va geometriya parametrlari

Obyektivni toʻgʻri tanlash TKT da tasvir sifatini belgilovchi eng muhim bosqichdir (@tab-optics). Bu yerda $h$ --- sensorning mos yoʻnalishdagi oʻlchami, $N_x$ --- shu yoʻnalishdagi piksellar soni.

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
      [2], [*Ishchi masofa* ($"WD"$)], [$display("WD" = f dot ("FOV" / h + 1))$],
      [Obyektivdan nazorat obyektigacha boʻlgan masofa.],
      [3], [*Koʻrish maydoni* ($"FOV"$)], [$display("FOV"_x approx (h_x dot "WD") / f)$],
      [Kamera va obyektiv tasvirlay oladigan maydon (mm $times$ mm).],
      [4], [*Optik kattalashtirish* ($M$)], [$display(M = h / "FOV" = f / ("WD" - f))$],
      [Sensor oʻlchami ($h$) va $"FOV"$ nisbati.],
      [5], [*Pikselli ajratish qobiliyati*], [$display(Delta x = "FOV"_x / N_x)$ (mm/piksel)],
      [Bitta pikselga toʻgʻri keluvchi real masofa oʻlchami.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Texnik koʻrish tizimi optik-geometrik parametrlarining bogʻliqligi],
) <tab-optics>

== TKT axborotni qayta ishlash dasturiy konveyeri (_pipeline_)

Texnik koʻrish tizimida olingan kadr boʻyicha boshqaruv qarorini qabul qilish 5 bosqichli iyerarxik konveyer orqali amalga oshiriladi (@fig-pipeline):

$
  "Xom tasvir" attach(stretch(->, size: #2.2em), t: "I") "Filtrlangan tasvir" attach(stretch(->, size: #2.2em), t: "II") "Binar / segmentlangan" \
  attach(stretch(->, size: #2.2em), t: "III") "Ajratilgan xususiyatlar" attach(stretch(->, size: #2.2em), t: "IV") "Boshqaruv qarori"
$

- *I bosqich: dastlabki ishlov berish (_preprocessing_):* shovqinlarni yoʻqotish (Gauss / median filtri), kontrastni oshirish (_histogram equalization_).
- *II bosqich: segmentatsiya (_binarization & segmentation_):* Otsu algoritmi yoki chegaraviy boʻsagʻa (_thresholding_) orqali obyektni fondan ajratish.
- *III bosqich: xususiyatlarni ajratish (_feature extraction_):* konturlarni aniqlash (Canny / Sobel), obyekt yuzasi (_area_), perimetri, ogʻirlik markazi $(X_c, Y_c)$ va tasvir momentlarini hisoblash.
- *IV bosqich: obyektni tanib olish va pozitsiyani baholash (_pattern recognition & pose estimation_):* obyekt turini sinflash hamda robot tutqichi uchun pozitsiya va orientatsiyani $(X, Y, Z, theta)$ aniqlash.
- *V bosqich: ijrochi signalni shakllantirish (_action / control_):* robot kontrolleriga traektoriya koordinatasini uzatish yoki nuqsonli mahsulotni saralovchi pnevmosilindrni faollashtirish.

= Mavzuga oid chizmalar va sxemalar

== Texnik koʻrish tizimining apparat va funksional strukturasi

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

    blk((0, 2.3), [LED yoritish \ tizimi \ (ring / backlight)], yellow.lighten(75%), 1pt + orng)
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
    blk((0, -2.9), [Robot kontrolleri / \ pnevmosaralagich], blue.lighten(80%), 1pt + blue-c, w: 2.8)

    line((0, 1.65), (0, 0.65), stroke: (paint: orng, thickness: 1pt, dash: "dashed"), mark: arr(orng))
    content((0.15, 1.15), anchor: "west", text(size: 6.5pt)[Yorugʻlik oqimi])

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
  caption: [Texnik koʻrish tizimining apparat va axborot oqimlari strukturaviy sxemasi],
) <fig-tkt>

== Sanoat TKT da qoʻllaniladigan asosiy yoritish usullari

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
    )[a) Toʻgʻridan yoritish \ (frontlight)]))
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
    )[b) Orqa fonli yoritish \ (backlight)]))
    rect((s, 0), (s + 3, 0.4), fill: yellow.lighten(60%), stroke: 1pt + orng)
    content((s + 1.5, 0.2), text(size: 6pt, weight: "bold")[Yoritgich paneli])
    rect((s + 1, 0.4), (s + 2, 0.8), fill: gray.darken(40%), stroke: 1pt)
    content((s + 1.5, 0.6), text(size: 6pt, weight: "bold", fill: white)[Obyekt])
    line((s + 0.5, 0.4), (s + 0.5, 2.0), stroke: 1pt + orng, mark: arr(orng))
    line((s + 2.5, 0.4), (s + 2.5, 2.0), stroke: 1pt + orng, mark: arr(orng))
    content((s + 1.5, 1.3), text(size: 6.5pt, weight: "bold", fill: red)[Siluet])
    content((s + 1.5, 2.05), anchor: "south", text(size: 6.5pt, weight: "bold")[Kameraga])
  }),
  caption: [TKT da sirt detallarini (a) va obyekt siluetini (b) aniqlash uchun yoritish usullari],
) <fig-light>

== TKT axborotni qayta ishlash va boshqaruv qarorini qabul qilish konveyeri

#figure(
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let labels = (
      [1\. Tasvirni \ qabul qilish \ (acquisition)],
      [2\. Dastlabki \ ishlov berish \ (filtr, kontrast)],
      [3\. Segmentatsiya \ (threshold / \ Otsu)],
      [4\. Xususiyat \ ajratish (kontur, \ yuza, markaz)],
      [5\. Boshqaruv \ qarori ($X, Y, theta$ \ / brak)],
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
  caption: [Texnik koʻrish tizimida tasvir maʼlumotlarini bosqichma-bosqich qayta ishlash algoritmi],
) <fig-pipeline>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: texnik koʻrish tizimi komponentlarining qiyosiy tahlili

TKT apparat tarkibiy qismlarining vazifalari va tanlash mezonlarini tahlil qiling hamda @tab-comp ni toʻldiring.

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
      [1], [*LED yoritgich*], [Spektr (oq, IK, qizil), yoritish shakli (ring, coaxial, backlight).],
      [Fon va detal oʻrtasidagi kontrastni taʼminlaydi; segmentatsiya xatoliklarini sezilarli kamaytiradi.],
      [2], [*Optik obyektiv*], [Fokus masofasi $f$, diafragma soni $F\/\#$, distorsiya koeffitsienti.],
      [Tasvir ravshanligi va $"FOV"$ koʻrish maydonini belgilaydi.],
      [3], [*CMOS kamera*], [Matritsa ajratish qobiliyati (piksellar), FPS, zatvor turi (global / rolling).],
      [Pikselli oʻlchash aniqligini va harakatdagi obyekt tasvirining xiralashmasligini taʼminlaydi.],
      [4], [*Frame grabber*], [Oʻtkazuvchanlik (Gbit/s), interfeys (GigE Vision, USB 3.0, Camera Link).],
      [Tasvir oqimini kichik kechikish bilan ($< 1 "ms"$) RAM ga uzatishni taʼminlaydi.],
      [5], [*Tasvir protsessori*], [CPU yadrolari va chastotasi, GPU CUDA yadrolari, FPGA.],
      [Tasvirni qayta ishlash va obyektni tanib olish algoritmlari tezligini belgilaydi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Texnik koʻrish tizimi apparat qismlarining texnik koʻrsatkichlari tahlili],
) <tab-comp>

== Topshiriq 2: sanoat roboti uchun texnik koʻrish tizimini komplektlash

Sanoat manipulyatori konveyerdan oʻtayotgan turli diametrli sharikopodshipniklarni ($D = 20 dots 50 "mm"$) ushlab saralashi kerak.

- Nazorat maydoni $"FOV" = 300 "mm" times 200 "mm"$, ishchi masofa $"WD" approx 600 "mm"$.
- Oʻlchash aniqligi talabi: $Delta x <= 0.2 "mm/piksel"$.
- Konveyer tezligi $v = 0.5 "m/s"$.

*Tahlil va TKT komplektatsiyasi:*

#set enum(numbering: "a)")
+ *Kamera va matritsa tanlovi:*
  $ N_x >= 300 / 0.2 = 1500 "piksel", quad quad N_y >= 200 / 0.2 = 1000 "piksel" $
  Full HD ($1920 times 1080$, global shutter CMOS) kamera tanlanadi. Piksel oʻlchami $6.0 thin mu"m"$ deb olinsa, sensor oʻlchamlari $h_x = 11.52 "mm"$, $h_y = 6.48 "mm"$.
+ *Obyektiv fokus masofasi $f$:*
  $
    f = (h_x dot "WD") / ("FOV"_x + h_x) = (11.52 times 600) / (300 + 11.52) approx 22.19 "mm" quad => quad f_"std" = 25 "mm"
  $
  $f = 25 "mm"$ da $"WD" = 600 "mm"$ saqlansa, maydon talabdan kichik boʻladi ($"FOV"_x approx 265 "mm" < 300 "mm"$). Sensor 16:9, maydon esa 3:2 boʻlgani uchun cheklovchi oʻq --- vertikal ($y$):
  $ "WD" = f dot ("FOV"_y / h_y + 1) = 25 times (200 / 6.48 + 1) approx 797 "mm" $
  Bunda $"FOV"_x approx 356 "mm"$ va $Delta x = Delta y approx 0.185 "mm/piksel" <= 0.2$ --- talab bajariladi. ($f = 16 "mm"$ tanlansa, $Delta x approx 0.22 "mm/piksel"$ boʻlib, aniqlik talabi bajarilmaydi.)
+ *Yoritish usuli:* metall sirtdagi yaltirashni yoʻqotish uchun _diffuse coaxial LED light_ qoʻllaniladi.
+ *Ekspozitsiya vaqti:* harakat sababli xiralashish bir pikseldan oshmasligi uchun
  $ t_"exp" <= (Delta x) / v = (0.185 "mm") / (500 "mm/s") approx 0.37 "ms" $
#set enum(numbering: "1.")

= Hisoblash va modellashtirish masalalari

== Masala 1: obyektiv fokus masofasi, ishchi masofa va FOV hisobi

Sanoat TKT kamerasining fotosensor oʻlchamlari $h_x = 8.8 "mm"$, $h_y = 6.6 "mm"$ ($1\/1.8''$ sensor). Nazorat qilinayotgan texnologik maydon oʻlchamlari $"FOV"_x = 400 "mm"$, $"FOV"_y = 300 "mm"$. Kamera obyektdan $"WD" = 800 "mm"$ ishchi masofada oʻrnatilgan.

#set enum(numbering: "a)")
+ Obyektivning talab qilingan fokus masofasi $f$ (mm) ni hisoblang va eng yaqin standart obyektivni ($f_"std" in {8, 12, 16, 25, 35, 50} "mm"$) tanlang.
+ Tanlangan standart fokus masofasi $f_"std" = 16 "mm"$ boʻlgandagi yangi ishchi masofa $"WD"_"yangi"$ (mm) ni toping.
+ TKT ning optik kattalashtirish koeffitsienti $M$ ni hisoblang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$
  f = (h_x dot "WD") / ("FOV"_x + h_x), quad quad "WD"_"yangi" = f_"std" dot ("FOV"_x / h_x + 1), quad quad M = h_x / "FOV"_x
$

*Hisoblash bosqichlari:*

- Fokus masofasini hisoblash:
  $ f = (8.8 "mm" times 800 "mm") / (400 "mm" + 8.8 "mm") = 7040 / 408.8 approx 17.22 "mm" $
  Standart obyektivlar qatoridan eng yaqini $f_"std" = 16 "mm"$ tanlanadi.
- Yangi ishchi masofa $"WD"_"yangi"$ ($f_"std" = 16 "mm"$ uchun):
  $ "WD"_"yangi" = 16.0 times (400 / 8.8 + 1) = 16.0 times (45.454 + 1) = 16.0 times 46.454 approx 743.27 "mm" $
- Optik kattalashtirish $M$:
  $ M = (8.8 "mm") / (400 "mm") = 0.022 quad ("yoki" 1 : 45.45) $

== Masala 2: pikselli ajratish qobiliyati va sub-piksel defektoskopiya aniqligi hisobi

Texnik koʻrish tizimi $"FOV" = 120 "mm" times 90 "mm"$ maydonda mikrodarzlarni (_crack_) aniqlashi kerak. TKT kamerasining ajratish qobiliyati $2048 times 1536$ piksel (3.1 Mpx).

#set enum(numbering: "a)")
+ TKT ning fazoviy pikselli ajratish qobiliyati $Delta x$ ni mm/piksel va $mu$m/piksel da hisoblang.
+ Agar tasvirni qayta ishlash algoritmi $1\/4$ sub-piksel aniqlikni (_sub-pixel accuracy_) taʼminlasa, TKT oʻlchay oladigan eng kichik nuqson oʻlchami $Delta x_"sub"$ ($mu$m) qanchaga teng?
+ Uzunligi $L = 15.4 "mm"$ boʻlgan detal tasvirda necha piksel $N_"pix"$ joyni egallaydi?
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ Delta x = "FOV"_x / N_x, quad quad Delta x_"sub" = (Delta x) / 4, quad quad N_"pix" = L / (Delta x) $

*Hisoblash bosqichlari:*

- Fazoviy pikselli ajratish qobiliyati $Delta x$:
  $ Delta x = (120 "mm") / (2048 "piksel") approx 0.05859 "mm/piksel" = 58.59 thin mu"m/piksel" $
- Sub-piksel aniqligi $Delta x_"sub"$ ($1\/4$ sub-piksel):
  $ Delta x_"sub" = (58.59 thin mu"m") / 4 approx 14.65 thin mu"m" $
- Detalning piksellardagi oʻlchami $N_"pix"$:
  $ N_"pix" = (15.4 "mm") / (0.05859 "mm/piksel") approx 262.8 "piksel" $

== Masala 3: TKT video oqimi va tasvirga ishlov berish tezligi hisobi

Sanoat TKT videokamerasi $2560 times 1440$ piksel (QHD) ajratish qobiliyatida, 8 bitli grayscale formatida (1 bayt/piksel) va $120$ FPS kadrlar chastotasida ishlaydi.

#set enum(numbering: "a)")
+ Bitta kadr tasvirining xotiradagi hajmi $M_"kadr"$ (MB) ni hisoblang.
+ Kamera va frame grabber oʻrtasidagi maʼlumotlar oqimi $B_"oqim"$ ni MB/s va Gbit/s da hisoblang.
+ Tasvirni qayta ishlash algoritmi bitta kadr uchun $t_"proc" = 6.2 "ms"$ vaqt sarflaydi. TKT real vaqt rejimida barcha kadrlarni kechikishsiz qayta ishlay oladimi?
#set enum(numbering: "1.")

*Yechish va formulalar* (xotira hajmi uchun ikkilik prefiks: $1 "MB" = 2^20$ bayt; bit oqimi uchun oʻnlik prefiks: $1 "Gbit" = 10^9$ bit):

$
  M_"kadr" = (W times H times 1 "bayt") / 2^20, quad quad B_"oqim" = M_"kadr" times "FPS", quad quad t_"kadr" = (1000 "ms") / "FPS"
$

*Hisoblash bosqichlari:*

- Bitta kadr hajmi $M_"kadr"$:
  $ N_"pix" = 2560 times 1440 = 3686400 "piksel" $
  $ M_"kadr" = (3686400 "bayt") / 1048576 approx 3.516 "MB" $
- Maʼlumotlar oqimi $B_"oqim"$ (120 FPS da):
  $ B_"oqim" = 3.516 "MB" times 120 approx 421.9 "MB/s" $
  $ B_"Gbit/s" = (3686400 times 120 times 8) / 10^9 approx 3.54 "Gbit/s" $
  Demak, GigE Vision ($1 "Gbit/s"$) yetarli emas --- USB 3.0 ($5 "Gbit/s"$), 10GigE yoki CoaXPress talab etiladi.
- Real vaqt rejimini baholash:
  $ t_"kadr" = (1000 "ms") / 120 approx 8.33 "ms", quad quad t_"proc" = 6.20 "ms" $
  $t_"proc" < t_"kadr"$ ($6.2 "ms" < 8.33 "ms"$) boʻlganligi sababli, TKT real vaqt rejimida kadrlarni yoʻqotmasdan (_zero frame drop_) toʻliq qayta ishlay oladi.

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: texnik koʻrish stendini va optik tizimni yigʻish.* Videokamerani optik skamya ustiga oʻrnating, $f = 16 "mm"$ obyektivni burab kiriting va USB 3.0 / GigE kabeli orqali sanoat kompyuteriga ulang.
+ *2-bosqich: yoritish usulini va optik fokusni sozlash.* Nazorat obyekti uchun backlight va diffuse ring light yoritgichlarini navbatma-navbat qoʻllab, ikkala holatdagi tasvir kontrastini (gistogrammasini) dasturda taqqoslang.
+ *3-bosqich: TKT kamerasini kalibrlash va $Delta x$ ni aniqlash.* Kalibrlash shaxmat taxtasi (_checkerboard_) yordamida $"FOV"$ oʻlchamlarini dasturda aniqlang va pikselli ajratish qobiliyati $Delta x$ (mm/piksel) ni hisoblang.
+ *4-bosqich: tasvirni segmentatsiya qilish va konturlarni ajratish.* OpenCV / MATLAB muhitida Otsu algoritmi bilan binarizatsiya qiling, Canny filtri bilan konturlarni toping va detal ogʻirlik markazi koordinatalarini $(X_c, Y_c)$ aniqlang.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan amaliy natijalarni nazariy hisoblar bilan taqqoslab, hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Texnik koʻrish tizimining (TKT) robototexnikadagi asosiy funksional vazifalarini va afzalliklarini sanab bering.
+ TKT apparat taʼminotining 6 ta asosiy tarkibiy qismini sanang va ularning vazifalarini tushuntiring.
+ TKT da yoritish usullari (frontlight, backlight, diffuse ring light, coaxial light) bir-biridan qanday farqlanadi?
+ Obyektivning fokus masofasi ($f$), ishchi masofa ($"WD"$) va koʻrish maydoni ($"FOV"$) oʻrtasidagi matematik bogʻliqlikni izohlang.
+ CCD va CMOS videokamera matritsalarining signalni oʻqish (_readout_), tezkorlik va energiya sarfi boʻyicha farqi nimada?
+ Frame grabber (kadr ushlab qoluvchi adapter) qanday vazifani bajaradi va GigE Vision hamda USB 3.0 interfeyslarining oʻtkazuvchanligi qanday?
+ TKT tasvir maʼlumotlarini qayta ishlash konveyerining (_acquisition_ $->$ _preprocessing_ $->$ _segmentation_ $->$ _feature extraction_ $->$ _decision_) 5 bosqichini tushuntiring.
+ Pikselli ajratish qobiliyati ($Delta x$) va sub-piksel aniqlik (_sub-pixel accuracy_) nimani anglatadi?
+ Global shutter va rolling shutter zatvor mexanizmlarining harakatlanayotgan sanoat obyektlari tasviriga taʼsiri qanday?
+ Otsu binarizatsiya algoritmi va Canny kontur aniqlash operatorining TKT dagi roli nimadan iborat?
+ TKT real vaqt rejimida ishlashi uchun kadrlar kelish vaqti ($t_"kadr"$) va algoritm vaqti ($t_"proc"$) oʻrtasida qanday shart bajarilishi kerak?
+ Sanoat manipulyatorini 3D yoʻnaltirishda (_robot guidance_) stereo vision va TKT ning birga qoʻllanilish afzalliklarini izohlang.
