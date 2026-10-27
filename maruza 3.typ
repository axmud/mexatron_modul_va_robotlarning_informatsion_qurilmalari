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
  title: "Maʼruza №3. Mexatron modullar va robotlarda qoʻllaniladigan informatsion tizimlar va ularning sinflanishi",
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
#set text(size: 12pt, lang: "uz")
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
  )[Mavzu: Mexatron modullar va robotlarda qoʻllaniladigan \ informatsion tizimlar va ularning sinflanishi]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion tizim tushunchasi va uning robotdagi vazifalari.
  + Informatsion-oʻlchash kanalining umumlashgan tuzilishi.
  + Oʻlchash jarayoni va datchikning informatsion modeli.
  + Informatsion tizimlarning vazifasi boʻyicha sinflanishi.
  + Datchiklarning fizik va energetik belgilar boʻyicha sinflanishi.
  + Robot informatsion tizimining ierarxik tuzilishi.
  + Informatsion tizimlarga qoʻyiladigan talablar.

  *Tayanch iboralar:* informatsion tizim, informatsion-oʻlchash kanali, sezgir element, oʻlchash oʻzgartkichi, informatsion model, kinestetik tizim, lokatsion tizim, texnik koʻrish tizimi, taktil tizim, kuch-moment sezish, navigatsiya tizimi, generatorli va parametrik datchiklar, energetik sohalar, intellektual datchik, axborotga ishlov berish ierarxiyasi.
]

// =====================================================================
= Informatsion tizim tushunchasi va uning robotdagi vazifalari
// =====================================================================

Oldingi maʼruzalarda robotning informatsion qurilmalari, axborot miqdori va signallar haqida umumiy tushunchalar berildi. Amaliyotda robot alohida datchiklar bilan emas, balki ularning tizimi bilan ishlaydi: bir nechta datchik, ularning signallariga ishlov beruvchi sxemalar, aloqa kanallari va algoritmlar birgalikda robotga kerakli axborotni yetkazadi.

*Robotning informatsion tizimi* — robotning ichki holati, ishchi muhit va bajarilayotgan texnologik jarayon haqidagi axborotni olish, oʻzgartirish, uzatish, qayta ishlash va boshqaruv tizimiga berishni taʼminlovchi texnik va dasturiy vositalar majmuasi. Uning tarkibiga datchiklar (sezgir elementlar va oʻlchash oʻzgartkichlari), signalga ishlov berish qurilmalari, analog-raqamli oʻzgartkichlar, aloqa interfeyslari hamda axborotni qayta ishlash algoritmlari kiradi.

Informatsion tizim robotda quyidagi asosiy vazifalarni bajaradi:
- *qayta aloqani taʼminlash* — yuritmalar va boʻgʻinlarning holati, tezligi, momenti haqidagi axborotni boshqaruv konturlariga berish;
- *ishchi muhitni idrok etish* — obyektlar, toʻsiqlar va ularning joylashuvini aniqlash, muhit modelini qurish;
- *muhit bilan oʻzaro taʼsirni nazorat qilish* — kontakt kuchlarini oʻlchash va cheklash;
- *navigatsiya* — mobil robotning fazodagi oʻrnini va yoʻnalishini aniqlash;
- *diagnostika va xavfsizlik* — robot qismlarining holatini kuzatish, nosozliklarni aniqlash, inson yaqinlashganini sezish;
- *inson bilan muloqot* — operator buyruqlarini qabul qilish va unga robot holati haqida axborot berish.

Birinchi vazifa har qanday robotda mavjud. Qolganlari robot qanchalik murakkab va avtonom boʻlsa, shunchalik katta ahamiyat kasb etadi.

// =====================================================================
= Informatsion-oʻlchash kanalining umumlashgan tuzilishi
// =====================================================================

Informatsion tizim bir nechta *informatsion-oʻlchash kanallaridan* tashkil topadi. Har bir kanal bitta fizik kattalik haqidagi axborotni oʻlchanayotgan obyektdan boshqaruv tizimigacha yetkazadi. Kanalning umumlashgan tuzilishi 1-rasmda keltirilgan.

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
    node((2, 0), [Oʻlchash \ oʻzgartkichi], name: <oz>),
    node((3, 0), [Signalga \ ishlov berish], name: <ib>),
    node((4, 0), [ARO], name: <aro>),
    node((5, 0), [Interfeys], name: <if>),
    node((5, 1), [Boshqaruv \ tizimi], fill: lightorange, name: <bt>),
    node((2, 1), [Yordamchi energiya \ manbai (taʼminot)], fill: white, name: <en>),
    edge(<ob>, <se>, "->", [$x$], label-side: left),
    edge(<se>, <oz>, "->"),
    edge(<oz>, <ib>, "->"),
    edge(<ib>, <aro>, "->"),
    edge(<aro>, <if>, "->"),
    edge(<if>, <bt>, "->", [$y$], label-side: left),
    edge(<en>, <oz>, "->", stroke: (dash: "dashed", thickness: 1pt)),
  ),
  caption: [Informatsion-oʻlchash kanalining umumlashgan tuzilishi],
) <fig-kanal>

Kanal elementlarining vazifalari:
- *sezgir element* oʻlchanayotgan kattalik $x$ bevosita taʼsir qiladigan element; unda kattalik qandaydir fizik parametr oʻzgarishiga aylanadi (masalan, deformatsiya — qarshilik oʻzgarishiga, siljish — sigʻim yoki induktivlik oʻzgarishiga);
- *oʻlchash oʻzgartkichi* bu oʻzgarishni elektr signaliga (kuchlanish, tok, chastota) aylantiradi; parametrik datchiklarda buning uchun tashqi taʼminot manbai kerak;
- *signalga ishlov berish* qurilmasi signalni kuchaytiradi, filtrlaydi, chiziqlashtiradi va ARO diapazoniga moslaydi;
- *ARO* signalni diskretlaydi va kvantlaydi (2-maʼruza);
- *interfeys* raqamli natijani boshqaruv tizimiga uzatadi: analog chiqishlar (0–10 V, 4–20 mA), impulsli chiqishlar (enkoder A/B/Z signallari) yoki raqamli shinalar (I²C, SPI, CAN, EtherCAT, IO-Link).

Anʼanaviy datchiklarda bu elementlar alohida bloklar boʻlgan. Zamonaviy *integrallashgan* va *intellektual* datchiklarda ularning hammasi bitta korpusda, koʻpincha bitta kristallda joylashadi va datchik tayyor, kalibrlangan raqamli natijani beradi.

// =====================================================================
= Oʻlchash jarayoni va datchikning informatsion modeli
// =====================================================================

Oʻlchash jarayonini axborotni oʻzgartirishlar zanjiri sifatida koʻrish mumkin. 1-maʼruzada keltirilgan datchik modeliga koʻra, kanal chiqishi $y$ oʻlchanayotgan kattalik $x$ dan tashqari taʼsir etuvchi omillar $z_1, dots, z_m$ va shovqin $xi$ ga ham bogʻliq:

#eq($ y = F(x, z_1, z_2, dots, z_m) + xi. $)

(1) ifoda datchikning *toʻgʻri informatsion modelidir*: u maʼlum $x$ uchun qanday $y$ olinishini tavsiflaydi. Boshqaruv tizimiga esa teskari masala kerak: oʻlchangan $y$ boʻyicha kattalikning bahosi $hat(x)$ ni topish. Buning uchun datchikning *teskari modeli* (kalibrlash tavsifi) qoʻllaniladi:

#eq($ hat(x) = F^(-1)(y, hat(z)_1, dots, hat(z)_m), $)

bu yerda $hat(z)_1, dots, hat(z)_m$ — taʼsir etuvchi omillarning oʻlchangan yoki baholangan qiymatlari. Masalan, harorat datchigi koʻrsatkichidan foydalanib, tenzodatchik sezgirligining haroratga bogʻliqligi hisobga olinadi.

(2) ifodadan oʻlchash xatoliklarini kamaytirishning uch asosiy yoʻli kelib chiqadi:
+ *konstruktiv usul* — datchikni taʼsir etuvchi omillarga kam sezgir qilib yasash (termostatlash, ekranlash, differensial sxemalar);
+ *strukturaviy usul* — taʼsir etuvchi omillarni qoʻshimcha datchiklar bilan oʻlchab, (2) model orqali kompensatsiya qilish;
+ *algoritmik usul* — bir nechta oʻlchashni oʻrtachalash, filtrlash va turli datchiklar maʼlumotlarini birlashtirish orqali shovqin $xi$ taʼsirini kamaytirish.

Bu usullar keyingi maʼruzalarda — datchiklar tavsiflari va xatoliklarini kompensatsiya qilish mavzusida batafsil oʻrganiladi.

// =====================================================================
= Informatsion tizimlarning vazifasi boʻyicha sinflanishi
// =====================================================================

Robototexnikada informatsion tizimlarni ular bajaradigan vazifaga koʻra sinflash qabul qilingan. Bu sinflanish inson sezgi organlari bilan oʻxshashlikka ham asoslanadi (1-maʼruza) va fanning keyingi mavzulari aynan shu tartibda oʻrganiladi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.2fr, 1.3fr),
    header: ([Informatsion tizim], [Oʻlchanadigan kattaliklar], [Asosiy datchiklar]),
    [Kinestetik (ichki holat) tizimlari],
    [Boʻgʻinlarning burchak va chiziqli siljishi, tezligi, tezlanishi, dvigatel toki],
    [Enkoderlar, rezolverlar, potensiometrlar, taxogeneratorlar, tok datchiklari],

    [Lokatsion tizimlar],
    [Obyektgacha masofa, obyektlarning joylashuvi va harakati],
    [Ultratovush lokatorlari, lazer masofa oʻlchagichlari, LiDAR, radarlar],

    [Texnik koʻrish tizimlari],
    [Obyektlar shakli, rangi, joylashuvi; sahna tasviri va chuqurligi],
    [Kameralar, stereokameralar, chuqurlik (RGB-D) kameralari],

    [Taktil va kuch-moment sezish tizimlari],
    [Kontakt bor-yoʻqligi, kontakt kuchi va momenti, sirpanish],
    [Taktil matritsalar, kuch-moment datchiklari, sirpanish datchiklari],

    [Navigatsiya tizimlari],
    [Mobil robotning fazodagi oʻrni, tezligi va yoʻnalishi],
    [IMU (akselerometr, giroskop), magnitometr, GNSS, odometriya],

    [Diagnostika va xavfsizlik tizimlari],
    [Harorat, vibratsiya, inson yaqinligi, nosozlik belgilari],
    [Harorat va vibratsiya datchiklari, yaqinlik datchiklari, xavfsizlik skanerlari],

    [Inson-robot muloqot tizimlari],
    [Operator ovozi, imo-ishoralari, boshqaruv qurilmalari holati],
    [Mikrofonlar, kameralar, joystiklar, sensorli ekranlar],
  ),
  caption: [Robot informatsion tizimlarining vazifasi boʻyicha sinflanishi],
) <tab-vazifa>

*Kinestetik tizimlar* robotning «mushak-boʻgʻin sezgisi» boʻlib, yuritmalarning qayta aloqa konturlarini taʼminlaydi. Ularsiz robot boshqariluvchi harakatni bajara olmaydi, shuning uchun ular I avlod robotlarida ham mavjud.

*Lokatsion tizimlar* muhitga signal (tovush, yorugʻlik, radiotoʻlqin) yuborib, qaytgan signal boʻyicha masofa va obyekt joylashuvini aniqlaydi. Ular mobil robotlarda toʻsiqlardan qochish va xarita tuzishning asosiy vositasi hisoblanadi.

*Texnik koʻrish tizimlari* eng katta hajmdagi axborotni beradi va obyektlarni tanib olish imkonini beradi, lekin eng murakkab ishlov berish algoritmlarini talab qiladi.

*Taktil va kuch-moment sezish tizimlari* robot obyekt bilan kontaktga kirganda ishlaydi: ular yigʻish, silliqlash, nozik obyektlarni ushlash va inson bilan xavfsiz hamkorlik uchun zarur.

*Navigatsiya tizimlari* mobil robotlar, dronlar va avtonom transport vositalarida robotning global va lokal koordinatalarini aniqlaydi. Odatda ular bir nechta turli datchik maʼlumotlarini birlashtirish asosida quriladi.

Bu sinflanish shartli: bitta datchik bir nechta tizimga xizmat qilishi mumkin. Masalan, kamera ham texnik koʻrish, ham navigatsiya (vizual odometriya), ham inson bilan muloqot (imo-ishoralarni tanish) uchun ishlatiladi.

// =====================================================================
= Datchiklarning fizik va energetik belgilar boʻyicha sinflanishi
// =====================================================================

Informatsion tizim elementlari — datchiklar — vazifasidan tashqari bir qator boshqa belgilar boʻyicha ham sinflanadi. Regtien va Dertien datchiklarni sinflashning bir nechta sxemasini koʻrib chiqadi: oʻlchanadigan kattalik va qoʻllanish sohasi boʻyicha, energiya oqimi (port modellari) boʻyicha, oʻzgartirish prinsipi boʻyicha va energetik sohalar boʻyicha.

== Energiya oqimi boʻyicha: generatorli va parametrik datchiklar

*Generatorli* (oʻzi energiya hosil qiluvchi, inglizcha _self-generating, direct_) datchiklar yordamchi energiya manbaisiz ishlaydi: chiqish signali energiyasini bevosita oʻlchanayotgan obyektdan oladi. Ularning muhim afzalligi — nol siljishi yoʻqligi: kirish nolga teng boʻlsa, chiqish ham amalda nolga teng. Kamchiligi — obyektdan energiya olinishi tufayli uning holati biroz oʻzgarishi mumkin. Misollar: termojuft, piezoelektrik akselerometr, induksion tezlik datchigi, fotodiod (fotovoltaik rejimda).

*Parametrik* (modulyatsiyalovchi, inglizcha _modulating_) datchiklarda oʻlchanayotgan kattalik materialning biror xossasini yoki geometrik parametrni oʻzgartiradi, bu oʻzgarish esa tashqi yordamchi manba signali orqali «soʻrab olinadi». Chiqish energiyasi asosan yordamchi manbadan olinadi. Datchiklarning aksariyati shu guruhga kiradi: barcha rezistiv, sigʻim va induktiv datchiklar, shuningdek optik va akustik siljish datchiklarining koʻpchiligi.

Bu farq oʻlchash sxemasini tanlashni belgilaydi: generatorli datchiklar uchun *generatorli oʻlchash sxemalari* (kuchaytirgichlar, zaryad kuchaytirgichlari), parametrik datchiklar uchun esa taʼminot manbaiga ega *parametrik sxemalar* (koʻprik sxemalari, kuchlanish boʻlgichlari) qoʻllaniladi.

== Energetik sohalar boʻyicha

Datchikning kirish va chiqish signallari turli energetik sohalarga tegishli boʻlishi mumkin. Datchiklar nazariyasida koʻpincha oltita signal sohasi ajratiladi: nurlanish (optik), mexanik, issiqlik, elektr, magnit va kimyoviy sohalar. Datchik kirish signalini biror sohadan elektr sohasiga oʻtkazadi; parametrik datchikda esa yordamchi signal sohasi ham hisobga olinadi. Bunday yondashuv bir xil vazifani turli fizik yoʻllar bilan hal qilish imkoniyatlarini tizimli koʻrishga yordam beradi.

== Oʻzgartirish prinsipi boʻyicha

Regtien va Dertien bu sinflanishni amaliyot uchun eng foydali deb hisoblaydi, chunki datchik tavsiflari asosan uning fizik ishlash prinsipi bilan belgilanadi. Bunda datchikning elektr chiqishi materialning xossasiga, geometriyaga yoki harakatga bogʻliq boʻlishi mumkin. Robototexnikada qoʻllaniladigan asosiy prinsiplar 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1.3fr, 1.2fr),
    header: ([Prinsip], [Fizik effekt], [Robotdagi qoʻllanilishi]),
    [Rezistiv],
    [Qarshilikning siljish, deformatsiya yoki haroratga bogʻliqligi],
    [Potensiometrlar, tenzodatchiklar, termorezistorlar],

    [Sigʻim],
    [Elektrodlar orasidagi masofa, yuza yoki dielektrik oʻzgarishi],
    [Yaqinlik datchiklari, taktil qoplamalar, MEMS akselerometrlar],

    [Induktiv va magnit],
    [Induktivlik, oʻzaro induktivlik oʻzgarishi; Xoll effekti],
    [Rezolverlar, LVDT, induktiv yaqinlik datchiklari, Xoll datchiklari],

    [Optik],
    [Yorugʻlik oqimining toʻsilishi, aks etishi, tarqalish vaqti],
    [Optik enkoderlar, lazer masofa oʻlchagichlari, kameralar],

    [Piezoelektrik],
    [Mexanik kuchlanishda zaryad hosil boʻlishi],
    [Dinamik kuch datchiklari, akselerometrlar, ultratovush oʻzgartkichlari],

    [Akustik],
    [Tovush toʻlqinining tarqalish vaqti va aks etishi],
    [Ultratovush lokatorlari va masofa oʻlchagichlari],
  ),
  caption: [Datchiklarning oʻzgartirish prinsipi boʻyicha sinflanishi],
) <tab-prinsip>

Bitta kattalikni turli prinsiplar bilan oʻlchash mumkin, aksincha, bitta prinsip turli kattaliklarni oʻlchashda qoʻllanadi. Masalan, magnit datchik siljish, tezlik yoki taktil datchik sifatida ishlatilishi mumkin, lekin barcha holatlarda uning imkoniyatlari magnit prinsipning fizikasi bilan cheklanadi.

== Boshqa belgilar boʻyicha

*Chiqish signali turi boʻyicha:* analog (kuchlanish, tok), chastotali va impulsli (inkremental enkoder, chastota chiqishli datchiklar) hamda raqamli (absolyut enkoder, raqamli interfeysli datchiklar).

*Muhit bilan taʼsir masofasi boʻyicha:* kontaktli (taktil, kuch-moment), yaqin masofali (yaqinlik datchiklari, millimetrdan bir necha santimetrgacha) va uzoq masofali (lokatsion va koʻrish tizimlari, metrlardan yuzlab metrlargacha).

*Axborotga ishlov berish darajasi boʻyicha:* oddiy datchiklar (faqat sezgir element va oʻzgartkich), integrallashgan datchiklar (oʻlchash sxemasi va ARO bilan) va intellektual datchiklar (mikroprotsessor, kalibrlash, oʻz-oʻzini diagnostika qilish va raqamli tarmoq interfeysi bilan).

// =====================================================================
= Robot informatsion tizimining ierarxik tuzilishi
// =====================================================================

Murakkab robotda datchiklardan kelgan axborot bir necha bosqichda qayta ishlanadi. Har bir yuqori bosqichda axborot hajmi kamayadi, lekin uning mazmuni boyiydi: millionlab piksellardan «oldinda 3 m masofada odam bor» degan bitta xulosa olinadi. Bu tamoyil robotlarni intellektual boshqarishning ierarxik prinsipiga mos keladi. Informatsion tizimning ierarxik tuzilishi 2-rasmda koʻrsatilgan.

#figure(
  diagram(
    spacing: (10mm, 6mm),
    node-stroke: 1pt,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [*5. Qaror qabul qilish va rejalashtirish*], width: 7.5cm, fill: lightorange, name: <l5>),
    node((0, 1), [*4. Muhit modeli va vaziyatni tanib olish*], width: 7.5cm, fill: lightblue, name: <l4>),
    node((0, 2), [*3. Belgilarni ajratish*], width: 7.5cm, fill: lightblue, name: <l3>),
    node((0, 3), [*2. Birlamchi ishlov berish*], width: 7.5cm, fill: lightblue, name: <l2>),
    node((0, 4), [*1. Datchiklar sathi*], width: 7.5cm, fill: white, name: <l1>),
    node((1, 0), align(left)[harakat rejasi, boshqaruv buyruqlari], stroke: none),
    node((1, 1), align(left)[xarita, obyektlar va ularning holati], stroke: none),
    node((1, 2), align(left)[chegaralar, nuqtalar, masofalar, kuch vektori], stroke: none),
    node((1, 3), align(left)[filtrlash, kalibrlash, sinxronlash], stroke: none),
    node((1, 4), align(left)[elektr signallari, raqamli kodlar], stroke: none),
    edge(<l1>, <l2>, "->"),
    edge(<l2>, <l3>, "->"),
    edge(<l3>, <l4>, "->"),
    edge(<l4>, <l5>, "->"),
  ),
  caption: [Robot informatsion tizimida axborotga ishlov berish ierarxiyasi],
) <fig-ierarxiya>

Quyi sathlarda (1–2) ishlov berish qatʼiy real vaqtda, koʻpincha datchikning oʻzida yoki yuritma drayverida bajariladi. Masalan, enkoder signali yuritmaning tezlik va pozitsiya konturida mikrosekundlar ichida ishlatiladi. Yuqori sathlarda (4–5) ishlov berish murakkab algoritmlar — tasvirlarni tanib olish, xarita qurish, sunʼiy intellekt usullarini talab qiladi va robotning markaziy kompyuterida bajariladi.

Sathlar boʻyicha axborot oqimi juda notekis. Raqamli kameraning axborot oqimi quyidagicha baholanadi:

#eq($ R = N_x dot N_y dot b dot f, $)

bu yerda $N_x, N_y$ — tasvirning gorizontal va vertikal piksellar soni, $b$ — bitta piksel uchun bitlar soni, $f$ — kadrlar chastotasi. $1920 times 1080$ piksel, 24 bit va 30 kadr/s uchun $R approx 1","49$ Gbit/s. Taqqoslash uchun, 17 bitli enkoderlar bilan jihozlangan olti boʻgʻinli manipulyator 1 kHz chastotada atigi $6 dot 17 dot 1000 approx 0","1$ Mbit/s axborot hosil qiladi. Shu sababli koʻrish tizimlarida axborotni datchikning oʻzida yoki unga yaqin joyda dastlabki qayta ishlash (siqish, belgilarni ajratish) muhim masala hisoblanadi.

// =====================================================================
= Informatsion tizimlarga qoʻyiladigan talablar
// =====================================================================

Robot informatsion tizimi va uning elementlariga quyidagi asosiy talablar qoʻyiladi:
- *aniqlik va ruxsat qobiliyati* — robotning bajaradigan vazifasiga mos boʻlishi;
- *tezkorlik* — oʻtkazish polosasi yetarli, kechikish esa boshqaruv konturi uchun ruxsat etilgan qiymatdan kichik boʻlishi;
- *ishonchlilik* — nosozliklar orasidagi vaqt katta, muhim kanallar esa zaxiralangan boʻlishi (5-amaliyot);
- *shovqinbardoshlik* — elektromagnit xalaqitlar, vibratsiya, harorat oʻzgarishi sharoitida ishlay olishi;
- *kichik oʻlcham, massa va energiya isteʼmoli* — ayniqsa manipulyator zvenolari va mobil robotlarda;
- *integratsiyalash qulayligi* — standart interfeyslar, kalibrlash va almashtirish osonligi;
- *narx* — robotning umumiy narxiga mos boʻlishi.

Bu talablar koʻpincha bir-biriga zid: aniqlikni oshirish narx, oʻlcham yoki tezkorlik hisobiga erishiladi. Ikki misolda talablarning miqdoriy tomonini koʻramiz.

*Kechikishning taʼsiri.* Informatsion kanal $tau$ kechikish bilan axborot bersa, $v$ tezlik bilan harakatlanayotgan robot uchun bu kechikish quyidagi pozitsiya xatoligiga olib keladi:

#eq($ Delta s = v dot tau. $)

Masalan, 2 m/s tezlikda harakatlanayotgan mobil robotda 50 ms kechikish $Delta s = 2 dot 0","05 = 0","1$ m, yaʼni 10 sm xatolik beradi. Toʻsiqdan qochish masofasi aynan shu xatolikni hisobga olib tanlanishi kerak.

*Burchak ruxsat qobiliyati va masofa.* Skanerlovchi lokator yoki kamera kichik burchak qadami $Delta theta$ bilan oʻlchasa, $R$ masofadagi koʻndalang ruxsat qobiliyati:

#eq($ Delta x = R dot Delta theta. $)

Burchak qadami $0","2 degree$ ($3","49 dot 10^(-3)$ rad) boʻlgan LiDAR uchun 20 m masofada $Delta x approx 0","07$ m. Demak, bunday lokator 20 m masofada 7 sm dan kichik obyektlarni ishonchli ajrata olmasligi mumkin.

Bu misollar informatsion tizimni loyihalashda datchikni robot vazifasi, tezligi va ish masofasidan kelib chiqib tanlash kerakligini koʻrsatadi.

// =====================================================================
= Xulosa
// =====================================================================

Robotning informatsion tizimi informatsion-oʻlchash kanallaridan iborat boʻlib, har bir kanal sezgir element, oʻlchash oʻzgartkichi, signalga ishlov berish, ARO va interfeysni oʻz ichiga oladi. Datchikning toʻgʻri va teskari informatsion modellari oʻlchash xatoliklarini konstruktiv, strukturaviy va algoritmik usullar bilan kamaytirish asosini tashkil etadi.

Informatsion tizimlar vazifasi boʻyicha kinestetik, lokatsion, texnik koʻrish, taktil va kuch-moment, navigatsiya, diagnostika va muloqot tizimlariga boʻlinadi. Datchiklar esa energiya oqimi (generatorli va parametrik), energetik soha, oʻzgartirish prinsipi, chiqish signali, taʼsir masofasi va ishlov berish darajasi boʻyicha sinflanadi. Murakkab robotda axborot ierarxik ravishda — datchik signallaridan muhit modeli va qarorlargacha — qayta ishlanadi. Informatsion tizimga qoʻyiladigan talablar oʻzaro zid boʻlgani uchun uni loyihalash murosali yechim topishni talab qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robotning informatsion tizimi deganda nima tushuniladi va u qanday vazifalarni bajaradi?
  + Informatsion-oʻlchash kanali qanday elementlardan iborat? Har birining vazifasini tushuntiring.
  + Datchikning toʻgʻri va teskari informatsion modellari qanday farqlanadi?
  + Oʻlchash xatoliklarini kamaytirishning konstruktiv, strukturaviy va algoritmik usullariga misol keltiring.
  + Robot informatsion tizimlari vazifasi boʻyicha qanday sinflanadi?
  + Kinestetik va lokatsion tizimlar oʻrtasidagi farq nimada?
  + Generatorli va parametrik datchiklar qanday farqlanadi? Har biriga misol keltiring.
  + Datchiklarni oʻzgartirish prinsipi boʻyicha sinflashning afzalligi nimada?
  + Oddiy, integrallashgan va intellektual datchiklar qanday farqlanadi?
  + Robot informatsion tizimidagi axborotga ishlov berish ierarxiyasini tushuntiring.
  + Nima uchun texnik koʻrish tizimlarida axborotni dastlabki qayta ishlash muhim?
  + 1,5 m/s tezlikdagi robotda 80 ms kechikish qanday pozitsiya xatoligiga olib keladi?
]
