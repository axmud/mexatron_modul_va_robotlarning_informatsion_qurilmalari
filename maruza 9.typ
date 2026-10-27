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
  + Metrologiyaning asosiy tushunchalari. Kalibrlash va metrologik kuzatuvchanlik.
  + Metrologik tavsiflarning tasnifi.
  + Statik metrologik tavsiflar.
  + Oʻlchash xatoliklari, ularni normalash va yigʻish. Oʻlchash noaniqligi.
  + Dinamik metrologik tavsiflar.
  + Mexatron modullarning metrologik tavsiflari.
  + Robotlarning metrologik tavsiflari (ISO 9283).

  *Tayanch iboralar:* oʻlchash vositasi, metrologik tavsif, kalibrlash, qiyoslash, etalon, metrologik kuzatuvchanlik, oʻzgartirish funksiyasi, sezgirlik, chiziqlilik xatosi, gisterezis, takrorlanuvchanlik, harorat drifti, asosiy va qoʻshimcha xatolik, aniqlik klassi, xatoliklarni geometrik yigʻish, standart va kengaytirilgan noaniqlik, amplituda-chastota tavsifi, dinamik xatolik, lyuft, burilish bikrligi, pozitsiyalash aniqligi va takrorlanuvchanligi.
]

// =====================================================================
= Metrologiyaning asosiy tushunchalari
// =====================================================================

Oldingi maʼruzalarda robotlarda qoʻllanadigan turli datchiklar koʻrib chiqildi. Ularning har biri oʻlchash vositasi boʻlib, uning natijasiga qanchalik ishonish mumkinligini bilish kerak. Bu masalalar bilan *metrologiya* — oʻlchashlar, ularning birligini taʼminlash usullari va vositalari hamda talab qilinadigan aniqlikka erishish usullari haqidagi fan shugʻullanadi.

Asosiy tushunchalar:
- *oʻlchash* — fizik kattalik qiymatini tajriba yoʻli bilan maxsus texnik vositalar yordamida aniqlash;
- *oʻlchash vositasi* — oʻlchash uchun moʻljallangan va normalangan metrologik tavsiflarga ega texnik vosita (datchik, oʻlchash asbobi, oʻlchash tizimi);
- *metrologik tavsif* — oʻlchash vositasining oʻlchash natijasi va uning xatoligiga taʼsir qiluvchi xossasini miqdoriy ifodalovchi koʻrsatkich;
- *normalangan metrologik tavsiflar* — ishlab chiqaruvchi tomonidan kafolatlangan va oʻlchash vositasi hujjatlarida (pasportida) koʻrsatilgan tavsiflar.

== Kalibrlash va metrologik kuzatuvchanlik

*Kalibrlash* — oʻlchash vositasi koʻrsatkichlari bilan aniqroq oʻlchash vositasi (etalon) tomonidan aniqlangan qiymatlar orasidagi bogʻliqlikni belgilash amallari majmuasi. Kalibrlash natijasida oʻlchash vositasining haqiqiy oʻzgartirish funksiyasi va xatoligi aniqlanadi. Qonun bilan tartibga solinadigan sohalarda (savdo, xavfsizlik, sogʻliqni saqlash) qoʻllanadigan oʻlchash vositalari esa vakolatli metrologiya xizmati tomonidan davriy *qiyoslanadi* — ularning belgilangan talablarga mosligi tasdiqlanadi.

Har bir oʻlchash natijasi uzluksiz kalibrlashlar zanjiri orqali xalqaro birliklar tizimi (SI) birliklarini qayta hosil qiluvchi davlat etalonlari bilan bogʻlangan boʻlishi kerak. Bu xossa *metrologik kuzatuvchanlik* deyiladi (1-rasm). Zanjirning har bir pogʻonasida aniqlik biroz kamayadi, shuning uchun etalon kalibrlanayotgan vositadan odatda bir necha marta aniqroq boʻlishi talab qilinadi.

#figure(
  diagram(
    spacing: (6mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [SI birligi, \ davlat etaloni], fill: lightorange, name: <a>),
    node((1, 0), [Ishchi \ etalonlar], name: <b>),
    node((2, 0), [Kalibrlash \ laboratoriyasi], name: <c>),
    node((3, 0), [Kalibrlash \ stendi], name: <d>),
    node((4, 0), [Datchik, \ robot], fill: white, name: <e>),
    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <d>, "->"),
    edge(<d>, <e>, "->"),
  ),
  caption: [Metrologik kuzatuvchanlik zanjiri (chapdan oʻngga aniqlik kamayadi)],
) <fig-kuzat>

// =====================================================================
= Metrologik tavsiflarning tasnifi
// =====================================================================

Datchik va oʻlchash vositalarining metrologik tavsiflari quyidagi guruhlarga boʻlinadi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.6fr),
    header: ([Guruh], [Tavsiflar]),
    [Oʻlchash natijasini aniqlash uchun tavsiflar],
    [Oʻzgartirish funksiyasi (statik tavsif), oʻlchash diapazoni, sezgirlik, ruxsat qobiliyati, raqamli kod qiymati],
    [Xatolik tavsiflari],
    [Asosiy xatolik, uning sistematik va tasodifiy tashkil etuvchilari, chiziqlilik xatosi, gisterezis, takrorlanuvchanlik, aniqlik klassi],
    [Taʼsir etuvchi kattaliklarga sezgirlik],
    [Harorat, taʼminot kuchlanishi, namlik, vibratsiya taʼsiridagi qoʻshimcha xatoliklar va driftlar],
    [Dinamik tavsiflar],
    [Vaqt doimiysi, javob vaqti, amplituda-chastota va faza-chastota tavsiflari, oʻtkazish polosasi, xususiy chastota],
    [Oʻzaro taʼsir tavsiflari],
    [Kirish va chiqish qarshiliklari (impedanslari), obyektga va keyingi qurilmaga taʼsiri],
  ),
  caption: [Metrologik tavsiflarning tasnifi],
) <tab-tasnif>

Oxirgi guruh koʻpincha eʼtibordan chetda qoladi, lekin muhim: masalan, potensiometr chiqishiga kichik qarshilikli yuklama ulansa, tavsif buziladi (5-maʼruza), termojuftni ulovchi uzun simlar esa oʻlchash natijasiga taʼsir qiladi.

// =====================================================================
= Statik metrologik tavsiflar
// =====================================================================

Kirish kattaligi oʻzgarmas yoki juda sekin oʻzgarganda datchik chiqishi $y$ ning kirishi $x$ ga bogʻliqligi *oʻzgartirish funksiyasi* (statik tavsif) $y = f(x)$ bilan ifodalanadi. Uning asosiy koʻrsatkichlari:

- *oʻlchash diapazoni* — kattalikning normalangan xatolik bilan oʻlchanadigan qiymatlar oraligʻi $[x_min, x_max]$; chiqish diapazoni (toʻliq shkala, FS) $Y_"FS" = y(x_max) - y(x_min)$;
- *sezgirlik* — $S = d y slash d x$; chiziqli datchikda oʻzgarmas;
- *ruxsat qobiliyati* — chiqishda sezilarli oʻzgarish beradigan kirishning eng kichik oʻzgarishi; *sezgirlik boʻsagʻasi* esa nol atrofidagi shunday eng kichik qiymat;
- *chiziqlilik xatosi* — real tavsifning tanlangan toʻgʻri chiziqdan eng katta chetlanishi $Delta_max$ ning toʻliq shkalaga nisbati:

#eq($ delta_L = (Delta_max) / Y_"FS" dot 100 %. $)

Toʻgʻri chiziq turlicha tanlanishi mumkin: diapazon chekka nuqtalaridan oʻtuvchi chiziq yoki eng kichik kvadratlar usulida topilgan chiziq. Ikkinchi usulda xatolik kichikroq chiqadi, shuning uchun datchik pasportida qaysi usul qoʻllangani koʻrsatilishi kerak.

- *gisterezis* — kirish ortib va kamayib borganda bir xil $x$ ga mos chiqishlarning eng katta farqi (toʻliq shkalaga nisbatan, %);
- *takrorlanuvchanlik* — bir xil sharoitda, bir yoʻnalishdan bir xil kirishga takroriy yondashganda natijalarning tarqoqligi;
- *nol siljishi va sezgirlik drifti* — taʼsir etuvchi kattaliklar, ayniqsa harorat oʻzgarganda tavsifning siljishi.

Haroratning taʼsirini quyidagi model bilan ifodalash mumkin:

#eq($ y = S (1 + beta Delta T) dot x + y_0 + gamma Delta T, $)

bu yerda $Delta T$ — normal haroratdan chetlanish, $beta$ — sezgirlikning harorat koeffitsienti, $gamma$ — nol siljishining harorat koeffitsienti. *Misol.* Bosim datchigi uchun $gamma = 0","02 %$ FS/°C boʻlsa, normal 20 °C dan 50 °C gacha qizish nolni 0,6 % FS ga siljitadi — bu koʻp datchiklarning asosiy xatoligidan katta. Shuning uchun datchik pasportida *asosiy xatolik* (normal sharoitda) bilan bir qatorda har bir taʼsir etuvchi kattalik uchun *qoʻshimcha xatolik* ham normalanadi.

// =====================================================================
= Oʻlchash xatoliklari, ularni normalash va yigʻish
// =====================================================================

== Xatoliklarning ifodalanishi va aniqlik klassi

Oʻlchash xatoligi absolyut ($Delta = x_"oʻl" - x_"h"$), nisbiy ($delta = Delta slash x_"h" dot 100 %$) va keltirilgan koʻrinishda ifodalanadi. Datchik va asboblar uchun koʻpincha *keltirilgan xatolik* normalanadi:

#eq($ gamma = Delta / X_N dot 100 %, $)

bu yerda $X_N$ — normalovchi qiymat (odatda oʻlchash diapazoni). Ruxsat etilgan eng katta keltirilgan xatolik oʻlchash vositasining *aniqlik klassini* belgilaydi: masalan, 0,5 klass $|gamma| <= 0","5 %$ ni anglatadi. Keltirilgan xatolik butun diapazonda bir xil boʻlgani uchun nisbiy xatolik kichik qiymatlarni oʻlchashda keskin ortadi; shu sababli datchik diapazoni oʻlchanadigan qiymat diapazonning yuqori qismida boʻladigan qilib tanlanadi.

Kelib chiqishiga koʻra xatoliklar *sistematik* (oʻzgarmas yoki qonuniy oʻzgaradi, kalibrlash va tuzatish orqali kamaytiriladi), *tasodifiy* (statistik usullar bilan baholanadi, koʻp marta oʻlchab oʻrtachalash orqali kamaytiriladi) va *qoʻpol* (natijalardan chiqarib tashlanadi) turlarga boʻlinadi. Tasodifiy xatoliklarni statistik qayta ishlash usullari amaliy mashgʻulotlarda batafsil oʻrganiladi.

== Xatoliklarni yigʻish

Oʻlchash kanali bir nechta elementdan (datchik, kuchaytirgich, ARO) iborat boʻlib, har biri oʻz xatoligini qoʻshadi. Agar elementlar xatoliklari bir-biriga bogʻliq boʻlmagan tasodifiy kattaliklar boʻlsa, umumiy xatolik *geometrik* (kvadratik) yigʻindi bilan baholanadi:

#eq($ Delta_Sigma = sqrt(Delta_1^2 + Delta_2^2 + dots + Delta_n^2). $)

*Misol.* Datchik xatoligi 0,1 %, kuchaytirgichniki 0,05 %, ARO niki 0,02 % boʻlsa, $Delta_Sigma = sqrt(0","1^2 + 0","05^2 + 0","02^2) approx 0","114 %$. Arifmetik yigʻindi esa 0,17 % ni beradi — bu eng yomon holat, barcha xatoliklar bir vaqtda eng katta qiymatga va bir yoʻnalishga ega boʻlgandagi baho. (4) ifodadan muhim amaliy xulosa: umumiy xatolikni asosan eng katta tashkil etuvchi belgilaydi. Bu misolda ARO aniqligini oshirish deyarli foyda bermaydi, datchikni yaxshilash esa sezilarli natija beradi.

== Oʻlchash noaniqligi

Zamonaviy xalqaro amaliyotda oʻlchash natijasining sifati *noaniqlik* tushunchasi bilan ifodalanadi. Noaniqlik — oʻlchanayotgan kattalikka asosli ravishda mos keladigan qiymatlarning tarqoqligini tavsiflovchi parametr. Har bir noaniqlik manbai *standart noaniqlik* $u_i$ (standart ogʻish koʻrinishida) bilan baholanadi va ular (4) ga oʻxshash tarzda birlashtirilib, *jamlangan standart noaniqlik* $u_c$ olinadi. Natija *kengaytirilgan noaniqlik* bilan beriladi:

#eq($ U = k dot u_c, $)

bu yerda $k$ — qamrov koeffitsienti; $k = 2$ normal taqsimotda taxminan 95 % ishonch ehtimoliga mos keladi. Natija $x = hat(x) plus.minus U$ koʻrinishida yoziladi, masalan, «$25","40 plus.minus 0","04$ mm, $k = 2$».

// =====================================================================
= Dinamik metrologik tavsiflar
// =====================================================================

Kirish kattaligi tez oʻzgarganda datchik chiqishi undan kechikadi va amplitudasi buziladi. Bu holat *dinamik tavsiflar* bilan baholanadi. Birinchi tartibli datchikning (termojuft, termorezistor, filtrli datchiklar) uzatish funksiyasi $W(s) = S slash (tau s + 1)$ boʻlib, sinusoidal kirish uchun uning *amplituda-chastota tavsifi*:

#eq($ A(omega) = S / sqrt(1 + (omega tau)^2). $)

Chastota ortishi bilan chiqish amplitudasi kamayadi. Amplitudaning statik qiymatdan $1 slash sqrt(2)$ gacha (−3 dB) kamayish chastotasi $f_c = 1 slash (2 pi tau)$ datchikning *oʻtkazish polosasini* belgilaydi. *Misol.* $tau = 0","1$ s boʻlgan datchik bilan 1 Hz chastotada oʻzgaruvchi kattalik oʻlchansa, $omega tau = 0","628$ va $A slash S = 1 slash sqrt(1 + 0","628^2) approx 0","85$: amplituda 15 % ga kam oʻlchanadi. Bu *dinamik xatolik* statik xatolikka qoʻshiladi.

Massa va elastik elementga ega datchiklar (akselerometrlar, kuch-moment datchiklari) ikkinchi tartibli tizim sifatida tavsiflanadi:

#eq($ W(s) = (S omega_n^2) / (s^2 + 2 zeta omega_n s + omega_n^2), $)

bu yerda $omega_n$ — xususiy chastota, $zeta$ — soʻnish koeffitsienti. Soʻnish kichik boʻlsa, xususiy chastota atrofida rezonans yuzaga keladi va amplituda keskin oshib ketadi. Shuning uchun bunday datchiklar xususiy chastotadan ancha past chastotalarda ishlatiladi, soʻnish koeffitsienti esa $zeta approx 0","6 dots 0","7$ atrofida tanlanganda amplituda-chastota tavsifi eng keng diapazonda tekis boʻladi.

Dinamik tavsiflar boshqaruv konturi uchun ayniqsa muhim: datchikning kechikishi va faza siljishi qayta aloqali tizimning barqarorligini yomonlashtiradi. Shuning uchun datchik oʻtkazish polosasi boshqaruv konturining oʻtkazish polosasidan bir necha marta keng boʻlishi kerak.

// =====================================================================
= Mexatron modullarning metrologik tavsiflari
// =====================================================================

Mexatron modul (masalan, robot boʻgʻini yuritmasi) uchun alohida datchik tavsiflaridan tashqari butun modulning harakat aniqligi muhim. Uning asosiy metrologik tavsiflari: *pozitsiyalash aniqligi* (buyruq berilgan va haqiqiy holat farqi), *pozitsiyalash takrorlanuvchanligi*, *ruxsat qobiliyati* (eng kichik bajariladigan siljish) va *tezlikni ushlab turish aniqligi*. Ular modul zanjirining barcha elementlari xatoliklari bilan belgilanadi (2-jadval).

#figure(
  btable(
    columns: (auto, 1.3fr, 1fr),
    header: ([Element], [Xatolik manbai], [Xatolik turi]),
    [Enkoder],
    [Kvantlash, interpolyatsiya xatoligi, oʻrnatish ekssentrisiteti],
    [Sistematik va tasodifiy],
    [Reduktor],
    [Lyuft, kinematik (tishlar qadami) xatoligi, burilishdagi elastiklik],
    [Asosan sistematik, yuklamaga bogʻliq],
    [Zveno va podshipniklar],
    [Egilish, issiqlik kengayishi, geometrik oʻlcham xatoliklari],
    [Sistematik, sharoitga bogʻliq],
    [Boshqaruv tizimi],
    [Rostlagich xatoligi, ishqalanish, tebranishlar],
    [Dinamik],
  ),
  caption: [Mexatron modulning harakat xatoligi manbalari],
) <tab-modul>

Reduktor chiqish validagi enkoder ruxsat qobiliyati juda yuqori boʻlsa ham, modulning haqiqiy aniqligini koʻpincha mexanik xatoliklar cheklaydi. Masalan, burilish bikrligi $k_theta$ boʻlgan reduktorga $M$ moment taʼsir qilsa, u quyidagi burchakka buraladi va zveno uchida chiziqli xatolik hosil boʻladi:

#eq($ Delta phi = M / k_theta, quad Delta s = L dot Delta phi. $)

*Misol.* $k_theta = 10^4$ N·m/rad, $M = 50$ N·m va zveno uzunligi $L = 0","5$ m boʻlsa, $Delta phi = 0","005$ rad, $Delta s = 2","5$ mm. Bu qiymat yuklama bilan oʻzgaradi va dvigatel validagi enkoder uni umuman sezmaydi. Shuning uchun yuqori aniqlik talab qilinadigan modullarda chiqish validagi ikkinchi enkoder yoki moment datchigi orqali kompensatsiya qoʻllanadi.

// =====================================================================
= Robotlarning metrologik tavsiflari
// =====================================================================

Sanoat robotlarining ishlash tavsiflari va ularni sinash usullari ISO 9283 standartida belgilangan. Asosiy koʻrsatkichlar: pozitsiyalash aniqligi (AP) va takrorlanuvchanligi (RP), trayektoriya aniqligi (AT) va takrorlanuvchanligi (RT), barqarorlashish vaqti va pozitsiyadan oʻtib ketish.

Robot buyruq berilgan $P_0 (x_0, y_0, z_0)$ nuqtaga $n$ marta yondashadi va har gal erishilgan holat $(x_i, y_i, z_i)$ oʻlchanadi. Erishilgan nuqtalar oʻrtachasi — baritsentr $(macron(x), macron(y), macron(z))$ boʻyicha *pozitsiyalash aniqligi*:

#eq($ "AP" = sqrt((macron(x) - x_0)^2 + (macron(y) - y_0)^2 + (macron(z) - z_0)^2). $)

Har bir nuqtadan baritsentrgacha masofa $l_i$, ularning oʻrtachasi $macron(l)$ va standart ogʻishi $S_l$ boʻyicha *pozitsiyalash takrorlanuvchanligi*:

#eq($ "RP" = macron(l) + 3 S_l. $)

AP sistematik xatolikni (nuqtalar markazining buyruq nuqtasidan siljishini), RP esa tasodifiy xatolikni (nuqtalar tarqoqligini) tavsiflaydi. ISO 9283 boʻyicha sinovda robotning ishchi zonasida joylashtirilgan sinov kubining diagonal tekisligidagi beshta nuqtaga har biriga bir yoʻnalishdan 30 martadan yondashiladi, oʻlchash esa lazer treker yoki koordinata-oʻlchash mashinasi kabi aniq tashqi vosita bilan bajariladi. Robot pultidagi koordinatalar bu maqsadga yaramaydi, chunki ular robotning oʻz enkoderlari asosida hisoblanadi.

Sanoat robotlarida takrorlanuvchanlik odatda aniqlikdan ancha yaxshi boʻladi, shuning uchun ishlab chiqaruvchilar pasportda asosan RP ni koʻrsatadi. Aniqlik esa robotning kinematik modeli (zvenolar uzunliklari, boʻgʻinlarning nol holatlari) va real konstruksiya orasidagi farqlarga bogʻliq; u *kinematik kalibrlash* orqali — model parametrlarini oʻlchash natijalariga moslash yoʻli bilan — sezilarli yaxshilanadi. Robot oflayn dasturlansa (dastur kompyuterdagi model asosida tuzilsa), aniqlik ayniqsa muhim, chunki robot nuqtalarga «oʻrgatilmay», hisoblangan koordinatalar boʻyicha boradi.

Mexatron modul va robotlarning metrologik tavsiflarini hisoblash boʻyicha amaliy misollar (AP va RP hisobi, enkoder ruxsati va lyuft taʼsirini taqqoslash) amaliy mashgʻulotlarda koʻriladi.

// =====================================================================
= Xulosa
// =====================================================================

Metrologik tavsiflar oʻlchash vositasi natijasiga qanchalik ishonish mumkinligini miqdoriy ifodalaydi. Ular oʻlchash natijasini aniqlash, xatolik, taʼsir etuvchi kattaliklarga sezgirlik, dinamik va oʻzaro taʼsir tavsiflariga boʻlinadi. Oʻlchash vositalarining aniqligi kalibrlash orqali tasdiqlanadi, natijalarning ishonchliligi esa davlat etalonlarigacha boʻlgan metrologik kuzatuvchanlik zanjiri bilan taʼminlanadi.

Statik tavsiflar (sezgirlik, chiziqlilik, gisterezis, takrorlanuvchanlik, drift) va dinamik tavsiflar (vaqt doimiysi, amplituda-chastota tavsifi, xususiy chastota) birgalikda datchik xatoligini belgilaydi. Kanal elementlari xatoliklari geometrik yigʻiladi va umumiy xatolikni asosan eng katta tashkil etuvchi belgilaydi. Mexatron modulning aniqligini koʻpincha mexanik elementlar — lyuft va elastiklik cheklaydi; robotlarning aniqligi va takrorlanuvchanligi esa ISO 9283 boʻyicha AP va RP koʻrsatkichlari bilan baholanadi va kinematik kalibrlash orqali yaxshilanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Metrologik tavsif va normalangan metrologik tavsif deganda nima tushuniladi?
  + Kalibrlash va qiyoslash qanday farqlanadi? Metrologik kuzatuvchanlik nima?
  + Metrologik tavsiflar qanday guruhlarga boʻlinadi?
  + Chiziqlilik xatosi qanday aniqlanadi? Toʻgʻri chiziqni tanlash usuli natijaga qanday taʼsir qiladi?
  + Asosiy va qoʻshimcha xatoliklar qanday farqlanadi?
  + 0…10 bar diapazonli 0,5 klassdagi datchik bilan 2 bar oʻlchanganda nisbiy xatolik qancha boʻlishi mumkin?
  + Xatoliklar qachon geometrik, qachon arifmetik yigʻiladi?
  + Xatoliklari 0,2 %, 0,1 % va 0,05 % boʻlgan uch elementli kanalning umumiy xatoligini toping.
  + Standart va kengaytirilgan noaniqlik qanday farqlanadi?
  + $tau = 0","2$ s boʻlgan datchik 0,5 Hz chastotali signal amplitudasini necha foiz kam oʻlchaydi?
  + Ikkinchi tartibli datchik uchun soʻnish koeffitsienti qanday tanlanadi va nima uchun?
  + Mexatron modulning pozitsiyalash xatoligiga qanday omillar taʼsir qiladi?
  + Robotlarning AP va RP koʻrsatkichlari qanday aniqlanadi va nima uchun takrorlanuvchanlik odatda aniqlikdan yaxshiroq?
]
