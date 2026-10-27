// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №3. Mexatron modullar va robotlarda qoʻllaniladigan
//             informatsion tizimlar va ularning sinflanishi
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №3. Mexatron modullar va robotlarda qöllaniladigan informatsion tizimlar va ularning sinflanişi",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 3  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №3]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarda qöllaniladigan \ informatsion tizimlar va ularning sinflanişi]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion tizim tuşunçasi va uning robotdagi vazifalari.
  + Informatsion-ölçaş kanalining umumlaşgan tuzilişi.
  + Ölçaş jarayoni va datçikning informatsion modeli.
  + Informatsion tizimlarning vazifasi böyiça sinflanişi.
  + Datçiklarning fizik va energetik belgilar böyiça sinflanişi.
  + Robot informatsion tizimining ierarxik tuzilişi.
  + Informatsion tizimlarga qöyiladigan talablar.

  *Tayanç iboralar:* informatsion tizim, informatsion-ölçaş kanali, sezgir element, ölçaş özgartkiçi, informatsion model, kinestetik tizim, lokatsion tizim, texnik köriş tizimi, taktil tizim, kuç-moment seziş, navigatsiya tizimi, generatorli va parametrik datçiklar, energetik sohalar, intellektual datçik, axborotga işlov beriş ierarxiyasi.
]

// =====================================================================
= Informatsion tizim tuşunçasi va uning robotdagi vazifalari
// =====================================================================

Oldingi maʼruzalarda robotning informatsion qurilmalari, axborot miqdori va signallar haqida umumiy tuşunçalar berildi. Amaliyotda robot alohida datçiklar bilan emas, balki ularning tizimi bilan işlaydi: bir neçta datçik, ularning signallariga işlov beruvçi sxemalar, aloqa kanallari va algoritmlar birgalikda robotga kerakli axborotni yetkazadi.

*Robotning informatsion tizimi* — robotning içki holati, işçi muhit va bajarilayotgan texnologik jarayon haqidagi axborotni oliş, özgartiriş, uzatiş, qayta işlaş va boşqaruv tizimiga berişni taʼminlovçi texnik va dasturiy vositalar majmuasi. Uning tarkibiga datçiklar (sezgir elementlar va ölçaş özgartkiçlari), signalga işlov beriş qurilmalari, analog-raqamli özgartkiçlar, aloqa interfeyslari hamda axborotni qayta işlaş algoritmlari kiradi.

Informatsion tizim robotda quyidagi asosiy vazifalarni bajaradi:
- *qayta aloqani taʼminlaş* — yuritmalar va böğinlarning holati, tezligi, momenti haqidagi axborotni boşqaruv konturlariga beriş;
- *işçi muhitni idrok etiş* — obyektlar, tösiqlar va ularning joylaşuvini aniqlaş, muhit modelini quriş;
- *muhit bilan özaro taʼsirni nazorat qiliş* — kontakt kuçlarini ölçaş va çeklaş;
- *navigatsiya* — mobil robotning fazodagi örnini va yönalişini aniqlaş;
- *diagnostika va xavfsizlik* — robot qismlarining holatini kuzatiş, nosozliklarni aniqlaş, inson yaqinlaşganini seziş;
- *inson bilan muloqot* — operator buyruqlarini qabul qiliş va unga robot holati haqida axborot beriş.

Birinçi vazifa har qanday robotda mavjud. Qolganlari robot qançalik murakkab va avtonom bölsa, şunçalik katta ahamiyat kasb etadi.

// =====================================================================
= Informatsion-ölçaş kanalining umumlaşgan tuzilişi
// =====================================================================

Informatsion tizim bir neçta *informatsion-ölçaş kanallaridan* taşkil topadi. Har bir kanal bitta fizik kattalik haqidagi axborotni ölçanayotgan obyektdan boşqaruv tizimigaça yetkazadi. Kanalning umumlaşgan tuzilişi 1-rasmda keltirilgan.

#figure(
  diagram(
    spacing: (5.5mm, 10mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Obyekt], fill: white, name: <ob>),
    node((1, 0), [Sezgir \ element], name: <se>),
    node((2, 0), [Ölçaş \ özgartkiçi], name: <oz>),
    node((3, 0), [Signalga \ işlov beriş], name: <ib>),
    node((4, 0), [ARO], name: <aro>),
    node((5, 0), [Interfeys], name: <if>),
    node((5, 1), [Boşqaruv \ tizimi], fill: lightorange, name: <bt>),
    node((2, 1), [Yordamçi energiya \ manbai (taʼminot)], fill: white, name: <en>),
    edge(<ob>, <se>, "->", [$x$], label-side: left),
    edge(<se>, <oz>, "->"),
    edge(<oz>, <ib>, "->"),
    edge(<ib>, <aro>, "->"),
    edge(<aro>, <if>, "->"),
    edge(<if>, <bt>, "->", [$y$], label-side: left),
    edge(<en>, <oz>, "->", stroke: (dash: "dashed", thickness: 1pt)),
  ),
  caption: [Informatsion-ölçaş kanalining umumlaşgan tuzilişi],
) <fig-kanal>

Kanal elementlarining vazifalari:
- *sezgir element* ölçanayotgan kattalik $x$ bevosita taʼsir qiladigan element; unda kattalik qandaydir fizik parametr özgarişiga aylanadi (masalan, deformatsiya — qarşilik özgarişiga, siljiş — siğim yoki induktivlik özgarişiga);
- *ölçaş özgartkiçi* bu özgarişni elektr signaliga (kuçlaniş, tok, çastota) aylantiradi; parametrik datçiklarda buning uçun taşqi taʼminot manbai kerak;
- *signalga işlov beriş* qurilmasi signalni kuçaytiradi, filtrlaydi, çiziqlaştiradi va ARO diapazoniga moslaydi;
- *ARO* signalni diskretlaydi va kvantlaydi (2-maʼruza);
- *interfeys* raqamli natijani boşqaruv tizimiga uzatadi: analog çiqişlar (0–10 V, 4–20 mA), impulsli çiqişlar (enkoder A/B/Z signallari) yoki raqamli şinalar (I²C, SPI, CAN, EtherCAT, IO-Link).

Anʼanaviy datçiklarda bu elementlar alohida bloklar bölgan. Zamonaviy *integrallaşgan* va *intellektual* datçiklarda ularning hammasi bitta korpusda, köpinça bitta kristallda joylaşadi va datçik tayyor, kalibrlangan raqamli natijani beradi.

// =====================================================================
= Ölçaş jarayoni va datçikning informatsion modeli
// =====================================================================

Ölçaş jarayonini axborotni özgartirişlar zanjiri sifatida köriş mumkin. 1-maʼruzada keltirilgan datçik modeliga köra, kanal çiqişi $y$ ölçanayotgan kattalik $x$ dan taşqari taʼsir etuvçi omillar $z_1, dots, z_m$ va şovqin $xi$ ga ham boğliq:

#eq($ y = F(x, z_1, z_2, dots, z_m) + xi. $)

(1) ifoda datçikning *töğri informatsion modelidir*: u maʼlum $x$ uçun qanday $y$ olinişini tavsiflaydi. Boşqaruv tizimiga esa teskari masala kerak: ölçangan $y$ böyiça kattalikning bahosi $hat(x)$ ni topiş. Buning uçun datçikning *teskari modeli* (kalibrlaş tavsifi) qöllaniladi:

#eq($ hat(x) = F^(-1)(y, hat(z)_1, dots, hat(z)_m), $)

bu yerda $hat(z)_1, dots, hat(z)_m$ — taʼsir etuvçi omillarning ölçangan yoki baholangan qiymatlari. Masalan, harorat datçigi körsatkiçidan foydalanib, tenzodatçik sezgirligining haroratga boğliqligi hisobga olinadi.

(2) ifodadan ölçaş xatoliklarini kamaytirişning uç asosiy yöli kelib çiqadi:
+ *konstruktiv usul* — datçikni taʼsir etuvçi omillarga kam sezgir qilib yasaş (termostatlaş, ekranlaş, differensial sxemalar);
+ *strukturaviy usul* — taʼsir etuvçi omillarni qöşimça datçiklar bilan ölçab, (2) model orqali kompensatsiya qiliş;
+ *algoritmik usul* — bir neçta ölçaşni örtaçalaş, filtrlaş va turli datçiklar maʼlumotlarini birlaştiriş orqali şovqin $xi$ taʼsirini kamaytiriş.

Bu usullar keyingi maʼruzalarda — datçiklar tavsiflari va xatoliklarini kompensatsiya qiliş mavzusida batafsil örganiladi.

// =====================================================================
= Informatsion tizimlarning vazifasi böyiça sinflanişi
// =====================================================================

Robototexnikada informatsion tizimlarni ular bajaradigan vazifaga köra sinflaş qabul qilingan. Bu sinflaniş inson sezgi organlari bilan öxşaşlikka ham asoslanadi (1-maʼruza) va fanning keyingi mavzulari aynan şu tartibda örganiladi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.2fr, 1.3fr),
    header: ([Informatsion tizim], [Ölçanadigan kattaliklar], [Asosiy datçiklar]),
    [Kinestetik (içki holat) tizimlari],
    [Böğinlarning burçak va çiziqli siljişi, tezligi, tezlanişi, dvigatel toki],
    [Enkoderlar, rezolverlar, potensiometrlar, taxogeneratorlar, tok datçiklari],

    [Lokatsion tizimlar],
    [Obyektgaça masofa, obyektlarning joylaşuvi va harakati],
    [Ultratovuş lokatorlari, lazer masofa ölçagiçlari, LiDAR, radarlar],

    [Texnik köriş tizimlari],
    [Obyektlar şakli, rangi, joylaşuvi; sahna tasviri va çuqurligi],
    [Kameralar, stereokameralar, çuqurlik (RGB-D) kameralari],

    [Taktil va kuç-moment seziş tizimlari],
    [Kontakt bor-yöqligi, kontakt kuçi va momenti, sirpaniş],
    [Taktil matritsalar, kuç-moment datçiklari, sirpaniş datçiklari],

    [Navigatsiya tizimlari],
    [Mobil robotning fazodagi örni, tezligi va yönalişi],
    [IMU (akselerometr, giroskop), magnitometr, GNSS, odometriya],

    [Diagnostika va xavfsizlik tizimlari],
    [Harorat, vibratsiya, inson yaqinligi, nosozlik belgilari],
    [Harorat va vibratsiya datçiklari, yaqinlik datçiklari, xavfsizlik skanerlari],

    [Inson-robot muloqot tizimlari],
    [Operator ovozi, imo-işoralari, boşqaruv qurilmalari holati],
    [Mikrofonlar, kameralar, joystiklar, sensorli ekranlar],
  ),
  caption: [Robot informatsion tizimlarining vazifasi böyiça sinflanişi],
) <tab-vazifa>

*Kinestetik tizimlar* robotning «muşak-böğin sezgisi» bölib, yuritmalarning qayta aloqa konturlarini taʼminlaydi. Ularsiz robot boşqariluvçi harakatni bajara olmaydi, şuning uçun ular I avlod robotlarida ham mavjud.

*Lokatsion tizimlar* muhitga signal (tovuş, yoruğlik, radiotölqin) yuborib, qaytgan signal böyiça masofa va obyekt joylaşuvini aniqlaydi. Ular mobil robotlarda tösiqlardan qoçiş va xarita tuzişning asosiy vositasi hisoblanadi.

*Texnik köriş tizimlari* eng katta hajmdagi axborotni beradi va obyektlarni tanib oliş imkonini beradi, lekin eng murakkab işlov beriş algoritmlarini talab qiladi.

*Taktil va kuç-moment seziş tizimlari* robot obyekt bilan kontaktga kirganda işlaydi: ular yiğiş, silliqlaş, nozik obyektlarni uşlaş va inson bilan xavfsiz hamkorlik uçun zarur.

*Navigatsiya tizimlari* mobil robotlar, dronlar va avtonom transport vositalarida robotning global va lokal koordinatalarini aniqlaydi. Odatda ular bir neçta turli datçik maʼlumotlarini birlaştiriş asosida quriladi.

Bu sinflaniş şartli: bitta datçik bir neçta tizimga xizmat qilişi mumkin. Masalan, kamera ham texnik köriş, ham navigatsiya (vizual odometriya), ham inson bilan muloqot (imo-işoralarni taniş) uçun işlatiladi.

// =====================================================================
= Datçiklarning fizik va energetik belgilar böyiça sinflanişi
// =====================================================================

Informatsion tizim elementlari — datçiklar — vazifasidan taşqari bir qator boşqa belgilar böyiça ham sinflanadi. Regtien va Dertien datçiklarni sinflaşning bir neçta sxemasini körib çiqadi: ölçanadigan kattalik va qöllaniş sohasi böyiça, energiya oqimi (port modellari) böyiça, özgartiriş prinsipi böyiça va energetik sohalar böyiça.

== Energiya oqimi böyiça: generatorli va parametrik datçiklar

*Generatorli* (özi energiya hosil qiluvçi, inglizça _self-generating, direct_) datçiklar yordamçi energiya manbaisiz işlaydi: çiqiş signali energiyasini bevosita ölçanayotgan obyektdan oladi. Ularning muhim afzalligi — nol siljişi yöqligi: kiriş nolga teng bölsa, çiqiş ham amalda nolga teng. Kamçiligi — obyektdan energiya olinişi tufayli uning holati biroz özgarişi mumkin. Misollar: termojuft, piezoelektrik akselerometr, induksion tezlik datçigi, fotodiod (fotovoltaik rejimda).

*Parametrik* (modulyatsiyalovçi, inglizça _modulating_) datçiklarda ölçanayotgan kattalik materialning biror xossasini yoki geometrik parametrni özgartiradi, bu özgariş esa taşqi yordamçi manba signali orqali «sörab olinadi». Çiqiş energiyasi asosan yordamçi manbadan olinadi. Datçiklarning aksariyati şu guruhga kiradi: barça rezistiv, siğim va induktiv datçiklar, şuningdek optik va akustik siljiş datçiklarining köpçiligi.

Bu farq ölçaş sxemasini tanlaşni belgilaydi: generatorli datçiklar uçun *generatorli ölçaş sxemalari* (kuçaytirgiçlar, zaryad kuçaytirgiçlari), parametrik datçiklar uçun esa taʼminot manbaiga ega *parametrik sxemalar* (köprik sxemalari, kuçlaniş bölgiçlari) qöllaniladi.

== Energetik sohalar böyiça

Datçikning kiriş va çiqiş signallari turli energetik sohalarga tegişli bölişi mumkin. Datçiklar nazariyasida köpinça oltita signal sohasi ajratiladi: nurlaniş (optik), mexanik, issiqlik, elektr, magnit va kimyoviy sohalar. Datçik kiriş signalini biror sohadan elektr sohasiga ötkazadi; parametrik datçikda esa yordamçi signal sohasi ham hisobga olinadi. Bunday yondaşuv bir xil vazifani turli fizik yöllar bilan hal qiliş imkoniyatlarini tizimli körişga yordam beradi.

== Özgartiriş prinsipi böyiça

Regtien va Dertien bu sinflanişni amaliyot uçun eng foydali deb hisoblaydi, çunki datçik tavsiflari asosan uning fizik işlaş prinsipi bilan belgilanadi. Bunda datçikning elektr çiqişi materialning xossasiga, geometriyaga yoki harakatga boğliq bölişi mumkin. Robototexnikada qöllaniladigan asosiy prinsiplar 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.2fr),
    header: ([Prinsip], [Fizik effekt], [Robotdagi qöllanilişi]),
    [Rezistiv],
    [Qarşilikning siljiş, deformatsiya yoki haroratga boğliqligi],
    [Potensiometrlar, tenzodatçiklar, termorezistorlar],

    [Siğim],
    [Elektrodlar orasidagi masofa, yuza yoki dielektrik özgarişi],
    [Yaqinlik datçiklari, taktil qoplamalar, MEMS akselerometrlar],

    [Induktiv va magnit],
    [Induktivlik, özaro induktivlik özgarişi; Xoll effekti],
    [Rezolverlar, LVDT, induktiv yaqinlik datçiklari, Xoll datçiklari],

    [Optik],
    [Yoruğlik oqimining tösilişi, aks etişi, tarqaliş vaqti],
    [Optik enkoderlar, lazer masofa ölçagiçlari, kameralar],

    [Piezoelektrik],
    [Mexanik kuçlanişda zaryad hosil bölişi],
    [Dinamik kuç datçiklari, akselerometrlar, ultratovuş özgartkiçlari],

    [Akustik],
    [Tovuş tölqinining tarqaliş vaqti va aks etişi],
    [Ultratovuş lokatorlari va masofa ölçagiçlari],
  ),
  caption: [Datçiklarning özgartiriş prinsipi böyiça sinflanişi],
) <tab-prinsip>

Bitta kattalikni turli prinsiplar bilan ölçaş mumkin, aksinça, bitta prinsip turli kattaliklarni ölçaşda qöllanadi. Masalan, magnit datçik siljiş, tezlik yoki taktil datçik sifatida işlatilişi mumkin, lekin barça holatlarda uning imkoniyatlari magnit prinsipning fizikasi bilan çeklanadi.

== Boşqa belgilar böyiça

*Çiqiş signali turi böyiça:* analog (kuçlaniş, tok), çastotali va impulsli (inkremental enkoder, çastota çiqişli datçiklar) hamda raqamli (absolyut enkoder, raqamli interfeysli datçiklar).

*Muhit bilan taʼsir masofasi böyiça:* kontaktli (taktil, kuç-moment), yaqin masofali (yaqinlik datçiklari, millimetrdan bir neça santimetrgaça) va uzoq masofali (lokatsion va köriş tizimlari, metrlardan yuzlab metrlargaça).

*Axborotga işlov beriş darajasi böyiça:* oddiy datçiklar (faqat sezgir element va özgartkiç), integrallaşgan datçiklar (ölçaş sxemasi va ARO bilan) va intellektual datçiklar (mikroprotsessor, kalibrlaş, öz-özini diagnostika qiliş va raqamli tarmoq interfeysi bilan).

// =====================================================================
= Robot informatsion tizimining ierarxik tuzilişi
// =====================================================================

Murakkab robotda datçiklardan kelgan axborot bir neça bosqiçda qayta işlanadi. Har bir yuqori bosqiçda axborot hajmi kamayadi, lekin uning mazmuni boyiydi: millionlab piksellardan «oldinda 3 m masofada odam bor» degan bitta xulosa olinadi. Bu tamoyil robotlarni intellektual boşqarişning ierarxik prinsipiga mos keladi. Informatsion tizimning ierarxik tuzilişi 2-rasmda körsatilgan.

#figure(
  diagram(
    spacing: (10mm, 6mm),
    node-stroke: 1pt,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [*5. Qaror qabul qiliş va rejalaştiriş*], width: 7.5cm, fill: lightorange, name: <l5>),
    node((0, 1), [*4. Muhit modeli va vaziyatni tanib oliş*], width: 7.5cm, fill: lightblue, name: <l4>),
    node((0, 2), [*3. Belgilarni ajratiş*], width: 7.5cm, fill: lightblue, name: <l3>),
    node((0, 3), [*2. Birlamçi işlov beriş*], width: 7.5cm, fill: lightblue, name: <l2>),
    node((0, 4), [*1. Datçiklar sathi*], width: 7.5cm, fill: white, name: <l1>),
    node((1, 0), align(left)[harakat rejasi, boşqaruv buyruqlari], stroke: none),
    node((1, 1), align(left)[xarita, obyektlar va ularning holati], stroke: none),
    node((1, 2), align(left)[çegaralar, nuqtalar, masofalar, kuç vektori], stroke: none),
    node((1, 3), align(left)[filtrlaş, kalibrlaş, sinxronlaş], stroke: none),
    node((1, 4), align(left)[elektr signallari, raqamli kodlar], stroke: none),
    edge(<l1>, <l2>, "->"),
    edge(<l2>, <l3>, "->"),
    edge(<l3>, <l4>, "->"),
    edge(<l4>, <l5>, "->"),
  ),
  caption: [Robot informatsion tizimida axborotga işlov beriş ierarxiyasi],
) <fig-ierarxiya>

Quyi sathlarda (1–2) işlov beriş qatʼiy real vaqtda, köpinça datçikning özida yoki yuritma drayverida bajariladi. Masalan, enkoder signali yuritmaning tezlik va pozitsiya konturida mikrosekundlar içida işlatiladi. Yuqori sathlarda (4–5) işlov beriş murakkab algoritmlar — tasvirlarni tanib oliş, xarita quriş, sunʼiy intellekt usullarini talab qiladi va robotning markaziy kompyuterida bajariladi.

Sathlar böyiça axborot oqimi juda notekis. Raqamli kameraning axborot oqimi quyidagiça baholanadi:

#eq($ R = N_x dot N_y dot b dot f, $)

bu yerda $N_x, N_y$ — tasvirning gorizontal va vertikal piksellar soni, $b$ — bitta piksel uçun bitlar soni, $f$ — kadrlar çastotasi. $1920 times 1080$ piksel, 24 bit va 30 kadr/s uçun $R approx 1","49$ Gbit/s. Taqqoslaş uçun, 17 bitli enkoderlar bilan jihozlangan olti böğinli manipulyator 1 kHz çastotada atigi $6 dot 17 dot 1000 approx 0","1$ Mbit/s axborot hosil qiladi. Şu sababli köriş tizimlarida axborotni datçikning özida yoki unga yaqin joyda dastlabki qayta işlaş (siqiş, belgilarni ajratiş) muhim masala hisoblanadi.

// =====================================================================
= Informatsion tizimlarga qöyiladigan talablar
// =====================================================================

Robot informatsion tizimi va uning elementlariga quyidagi asosiy talablar qöyiladi:
- *aniqlik va ruxsat qobiliyati* — robotning bajaradigan vazifasiga mos bölişi;
- *tezkorlik* — ötkaziş polosasi yetarli, keçikiş esa boşqaruv konturi uçun ruxsat etilgan qiymatdan kiçik bölişi;
- *işonçlilik* — nosozliklar orasidagi vaqt katta, muhim kanallar esa zaxiralangan bölişi (5-amaliyot);
- *şovqinbardoşlik* — elektromagnit xalaqitlar, vibratsiya, harorat özgarişi şaroitida işlay olişi;
- *kiçik ölçam, massa va energiya isteʼmoli* — ayniqsa manipulyator zvenolari va mobil robotlarda;
- *integratsiyalaş qulayligi* — standart interfeyslar, kalibrlaş va almaştiriş osonligi;
- *narx* — robotning umumiy narxiga mos bölişi.

Bu talablar köpinça bir-biriga zid: aniqlikni oşiriş narx, ölçam yoki tezkorlik hisobiga erişiladi. Ikki misolda talablarning miqdoriy tomonini köramiz.

*Keçikişning taʼsiri.* Informatsion kanal $tau$ keçikiş bilan axborot bersa, $v$ tezlik bilan harakatlanayotgan robot uçun bu keçikiş quyidagi pozitsiya xatoligiga olib keladi:

#eq($ Delta s = v dot tau. $)

Masalan, 2 m/s tezlikda harakatlanayotgan mobil robotda 50 ms keçikiş $Delta s = 2 dot 0","05 = 0","1$ m, yaʼni 10 sm xatolik beradi. Tösiqdan qoçiş masofasi aynan şu xatolikni hisobga olib tanlanişi kerak.

*Burçak ruxsat qobiliyati va masofa.* Skanerlovçi lokator yoki kamera kiçik burçak qadami $Delta theta$ bilan ölçasa, $R$ masofadagi köndalang ruxsat qobiliyati:

#eq($ Delta x = R dot Delta theta. $)

Burçak qadami $0","2 degree$ ($3","49 dot 10^(-3)$ rad) bölgan LiDAR uçun 20 m masofada $Delta x approx 0","07$ m. Demak, bunday lokator 20 m masofada 7 sm dan kiçik obyektlarni işonçli ajrata olmasligi mumkin.

Bu misollar informatsion tizimni loyihalaşda datçikni robot vazifasi, tezligi va iş masofasidan kelib çiqib tanlaş kerakligini körsatadi.

// =====================================================================
= Xulosa
// =====================================================================

Robotning informatsion tizimi informatsion-ölçaş kanallaridan iborat bölib, har bir kanal sezgir element, ölçaş özgartkiçi, signalga işlov beriş, ARO va interfeysni öz içiga oladi. Datçikning töğri va teskari informatsion modellari ölçaş xatoliklarini konstruktiv, strukturaviy va algoritmik usullar bilan kamaytiriş asosini taşkil etadi.

Informatsion tizimlar vazifasi böyiça kinestetik, lokatsion, texnik köriş, taktil va kuç-moment, navigatsiya, diagnostika va muloqot tizimlariga bölinadi. Datçiklar esa energiya oqimi (generatorli va parametrik), energetik soha, özgartiriş prinsipi, çiqiş signali, taʼsir masofasi va işlov beriş darajasi böyiça sinflanadi. Murakkab robotda axborot ierarxik ravişda — datçik signallaridan muhit modeli va qarorlargaça — qayta işlanadi. Informatsion tizimga qöyiladigan talablar özaro zid bölgani uçun uni loyihalaş murosali yeçim topişni talab qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robotning informatsion tizimi deganda nima tuşuniladi va u qanday vazifalarni bajaradi?
  + Informatsion-ölçaş kanali qanday elementlardan iborat? Har birining vazifasini tuşuntiring.
  + Datçikning töğri va teskari informatsion modellari qanday farqlanadi?
  + Ölçaş xatoliklarini kamaytirişning konstruktiv, strukturaviy va algoritmik usullariga misol keltiring.
  + Robot informatsion tizimlari vazifasi böyiça qanday sinflanadi?
  + Kinestetik va lokatsion tizimlar örtasidagi farq nimada?
  + Generatorli va parametrik datçiklar qanday farqlanadi? Har biriga misol keltiring.
  + Datçiklarni özgartiriş prinsipi böyiça sinflaşning afzalligi nimada?
  + Oddiy, integrallaşgan va intellektual datçiklar qanday farqlanadi?
  + Robot informatsion tizimidagi axborotga işlov beriş ierarxiyasini tuşuntiring.
  + Nima uçun texnik köriş tizimlarida axborotni dastlabki qayta işlaş muhim?
  + 1,5 m/s tezlikdagi robotda 80 ms keçikiş qanday pozitsiya xatoligiga olib keladi?
]
