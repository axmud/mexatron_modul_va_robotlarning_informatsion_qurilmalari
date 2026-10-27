// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №9. Mexatron modullar va robotlarning metrologik tavsiflari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №9. Mexatron modullar va robotlarning metrologik tavsiflari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 9  // maʼruza raqami
#set document(keywords: (info.fan,))
#set page(header: context {
  set text(size: 9pt, fill: luma(110))
  grid(
    columns: (3fr, auto, 1fr),
    align: (left, center, right),
    info.fan, info.semestr, [Maʼruza №#raqam],
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + luma(170))
})
// ===================
#set text(size: 12pt, lang: "uz", font: info.font)
#set par(justify: true, leading: 0.75em, first-line-indent: (amount: 1.25cm, all: true))
#set heading(numbering: "1.1.")
#show heading: set text(fill: headingblue)
#show heading.where(level: 1): it => block(above: 1.4em, below: 0.9em, text(size: 14pt, it))
#show heading.where(level: 2): it => block(above: 1.2em, below: 0.7em, text(size: 12.5pt, it))
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)

#show figure.where(kind: image): set figure(supplement: "Rasm")
#show figure.where(kind: table): set figure(supplement: "Jadval")
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption: set text(size: 11pt)
#show table: set par(justify: false, first-line-indent: 0pt)

#let eq(body) = math.equation(block: true, numbering: "(1)", body)
#show figure.where(kind: table): set block(breakable: true)

// booktabs uslubidagi jadval
#let btable(columns: auto, align: left, header: (), ..rows) = table(
  columns: columns,
  align: align,
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 1pt),
  table.header(..header.map(h => text(weight: "bold", h))),
  table.hline(stroke: 0.6pt),
  ..rows,
  table.hline(stroke: 1pt),
)

// ---------------------------------------------------------------------
// Sarlavha
// ---------------------------------------------------------------------
#align(center)[
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №9]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarning metrologik tavsiflari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Metrologiyaning asosiy tuşunçalari. Kalibrlaş va metrologik kuzatuvçanlik.
  + Metrologik tavsiflarning tasnifi.
  + Statik metrologik tavsiflar.
  + Ölçaş xatoliklari, ularni normalaş va yiğiş. Ölçaş noaniqligi.
  + Dinamik metrologik tavsiflar.
  + Mexatron modullarning metrologik tavsiflari.
  + Robotlarning metrologik tavsiflari (ISO 9283).

  *Tayanç iboralar:* ölçaş vositasi, metrologik tavsif, kalibrlaş, qiyoslaş, etalon, metrologik kuzatuvçanlik, özgartiriş funksiyasi, sezgirlik, çiziqlilik xatosi, gisterezis, takrorlanuvçanlik, harorat drifti, asosiy va qöşimça xatolik, aniqlik klassi, xatoliklarni geometrik yiğiş, standart va kengaytirilgan noaniqlik, amplituda-çastota tavsifi, dinamik xatolik, lyuft, buriliş bikrligi, pozitsiyalaş aniqligi va takrorlanuvçanligi.
]

// =====================================================================
= Metrologiyaning asosiy tuşunçalari
// =====================================================================

Oldingi maʼruzalarda robotlarda qöllanadigan turli datçiklar körib çiqildi. Ularning har biri ölçaş vositasi bölib, uning natijasiga qançalik işoniş mumkinligini biliş kerak. Bu masalalar bilan *metrologiya* — ölçaşlar, ularning birligini taʼminlaş usullari va vositalari hamda talab qilinadigan aniqlikka erişiş usullari haqidagi fan şuğullanadi.

Asosiy tuşunçalar:
- *ölçaş* — fizik kattalik qiymatini tajriba yöli bilan maxsus texnik vositalar yordamida aniqlaş;
- *ölçaş vositasi* — ölçaş uçun möljallangan va normalangan metrologik tavsiflarga ega texnik vosita (datçik, ölçaş asbobi, ölçaş tizimi);
- *metrologik tavsif* — ölçaş vositasining ölçaş natijasi va uning xatoligiga taʼsir qiluvçi xossasini miqdoriy ifodalovçi körsatkiç;
- *normalangan metrologik tavsiflar* — işlab çiqaruvçi tomonidan kafolatlangan va ölçaş vositasi hujjatlarida (pasportida) körsatilgan tavsiflar.

== Kalibrlaş va metrologik kuzatuvçanlik

*Kalibrlaş* — ölçaş vositasi körsatkiçlari bilan aniqroq ölçaş vositasi (etalon) tomonidan aniqlangan qiymatlar orasidagi boğliqlikni belgilaş amallari majmuasi. Kalibrlaş natijasida ölçaş vositasining haqiqiy özgartiriş funksiyasi va xatoligi aniqlanadi. Qonun bilan tartibga solinadigan sohalarda (savdo, xavfsizlik, soğliqni saqlaş) qöllanadigan ölçaş vositalari esa vakolatli metrologiya xizmati tomonidan davriy *qiyoslanadi* — ularning belgilangan talablarga mosligi tasdiqlanadi.

Har bir ölçaş natijasi uzluksiz kalibrlaşlar zanjiri orqali xalqaro birliklar tizimi (SI) birliklarini qayta hosil qiluvçi davlat etalonlari bilan boğlangan bölişi kerak. Bu xossa *metrologik kuzatuvçanlik* deyiladi (1-rasm). Zanjirning har bir poğonasida aniqlik biroz kamayadi, şuning uçun etalon kalibrlanayotgan vositadan odatda bir neça marta aniqroq bölişi talab qilinadi.

#figure(
  diagram(
    spacing: (6mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [SI birligi, \ davlat etaloni], fill: lightorange, name: <a>),
    node((1, 0), [Işçi \ etalonlar], name: <b>),
    node((2, 0), [Kalibrlaş \ laboratoriyasi], name: <c>),
    node((3, 0), [Kalibrlaş \ stendi], name: <d>),
    node((4, 0), [Datçik, \ robot], fill: white, name: <e>),
    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <d>, "->"),
    edge(<d>, <e>, "->"),
  ),
  caption: [Metrologik kuzatuvçanlik zanjiri (çapdan öngga aniqlik kamayadi)],
) <fig-kuzat>

// =====================================================================
= Metrologik tavsiflarning tasnifi
// =====================================================================

Datçik va ölçaş vositalarining metrologik tavsiflari quyidagi guruhlarga bölinadi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.6fr),
    header: ([Guruh], [Tavsiflar]),
    [Ölçaş natijasini aniqlaş uçun tavsiflar],
    [Özgartiriş funksiyasi (statik tavsif), ölçaş diapazoni, sezgirlik, ruxsat qobiliyati, raqamli kod qiymati],
    [Xatolik tavsiflari],
    [Asosiy xatolik, uning sistematik va tasodifiy taşkil etuvçilari, çiziqlilik xatosi, gisterezis, takrorlanuvçanlik, aniqlik klassi],
    [Taʼsir etuvçi kattaliklarga sezgirlik],
    [Harorat, taʼminot kuçlanişi, namlik, vibratsiya taʼsiridagi qöşimça xatoliklar va driftlar],
    [Dinamik tavsiflar],
    [Vaqt doimiysi, javob vaqti, amplituda-çastota va faza-çastota tavsiflari, ötkaziş polosasi, xususiy çastota],
    [Özaro taʼsir tavsiflari],
    [Kiriş va çiqiş qarşiliklari (impedanslari), obyektga va keyingi qurilmaga taʼsiri],
  ),
  caption: [Metrologik tavsiflarning tasnifi],
) <tab-tasnif>

Oxirgi guruh köpinça eʼtibordan çetda qoladi, lekin muhim: masalan, potensiometr çiqişiga kiçik qarşilikli yuklama ulansa, tavsif buziladi (5-maʼruza), termojuftni ulovçi uzun simlar esa ölçaş natijasiga taʼsir qiladi.

// =====================================================================
= Statik metrologik tavsiflar
// =====================================================================

Kiriş kattaligi özgarmas yoki juda sekin özgarganda datçik çiqişi $y$ ning kirişi $x$ ga boğliqligi *özgartiriş funksiyasi* (statik tavsif) $y = f(x)$ bilan ifodalanadi. Uning asosiy körsatkiçlari:

- *ölçaş diapazoni* — kattalikning normalangan xatolik bilan ölçanadigan qiymatlar oraliği $[x_min, x_max]$; çiqiş diapazoni (töliq şkala, FS) $Y_"FS" = y(x_max) - y(x_min)$;
- *sezgirlik* — $S = d y slash d x$; çiziqli datçikda özgarmas;
- *ruxsat qobiliyati* — çiqişda sezilarli özgariş beradigan kirişning eng kiçik özgarişi; *sezgirlik bösağasi* esa nol atrofidagi şunday eng kiçik qiymat;
- *çiziqlilik xatosi* — real tavsifning tanlangan töğri çiziqdan eng katta çetlanişi $Delta_max$ ning töliq şkalaga nisbati:

#eq($ delta_L = (Delta_max) / Y_"FS" dot 100 %. $)

Töğri çiziq turliça tanlanişi mumkin: diapazon çekka nuqtalaridan ötuvçi çiziq yoki eng kiçik kvadratlar usulida topilgan çiziq. Ikkinçi usulda xatolik kiçikroq çiqadi, şuning uçun datçik pasportida qaysi usul qöllangani körsatilişi kerak.

- *gisterezis* — kiriş ortib va kamayib borganda bir xil $x$ ga mos çiqişlarning eng katta farqi (töliq şkalaga nisbatan, %);
- *takrorlanuvçanlik* — bir xil şaroitda, bir yönalişdan bir xil kirişga takroriy yondaşganda natijalarning tarqoqligi;
- *nol siljişi va sezgirlik drifti* — taʼsir etuvçi kattaliklar, ayniqsa harorat özgarganda tavsifning siljişi.

Haroratning taʼsirini quyidagi model bilan ifodalaş mumkin:

#eq($ y = S (1 + beta Delta T) dot x + y_0 + gamma Delta T, $)

bu yerda $Delta T$ — normal haroratdan çetlaniş, $beta$ — sezgirlikning harorat koeffitsienti, $gamma$ — nol siljişining harorat koeffitsienti. *Misol.* Bosim datçigi uçun $gamma = 0","02 %$ FS/°C bölsa, normal 20 °C dan 50 °C gaça qiziş nolni 0,6 % FS ga siljitadi — bu köp datçiklarning asosiy xatoligidan katta. Şuning uçun datçik pasportida *asosiy xatolik* (normal şaroitda) bilan bir qatorda har bir taʼsir etuvçi kattalik uçun *qöşimça xatolik* ham normalanadi.

// =====================================================================
= Ölçaş xatoliklari, ularni normalaş va yiğiş
// =====================================================================

== Xatoliklarning ifodalanişi va aniqlik klassi

Ölçaş xatoligi absolyut ($Delta = x_"öl" - x_"h"$), nisbiy ($delta = Delta slash x_"h" dot 100 %$) va keltirilgan körinişda ifodalanadi. Datçik va asboblar uçun köpinça *keltirilgan xatolik* normalanadi:

#eq($ gamma = Delta / X_N dot 100 %, $)

bu yerda $X_N$ — normalovçi qiymat (odatda ölçaş diapazoni). Ruxsat etilgan eng katta keltirilgan xatolik ölçaş vositasining *aniqlik klassini* belgilaydi: masalan, 0,5 klass $|gamma| <= 0","5 %$ ni anglatadi. Keltirilgan xatolik butun diapazonda bir xil bölgani uçun nisbiy xatolik kiçik qiymatlarni ölçaşda keskin ortadi; şu sababli datçik diapazoni ölçanadigan qiymat diapazonning yuqori qismida böladigan qilib tanlanadi.

Kelib çiqişiga köra xatoliklar *sistematik* (özgarmas yoki qonuniy özgaradi, kalibrlaş va tuzatiş orqali kamaytiriladi), *tasodifiy* (statistik usullar bilan baholanadi, köp marta ölçab örtaçalaş orqali kamaytiriladi) va *qöpol* (natijalardan çiqarib taşlanadi) turlarga bölinadi. Tasodifiy xatoliklarni statistik qayta işlaş usullari amaliy maşğulotlarda batafsil örganiladi.

== Xatoliklarni yiğiş

Ölçaş kanali bir neçta elementdan (datçik, kuçaytirgiç, ARO) iborat bölib, har biri öz xatoligini qöşadi. Agar elementlar xatoliklari bir-biriga boğliq bölmagan tasodifiy kattaliklar bölsa, umumiy xatolik *geometrik* (kvadratik) yiğindi bilan baholanadi:

#eq($ Delta_Sigma = sqrt(Delta_1^2 + Delta_2^2 + dots + Delta_n^2). $)

*Misol.* Datçik xatoligi 0,1 %, kuçaytirgiçniki 0,05 %, ARO niki 0,02 % bölsa, $Delta_Sigma = sqrt(0","1^2 + 0","05^2 + 0","02^2) approx 0","114 %$. Arifmetik yiğindi esa 0,17 % ni beradi — bu eng yomon holat, barça xatoliklar bir vaqtda eng katta qiymatga va bir yönalişga ega bölgandagi baho. (4) ifodadan muhim amaliy xulosa: umumiy xatolikni asosan eng katta taşkil etuvçi belgilaydi. Bu misolda ARO aniqligini oşiriş deyarli foyda bermaydi, datçikni yaxşilaş esa sezilarli natija beradi.

== Ölçaş noaniqligi

Zamonaviy xalqaro amaliyotda ölçaş natijasining sifati *noaniqlik* tuşunçasi bilan ifodalanadi. Noaniqlik — ölçanayotgan kattalikka asosli ravişda mos keladigan qiymatlarning tarqoqligini tavsiflovçi parametr. Har bir noaniqlik manbai *standart noaniqlik* $u_i$ (standart oğiş körinişida) bilan baholanadi va ular (4) ga öxşaş tarzda birlaştirilib, *jamlangan standart noaniqlik* $u_c$ olinadi. Natija *kengaytirilgan noaniqlik* bilan beriladi:

#eq($ U = k dot u_c, $)

bu yerda $k$ — qamrov koeffitsienti; $k = 2$ normal taqsimotda taxminan 95 % işonç ehtimoliga mos keladi. Natija $x = hat(x) plus.minus U$ körinişida yoziladi, masalan, «$25","40 plus.minus 0","04$ mm, $k = 2$».

// =====================================================================
= Dinamik metrologik tavsiflar
// =====================================================================

Kiriş kattaligi tez özgarganda datçik çiqişi undan keçikadi va amplitudasi buziladi. Bu holat *dinamik tavsiflar* bilan baholanadi. Birinçi tartibli datçikning (termojuft, termorezistor, filtrli datçiklar) uzatiş funksiyasi $W(s) = S slash (tau s + 1)$ bölib, sinusoidal kiriş uçun uning *amplituda-çastota tavsifi*:

#eq($ A(omega) = S / sqrt(1 + (omega tau)^2). $)

Çastota ortişi bilan çiqiş amplitudasi kamayadi. Amplitudaning statik qiymatdan $1 slash sqrt(2)$ gaça (−3 dB) kamayiş çastotasi $f_c = 1 slash (2 pi tau)$ datçikning *ötkaziş polosasini* belgilaydi. *Misol.* $tau = 0","1$ s bölgan datçik bilan 1 Hz çastotada özgaruvçi kattalik ölçansa, $omega tau = 0","628$ va $A slash S = 1 slash sqrt(1 + 0","628^2) approx 0","85$: amplituda 15 % ga kam ölçanadi. Bu *dinamik xatolik* statik xatolikka qöşiladi.

Massa va elastik elementga ega datçiklar (akselerometrlar, kuç-moment datçiklari) ikkinçi tartibli tizim sifatida tavsiflanadi:

#eq($ W(s) = (S omega_n^2) / (s^2 + 2 zeta omega_n s + omega_n^2), $)

bu yerda $omega_n$ — xususiy çastota, $zeta$ — söniş koeffitsienti. Söniş kiçik bölsa, xususiy çastota atrofida rezonans yuzaga keladi va amplituda keskin oşib ketadi. Şuning uçun bunday datçiklar xususiy çastotadan ança past çastotalarda işlatiladi, söniş koeffitsienti esa $zeta approx 0","6 dots 0","7$ atrofida tanlanganda amplituda-çastota tavsifi eng keng diapazonda tekis böladi.

Dinamik tavsiflar boşqaruv konturi uçun ayniqsa muhim: datçikning keçikişi va faza siljişi qayta aloqali tizimning barqarorligini yomonlaştiradi. Şuning uçun datçik ötkaziş polosasi boşqaruv konturining ötkaziş polosasidan bir neça marta keng bölişi kerak.

// =====================================================================
= Mexatron modullarning metrologik tavsiflari
// =====================================================================

Mexatron modul (masalan, robot böğini yuritmasi) uçun alohida datçik tavsiflaridan taşqari butun modulning harakat aniqligi muhim. Uning asosiy metrologik tavsiflari: *pozitsiyalaş aniqligi* (buyruq berilgan va haqiqiy holat farqi), *pozitsiyalaş takrorlanuvçanligi*, *ruxsat qobiliyati* (eng kiçik bajariladigan siljiş) va *tezlikni uşlab turiş aniqligi*. Ular modul zanjirining barça elementlari xatoliklari bilan belgilanadi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.3fr, 1fr),
    header: ([Element], [Xatolik manbai], [Xatolik turi]),
    [Enkoder],
    [Kvantlaş, interpolyatsiya xatoligi, örnatiş ekssentrisiteti],
    [Sistematik va tasodifiy],
    [Reduktor],
    [Lyuft, kinematik (tişlar qadami) xatoligi, burilişdagi elastiklik],
    [Asosan sistematik, yuklamaga boğliq],
    [Zveno va podşipniklar],
    [Egiliş, issiqlik kengayişi, geometrik ölçam xatoliklari],
    [Sistematik, şaroitga boğliq],
    [Boşqaruv tizimi],
    [Rostlagiç xatoligi, işqalaniş, tebranişlar],
    [Dinamik],
  ),
  caption: [Mexatron modulning harakat xatoligi manbalari],
) <tab-modul>

Reduktor çiqiş validagi enkoder ruxsat qobiliyati juda yuqori bölsa ham, modulning haqiqiy aniqligini köpinça mexanik xatoliklar çeklaydi. Masalan, buriliş bikrligi $k_theta$ bölgan reduktorga $M$ moment taʼsir qilsa, u quyidagi burçakka buraladi va zveno uçida çiziqli xatolik hosil böladi:

#eq($ Delta phi = M / k_theta, quad Delta s = L dot Delta phi. $)

*Misol.* $k_theta = 10^4$ N·m/rad, $M = 50$ N·m va zveno uzunligi $L = 0","5$ m bölsa, $Delta phi = 0","005$ rad, $Delta s = 2","5$ mm. Bu qiymat yuklama bilan özgaradi va dvigatel validagi enkoder uni umuman sezmaydi. Şuning uçun yuqori aniqlik talab qilinadigan modullarda çiqiş validagi ikkinçi enkoder yoki moment datçigi orqali kompensatsiya qöllanadi.

// =====================================================================
= Robotlarning metrologik tavsiflari
// =====================================================================

Sanoat robotlarining işlaş tavsiflari va ularni sinaş usullari ISO 9283 standartida belgilangan. Asosiy körsatkiçlar: pozitsiyalaş aniqligi (AP) va takrorlanuvçanligi (RP), trayektoriya aniqligi (AT) va takrorlanuvçanligi (RT), barqarorlaşiş vaqti va pozitsiyadan ötib ketiş.

Robot buyruq berilgan $P_0 (x_0, y_0, z_0)$ nuqtaga $n$ marta yondaşadi va har gal erişilgan holat $(x_i, y_i, z_i)$ ölçanadi. Erişilgan nuqtalar örtaçasi — baritsentr $(macron(x), macron(y), macron(z))$ böyiça *pozitsiyalaş aniqligi*:

#eq($ "AP" = sqrt((macron(x) - x_0)^2 + (macron(y) - y_0)^2 + (macron(z) - z_0)^2). $)

Har bir nuqtadan baritsentrgaça masofa $l_i$, ularning örtaçasi $macron(l)$ va standart oğişi $S_l$ böyiça *pozitsiyalaş takrorlanuvçanligi*:

#eq($ "RP" = macron(l) + 3 S_l. $)

AP sistematik xatolikni (nuqtalar markazining buyruq nuqtasidan siljişini), RP esa tasodifiy xatolikni (nuqtalar tarqoqligini) tavsiflaydi. ISO 9283 böyiça sinovda robotning işçi zonasida joylaştirilgan sinov kubining diagonal tekisligidagi beşta nuqtaga har biriga bir yönalişdan 30 martadan yondaşiladi, ölçaş esa lazer treker yoki koordinata-ölçaş maşinasi kabi aniq taşqi vosita bilan bajariladi. Robot pultidagi koordinatalar bu maqsadga yaramaydi, çunki ular robotning öz enkoderlari asosida hisoblanadi.

Sanoat robotlarida takrorlanuvçanlik odatda aniqlikdan ança yaxşi böladi, şuning uçun işlab çiqaruvçilar pasportda asosan RP ni körsatadi. Aniqlik esa robotning kinematik modeli (zvenolar uzunliklari, böğinlarning nol holatlari) va real konstruksiya orasidagi farqlarga boğliq; u *kinematik kalibrlaş* orqali — model parametrlarini ölçaş natijalariga moslaş yöli bilan — sezilarli yaxşilanadi. Robot oflayn dasturlansa (dastur kompyuterdagi model asosida tuzilsa), aniqlik ayniqsa muhim, çunki robot nuqtalarga «örgatilmay», hisoblangan koordinatalar böyiça boradi.

Mexatron modul va robotlarning metrologik tavsiflarini hisoblaş böyiça amaliy misollar (AP va RP hisobi, enkoder ruxsati va lyuft taʼsirini taqqoslaş) amaliy maşğulotlarda köriladi.

// =====================================================================
= Xulosa
// =====================================================================

Metrologik tavsiflar ölçaş vositasi natijasiga qançalik işoniş mumkinligini miqdoriy ifodalaydi. Ular ölçaş natijasini aniqlaş, xatolik, taʼsir etuvçi kattaliklarga sezgirlik, dinamik va özaro taʼsir tavsiflariga bölinadi. Ölçaş vositalarining aniqligi kalibrlaş orqali tasdiqlanadi, natijalarning işonçliligi esa davlat etalonlarigaça bölgan metrologik kuzatuvçanlik zanjiri bilan taʼminlanadi.

Statik tavsiflar (sezgirlik, çiziqlilik, gisterezis, takrorlanuvçanlik, drift) va dinamik tavsiflar (vaqt doimiysi, amplituda-çastota tavsifi, xususiy çastota) birgalikda datçik xatoligini belgilaydi. Kanal elementlari xatoliklari geometrik yiğiladi va umumiy xatolikni asosan eng katta taşkil etuvçi belgilaydi. Mexatron modulning aniqligini köpinça mexanik elementlar — lyuft va elastiklik çeklaydi; robotlarning aniqligi va takrorlanuvçanligi esa ISO 9283 böyiça AP va RP körsatkiçlari bilan baholanadi va kinematik kalibrlaş orqali yaxşilanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Metrologik tavsif va normalangan metrologik tavsif deganda nima tuşuniladi?
  + Kalibrlaş va qiyoslaş qanday farqlanadi? Metrologik kuzatuvçanlik nima?
  + Metrologik tavsiflar qanday guruhlarga bölinadi?
  + Çiziqlilik xatosi qanday aniqlanadi? Töğri çiziqni tanlaş usuli natijaga qanday taʼsir qiladi?
  + Asosiy va qöşimça xatoliklar qanday farqlanadi?
  + 0…10 bar diapazonli 0,5 klassdagi datçik bilan 2 bar ölçanganda nisbiy xatolik qança bölişi mumkin?
  + Xatoliklar qaçon geometrik, qaçon arifmetik yiğiladi?
  + Xatoliklari 0,2 %, 0,1 % va 0,05 % bölgan uç elementli kanalning umumiy xatoligini toping.
  + Standart va kengaytirilgan noaniqlik qanday farqlanadi?
  + $tau = 0","2$ s bölgan datçik 0,5 Hz çastotali signal amplitudasini neça foiz kam ölçaydi?
  + Ikkinçi tartibli datçik uçun söniş koeffitsienti qanday tanlanadi va nima uçun?
  + Mexatron modulning pozitsiyalaş xatoligiga qanday omillar taʼsir qiladi?
  + Robotlarning AP va RP körsatkiçlari qanday aniqlanadi va nima uçun takrorlanuvçanlik odatda aniqlikdan yaxşiroq?
]
