// ============================================================
//  MMRIQ — 5-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_5.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Informatsion tizim xatoliklari va ishonchliligini hisoblash")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 5  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №5]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Informatsion tizim xatoliklari va ishonchliligini hisoblash]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatron modullar va robotlarda qoʻllaniladigan informatsion tizimlarning oʻlchash xatoliklari turlari, statistik tahlil usullari, ishonchlilik koʻrsatkichlari (toʻxtovsiz ishlash ehtimoli $P(t)$, buzilishlar intensivligi $lambda$, MTBF, MTTR) hamda zaxiralangan va koʻp kanalli informatsion tizimlarning ishonchlilik modelini hisoblash koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Informatsion-oʻlchov tizimlaridagi xatoliklarning kelib chiqish manbalarini (datchik, kuchaytirgich, filtr, ADC va algoritmik xatolar) oʻrganish va ularning klassifikatsiyasini tahlil qilish.
+ Oʻlchash natijalarini statistik qayta ishlash: oʻrtacha arifmetik qiymat $macron(x)$, dispersiya $S^2$, oʻrtacha kvadratik ogʻish $sigma$ va Student $t$-taqsimoti boʻyicha ishonch oraliqlarini (_confidence intervals_) hisoblash.
+ Informatsion tizim va datchiklarning ishonchlilik koʻrsatkichlarini (buzilishlar intensivligi $lambda(t)$, toʻxtovsiz ishlash ehtimoli $P(t)$, buzilishlar orasidagi oʻrtacha vaqt --- MTBF, oʻrtacha tiklanish vaqti --- MTTR hamda tayyorlik koeffitsienti $K_t$) oʻrganish.
+ Ketma-ket (_series_), parallel (_parallel_) hamda zaxiralangan (_Triple Modular Redundancy_ --- TMR / $K$-out-of-$N$) informatsion tizimlarning ishonchlilik strukturaviy sxemalarini (RBD --- _Reliability Block Diagram_) tuzish va ularning umumiy ishonchlilik ehtimolini hisoblash.
+ Datchiklar va robotik informatsion kanallar ishonchliligini baholash boʻyicha amaliy va muhandislik masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* informatsion-oʻlchov tizimlarining xatoligi va ishonchliligini tadqiq qilish laboratoriya stendi, koʻp kanalli zaxiralangan datchiklar bloki (LVDT, optik enkoderlar, MEMS IMU, tenzometrlar).
- *Nazorat-oʻlchov va diagnostika vositalari:* raqamli ossillograf, yuqori aniqlikdagi multimetr, etalon chastota va kuchlanish generatori, nosozliklarni simulyatsiya qilish bloki (_Fault Injector Module_).
- *Dasturiy muhit:* MATLAB / Simulink (Statistics and Machine Learning Toolbox, Reliability funksiyalari), LabVIEW, Python (NumPy / SciPy / Statsmodels) statistik tahlil modullari.

= Nazariy maʼlumotlar va matematik modellar

== Informatsion tizimlardagi xatoliklar va ularning manbalari

Mexatronik informatsion tizimda fizik kattalikni oʻlchash va qayta ishlash zanjiri boʻylab xatoliklar yigʻilib boradi. *Xatolik* $E$ deb oʻlchash natijasi $X_"oʻlchov"$ va oʻlchanayotgan kattalikning haqiqiy (haqiqatga eng yaqin) qiymati $X_"haqiqiy"$ oʻrtasidagi farqqa aytiladi.

*1. Xatoliklar turlari:*

- *Absolyut xatolik ($Delta X$):* $Delta X = X_"oʻlchov" - X_"haqiqiy"$.
- *Nisbiy xatolik ($delta$):* $delta = (Delta X) / X_"haqiqiy" times 100%$.
- *Keltirilgan xatolik ($gamma$):* $gamma = (Delta X_"max") / X_"FS" times 100%$, bunda $X_"FS"$ --- oʻlchov shkalasining toʻliq diapazoni (_Full Scale_).

*2. Xatoliklarning paydo boʻlish xarakteriga koʻra sinflanishi:*

- *Sistematik xatoliklar ($E_"sys"$):* qayta oʻlchashlarda oʻzgarmas saqlanadigan yoki maʼlum qonuniyat boʻyicha oʻzgaradigan xatolar (kalibrlash buzilishi, harorat drifti). Tuzatishlar (_correction factor_) kiritish orqali yoʻqotiladi.
- *Tasodifiy xatoliklar ($accent(E, circle)$):* oldindan aytib boʻlmaydigan, elektromagnit shovqinlar, tebranishlar va issiqlik fluktuatsiyalaridan kelib chiquvchi xatolar. Ehtimollar nazariyasi (Gauss normal taqsimoti) boʻyicha tahlil qilinadi.
- *Qoʻpol xatoliklar (_gross errors_):* operator eʼtiborsizligi yoki qurilmaning keskin uzilishi tufayli yuzaga keladi va statistik mezonlar ($3 sigma$ qoidasi yoki Grubbs mezoni) yordamida olib tashlanadi.

== Tasodifiy xatoliklarning statistik tahlili

Agar bir xil sharoitda $N$ marta mustaqil oʻlchashlar oʻtkazilib, $x_1, x_2, dots, x_N$ natijalar olingan boʻlsa:

+ *Oʻrtacha arifmetik qiymat ($macron(x)$):*
  #eq($ macron(x) = 1 / N sum_(i=1)^N x_i $)
+ *Oʻrtacha kvadratik (standart) ogʻish ($S_x$):*
  #eq($ S_x = sqrt(1 / (N - 1) sum_(i=1)^N (x_i - macron(x))^2) $)
+ *Oʻrtacha qiymatning standart ogʻishi ($S_(macron(x))$):*
  #eq($ S_(macron(x)) = S_x / sqrt(N) $)
+ *Ishonch oraligʻi (_confidence interval_):* ishonch ehtimoli $P = 1 - alpha$ (masalan, $P = 0.95$ yoki $95%$) boʻlganda, oʻlchanayotgan kattalikning haqiqiy qiymati $X_"haqiqiy"$ quyidagi oraliqda yotadi:
  #eq($ macron(x) - t_(alpha, N-1) dot S_(macron(x)) <= X_"haqiqiy" <= macron(x) + t_(alpha, N-1) dot S_(macron(x)) $)
  bunda $t_(alpha, N-1)$ --- erkinlik darajasi $f = N - 1$ va ahamiyatlilik darajasi $alpha$ uchun Student koeffitsienti (@tab-student).

#figure(
  {
    set text(size: 10pt)
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: center + horizon,
      stroke: none,
      inset: (x: 6pt, y: 4pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Erkinlik darajasi \ ($f = N - 1$)*],
        [*$P = 90%$ \ ($alpha = 0.10$)*],
        [*$P = 95%$ \ ($alpha = 0.05$)*],
        [*$P = 99%$ \ ($alpha = 0.01$)*],
      ),
      table.hline(stroke: 0.5pt),
      [3], [2.353], [3.182], [5.841],
      [4], [2.132], [2.776], [4.604],
      [5], [2.015], [2.571], [4.032],
      [9], [1.833], [2.262], [3.250],
      [19], [1.729], [2.093], [2.861],
      [$infinity$], [1.645], [1.960], [2.576],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Student $t$-taqsimoti koeffitsientlarining jadval qiymatlari ($t_(alpha, f)$, ikki tomonlama)],
) <tab-student>

== Informatsion tizimlar va datchiklarning ishonchliligi nazariyasi

*Ishonchlilik (_Reliability_)* --- informatsion tizim yoki datchikning berilgan vaqt mobaynida va belgilangan ekspluatatsiya sharoitlarida oʻziga yuklatilgan funksiyalarni talab qilingan koʻrsatkichlar doirasida bajarish qobiliyatidir.

*Asosiy ishonchlilik koʻrsatkichlari:*

+ *Toʻxtovsiz ishlash ehtimoli ($P(t)$ --- Reliability Function):* tizimning $0$ dan $t$ gacha boʻlgan vaqt oraligʻida hech qanday buzilishsiz ishlash ehtimoli:
  #eq($ P(t) = P(T > t) = 1 - F(t) $)
  bunda $F(t)$ --- buzilishlar ehtimollik taqsimot funksiyasi.
+ *Buzilishlar intensivligi ($lambda(t)$ --- Failure Rate):* vaqtning $t$ momentida tizimning buzilish tezligini ifodalaydi. Eksponensial modelda $lambda = "const"$ boʻlsa:
  #eq($ P(t) = e^(-lambda t) $)
+ *Buzilishlar orasidagi oʻrtacha vaqt (MTBF --- Mean Time Between Failures):*
  #eq($ "MTBF" = integral_0^infinity P(t) dif t = integral_0^infinity e^(-lambda t) dif t = 1 / lambda $)
+ *Oʻrtacha tiklanish vaqti (MTTR --- Mean Time To Repair):* nosozlik yuz berganda uni bartaraf etish va tizimni qayta ishga tushirish uchun ketgan oʻrtacha vaqt.
+ *Tayyorlik koeffitsienti ($K_t$ --- Availability Factor):* tizimning ixtiyoriy vaqt momentida ishchi holatda boʻlish ehtimoli:
  #eq($ K_t = "MTBF" / ("MTBF" + "MTTR") $)

== Strukturaviy ishonchlilik modellari va zaxiralash (Redundancy)

Informatsion tizim bir nechta datchik, modul va aloqa kanallaridan iborat boʻlganda, uning umumiy ishonchliligi ushbu modullarning ulanish strukturasiga bogʻliq (@fig-rbd).

=== Ketma-ket ulanish strukturasi (Series System)

Tizim ishlashi uchun barcha $n$ ta modul bir vaqtda soz holatda boʻlishi shart. Agar birorta modul buzilsa, butun tizim ishdan chiqadi:

#eq($ P_"sys" (t) = P_1 (t) dot P_2 (t) dots P_n (t) = product_(i=1)^n P_i (t) $)

Barcha modullar bir xil $lambda$ intensivlikka ega boʻlsa: $P_"sys" (t) = e^(-n lambda t)$, $"MTBF"_"sys" = 1 \/ (n lambda)$.

=== Parallel ulanish strukturasi (Parallel System / Full Redundancy)

Tizim ishlashi uchun kamida bitta modul soz boʻlishi yetarli. Tizim faqat barcha $n$ ta modul bir vaqtda buzilgandagina ishdan chiqadi:

#eq($ P_"sys" (t) = 1 - product_(i=1)^n (1 - P_i (t)) = 1 - (1 - e^(-lambda t))^n $)

=== Majoritar zaxiralash ($K$-out-of-$N$ / TMR --- Triple Modular Redundancy)

Kritik robotik informatsion tizimlarda 3 ta bir xil datchik (TMR --- 2-out-of-3) qoʻllaniladi. Majoritar element (ovoz berish --- _voting_ mantiqi) kamida 2 ta mos kelgan datchik signalini toʻgʻri deb qabul qiladi (ovoz beruvchi elementning oʻzi ideal deb olinadi):

#eq($ P_"TMR" (t) = 3 P^2 (t) - 2 P^3 (t) = 3 e^(-2 lambda t) - 2 e^(-3 lambda t) $)

= Mavzuga oid chizmalar va sxemalar

== Informatsion tizim oʻlchov zanjiri boʻylab xatoliklarning yigʻilishi (Error Propagation)

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let orng = orange.darken(15%)
    let err(body) = text(size: 7pt, weight: "bold", fill: orng, align(center, body))
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (6mm, 8mm),
      edge-stroke: 2pt + headingblue,

      node((0, 1), b[*Datchik* \ (sensor)], width: 2.2cm, height: 1.1cm),
      node((1, 1), b[*Signalni* \ *konditsiyalash* \ (Op-Amp / LPF)], width: 2.4cm, height: 1.1cm),
      node((2, 1), b[*12/16-bit* \ *ADC*], width: 2.2cm, height: 1.1cm),
      node((3, 1), b[*Mikrokontroller* \ *algoritmi*], width: 2.4cm, height: 1.1cm),
      node(
        (4, 1),
        b[*Chiqish natijasi* \ $X_"oʻlchov" plus.minus Delta X$],
        width: 2.5cm,
        height: 1.1cm,
        fill: red.lighten(90%),
        stroke: 1pt + red,
      ),

      node((0, 0), err[Nochiziqlilik, \ gisterezis, harorat drifti], stroke: none, fill: none),
      node((1, 0), err[Shovqin (noise), \ ofset kuchlanishi], stroke: none, fill: none),
      node((2, 0), err[Kvantlash xatosi \ (quantization)], stroke: none, fill: none),
      node((3, 0), err[Yaxlitlash, \ approksimatsiya], stroke: none, fill: none),

      edge((0, 1), (1, 1), "-|>", stroke: 1pt),
      edge((1, 1), (2, 1), "-|>", stroke: 1pt),
      edge((2, 1), (3, 1), "-|>", stroke: 1pt),
      edge((3, 1), (4, 1), "-|>", stroke: 1pt + red),
      ..range(0, 4).map(i => edge((i, 0), (i, 1), "-|>", stroke: 1pt + orng)),
    )
  },
  caption: [Informatsion-oʻlchov zanjiri boʻylab xatoliklar yigʻilishining blok-diagrammasi],
) <fig-err>

== Datchiklar va informatsion modullarning “vannasimon” (bathtub curve) buzilishlar intensivligi grafigi

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let arr = (end: "stealth", fill: black)
    let small(body) = text(size: 7.5pt, weight: "bold", body)
    let dash = (paint: blue.lighten(10%), thickness: 1pt, dash: "dashed")

    line((0, 0), (6.5, 0), stroke: 1pt, mark: arr)
    line((0, 0), (0, 4.0), stroke: 1pt, mark: arr)
    content((6.6, 0), anchor: "west", text(size: 9pt)[Vaqt ($t$, ekspluatatsiya)])
    content((0, 4.1), anchor: "south", text(size: 9pt)[Buzilishlar intensivligi ($lambda(t)$)])

    // Davr chegaralari
    line((1.8, 0), (1.8, 3.8), stroke: dash)
    line((4.2, 0), (4.2, 3.8), stroke: dash)

    // Vannasimon egri chiziq
    let bc = 2.2pt + headingblue
    bezier((0.3, 3.5), (1.8, 0.8), (0.8, 0.8), (1.5, 0.8), stroke: bc)
    line((1.8, 0.8), (4.2, 0.8), stroke: bc)
    bezier((4.2, 0.8), (5.8, 3.8), (4.8, 0.8), (5.5, 2.5), stroke: bc)

    content((0.95, 2.2), align(center, text(fill: orange.darken(15%), small[I davr: \ ishga tushirish \ (burn-in)])))
    content((3.0, 1.3), align(center, text(
      fill: headingblue,
      small[II davr: normal ekspluatatsiya \ ($lambda = "const"$, tasodifiy buzilishlar)],
    )))
    content((5.05, 2.2), align(center, text(fill: red, small[III davr: \ yeyilish / qarish \ (wear-out)])))
  }),
  caption: [Datchik va elektron modullarning ekspluatatsiya davridagi “vannasimon” buzilishlar intensivligi $lambda(t)$],
) <fig-bathtub>

== Ketma-ket, parallel va majoritar (TMR) zaxiralangan tizimlarning ishonchlilik strukturaviy sxemalari (RBD)

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let w = 1pt
    let arr = (end: "stealth", fill: black)
    let mblock(c, body) = {
      rect(
        (c.at(0) - 0.85, c.at(1) - 0.4),
        (c.at(0) + 0.85, c.at(1) + 0.4),
        radius: 0.08,
        fill: blue.lighten(93%),
        stroke: 0.8pt + headingblue,
      )
      content(c, align(center, text(size: 7pt, weight: "bold", body)))
    }
    let title(y, body) = content((-1.2, y), anchor: "east", text(size: 9pt, weight: "bold", body))

    // ---- a) Ketma-ket ----
    let ya = 2.9
    title(ya)[a) Ketma-ket:]
    mblock((0.6, ya))[Modul 1 \ $P_1$]
    mblock((3.0, ya))[Modul 2 \ $P_2$]
    mblock((5.4, ya))[Modul 3 \ $P_3$]
    line((-0.9, ya), (-0.25, ya), stroke: w, mark: arr)
    line((1.45, ya), (2.15, ya), stroke: w, mark: arr)
    line((3.85, ya), (4.55, ya), stroke: w, mark: arr)
    line((6.25, ya), (7.0, ya), stroke: w, mark: arr)

    // ---- b) Parallel ----
    let yb = 0
    title(yb)[b) Parallel:]
    mblock((3.0, yb + 0.8))[Sensor A ($P_1$)]
    mblock((3.0, yb - 0.8))[Sensor B ($P_2$)]
    line((-0.9, yb), (1.2, yb), stroke: w)
    line((1.2, yb - 0.8), (1.2, yb + 0.8), stroke: w)
    line((1.2, yb + 0.8), (2.15, yb + 0.8), stroke: w)
    line((1.2, yb - 0.8), (2.15, yb - 0.8), stroke: w)
    line((3.85, yb + 0.8), (4.8, yb + 0.8), stroke: w)
    line((3.85, yb - 0.8), (4.8, yb - 0.8), stroke: w)
    line((4.8, yb - 0.8), (4.8, yb + 0.8), stroke: w)
    line((4.8, yb), (7.0, yb), stroke: w, mark: arr)

    // ---- c) TMR (2/3) ----
    let yc = -3.2
    title(yc)[c) TMR (2/3):]
    for (i, dy) in (1.0, 0, -1.0).enumerate() {
      mblock((1.5, yc + dy))[Sensor #(i + 1)]
      line((-0.9, yc), (-0.2, yc), stroke: w)
      line((-0.2, yc + dy), (0.65, yc + dy), stroke: w)
    }
    line((-0.2, yc - 1.0), (-0.2, yc + 1.0), stroke: w)
    let maj = (4.2, yc)
    line((2.35, yc + 1.0), (maj.at(0), yc + 1.0), (maj.at(0), yc + 0.5), stroke: w)
    line((2.35, yc), (maj.at(0) - 0.5, yc), stroke: w)
    line((2.35, yc - 1.0), (maj.at(0), yc - 1.0), (maj.at(0), yc - 0.5), stroke: w)
    circle(maj, radius: 0.5, fill: orange.lighten(80%), stroke: 1.2pt + orange.darken(15%))
    content(maj, align(center, text(size: 7pt, weight: "bold")[2/3 \ Maj]))
    line((maj.at(0) + 0.5, yc), (7.0, yc), stroke: 2pt + orange.darken(15%), mark: (
      end: "stealth",
      fill: orange.darken(15%),
    ))
  }),
  caption: [Informatsion tizimlar ishonchliligining strukturaviy koʻrinishlari (RBD)],
) <fig-rbd>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: informatsion tizimdagi xatolik turlarini va ularni kamaytirish usullarini tahlil qilish

Mexatronik va robotik informatsion tizimda uchraydigan xatolik manbalarini tahlil qiling va @tab-err ni toʻldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.2cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Xatolik manbai*], [*Xatolik shakli / koʻrinishi*], [*Kompensatsiya / yoʻqotish usuli*]),
      table.hline(stroke: 0.5pt),
      [1], [Datchik harorat drifti], [Sistematik (nol siljishi va sezgirlik oʻzgarishi)],
      [Dasturiy harorat kompensatsiyasi, termostatlash.],
      [2], [Elektromagnit shovqinlar], [Tasodifiy (tebranma fluktuatsiyalar)],
      [Ekranlangan kabel, median va Kalman filtrlari.],
      [3], [ADC kvantlash xatosi], [Chekli ajratish qobiliyati ($plus.minus 0.5 "LSB"$)],
      [ADC bitlar sonini oshirish ($12 -> 16$-bit), oversampling.],
      [4], [Operator xatosi / tarmoq uzilishi], [Qoʻpol xatolik (keskin sakrashlar)],
      [Grubbs va $3 sigma$ qoidasi boʻyicha maʼlumotni filtrlash.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Informatsion tizim xatoliklari tahlili va kompensatsiya usullari],
) <tab-err>

== Topshiriq 2: kritik robotik tizimlar uchun zaxiralash darajasini tanlash

Avtonom uchuvchisiz dron (UAV) va sanoat roboti uchun sensorlar zaxiralanadi.

- *UAV navigatsiya tizimi:* MEMS IMU datchigining buzilishlar intensivligi $lambda = 10^(-4) "1/soat"$.
- *Variant A (zaxirasiz):* 1 ta IMU.
- *Variant B (TMR --- 2/3):* 3 ta IMU va majoritar mantiqiy blok.

$t = 500 "soat"$ parvoz vaqtida har bir variantning ishonchlilik ehtimoli $P(t)$ ni taqqoslang.

*Yechim:* $lambda t = 10^(-4) times 500 = 0.05$.

#eq($ P_A = e^(-0.05) approx 0.9512 quad (95.12%) $)
#eq($ P_B = 3 e^(-0.10) - 2 e^(-0.15) = 3 times 0.9048 - 2 times 0.8607 approx 0.9931 quad (99.31%) $)

TMR zaxiralash nosozlik ehtimolini $4.88%$ dan $0.69%$ gacha, yaʼni taxminan 7 baravar kamaytiradi.

= Hisoblash va modellashtirish masalalari

== Masala 1: oʻlchov natijalarini statistik tahlil qilish va Student boʻyicha oraliq baholash

Optik enkoder yordamida robot boʻgʻinining burilish burchagi bir xil sharoitda $N = 6$ marta oʻlchandi va quyidagi natijalar olindi (gradusda):

#eq($ x_i = {45.12 degree, 45.18 degree, 45.10 degree, 45.15 degree, 45.14 degree, 45.11 degree} $)

#set enum(numbering: "a)")
+ Oʻrtacha arifmetik qiymat $macron(x)$, dispersiya $S_x^2$ va oʻrtacha kvadratik ogʻish $S_x$ ni hisoblang.
+ Oʻrtacha qiymatning standart ogʻishi $S_(macron(x))$ ni aniqlang.
+ Ishonch ehtimoli $P = 0.95$ ($95%$) boʻlganda Student koeffitsientini @tab-student dan olib, burilish burchagining haqiqiy qiymati uchun ishonch oraligʻini toping.
#set enum(numbering: "1.")

*Hisoblash bosqichlari:*

- Oʻrtacha arifmetik qiymat $macron(x)$:
  #eq($ macron(x) = (45.12 + 45.18 + 45.10 + 45.15 + 45.14 + 45.11) / 6 = 270.80 / 6 approx 45.1333 degree $)
- Ogʻishlar kvadratlari yigʻindisi $sum (x_i - macron(x))^2$:
  #eq($ (45.12 - 45.1333)^2 = (-0.0133)^2 = 0.000177, \ quad (45.18 - 45.1333)^2 = (0.0467)^2 = 0.002181 $)
  #eq($ (45.10 - 45.1333)^2 = (-0.0333)^2 = 0.001109, \ quad (45.15 - 45.1333)^2 = (0.0167)^2 = 0.000279 $)
  #eq($ (45.14 - 45.1333)^2 = (0.0067)^2 = 0.000045, \ quad (45.11 - 45.1333)^2 = (-0.0233)^2 = 0.000543 $)
  #eq($ sum (x_i - macron(x))^2 = 0.004334 $)
- Dispersiya va tanlanma standart ogʻishi $S_x$:
  #eq($ S_x^2 = 0.004334 / (6 - 1) = 0.004334 / 5 = 0.0008668 ==> S_x = sqrt(0.0008668) approx 0.02944 degree $)
- Oʻrtacha qiymatning standart ogʻishi $S_(macron(x))$:
  #eq($ S_(macron(x)) = S_x / sqrt(6) = 0.02944 / 2.4495 approx 0.01202 degree $)
- Student koeffitsienti $P = 0.95$ va $f = N - 1 = 5$ uchun jadval boʻyicha: $t_(0.05, 5) = 2.571$.
- Ishonch chegarasi: $Delta = t dot S_(macron(x)) = 2.571 times 0.01202 degree approx 0.0309 degree$.
- Yakuniy ishonch oraligʻi ($95%$ ehtimollik bilan):
  #eq(
    $
      X_"haqiqiy" = 45.1333 degree plus.minus 0.0309 degree quad "yoki" quad 45.1024 degree <= X_"haqiqiy" <= 45.1642 degree
    $,
  )

== Masala 2: datchikning toʻxtovsiz ishlash ehtimoli $P(t)$ va MTBF hisobi

Sanoat roboti boʻgʻinidagi tok sensori drayverining buzilishlar intensivligi oʻzgarmas boʻlib, $lambda = 2.5 times 10^(-5) "1/soat"$ ga teng.

#set enum(numbering: "a)")
+ Sensorning buzilishlar orasidagi oʻrtacha vaqti (MTBF) necha soat va necha yilni tashkil etadi ($1 "yil" approx 8760 "soat"$)?
+ Sensorning $t = 1000$, $5000$ va $10000$ soat ekspluatatsiya vaqtidagi toʻxtovsiz ishlash ehtimolliklari $P(t)$ ni hisoblang.
+ Agar sensorni tiklash uchun oʻrtacha $"MTTR" = 5 "soat"$ ketsa, tayyorlik koeffitsienti $K_t$ qanchaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ "MTBF" = 1 / lambda, quad quad P(t) = e^(-lambda t), quad quad K_t = "MTBF" / ("MTBF" + "MTTR") $)

*Hisoblash bosqichlari:*

- MTBF hisobi:
  #eq($ "MTBF" = 1 / (2.5 times 10^(-5)) = 40000 "soat" approx 40000 / 8760 approx 4.566 "yil" $)
- $P(t)$ ehtimolliklar hisobi:
  #eq($ P(1000) = e^(-(2.5 times 10^(-5)) times 1000) = e^(-0.025) approx 0.9753 quad (97.53%) $)
  #eq($ P(5000) = e^(-(2.5 times 10^(-5)) times 5000) = e^(-0.125) approx 0.8825 quad (88.25%) $)
  #eq($ P(10000) = e^(-(2.5 times 10^(-5)) times 10000) = e^(-0.250) approx 0.7788 quad (77.88%) $)
- Tayyorlik koeffitsienti $K_t$:
  #eq($ K_t = 40000 / (40000 + 5) = 40000 / 40005 approx 0.999875 quad (99.9875%) $)

== Masala 3: zaxiralangan robotik informatsion tizimning ishonchlilik hisobi

Mobil robot navigatsiya tizimida 3 ta bir xil lidar sensori TMR (2/3) majoritar zaxiralash sxemasi boʻyicha ulangan. Har bir lidar datchigining $t = 2000 "soat"$ vaqtdagi toʻxtovsiz ishlash ehtimoli $P_1 = P_2 = P_3 = P = 0.90$ ($90%$).

#set enum(numbering: "a)")
+ Bitta lidar (zaxirasiz) ishlatilgandagi ishonchlilik ehtimoli $P_"single"$ ni aniqlang.
+ TMR (2/3) zaxiralangan informatsion tizimning umumiy ishonchlilik ehtimoli $P_"TMR"$ ni hisoblang va zaxiralash samarasini baholang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ P_"TMR" (t) = 3 P^2 (t) - 2 P^3 (t) $)

*Hisoblash bosqichlari:*

- Yakka sensor ishonchliligi: $P_"single" = 0.90$ ($90.0%$).
- TMR (2/3) zaxiralangan tizim ishonchliligi:
  #eq(
    $
      P_"TMR" = 3 times (0.90)^2 - 2 times (0.90)^3 = 3 times 0.81 - \ 2 times 0.729 = 2.43 - 1.458 = 0.972 quad (97.2%)
    $,
  )
- Xulosa: TMR (2/3) zaxiralash qoʻllanilishi natijasida informatsion tizimning toʻxtovsiz ishlash ehtimoli $90.0%$ dan $97.2%$ ga koʻtarildi va nosozlik ehtimoli $10%$ dan $2.8%$ ga (yaʼni $3.57$ baravar) kamaydi.

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: oʻlchov natijalarini toʻplash va statistik tozalash.* Laboratoriya stendidagi datchik koʻrsatkichlarini $N = 6 dots 10$ marta yozib oling. Qoʻpol xatoliklarni Grubbs yoki $3 sigma$ qoidasi boʻyicha maʼlumotlar toʻplamidan chiqarib tashlang.
+ *2-bosqich: statistik koʻrsatkichlarni hisoblash.* Olingan tanlanma boʻyicha $macron(x)$, $S_x$, $S_(macron(x))$ qiymatlarini hisoblang va $95%$ ishonch darajasida Student ishonch oraligʻini aniqlang.
+ *3-bosqich: datchiklar va modullarning ishonchlilik koʻrsatkichlarini modellashtirish.* MATLAB / Python muhitida eksponensial taqsimot boʻyicha $P(t) = e^(-lambda t)$ grafigini turli $lambda$ qiymatlari uchun chizing.
+ *4-bosqich: zaxiralangan tizimlar ishonchliligini simulyatsiya qilish.* Ketma-ket, parallel va TMR (2/3) ulanish strukturalari boʻyicha $P_"sys" (t)$ grafiklarini taqqoslang.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan natijalarni tahlil qilib, amaliy hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Informatsion tizimlardagi absolyut, nisbiy va keltirilgan xatoliklarning taʼrifini va farqini tushuntiring.
+ Sistematik va tasodifiy xatoliklarning kelib chiqish sabablari hamda ularni kamaytirish usullarini ayting.
+ Student $t$-taqsimoti nima va u kichik hajmdagi ($N < 30$) tanlanmalarda ishonch oraligʻini topishda qanday qoʻllaniladi?
+ Datchik va informatsion modullarning toʻxtovsiz ishlash ehtimoli $P(t)$ va buzilishlar intensivligi $lambda$ oʻrtasidagi bogʻliqlikni izohlang.
+ “Vannasimon” (_bathtub curve_) buzilishlar intensivligi grafigining 3 ta davri qanday xarakterlanadi?
+ MTBF (_Mean Time Between Failures_) va MTTR (_Mean Time To Repair_) koʻrsatkichlari nimani anglatadi?
+ Tayyorlik koeffitsienti $K_t$ qanday hisoblanadi va unga MTTR parametrining taʼsiri qanday?
+ Ketma-ket ulangan informatsion tizimlarning umumiy ishonchliligi nima uchun alohida modullar ishonchliligidan har doim kichik boʻladi?
+ Parallel zaxiralangan va majoritar (TMR --- 2/3) zaxiralangan tizimlarning afzallik hamda kamchiliklarini tushuntiring.
+ Nima uchun kritik robototexnik tizimlarda (kosmik robotlar, avtonom transport, tibbiyot robotlari) TMR zaxiralash qoʻllaniladi?
+ ADC kvantlash xatosi (_quantization error_) raqamli informatsion kanallarda qanday nazorat qilinadi?
+ Kalman filtri va median filtri tasodifiy oʻlchov xatoliklarini kamaytirishda qanday vazifani bajaradi?
