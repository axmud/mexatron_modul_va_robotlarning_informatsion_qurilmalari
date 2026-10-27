// ============================================================
//  MMRIQ — 4-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_4.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Mexatron modullar va robotlarning metrologik tavsiflari bilan tanişiş")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 4  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №4]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Mexatron modullar va robotlarning metrologik tavsiflari bilan tanişiş]

  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatronik modullar, datçiklar va robotik manipulyatorlarning metrologik tavsiflari (statik va dinamik xarakteristikalar), aniqlik mezonlari, xatoliklar nazariyasi hamda ISO 9283 standarti böyiça robotlarning pozitsion metrologik körsatkiçlarini baholaş va hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Mexatron modul va datçiklarning statik metrologik tavsiflarini (sezgirlik, aniqlik, takrorlanuvçanlik, çiziqlilik, gisterezis, ölik zona, ajratiş qobiliyati) örganiş.
+ Datçik va ölçov tizimlarining dinamik tavsiflarini (0-, 1- va 2-tartibli tizimlar, vaqt doimiysi $tau$, ötkaziş polosasi, amplituda-faza çastota xarakteristikasi) tahlil qiliş.
+ ISO 9283 xalqaro standartiga muvofiq sanoat robotlarining pozitsion va trayektoriyaviy metrologik mezonlarini ($A P$ --- Pose Accuracy, $R P$ --- Pose Repeatability, $A D$ --- Distance Accuracy, $R D$ --- Distance Repeatability) örganiş.
+ Ölçaş xatoliklarining turlarini (sistematik, tasodifiy, qöpol) aniqlaş va statistik matematik qayta işlaş usullarini qöllaş.
+ Sensorlar va sanoat robotlarining metrologik parametrlarini tajriba hamda hisoblaş masalalari yordamida baholaş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* metrologik sifatni sinaş va kalibrlaş laboratoriya stendi, datçiklarni kalibrlaş moslamasi (mikrometrli optik skamya), harorat va bosim kalibratorlari.
- *Sensor va ölçov vositalari:* LVDT çiziqli siljiş datçigi, optik va magnit enkoderlar, tenzometrik oğirlik sensori, lazer interferometr / lazer treker ölçov tizimi, raqamli ossillograf va multimetr.
- *Robotik stend:* 6-DoF sanoat roboti (KUKA / ABB / Fanuc) öquv maketi va Teach Pendant.
- *Dasturiy muhit:* MATLAB / Simulink (System Identification Toolbox), LabVIEW metrologiya moduli, Python (SciPy / NumPy) statistik tahlil vositalari.

= Nazariy maʼlumotlar va metrologik tavsiflar klassifikatsiyasi

== Metrologiya va metrologik tavsif tuşunçasi

*Metrologiya* --- ölçaşlar, ularning birligini taʼminlaş usullari va vositalari hamda talab qilingan aniqlikka erişiş yöllari haqidagi fandir. Mexatronika va robototexnikada informatsion qurilmalarning *metrologik tavsifi* deb ölçaş natijalariga va ölçaş xatoliklariga taʼsir etuvçi, hujjatlaştirilgan ölçov vositasi xossalariga aytiladi.

P.P.L. Regtien va W. Bolton darsliklariga köra, mexatron modul datçiklarining metrologik tavsiflari ikkita katta guruhga bölinadi:

+ *Statik metrologik tavsiflar:* ölçanayotgan fizik kattalik vaqt böyiça özgarmaganda yoki öta sekin özgarganda namoyon böladigan xarakteristikalar.
+ *Dinamik metrologik tavsiflar:* ölçanayotgan kattalik vaqt böyiça tez özgarganda datçikning impuls yoki çastotaviy reaksiyasini belgilovçi xarakteristikalar.

== Datçiklarning statik metrologik tavsiflari

Datçiklarning asosiy statik metrologik körsatkiçlari quyidagilardan iborat (@tab-static):

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.3cm, 4.3cm, 1fr),
      align: (center + horizon, left + horizon, center + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 6pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Metrologik tavsif*], [*Matematik ifodasi / taʼrifi*], [*Fizik maʼnosi va taʼsiri*]),
      table.hline(stroke: 0.5pt),
      [1], [*Sezgirlik* (Sensitivity)], [$S = (d Y) / (d X) approx (Delta Y) / (Delta X)$],
      [Kiriş kattaligi $Delta X$ ga özgarganda çiqiş signali $Y$ ning özgariş nisbati.],
      [2], [*Çiziqlilik* (Linearity)], [$delta_"lin" = (Delta Y_"max") / Y_"FS" times 100%$],
      [Real ötiş tavsifining ideal töğri çiziqdan maksimal oğiş foizi.],
      [3], [*Gisterezis* (Hysteresis)], [$H_"max" = max |Y_"töğri" - Y_"teskari"|$],
      [Kiriş kattaligi ortişi va kamayişida çiqiş signallari farqi.],
      [4], [*Ajratiş qobiliyati* (Resolution)], [$Delta X_"min"$],
      [Datçik sezadigan va ajrata oladigan eng kiçik kiriş özgarişi.],
      [5], [*Ölik zona* (Dead Band)], [$X_"dead"$],
      [Çiqiş signalida heç qanday özgariş hosil qilmaydigan kiriş oraliği.],
      [6], [*Aniqlik* (Accuracy)], [$E_"rel" = (|X_"ölçov" - X_"haqiqiy"|) / X_"haqiqiy"$],
      [Ölçaş natijasining haqiqiy qiymatga yaqinlik darajasi.],
      [7], [*Takrorlanuvçanlik* (Repeatability)], [$sigma = sqrt(1 / (N - 1) sum (x_i - macron(x))^2)$],
      [Bir xil şaroitda qayta ölçaşlar natijalarining bir-biriga mosligi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatron modul datçiklarining statik metrologik tavsiflari],
) <tab-static>

== Datçiklarning dinamik metrologik tavsiflari

Datçikning dinamik xulq-atvori differensial tenglama bilan ifodalanadi:

#eq($ a_n (d^n y(t)) / (d t^n) + dots + a_1 (d y(t)) / (d t) + a_0 y(t) = b_0 x(t) $)

Tartibiga köra datçiklar quyidagi dinamik sinflarga bölinadi:

+ *Nolinçi tartibli datçiklar (0-order):* çiqiş signali kirişga keçikişsiz oniy mos keladi ($y(t) = K dot x(t)$). Misol: potensiometr, tenzodatçik.

+ *Birinçi tartibli datçiklar (1st-order):* tizimda bitta energiya yiğuvçi element mavjud. Differensial tenglamasi:
  #eq($ tau (d y(t)) / (d t) + y(t) = K dot x(t) $)
  bunda $tau$ --- vaqt doimiysi (_time constant_). Poğonasimon kirişda ($x(t) = U_0$) javob reaksiyasi:
  #eq($ y(t) = K dot U_0 (1 - e^(-t \/ tau)) $)
  $t = tau$ bölganda qaror topgan qiymatning $63.2%$, $t = 3 tau$ da $95%$, $t = 5 tau$ da $99.3%$ qismiga erişiladi. Misol: termopara, qarşilik termometri (RTD).

+ *Ikkinçi tartibli datçiklar (2nd-order):* tizimda ikkita inersion/energiya yiğuvçi element bölib, tebranma xarakterga ega:
  #eq($ (d^2 y(t)) / (d t^2) + 2 zeta omega_n (d y(t)) / (d t) + omega_n^2 y(t) = K omega_n^2 x(t) $)
  bunda $omega_n$ --- xususiy tebraniş çastotasi, $zeta$ --- söniş (dempfirlaş, _damping_) koeffitsienti. Misol: MEMS akselerometr, pyezoelektr datçik, seysmometr.

== ISO 9283 standarti böyiça robotlarning metrologik tavsiflari

John J. Craig va ISO 9283 xalqaro standartiga köra, sanoat robotlarining metrologik sifat körsatkiçlari quyidagi asosiy mezonlar bilan belgilanadi (@fig-iso):

- *Pozitsiya aniqligi ($A P$ --- Pose Accuracy):* robot tutqiçining dasturlangan maqsadli pozitsiyasi $P_c (x_c, y_c, z_c)$ va $N$ marta takrorlangan ölçaşlar natijasidagi örtaça pozitsiya $macron(P)(macron(x), macron(y), macron(z))$ örtasidagi masofa:
  #eq($ A P = sqrt((macron(x) - x_c)^2 + (macron(y) - y_c)^2 + (macron(z) - z_c)^2) $)
- *Pozitsiya takrorlanuvçanligi ($R P$ --- Pose Repeatability):* robot tutqiçi bir xil koordinataga $N$ marta qaytganda, ölçangan nuqtalarning örtaça markaz $macron(P)$ atrofida tarqaliş sferasi radiusi:
  #eq($ R P = macron(l) + 3 S_l $)
  bunda $macron(l) = 1/N sum_(i=1)^N l_i$, $l_i = sqrt((x_i - macron(x))^2 + (y_i - macron(y))^2 + (z_i - macron(z))^2)$, $S_l$ --- $l_i$ ning standart oğişi.
- *Masofa aniqligi ($A D$) va takrorlanuvçanligi ($R D$):* ikki turli nuqta örtasida bosib ötilgan masofaning aniqligi va takrorlanuvçanligi.

= Mavzuga oid çizmalar va sxemalar

== Datçikning statik tavsifi: çiziqlilik, gisterezis va ölik zona

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let arr = (end: "stealth", fill: black)
    let small(body) = text(size: 7.5pt, body)
    let blue-c = headingblue
    let orng = orange.darken(15%)

    // Oʻlik zona
    rect((0, 0), (0.8, 4.2), fill: gray.lighten(85%), stroke: none)
    content((0.4, 2.1), angle: 90deg, text(size: 7.5pt, weight: "bold", fill: blue-c)[Ölik zona ($X_"dead"$)])

    // Oʻqlar
    line((0, 0), (6.5, 0), stroke: 1pt, mark: arr)
    line((0, 0), (0, 4.5), stroke: 1pt, mark: arr)
    content((6.6, 0), anchor: "west", text(size: 9pt)[Kiriş signal ($X$)])
    content((0, 4.6), anchor: "south", text(size: 9pt)[Çiqiş signal ($Y$)])

    // Ideal chiziq
    line((0.8, 0.5), (5.8, 3.8), stroke: (paint: gray, thickness: 1pt, dash: "dashed"))
    content((5.85, 3.8), anchor: "south-west", small[Ideal töğri çiziq])

    // Toʻgʻri yurish (pastki egri) va teskari yurish (yuqori egri)
    bezier((0.8, 0.5), (5.8, 3.8), (2.5, 1.0), (4.2, 2.4), stroke: 2.2pt + blue-c)
    bezier((5.8, 3.8), (0.8, 0.5), (3.5, 2.9), (2.0, 1.8), stroke: 2.2pt + orng)
    content((3.9, 1.75), anchor: "north-west", text(fill: blue-c, small[Töğri yuriş ($Y_"töğri"$)]))
    content((2.3, 2.3), anchor: "south-east", text(fill: orng, small[Teskari yuriş ($Y_"teskari"$)]))

    // Gisterezis masofasi
    line((3.2, 1.72), (3.2, 2.45), stroke: 1.2pt + red, mark: (start: "stealth", end: "stealth", fill: red))
    content((3.28, 2.05), anchor: "west", text(size: 8pt, weight: "bold", fill: red)[$H_"max"$])

    circle((0.8, 0.5), radius: 0.06, fill: blue-c, stroke: none)
    circle((5.8, 3.8), radius: 0.06, fill: blue-c, stroke: none)
  }),
  caption: [Datçikning statik xarakteristikasidagi çiziqsizlik, gisterezis va ölik zona],
) <fig-hyst>

== Birinçi tartibli datçikning poğonali (step response) dinamik reaksiyasi

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let arr = (end: "stealth", fill: black)
    let tau = 1.5
    let amp = 3.0
    let resp(t) = amp * (1 - calc.exp(-t / tau))
    let orng = orange.darken(15%)
    let dark = gray.darken(50%)

    // Oʻqlar
    line((0, 0), (6.5, 0), stroke: 1pt, mark: arr)
    line((0, 0), (0, 4.0), stroke: 1pt, mark: arr)
    content((6.6, 0), anchor: "west", text(size: 9pt)[Vaqt ($t$, s)])
    content((0, 4.1), anchor: "south", text(size: 9pt)[Signal ($y(t)$)])

    // Kirish pogʻonasi
    line((0, 0), (0, amp), (6.0, amp), stroke: (paint: blue.lighten(10%), thickness: 2pt, dash: "dashed"))
    content((6.0, amp + 0.1), anchor: "south-east", text(size: 9pt)[Kiriş $U_0$ ($100%$)])

    // Dinamik javob egri chizigʻi
    line(..range(0, 121).map(i => (i * 6.0 / 120, resp(i * 6.0 / 120))), stroke: 2.2pt + headingblue)

    // τ va 3τ belgilari
    let y1 = resp(tau)
    let y3 = resp(3 * tau)
    line((tau, 0), (tau, y1), (0, y1), stroke: (paint: orng, thickness: 1pt, dash: "dashed"))
    line((3 * tau, 0), (3 * tau, y3), (0, y3), stroke: (paint: dark, thickness: 1pt, dash: "dashed"))
    circle((tau, y1), radius: 0.08, fill: orng, stroke: none)
    circle((3 * tau, y3), radius: 0.08, fill: dark, stroke: none)
    content((tau, -0.1), anchor: "north", text(size: 9pt)[$t = tau$])
    content((3 * tau, -0.1), anchor: "north", text(size: 9pt)[$t = 3 tau$])
    content((-0.1, y1), anchor: "east", text(size: 9pt)[$63.2%$])
    content((-0.1, y3 - 0.08), anchor: "east", text(size: 9pt)[$95.0%$])
  }),
  caption: [1-tartibli datçikning vaqt doimiysi $tau$ böyiça poğonali ötiş dinamik xarakteristikasi],
) <fig-step>

== ISO 9283 böyiça robot tutqiçining pozitsiya aniqligi ($A P$) va takrorlanuvçanligi ($R P$)

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let pbar = (1.2, 0.9)

    grid(
      (-3, -3),
      (3, 3),
      step: 1,
      stroke: (paint: gray.lighten(70%), thickness: 0.5pt, dash: "dashed"),
    )

    // Maqsadli nuqta
    circle((0, 0), radius: 0.1, fill: red, stroke: none)
    content((-0.15, 0.15), anchor: "south-east", text(
      size: 9pt,
      weight: "bold",
      fill: red,
    )[Maqsad $P_c (x_c, y_c, z_c)$])

    // RP takrorlanuvchanlik doirasi
    circle(pbar, radius: 0.8, stroke: (paint: blue.lighten(10%), thickness: 2pt, dash: "dashed"))

    // Oʻlchangan nuqtalar (N ta)
    for p in ((1.0, 1.2), (1.4, 0.7), (1.1, 0.8), (1.3, 1.1), (0.9, 0.6), (1.5, 1.0)) {
      circle(p, radius: 0.06, fill: blue-c, stroke: none)
    }

    // AP vektori
    line((0, 0), pbar, stroke: 2.2pt + red, mark: (end: "stealth", fill: red))
    content((0.65, 0.35), anchor: "north-west", text(size: 9pt, weight: "bold", fill: red)[$A P$])

    // Oʻrtacha markaz
    circle(pbar, radius: 0.09, fill: orng, stroke: none)
    content((1.9, 1.75), anchor: "south-west", text(
      size: 9pt,
      weight: "bold",
      fill: orng,
    )[Örtaça markaz $macron(P)(macron(x), macron(y), macron(z))$])

    // RP radiusi
    line(pbar, (2.0, 0.9), stroke: 1pt + blue.lighten(10%), mark: (end: "stealth", fill: blue.lighten(10%)))
    content((1.6, 0.95), anchor: "south", text(size: 8pt, weight: "bold", fill: blue.lighten(10%))[$R P$])
  }),
  caption: [ISO 9283 böyiça robot tutqiçining pozitsiya aniqligi ($A P$) va takrorlanuvçanligi ($R P$)],
) <fig-iso>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: turli datçiklarning metrologik körsatkiçlarini qiyosiy tahlil qiliş

Mexatron modullarda qöllaniladigan 4 ta asosiy sensor turining metrologik parametrlari böyiça qiyosiy tahlil ötkazing va @tab-compare ni töldiring.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (2.3cm, 1fr, 1fr, 1fr, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Sensor turi*], [*Ölçaş diapazoni*], [*Ajratiş qobiliyati*], [*Noçiziqlilik xatosi*], [*Dinamik reaksiyasi*]
      ),
      table.hline(stroke: 0.5pt),
      [*Optik enkoder*],
      [$0 dots 360 degree$ (çeksiz aylaniş)],
      [$0.005 degree dots 0.001 degree$],
      [Minimal ($< 0.01%$)],
      [Juda tez (0-tartibli, $> 1 "MHz"$)],
      [*LVDT datçigi*],
      [$plus.minus 1 "mm" dots plus.minus 250 "mm"$],
      [Nazariy çeksiz (analog, $< 0.1 thin mu"m"$)],
      [$plus.minus 0.1% dots plus.minus 0.25%$],
      [Tez ($approx 1 "kHz"$)],
      [*Tenzodatçik*],
      [$0.1 "N" dots 100 "kN"$],
      [Nazariy çeksiz (mikrodeformatsiya)],
      [$plus.minus 0.05% dots plus.minus 0.1%$],
      [Tez ($10 dots 50 "kHz"$)],
      [*Termopara (K-tip)*],
      [$-200 degree"C" dots +1260 degree"C"$],
      [$0.1 degree"C"$ (ADC ga boğliq)],
      [$plus.minus 0.5% dots plus.minus 1.0%$],
      [Sekin (1-tartibli, $tau = 0.5 dots 5 "s"$)],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sensorlarning metrologik körsatkiçlari böyiça qiyosiy jadval],
) <tab-compare>

== Topşiriq 2: ISO 9283 böyiça robot manipulyatorlarini metrologik baholaş

Sanoat roboti (KUKA KR 60) va SCARA roboti (Epson G6) metrologik körsatkiçlari taqqoslamasini tahlil qiling:

- *KUKA KR 60 (Articulated 6-DoF):* nominal yuk kötarişi $60 "kg"$, işçi sohasi $r = 2100 "mm"$, pozitsiya takrorlanuvçanligi $R P = plus.minus 0.05 "mm"$.
- *Epson G6 (SCARA 4-DoF):* nominal yuk kötarişi $6 "kg"$, qöl uzunligi $650 "mm"$, $X Y$ tekisligidagi takrorlanuvçanligi $R P_(X Y) = plus.minus 0.015 "mm"$.

*Xulosa:* SCARA roboti kiçik yuk va çeklangan işçi sohada $3.3$ baravar yuqori takrorlanuvçanlikka ($R P$) ega, bu esa elektron komponentlarni montaj qilişda öta yuqori metrologik işonçlilikni taʼminlaydi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: sensorning sezgirligi, çiziqlilik xatosi va gisterezisi hisobi

Çiziqli siljiş sensori $X = 0 dots 50 "mm"$ diapazonda ölçaş olib boradi. Tajribada töğri va teskari yurişda olingan kuçlaniş qiymatlari (V) @tab-exp da keltirilgan. Sensorning nominal töliq şkalasi $Y_"FS" = 5.00 "V"$.

#figure(
  {
    set text(size: 10pt)
    table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (
        left + horizon,
        center + horizon,
        center + horizon,
        center + horizon,
        center + horizon,
        center + horizon,
        center + horizon,
      ),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Kiriş $X$ (mm)*], [*0*], [*10*], [*20*], [*30*], [*40*], [*50*]),
      table.hline(stroke: 0.5pt),
      [*Töğri yuriş $Y_"töğri"$ (V)*], [0.00], [0.98], [2.02], [3.05], [4.02], [5.00],
      [*Teskari yuriş $Y_"teskari"$ (V)*], [0.00], [1.04], [2.10], [3.12], [4.08], [5.00],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sensor ölçov tajribasi natijalari],
) <tab-exp>

#set enum(numbering: "a)")
+ Sensorning örtaça sezgirligi $S$ (mV/mm) ni hisoblang.
+ Maksimal gisterezis xatoligi $H_"max"$ va uning şkalaga nisbatan foizini toping.
+ Ideal çiziqli boğliqlik $Y_"ideal" = 0.1 dot X$ bölganda, maksimal çiziqsizlik xatosi $delta_"lin"$ foizini aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq(
  $
    S = (Y_"max" - Y_"min") / (X_"max" - X_"min") = (5.00 "V" - 0.00 "V") / (50 "mm" - 0 "mm") = 0.100 "V/mm" = 100 "mV/mm"
  $,
)
#eq($ H_"max" = max |Y_"teskari" - Y_"töğri"|, quad quad delta_"hyst" = H_"max" / Y_"FS" times 100% $)
#eq($ Delta Y_"max" = max |Y - Y_"ideal"|, quad quad delta_"lin" = (Delta Y_"max") / Y_"FS" times 100% $)

*Hisoblaş bosqiçlari:*

- Har bir nuqtadagi gisterezis farqlari:
  #eq($ Delta Y(10) = |1.04 - 0.98| = 0.06 "V", quad Delta Y(20) = |2.10 - 2.02| = 0.08 "V" $)
  #eq($ Delta Y(30) = |3.12 - 3.05| = 0.07 "V", quad Delta Y(40) = |4.08 - 4.02| = 0.06 "V" $)
  Maksimal gisterezis: $H_"max" = 0.08 "V"$ ($X = 20 "mm"$ nuqtasida).
  #eq($ delta_"hyst" = (0.08 "V") / (5.00 "V") times 100% = 1.6% $)
- Ideal çiziqdan oğişlar ($Y_"ideal" = 1.00; 2.00; 3.00; 4.00 "V"$):
  - töğri yuriş: $-0.02; +0.02; +0.05; +0.02 "V"$;
  - teskari yuriş: $+0.04; +0.10; +0.12; +0.08 "V"$.

  Maksimal oğiş $X = 30 "mm"$ da teskari yurişda: $Delta Y_"max" = |3.12 - 3.00| = 0.12 "V"$.
  #eq($ delta_"lin" = (0.12 "V") / (5.00 "V") times 100% = 2.4% $)

== Masala 2: birinçi tartibli harorat datçigining dinamik javobi hisobi

Mexatron moduldagi harorat sensori birinçi tartibli dinamik zveno sifatida modellaştiriladi. Datçikning vaqt doimiysi $tau = 2.5 "s"$. Dastlab datçik $T_0 = 20 degree"C"$ haroratda bölgan. Vaqtning $t = 0$ momentida datçik $T_"muhit" = 100 degree"C"$ bölgan muhitga joylaştirildi.

#set enum(numbering: "a)")
+ $t = 2.5 "s"$ ($tau$), $t = 5.0 "s"$ ($2 tau$) va $t = 7.5 "s"$ ($3 tau$) momentlarida datçik körsatgan harorat $T(t)$ ni hisoblang.
+ Datçik körsatkiçi harorat özgarişining $99%$ qismiga ($T = 99.2 degree"C"$) erişişi uçun qança vaqt $t_99$ kerak böladi?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ T(t) = T_"muhit" + (T_0 - T_"muhit") e^(-t \/ tau) = 100 + (20 - 100) e^(-t \/ 2.5) = 100 - 80 e^(-t \/ 2.5) $)

*Hisoblaş bosqiçlari:*

- $t = tau = 2.5 "s"$ bölganda:
  #eq($ T(2.5) = 100 - 80 dot e^(-1) = 100 - 80 dot 0.3679 = 100 - 29.43 = 70.57 degree"C" $)
- $t = 2 tau = 5.0 "s"$ bölganda:
  #eq($ T(5.0) = 100 - 80 dot e^(-2) = 100 - 80 dot 0.1353 = 100 - 10.83 = 89.17 degree"C" $)
- $t = 3 tau = 7.5 "s"$ bölganda:
  #eq($ T(7.5) = 100 - 80 dot e^(-3) = 100 - 80 dot 0.0498 = 100 - 3.98 = 96.02 degree"C" $)
- $T(t_99) = 99.2 degree"C"$ bölganda vaqt hisobi:
  #eq($ 99.2 = 100 - 80 e^(-t \/ 2.5) ==> 80 e^(-t \/ 2.5) = 0.8 ==> e^(-t \/ 2.5) = 0.01 $)
  #eq($ t_99 / 2.5 = -ln(0.01) approx 4.605 ==> t_99 = 2.5 times 4.605 approx 11.51 "s" $)

== Masala 3: ISO 9283 böyiça robotning pozitsiya aniqligi ($A P$) va takrorlanuvçanligi ($R P$) hisobi

Sanoat roboti tutqiçi uçun dasturlangan maqsadli koordinata $P_c (100.00, 200.00, 300.00) "mm"$. Robot $N = 5$ marta uşbu nuqtaga harakatlantirildi va lazer treker yordamida olingan amaliy koordinatalar (mm) @tab-pos da keltirilgan.

#figure(
  {
    set text(size: 10pt)
    table(
      columns: (auto, 2.5cm, 2.5cm, 2.5cm),
      align: center + horizon,
      stroke: none,
      inset: (x: 6pt, y: 4pt),
      table.hline(stroke: 1pt),
      table.header([*Ölçaş №*], [*$X_i$*], [*$Y_i$*], [*$Z_i$*]),
      table.hline(stroke: 0.5pt),
      [1], [100.12], [200.08], [300.05],
      [2], [100.10], [200.12], [300.03],
      [3], [100.15], [200.10], [300.07],
      [4], [100.08], [200.05], [300.04],
      [5], [100.10], [200.15], [300.06],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Robot pozitsiyasini ölçaş natijalari (mm)],
) <tab-pos>

#set enum(numbering: "a)")
+ Örtaça pozitsiya koordinatalari $macron(x), macron(y), macron(z)$ ni hisoblang.
+ Robotning pozitsiya aniqligi ($A P$) qiymatini aniqlang.
+ Har bir nuqtaning örtaça markazgaça bölgan masofasi $l_i$, örtaça masofa $macron(l)$ hamda standart oğiş $S_l$ böyiça pozitsiya takrorlanuvçanligi ($R P$) ni hisoblang.
#set enum(numbering: "1.")

*Hisoblaş bosqiçlari:*

- Örtaça koordinatalar:
  #eq($ macron(x) = (100.12 + 100.10 + 100.15 + 100.08 + 100.10) / 5 = 500.55 / 5 = 100.11 "mm" $)
  #eq($ macron(y) = (200.08 + 200.12 + 200.10 + 200.05 + 200.15) / 5 = 1000.50 / 5 = 200.10 "mm" $)
  #eq($ macron(z) = (300.05 + 300.03 + 300.07 + 300.04 + 300.06) / 5 = 1500.25 / 5 = 300.05 "mm" $)
- Pozitsiya aniqligi ($A P$):
  #eq($ A P = sqrt((100.11 - 100.00)^2 + (200.10 - 200.00)^2 + (300.05 - 300.00)^2) $)
  #eq(
    $ A P = sqrt((0.11)^2 + (0.10)^2 + (0.05)^2) = sqrt(0.0121 + 0.0100 + 0.0025) \ = sqrt(0.0246) approx 0.1568 "mm" $,
  )
- Har bir ölçovning örtaça markazdan masofasi $l_i = sqrt((x_i - macron(x))^2 + (y_i - macron(y))^2 + (z_i - macron(z))^2)$:
  #eq($ l_1 = sqrt((0.01)^2 + (-0.02)^2 + (0.00)^2) = sqrt(0.0005) approx 0.0224 "mm" $)
  #eq($ l_2 = sqrt((-0.01)^2 + (0.02)^2 + (-0.02)^2) = sqrt(0.0009) = 0.0300 "mm" $)
  #eq($ l_3 = sqrt((0.04)^2 + (0.00)^2 + (0.02)^2) = sqrt(0.0020) approx 0.0447 "mm" $)
  #eq($ l_4 = sqrt((-0.03)^2 + (-0.05)^2 + (-0.01)^2) = sqrt(0.0035) approx 0.0592 "mm" $)
  #eq($ l_5 = sqrt((-0.01)^2 + (0.05)^2 + (0.01)^2) = sqrt(0.0027) approx 0.0520 "mm" $)
  Örtaça masofa:
  #eq($ macron(l) = (0.0224 + 0.0300 + 0.0447 + 0.0592 + 0.0520) / 5 = 0.2083 / 5 = 0.0417 "mm" $)
  Standart oğiş:
  #eq($ S_l = sqrt((sum_(i=1)^5 (l_i - macron(l))^2) / (N - 1)) approx 0.0152 "mm" $)
- Pozitsiya takrorlanuvçanligi ($R P$):
  #eq($ R P = macron(l) + 3 S_l = 0.0417 + 3 times 0.0152 = 0.0417 + 0.0456 = 0.0873 "mm" $)

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: datçiklarning statik kalibrlaş tajribasini ötkaziş.* LVDT va tenzodatçiklarga bosqiçma-bosqiç kiriş qiymatlarini berib, töğri va teskari yurişdagi çiqiş signallarini multimetr/ossillografda qayd eting.
+ *2-bosqiç: gisterezis va çiziqlilik xatoliklarini hisoblaş.* Olingan tajriba maʼlumotlari böyiça $S$, $H_"max"$ va $delta_"lin"$ parametrlarini 5-bölimdagi 1-masala formulalari asosida hisoblang.
+ *3-bosqiç: datçikning dinamik vaqt doimiysi $tau$ ni aniqlaş.* Harorat datçigini issiq suvli idişga joylaştirib, ossillograf yoki LabVIEW muhitida ötiş jarayoni egri çiziğini yozib oling. $63.2%$ darajaga erişiş vaqti böyiça $tau$ ni toping.
+ *4-bosqiç: ISO 9283 böyiça robot pozitsion aniqligini ölçaş.* Sanoat robotini belgilangan $P_c$ nuqtasiga 5 marta harakatlantirib, amaliy koordinatalarni lazer interferometr/indikatorda qayd qiling va $A P$ hamda $R P$ ni hisoblang.
+ *5-bosqiç: natijalarni tahlil qiliş va hisobot tayyorlaş.* Hisoblangan metrologik parametrlarni standart talablar bilan taqqoslang.

= Nazorat va muhokama savollari

+ Metrologiya va metrologik tavsif tuşunçalarining mexatronikadagi ahamiyati nimada?
+ Datçikning statik metrologik tavsiflariga nimalar kiradi va ularning bir-biridan farqini tuşuntiring.
+ Datçikning sezgirligi ($S$) va ajratiş qobiliyati ($Delta X$) örtasidagi boğliqlik nimadan iborat?
+ Gisterezis hodisasi nima va u datçik aniqligiga qanday salbiy taʼsir körsatadi?
+ 0-, 1- va 2-tartibli datçiklarning dinamik farqlarini tuşuntiring.
+ 1-tartibli datçikda vaqt doimiysi $tau$ nimani anglatadi va $t = 3 tau$ vaqtida signal neça foizga erişadi?
+ 2-tartibli tebranma datçiklarda söniş koeffitsienti ($zeta$) qiymatining ötiş jarayoniga taʼsiri qanday?
+ ISO 9283 standartiga köra pozitsiya aniqligi ($A P$) va pozitsiya takrorlanuvçanligi ($R P$) örtasidagi tub farq nimada?
+ Nima uçun sanoat robotlarida pozitsiya takrorlanuvçanligi ($R P$) pozitsiya aniqligidan ($A P$) köra muhimroq hisoblanadi?
+ Sistematik va tasodifiy xatoliklarning kelib çiqiş sabablari hamda ularni kamaytiriş usullarini ayting.
+ Robot tutqiçining dinamik tebranişlari va drift (siljiş) hodisasi metrologik körsatkiçlarga qanday taʼsir qiladi?
+ Sanoat robotlarini kalibrlaşda lazer treker va optik interferometr tizimlarining qöllaniliş texnologiyasini izohlang.
