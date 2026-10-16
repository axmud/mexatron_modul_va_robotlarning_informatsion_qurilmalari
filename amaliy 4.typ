// ============================================================
//  MMRIQ — 4-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_4.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Mexatron modullar va robotlarning metrologik tavsiflari bilan tanishish")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №4]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Mexatron modullar va robotlarning metrologik tavsiflari bilan tanishish]

  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatronik modullar, datchiklar va robotik manipulyatorlarning metrologik tavsiflari (statik va dinamik xarakteristikalar), aniqlik mezonlari, xatoliklar nazariyasi hamda ISO 9283 standarti boʻyicha robotlarning pozitsion metrologik koʻrsatkichlarini baholash va hisoblash koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Mexatron modul va datchiklarning statik metrologik tavsiflarini (sezgirlik, aniqlik, takrorlanuvchanlik, chiziqlilik, gisterezis, oʻlik zona, ajratish qobiliyati) oʻrganish.
+ Datchik va oʻlchov tizimlarining dinamik tavsiflarini (0-, 1- va 2-tartibli tizimlar, vaqt doimiysi $tau$, oʻtkazish polosasi, amplituda-faza chastota xarakteristikasi) tahlil qilish.
+ ISO 9283 xalqaro standartiga muvofiq sanoat robotlarining pozitsion va trayektoriyaviy metrologik mezonlarini ($A P$ --- Pose Accuracy, $R P$ --- Pose Repeatability, $A D$ --- Distance Accuracy, $R D$ --- Distance Repeatability) oʻrganish.
+ Oʻlchash xatoliklarining turlarini (sistematik, tasodifiy, qoʻpol) aniqlash va statistik matematik qayta ishlash usullarini qoʻllash.
+ Sensorlar va sanoat robotlarining metrologik parametrlarini tajriba hamda hisoblash masalalari yordamida baholash.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* metrologik sifatni sinash va kalibrlash laboratoriya stendi, datchiklarni kalibrlash moslamasi (mikrometrli optik skamya), harorat va bosim kalibratorlari.
- *Sensor va oʻlchov vositalari:* LVDT chiziqli siljish datchigi, optik va magnit enkoderlar, tenzometrik ogʻirlik sensori, lazer interferometr / lazer treker oʻlchov tizimi, raqamli ossillograf va multimetr.
- *Robotik stend:* 6-DoF sanoat roboti (KUKA / ABB / Fanuc) oʻquv maketi va Teach Pendant.
- *Dasturiy muhit:* MATLAB / Simulink (System Identification Toolbox), LabVIEW metrologiya moduli, Python (SciPy / NumPy) statistik tahlil vositalari.

= Nazariy maʼlumotlar va metrologik tavsiflar klassifikatsiyasi

== Metrologiya va metrologik tavsif tushunchasi

*Metrologiya* --- oʻlchashlar, ularning birligini taʼminlash usullari va vositalari hamda talab qilingan aniqlikka erishish yoʻllari haqidagi fandir. Mexatronika va robototexnikada informatsion qurilmalarning *metrologik tavsifi* deb oʻlchash natijalariga va oʻlchash xatoliklariga taʼsir etuvchi, hujjatlashtirilgan oʻlchov vositasi xossalariga aytiladi.

P.P.L. Regtien va W. Bolton darsliklariga koʻra, mexatron modul datchiklarining metrologik tavsiflari ikkita katta guruhga boʻlinadi:

+ *Statik metrologik tavsiflar:* oʻlchanayotgan fizik kattalik vaqt boʻyicha oʻzgarmaganda yoki oʻta sekin oʻzgarganda namoyon boʻladigan xarakteristikalar.
+ *Dinamik metrologik tavsiflar:* oʻlchanayotgan kattalik vaqt boʻyicha tez oʻzgarganda datchikning impuls yoki chastotaviy reaksiyasini belgilovchi xarakteristikalar.

== Datchiklarning statik metrologik tavsiflari

Datchiklarning asosiy statik metrologik koʻrsatkichlari quyidagilardan iborat (@tab-static):

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
      [Kirish kattaligi $Delta X$ ga oʻzgarganda chiqish signali $Y$ ning oʻzgarish nisbati.],
      [2], [*Chiziqlilik* (Linearity)], [$delta_"lin" = (Delta Y_"max") / Y_"FS" times 100%$],
      [Real oʻtish tavsifining ideal toʻgʻri chiziqdan maksimal ogʻish foizi.],
      [3], [*Gisterezis* (Hysteresis)], [$H_"max" = max |Y_"toʻgʻri" - Y_"teskari"|$],
      [Kirish kattaligi ortishi va kamayishida chiqish signallari farqi.],
      [4], [*Ajratish qobiliyati* (Resolution)], [$Delta X_"min"$],
      [Datchik sezadigan va ajrata oladigan eng kichik kirish oʻzgarishi.],
      [5], [*Oʻlik zona* (Dead Band)], [$X_"dead"$],
      [Chiqish signalida hech qanday oʻzgarish hosil qilmaydigan kirish oraligʻi.],
      [6], [*Aniqlik* (Accuracy)], [$E_"rel" = (|X_"oʻlchov" - X_"haqiqiy"|) / X_"haqiqiy"$],
      [Oʻlchash natijasining haqiqiy qiymatga yaqinlik darajasi.],
      [7], [*Takrorlanuvchanlik* (Repeatability)], [$sigma = sqrt(1 / (N - 1) sum (x_i - macron(x))^2)$],
      [Bir xil sharoitda qayta oʻlchashlar natijalarining bir-biriga mosligi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatron modul datchiklarining statik metrologik tavsiflari],
) <tab-static>

== Datchiklarning dinamik metrologik tavsiflari

Datchikning dinamik xulq-atvori differensial tenglama bilan ifodalanadi:

#eq($ a_n (d^n y(t)) / (d t^n) + dots + a_1 (d y(t)) / (d t) + a_0 y(t) = b_0 x(t) $)

Tartibiga koʻra datchiklar quyidagi dinamik sinflarga boʻlinadi:

+ *Nolinchi tartibli datchiklar (0-order):* chiqish signali kirishga kechikishsiz oniy mos keladi ($y(t) = K dot x(t)$). Misol: potensiometr, tenzodatchik.

+ *Birinchi tartibli datchiklar (1st-order):* tizimda bitta energiya yigʻuvchi element mavjud. Differensial tenglamasi:
  #eq($ tau (d y(t)) / (d t) + y(t) = K dot x(t) $)
  bunda $tau$ --- vaqt doimiysi (_time constant_). Pogʻonasimon kirishda ($x(t) = U_0$) javob reaksiyasi:
  #eq($ y(t) = K dot U_0 (1 - e^(-t \/ tau)) $)
  $t = tau$ boʻlganda qaror topgan qiymatning $63.2%$, $t = 3 tau$ da $95%$, $t = 5 tau$ da $99.3%$ qismiga erishiladi. Misol: termopara, qarshilik termometri (RTD).

+ *Ikkinchi tartibli datchiklar (2nd-order):* tizimda ikkita inersion/energiya yigʻuvchi element boʻlib, tebranma xarakterga ega:
  #eq($ (d^2 y(t)) / (d t^2) + 2 zeta omega_n (d y(t)) / (d t) + omega_n^2 y(t) = K omega_n^2 x(t) $)
  bunda $omega_n$ --- xususiy tebranish chastotasi, $zeta$ --- soʻnish (dempfirlash, _damping_) koeffitsienti. Misol: MEMS akselerometr, pyezoelektr datchik, seysmometr.

== ISO 9283 standarti boʻyicha robotlarning metrologik tavsiflari

John J. Craig va ISO 9283 xalqaro standartiga koʻra, sanoat robotlarining metrologik sifat koʻrsatkichlari quyidagi asosiy mezonlar bilan belgilanadi (@fig-iso):

- *Pozitsiya aniqligi ($A P$ --- Pose Accuracy):* robot tutqichining dasturlangan maqsadli pozitsiyasi $P_c (x_c, y_c, z_c)$ va $N$ marta takrorlangan oʻlchashlar natijasidagi oʻrtacha pozitsiya $macron(P)(macron(x), macron(y), macron(z))$ oʻrtasidagi masofa:
  #eq($ A P = sqrt((macron(x) - x_c)^2 + (macron(y) - y_c)^2 + (macron(z) - z_c)^2) $)
- *Pozitsiya takrorlanuvchanligi ($R P$ --- Pose Repeatability):* robot tutqichi bir xil koordinataga $N$ marta qaytganda, oʻlchangan nuqtalarning oʻrtacha markaz $macron(P)$ atrofida tarqalish sferasi radiusi:
  #eq($ R P = macron(l) + 3 S_l $)
  bunda $macron(l) = 1/N sum_(i=1)^N l_i$, $l_i = sqrt((x_i - macron(x))^2 + (y_i - macron(y))^2 + (z_i - macron(z))^2)$, $S_l$ --- $l_i$ ning standart ogʻishi.
- *Masofa aniqligi ($A D$) va takrorlanuvchanligi ($R D$):* ikki turli nuqta oʻrtasida bosib oʻtilgan masofaning aniqligi va takrorlanuvchanligi.

= Mavzuga oid chizmalar va sxemalar

== Datchikning statik tavsifi: chiziqlilik, gisterezis va oʻlik zona

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let arr = (end: "stealth", fill: black)
    let small(body) = text(size: 7.5pt, body)
    let blue-c = headingblue
    let orng = orange.darken(15%)

    // Oʻlik zona
    rect((0, 0), (0.8, 4.2), fill: gray.lighten(85%), stroke: none)
    content((0.4, 2.1), angle: 90deg, text(size: 7.5pt, weight: "bold", fill: blue-c)[Oʻlik zona ($X_"dead"$)])

    // Oʻqlar
    line((0, 0), (6.5, 0), stroke: 1pt, mark: arr)
    line((0, 0), (0, 4.5), stroke: 1pt, mark: arr)
    content((6.6, 0), anchor: "west", text(size: 9pt)[Kirish signal ($X$)])
    content((0, 4.6), anchor: "south", text(size: 9pt)[Chiqish signal ($Y$)])

    // Ideal chiziq
    line((0.8, 0.5), (5.8, 3.8), stroke: (paint: gray, thickness: 1pt, dash: "dashed"))
    content((5.85, 3.8), anchor: "south-west", small[Ideal toʻgʻri chiziq])

    // Toʻgʻri yurish (pastki egri) va teskari yurish (yuqori egri)
    bezier((0.8, 0.5), (5.8, 3.8), (2.5, 1.0), (4.2, 2.4), stroke: 2.2pt + blue-c)
    bezier((5.8, 3.8), (0.8, 0.5), (3.5, 2.9), (2.0, 1.8), stroke: 2.2pt + orng)
    content((3.9, 1.75), anchor: "north-west", text(fill: blue-c, small[Toʻgʻri yurish ($Y_"toʻgʻri"$)]))
    content((2.3, 2.3), anchor: "south-east", text(fill: orng, small[Teskari yurish ($Y_"teskari"$)]))

    // Gisterezis masofasi
    line((3.2, 1.72), (3.2, 2.45), stroke: 1.2pt + red, mark: (start: "stealth", end: "stealth", fill: red))
    content((3.28, 2.05), anchor: "west", text(size: 8pt, weight: "bold", fill: red)[$H_"max"$])

    circle((0.8, 0.5), radius: 0.06, fill: blue-c, stroke: none)
    circle((5.8, 3.8), radius: 0.06, fill: blue-c, stroke: none)
  }),
  caption: [Datchikning statik xarakteristikasidagi chiziqsizlik, gisterezis va oʻlik zona],
) <fig-hyst>

== Birinchi tartibli datchikning pogʻonali (step response) dinamik reaksiyasi

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
    content((6.0, amp + 0.1), anchor: "south-east", text(size: 9pt)[Kirish $U_0$ ($100%$)])

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
  caption: [1-tartibli datchikning vaqt doimiysi $tau$ boʻyicha pogʻonali oʻtish dinamik xarakteristikasi],
) <fig-step>

== ISO 9283 boʻyicha robot tutqichining pozitsiya aniqligi ($A P$) va takrorlanuvchanligi ($R P$)

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
    )[Oʻrtacha markaz $macron(P)(macron(x), macron(y), macron(z))$])

    // RP radiusi
    line(pbar, (2.0, 0.9), stroke: 1pt + blue.lighten(10%), mark: (end: "stealth", fill: blue.lighten(10%)))
    content((1.6, 0.95), anchor: "south", text(size: 8pt, weight: "bold", fill: blue.lighten(10%))[$R P$])
  }),
  caption: [ISO 9283 boʻyicha robot tutqichining pozitsiya aniqligi ($A P$) va takrorlanuvchanligi ($R P$)],
) <fig-iso>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: turli datchiklarning metrologik koʻrsatkichlarini qiyosiy tahlil qilish

Mexatron modullarda qoʻllaniladigan 4 ta asosiy sensor turining metrologik parametrlari boʻyicha qiyosiy tahlil oʻtkazing va @tab-compare ni toʻldiring.

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
        [*Sensor turi*],
        [*Oʻlchash diapazoni*],
        [*Ajratish qobiliyati*],
        [*Nochiziqlilik xatosi*],
        [*Dinamik reaksiyasi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Optik enkoder*],
      [$0 dots 360 degree$ (cheksiz aylanish)],
      [$0.005 degree dots 0.001 degree$],
      [Minimal ($< 0.01%$)],
      [Juda tez (0-tartibli, $> 1 "MHz"$)],
      [*LVDT datchigi*],
      [$plus.minus 1 "mm" dots plus.minus 250 "mm"$],
      [Nazariy cheksiz (analog, $< 0.1 thin mu"m"$)],
      [$plus.minus 0.1% dots plus.minus 0.25%$],
      [Tez ($approx 1 "kHz"$)],
      [*Tenzodatchik*],
      [$0.1 "N" dots 100 "kN"$],
      [Nazariy cheksiz (mikrodeformatsiya)],
      [$plus.minus 0.05% dots plus.minus 0.1%$],
      [Tez ($10 dots 50 "kHz"$)],
      [*Termopara (K-tip)*],
      [$-200 degree"C" dots +1260 degree"C"$],
      [$0.1 degree"C"$ (ADC ga bogʻliq)],
      [$plus.minus 0.5% dots plus.minus 1.0%$],
      [Sekin (1-tartibli, $tau = 0.5 dots 5 "s"$)],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sensorlarning metrologik koʻrsatkichlari boʻyicha qiyosiy jadval],
) <tab-compare>

== Topshiriq 2: ISO 9283 boʻyicha robot manipulyatorlarini metrologik baholash

Sanoat roboti (KUKA KR 60) va SCARA roboti (Epson G6) metrologik koʻrsatkichlari taqqoslamasini tahlil qiling:

- *KUKA KR 60 (Articulated 6-DoF):* nominal yuk koʻtarishi $60 "kg"$, ishchi sohasi $r = 2100 "mm"$, pozitsiya takrorlanuvchanligi $R P = plus.minus 0.05 "mm"$.
- *Epson G6 (SCARA 4-DoF):* nominal yuk koʻtarishi $6 "kg"$, qoʻl uzunligi $650 "mm"$, $X Y$ tekisligidagi takrorlanuvchanligi $R P_(X Y) = plus.minus 0.015 "mm"$.

*Xulosa:* SCARA roboti kichik yuk va cheklangan ishchi sohada $3.3$ baravar yuqori takrorlanuvchanlikka ($R P$) ega, bu esa elektron komponentlarni montaj qilishda oʻta yuqori metrologik ishonchlilikni taʼminlaydi.

= Hisoblash va modellashtirish masalalari

== Masala 1: sensorning sezgirligi, chiziqlilik xatosi va gisterezisi hisobi

Chiziqli siljish sensori $X = 0 dots 50 "mm"$ diapazonda oʻlchash olib boradi. Tajribada toʻgʻri va teskari yurishda olingan kuchlanish qiymatlari (V) @tab-exp da keltirilgan. Sensorning nominal toʻliq shkalasi $Y_"FS" = 5.00 "V"$.

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
      table.header([*Kirish $X$ (mm)*], [*0*], [*10*], [*20*], [*30*], [*40*], [*50*]),
      table.hline(stroke: 0.5pt),
      [*Toʻgʻri yurish $Y_"toʻgʻri"$ (V)*], [0.00], [0.98], [2.02], [3.05], [4.02], [5.00],
      [*Teskari yurish $Y_"teskari"$ (V)*], [0.00], [1.04], [2.10], [3.12], [4.08], [5.00],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sensor oʻlchov tajribasi natijalari],
) <tab-exp>

#set enum(numbering: "a)")
+ Sensorning oʻrtacha sezgirligi $S$ (mV/mm) ni hisoblang.
+ Maksimal gisterezis xatoligi $H_"max"$ va uning shkalaga nisbatan foizini toping.
+ Ideal chiziqli bogʻliqlik $Y_"ideal" = 0.1 dot X$ boʻlganda, maksimal chiziqsizlik xatosi $delta_"lin"$ foizini aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq(
  $
    S = (Y_"max" - Y_"min") / (X_"max" - X_"min") = (5.00 "V" - 0.00 "V") / (50 "mm" - 0 "mm") = 0.100 "V/mm" = 100 "mV/mm"
  $,
)
#eq($ H_"max" = max |Y_"teskari" - Y_"toʻgʻri"|, quad quad delta_"hyst" = H_"max" / Y_"FS" times 100% $)
#eq($ Delta Y_"max" = max |Y - Y_"ideal"|, quad quad delta_"lin" = (Delta Y_"max") / Y_"FS" times 100% $)

*Hisoblash bosqichlari:*

- Har bir nuqtadagi gisterezis farqlari:
  #eq($ Delta Y(10) = |1.04 - 0.98| = 0.06 "V", quad Delta Y(20) = |2.10 - 2.02| = 0.08 "V" $)
  #eq($ Delta Y(30) = |3.12 - 3.05| = 0.07 "V", quad Delta Y(40) = |4.08 - 4.02| = 0.06 "V" $)
  Maksimal gisterezis: $H_"max" = 0.08 "V"$ ($X = 20 "mm"$ nuqtasida).
  #eq($ delta_"hyst" = (0.08 "V") / (5.00 "V") times 100% = 1.6% $)
- Ideal chiziqdan ogʻishlar ($Y_"ideal" = 1.00; 2.00; 3.00; 4.00 "V"$):
  - toʻgʻri yurish: $-0.02; +0.02; +0.05; +0.02 "V"$;
  - teskari yurish: $+0.04; +0.10; +0.12; +0.08 "V"$.

  Maksimal ogʻish $X = 30 "mm"$ da teskari yurishda: $Delta Y_"max" = |3.12 - 3.00| = 0.12 "V"$.
  #eq($ delta_"lin" = (0.12 "V") / (5.00 "V") times 100% = 2.4% $)

== Masala 2: birinchi tartibli harorat datchigining dinamik javobi hisobi

Mexatron moduldagi harorat sensori birinchi tartibli dinamik zveno sifatida modellashtiriladi. Datchikning vaqt doimiysi $tau = 2.5 "s"$. Dastlab datchik $T_0 = 20 degree"C"$ haroratda boʻlgan. Vaqtning $t = 0$ momentida datchik $T_"muhit" = 100 degree"C"$ boʻlgan muhitga joylashtirildi.

#set enum(numbering: "a)")
+ $t = 2.5 "s"$ ($tau$), $t = 5.0 "s"$ ($2 tau$) va $t = 7.5 "s"$ ($3 tau$) momentlarida datchik koʻrsatgan harorat $T(t)$ ni hisoblang.
+ Datchik koʻrsatkichi harorat oʻzgarishining $99%$ qismiga ($T = 99.2 degree"C"$) erishishi uchun qancha vaqt $t_99$ kerak boʻladi?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ T(t) = T_"muhit" + (T_0 - T_"muhit") e^(-t \/ tau) = 100 + (20 - 100) e^(-t \/ 2.5) = 100 - 80 e^(-t \/ 2.5) $)

*Hisoblash bosqichlari:*

- $t = tau = 2.5 "s"$ boʻlganda:
  #eq($ T(2.5) = 100 - 80 dot e^(-1) = 100 - 80 dot 0.3679 = 100 - 29.43 = 70.57 degree"C" $)
- $t = 2 tau = 5.0 "s"$ boʻlganda:
  #eq($ T(5.0) = 100 - 80 dot e^(-2) = 100 - 80 dot 0.1353 = 100 - 10.83 = 89.17 degree"C" $)
- $t = 3 tau = 7.5 "s"$ boʻlganda:
  #eq($ T(7.5) = 100 - 80 dot e^(-3) = 100 - 80 dot 0.0498 = 100 - 3.98 = 96.02 degree"C" $)
- $T(t_99) = 99.2 degree"C"$ boʻlganda vaqt hisobi:
  #eq($ 99.2 = 100 - 80 e^(-t \/ 2.5) ==> 80 e^(-t \/ 2.5) = 0.8 ==> e^(-t \/ 2.5) = 0.01 $)
  #eq($ t_99 / 2.5 = -ln(0.01) approx 4.605 ==> t_99 = 2.5 times 4.605 approx 11.51 "s" $)

== Masala 3: ISO 9283 boʻyicha robotning pozitsiya aniqligi ($A P$) va takrorlanuvchanligi ($R P$) hisobi

Sanoat roboti tutqichi uchun dasturlangan maqsadli koordinata $P_c (100.00, 200.00, 300.00) "mm"$. Robot $N = 5$ marta ushbu nuqtaga harakatlantirildi va lazer treker yordamida olingan amaliy koordinatalar (mm) @tab-pos da keltirilgan.

#figure(
  {
    set text(size: 10pt)
    table(
      columns: (auto, 2.5cm, 2.5cm, 2.5cm),
      align: center + horizon,
      stroke: none,
      inset: (x: 6pt, y: 4pt),
      table.hline(stroke: 1pt),
      table.header([*Oʻlchash №*], [*$X_i$*], [*$Y_i$*], [*$Z_i$*]),
      table.hline(stroke: 0.5pt),
      [1], [100.12], [200.08], [300.05],
      [2], [100.10], [200.12], [300.03],
      [3], [100.15], [200.10], [300.07],
      [4], [100.08], [200.05], [300.04],
      [5], [100.10], [200.15], [300.06],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Robot pozitsiyasini oʻlchash natijalari (mm)],
) <tab-pos>

#set enum(numbering: "a)")
+ Oʻrtacha pozitsiya koordinatalari $macron(x), macron(y), macron(z)$ ni hisoblang.
+ Robotning pozitsiya aniqligi ($A P$) qiymatini aniqlang.
+ Har bir nuqtaning oʻrtacha markazgacha boʻlgan masofasi $l_i$, oʻrtacha masofa $macron(l)$ hamda standart ogʻish $S_l$ boʻyicha pozitsiya takrorlanuvchanligi ($R P$) ni hisoblang.
#set enum(numbering: "1.")

*Hisoblash bosqichlari:*

- Oʻrtacha koordinatalar:
  #eq($ macron(x) = (100.12 + 100.10 + 100.15 + 100.08 + 100.10) / 5 = 500.55 / 5 = 100.11 "mm" $)
  #eq($ macron(y) = (200.08 + 200.12 + 200.10 + 200.05 + 200.15) / 5 = 1000.50 / 5 = 200.10 "mm" $)
  #eq($ macron(z) = (300.05 + 300.03 + 300.07 + 300.04 + 300.06) / 5 = 1500.25 / 5 = 300.05 "mm" $)
- Pozitsiya aniqligi ($A P$):
  #eq($ A P = sqrt((100.11 - 100.00)^2 + (200.10 - 200.00)^2 + (300.05 - 300.00)^2) $)
  #eq($ A P = sqrt((0.11)^2 + (0.10)^2 + (0.05)^2) = sqrt(0.0121 + 0.0100 + 0.0025) = sqrt(0.0246) approx 0.1568 "mm" $)
- Har bir oʻlchovning oʻrtacha markazdan masofasi $l_i = sqrt((x_i - macron(x))^2 + (y_i - macron(y))^2 + (z_i - macron(z))^2)$:
  #eq($ l_1 = sqrt((0.01)^2 + (-0.02)^2 + (0.00)^2) = sqrt(0.0005) approx 0.0224 "mm" $)
  #eq($ l_2 = sqrt((-0.01)^2 + (0.02)^2 + (-0.02)^2) = sqrt(0.0009) = 0.0300 "mm" $)
  #eq($ l_3 = sqrt((0.04)^2 + (0.00)^2 + (0.02)^2) = sqrt(0.0020) approx 0.0447 "mm" $)
  #eq($ l_4 = sqrt((-0.03)^2 + (-0.05)^2 + (-0.01)^2) = sqrt(0.0035) approx 0.0592 "mm" $)
  #eq($ l_5 = sqrt((-0.01)^2 + (0.05)^2 + (0.01)^2) = sqrt(0.0027) approx 0.0520 "mm" $)
  Oʻrtacha masofa:
  #eq($ macron(l) = (0.0224 + 0.0300 + 0.0447 + 0.0592 + 0.0520) / 5 = 0.2083 / 5 = 0.0417 "mm" $)
  Standart ogʻish:
  #eq($ S_l = sqrt((sum_(i=1)^5 (l_i - macron(l))^2) / (N - 1)) approx 0.0152 "mm" $)
- Pozitsiya takrorlanuvchanligi ($R P$):
  #eq($ R P = macron(l) + 3 S_l = 0.0417 + 3 times 0.0152 = 0.0417 + 0.0456 = 0.0873 "mm" $)

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: datchiklarning statik kalibrlash tajribasini oʻtkazish.* LVDT va tenzodatchiklarga bosqichma-bosqich kirish qiymatlarini berib, toʻgʻri va teskari yurishdagi chiqish signallarini multimetr/ossillografda qayd eting.
+ *2-bosqich: gisterezis va chiziqlilik xatoliklarini hisoblash.* Olingan tajriba maʼlumotlari boʻyicha $S$, $H_"max"$ va $delta_"lin"$ parametrlarini 5-boʻlimdagi 1-masala formulalari asosida hisoblang.
+ *3-bosqich: datchikning dinamik vaqt doimiysi $tau$ ni aniqlash.* Harorat datchigini issiq suvli idishga joylashtirib, ossillograf yoki LabVIEW muhitida oʻtish jarayoni egri chizigʻini yozib oling. $63.2%$ darajaga erishish vaqti boʻyicha $tau$ ni toping.
+ *4-bosqich: ISO 9283 boʻyicha robot pozitsion aniqligini oʻlchash.* Sanoat robotini belgilangan $P_c$ nuqtasiga 5 marta harakatlantirib, amaliy koordinatalarni lazer interferometr/indikatorda qayd qiling va $A P$ hamda $R P$ ni hisoblang.
+ *5-bosqich: natijalarni tahlil qilish va hisobot tayyorlash.* Hisoblangan metrologik parametrlarni standart talablar bilan taqqoslang.

= Nazorat va muhokama savollari

+ Metrologiya va metrologik tavsif tushunchalarining mexatronikadagi ahamiyati nimada?
+ Datchikning statik metrologik tavsiflariga nimalar kiradi va ularning bir-biridan farqini tushuntiring.
+ Datchikning sezgirligi ($S$) va ajratish qobiliyati ($Delta X$) oʻrtasidagi bogʻliqlik nimadan iborat?
+ Gisterezis hodisasi nima va u datchik aniqligiga qanday salbiy taʼsir koʻrsatadi?
+ 0-, 1- va 2-tartibli datchiklarning dinamik farqlarini tushuntiring.
+ 1-tartibli datchikda vaqt doimiysi $tau$ nimani anglatadi va $t = 3 tau$ vaqtida signal necha foizga erishadi?
+ 2-tartibli tebranma datchiklarda soʻnish koeffitsienti ($zeta$) qiymatining oʻtish jarayoniga taʼsiri qanday?
+ ISO 9283 standartiga koʻra pozitsiya aniqligi ($A P$) va pozitsiya takrorlanuvchanligi ($R P$) oʻrtasidagi tub farq nimada?
+ Nima uchun sanoat robotlarida pozitsiya takrorlanuvchanligi ($R P$) pozitsiya aniqligidan ($A P$) koʻra muhimroq hisoblanadi?
+ Sistematik va tasodifiy xatoliklarning kelib chiqish sabablari hamda ularni kamaytirish usullarini ayting.
+ Robot tutqichining dinamik tebranishlari va drift (siljish) hodisasi metrologik koʻrsatkichlarga qanday taʼsir qiladi?
+ Sanoat robotlarini kalibrlashda lazer treker va optik interferometr tizimlarining qoʻllanilish texnologiyasini izohlang.
