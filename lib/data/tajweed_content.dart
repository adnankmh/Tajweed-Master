import 'package:flutter/material.dart';
import '../models/content_models.dart';

LocalText lt(String ar, String en, String fr, String tr, String es, String de) => LocalText({
      'ar': ar,
      'en': en,
      'fr': fr,
      'tr': tr,
      'es': es,
      'de': de,
    });

const _arabicPracticeNote = 'اقرأ المثال بهدوء، حدّد موضع الحكم، ثم أعد القراءة مع ضبط المخرج والصفة والغنة أو المد حسب الحكم.';

final List<TajweedRule> tajweedRules = [
  TajweedRule(
    id: 'izhar',
    color: const Color(0xFF0EA5E9),
    category: 'nun',
    title: lt('الإظهار الحلقي', 'Throat clear articulation', 'Izhar guttural', 'Boğaz izharı', 'Izhar gutural', 'Kehl-Izhar'),
    short: lt('إخراج النون الساكنة أو التنوين بوضوح عند حروف الحلق الستة.', 'Clear pronunciation of noon sakin or tanween before the six throat letters.', 'Prononciation claire avant les lettres gutturales.', 'Boğaz harflerinden önce açık okuma.', 'Pronunciación clara antes de letras guturales.', 'Klare Aussprache vor Kehllauten.'),
    deep: lt(
      'الإظهار هو بيان النون الساكنة أو التنوين من غير غنة زائدة ولا إدغام عند أحد حروف الحلق: الهمزة والهاء والعين والحاء والغين والخاء. السر العملي في هذا الحكم أن مخرج الحرف التالي بعيد عن مخرج النون، لذلك لا تُقلب النون ولا تُدغم، بل تظهر واضحة مع المحافظة على زمن طبيعي للغنة الأصلية دون تطويل. يبدأ التدريب بتحديد النون الساكنة أو علامة التنوين ثم النظر إلى أول حرف بعدها، فإن كان حرفًا حلقيًا نقرأ النون أو التنوين ببيان وهدوء.',
      'Izhar means making noon sakin or tanween clear before ء ه ع ح غ خ. The following letter is far from the articulation point of noon, so the noon is neither merged nor changed. Train by locating noon/tanween, checking the next letter, then reading clearly without extra nasalization.',
      'L’Izhar consiste à prononcer clairement le nûn sākin ou le tanwîn devant ء ه ع ح غ خ, sans fusion ni transformation. On s’entraîne en repérant le signe puis la lettre suivante.',
      'İzhar, sakin nun veya tenvini ء ه ع ح غ خ harflerinden önce açık okumaktır; ne idğam yapılır ne de kalb. İşaret ve sonraki harf kontrol edilir.',
      'Izhar es pronunciar claramente nûn sakina o tanwîn antes de ء ه ع ح غ خ, sin fusión ni cambio. Se practica identificando el signo y la letra siguiente.',
      'Izhar bedeutet die klare Aussprache von Nūn sākin oder Tanwīn vor ء ه ع ح غ خ ohne Verschmelzung oder Umwandlung.'),
    examples: ['مَنْ آمَنَ', 'عَلِيمٌ حَكِيمٌ', 'يَنْهَوْنَ', 'مِنْ خَوْفٍ', _arabicPracticeNote],
    commonMistakes: [
      lt('تطويل الغنة وكأنها إدغام أو إخفاء.', 'Lengthening nasalization as if it were idgham or ikhfa.', 'Allonger la nasalisation.', 'Gunneleri uzatmak.', 'Alargar la nasalización.', 'Nasalisierung verlängern.'),
      lt('إخفاء النون بسبب السرعة في القراءة.', 'Hiding the noon because of rushing.', 'Cacher le nûn en lisant vite.', 'Hızlı okuyup nûnu gizlemek.', 'Ocultar el nûn por prisa.', 'Nūn durch Eile verdecken.'),
    ],
    questions: [
      QuizQuestion(id: 'q_izhar_1', question: lt('ما حروف الإظهار الحلقي؟', 'Which are the Izhar throat letters?', 'Quelles sont les lettres?', 'İzhar harfleri hangileridir?', '¿Cuáles son las letras?', 'Welche Buchstaben?'), options: [lt('ء ه ع ح غ خ', 'ء ه ع ح غ خ', 'ء ه ع ح غ خ', 'ء ه ع ح غ خ', 'ء ه ع ح غ خ', 'ء ه ع ح غ خ'), lt('ي ر م ل و ن', 'ي ر م ل و ن', 'ي ر م ل و ن', 'ي ر م ل و ن', 'ي ر م ل و ن', 'ي ر م ل و ن'), lt('ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د')], correctIndex: 0, explanation: lt('هذه هي حروف الحلق الستة.', 'These are the six throat letters.', 'Ce sont les six lettres.', 'Altı boğaz harfi.', 'Son las seis letras.', 'Die sechs Kehllaute.')),
    ],
  ),
  TajweedRule(
    id: 'idgham_ghunnah',
    color: const Color(0xFF22C55E),
    category: 'nun',
    title: lt('الإدغام بغنة', 'Merging with nasalization', 'Idgham avec ghunna', 'Gunneli idğam', 'Idgham con ghunna', 'Idgham mit Ghunnah'),
    short: lt('إدخال النون أو التنوين في ي، ن، م، و مع غنة بمقدار حركتين.', 'Merging noon/tanween into ي ن م و with two-count nasalization.', 'Fusion avec nasalisation.', 'İki hareke gunneli birleşme.', 'Fusión con nasalización.', 'Verschmelzung mit Nasalton.'),
    deep: lt('الإدغام بغنة يكون إذا جاءت النون الساكنة أو التنوين وبعدها أحد حروف: ي ن م و. فينتقل الصوت إلى الحرف التالي مع بقاء الغنة مقدار حركتين تقريبًا. المهم ألا تُنطق النون واضحة كالإظهار، وألا تختفي الغنة. في التلاوة العملية نصل الكلمتين بسلاسة، وننتبه أن الحكم غالبًا يكون بين كلمتين لا داخل كلمة واحدة في هذا الباب.', 'This rule merges noon/tanween into ي ن م و while preserving a two-count nasal sound. It usually occurs across two words. The learner should not pronounce a clear noon and should not remove the nasal sound.', 'Fusion du nûn/tanwîn dans ي ن م و avec nasalisation de deux temps.', 'Nun/tenvin ي ن م و harflerine iki hareke gunneyle katılır.', 'Se fusiona con ي ن م و manteniendo nasalización.', 'Nūn/Tanwīn verschmilzt mit ي ن م و bei zwei Zählzeiten.'),
    examples: ['مَنْ يَقُولُ', 'غَفُورٌ رَحِيمٌ ليس من هذا النوع', 'مِنْ وَالٍ', 'هُدًى مِّن'],
    commonMistakes: [lt('نطق النون واضحة بدل إدغامها.', 'Pronouncing noon clearly instead of merging.', 'Prononcer nûn clairement.', 'Nûnu açık okumak.', 'Pronunciar nûn claro.', 'Nūn klar aussprechen.'), lt('حذف الغنة تمامًا.', 'Removing the nasalization.', 'Supprimer la ghunna.', 'Gunneyi kaldırmak.', 'Eliminar la nasalización.', 'Ghunnah entfernen.')],
    questions: [QuizQuestion(id: 'q_idg_1', question: lt('كم مقدار الغنة غالبًا؟', 'How long is the ghunnah?', 'Durée de ghunna?', 'Gunne süresi?', 'Duración?', 'Dauer?'), options: [lt('حركتان', 'Two counts', 'Deux temps', 'İki hareke', 'Dos tiempos', 'Zwei Zählzeiten'), lt('ست حركات', 'Six counts', 'Six', 'Altı', 'Seis', 'Sechs'), lt('لا غنة', 'No ghunnah', 'Aucune', 'Yok', 'Ninguna', 'Keine')], correctIndex: 0, explanation: lt('الغنة هنا بمقدار حركتين.', 'It is two counts.', 'Deux temps.', 'İki hareke.', 'Dos tiempos.', 'Zwei.'))],
  ),
  TajweedRule(
    id: 'idgham_no_ghunnah',
    color: const Color(0xFF84CC16),
    category: 'nun',
    title: lt('الإدغام بغير غنة', 'Merging without nasalization', 'Idgham sans ghunna', 'Gunnesiz idğam', 'Idgham sin ghunna', 'Idgham ohne Ghunnah'),
    short: lt('إدغام النون أو التنوين في اللام أو الراء من غير غنة.', 'Merging noon/tanween into ل or ر without nasalization.', 'Fusion sans nasalisation.', 'ل/ر içine gunnesiz katma.', 'Fusión sin nasalización.', 'Verschmelzung ohne Nasalton.'),
    deep: lt('إذا جاء بعد النون الساكنة أو التنوين حرف اللام أو الراء فإن النون تُدغم بغير غنة. يزول صوت النون وينتقل اللسان إلى اللام أو الراء مباشرة. يحتاج المتعلم إلى الانتباه حتى لا يضيف غنة لا وجود لها، وخاصة عند الراء لأن التفخيم أو الترقيق قد يشغل القارئ عن أصل الحكم.', 'Before ل or ر, noon/tanween merges without ghunnah. The sound moves directly into the next letter. Avoid adding nasalization.', 'Devant ل ou ر, fusion sans ghunna.', 'ل veya ر öncesi gunnesiz idğam.', 'Ante ل o ر, fusión sin ghunna.', 'Vor ل oder ر ohne Ghunnah.'),
    examples: ['مِنْ رَبِّهِمْ', 'هُدًى لِّلْمُتَّقِينَ', 'غَفُورٌ رَّحِيمٌ'],
    commonMistakes: [lt('إضافة غنة طويلة مع اللام أو الراء.', 'Adding a long nasal sound.', 'Ajouter une ghunna.', 'Gunne eklemek.', 'Añadir nasalización.', 'Ghunnah hinzufügen.')],
    questions: [QuizQuestion(id: 'q_idgn_1', question: lt('ما حرفا الإدغام بغير غنة؟', 'Which letters?', 'Quelles lettres?', 'Hangi harfler?', '¿Qué letras?', 'Welche Buchstaben?'), options: [lt('ل ر', 'ل ر', 'ل ر', 'ل ر', 'ل ر', 'ل ر'), lt('ي و', 'ي و', 'ي و', 'ي و', 'ي و', 'ي و'), lt('ب م', 'ب م', 'ب م', 'ب م', 'ب م', 'ب م')], correctIndex: 0, explanation: lt('هما اللام والراء.', 'They are lam and ra.', 'Lâm et râ.', 'Lam ve ra.', 'Lam y ra.', 'Lam und Ra.'))],
  ),
  TajweedRule(
    id: 'iqlab',
    color: const Color(0xFFF97316),
    category: 'nun',
    title: lt('الإقلاب', 'Conversion before Baa', 'Iqlab', 'İklab', 'Iqlab', 'Iqlab'),
    short: lt('قلب النون الساكنة أو التنوين ميمًا مخفاة عند الباء مع غنة.', 'Changing noon/tanween into a hidden meem before ب with ghunnah.', 'Transformation en mîm caché devant ب.', 'ب önünde gizli mime çevirme.', 'Cambio a mim oculta ante ب.', 'Umwandlung zu verborgenem Mīm vor ب.'),
    deep: lt('الإقلاب لا يكون إلا مع حرف الباء. عنده لا نُظهر النون، ولا ندغمها في الباء، بل نقلبها ميمًا مخفاة مع بقاء الغنة. الشفتان تقتربان دون إطباق قوي، ثم يخرج حرف الباء. علامة المصحف غالبًا ميم صغيرة فوق النون أو التنوين، وهي تساعد القارئ على معرفة الحكم بسرعة.', 'Iqlab occurs only before ب. Noon/tanween changes to a hidden meem with nasalization. The lips approach lightly, then the baa is pronounced.', 'Iqlab se produit seulement devant ب.', 'İklab yalnız ب önünde olur.', 'Iqlab solo ocurre ante ب.', 'Iqlab nur vor ب.'),
    examples: ['مِنْ بَعْدِ', 'سَمِيعٌ بَصِيرٌ', 'لَنَسْفَعًا بِالنَّاصِيَةِ'],
    commonMistakes: [lt('إطباق الشفتين بقوة فيصير ميمًا ظاهرة.', 'Closing lips too strongly.', 'Fermer trop fort les lèvres.', 'Dudakları çok kapatmak.', 'Cerrar demasiado los labios.', 'Lippen zu stark schließen.')],
    questions: [QuizQuestion(id: 'q_iq_1', question: lt('الإقلاب يكون عند أي حرف؟', 'Iqlab occurs before which letter?', 'Devant quelle lettre?', 'Hangi harf?', '¿Ante qué letra?', 'Vor welchem Buchstaben?'), options: [lt('الباء', 'Baa', 'Baa', 'Be', 'Baa', 'Bā'), lt('اللام', 'Lam', 'Lam', 'Lam', 'Lam', 'Lam'), lt('الخاء', 'Khaa', 'Khaa', 'Hı', 'Khaa', 'Kha')], correctIndex: 0, explanation: lt('حرف الإقلاب هو الباء فقط.', 'Only baa.', 'Seulement ب.', 'Sadece ب.', 'Solo ب.', 'Nur ب.'))],
  ),
  TajweedRule(
    id: 'ikhfa',
    color: const Color(0xFFA855F7),
    category: 'nun',
    title: lt('الإخفاء الحقيقي', 'True concealment', 'Ikhfa réel', 'Hakiki ihfa', 'Ikhfa real', 'Echtes Ikhfa'),
    short: lt('إخفاء النون أو التنوين مع غنة عند خمسة عشر حرفًا.', 'Concealing noon/tanween with ghunnah before fifteen letters.', 'Dissimulation avec ghunna.', 'On beş harfte gunneyle gizleme.', 'Ocultación con nasalización.', 'Verbergen mit Ghunnah.'),
    deep: lt('الإخفاء مرتبة وسطى بين الإظهار والإدغام. لا تُنطق النون كاملة، ولا تُدغم في الحرف التالي، بل يكون الصوت مخفى مع غنة مقدارها حركتان تقريبًا. درجة الإخفاء تختلف بقرب الحرف التالي من مخرج النون أو بعده. التدريب الصحيح يكون بتثبيت الغنة ثم الانتقال إلى الحرف التالي بلا قطع ولا تشديد زائد.', 'Ikhfa is between clear articulation and merging. The noon is not fully pronounced and not fully merged; it is concealed with a two-count nasal sound.', 'Ikhfa est entre clarté et fusion, avec ghunna.', 'İhfa, izhar ile idğam arasında gunneyle gizlemedir.', 'Ikhfa está entre claridad y fusión.', 'Ikhfa liegt zwischen Klarheit und Verschmelzung.'),
    examples: ['مِنْ قَبْلُ', 'أَنْفُسَكُمْ', 'عَلِيمٌ خَبِيرٌ ليس إخفاء إن كان خاء بل إظهار', 'مِنْ ثَمَرَةٍ'],
    commonMistakes: [lt('تحويل الإخفاء إلى إدغام كامل.', 'Turning concealment into full merging.', 'Le transformer en fusion complète.', 'Tam idğama çevirmek.', 'Convertirlo en fusión completa.', 'Zu vollständigem Idgham machen.')],
    questions: [QuizQuestion(id: 'q_ikh_1', question: lt('الإخفاء يكون بين ماذا وماذا؟', 'Ikhfa lies between what?', 'Entre quoi?', 'Neyin arasında?', '¿Entre qué?', 'Zwischen was?'), options: [lt('الإظهار والإدغام', 'Izhar and Idgham', 'Izhar et Idgham', 'İzhar ve idğam', 'Izhar e Idgham', 'Izhar und Idgham'), lt('المد والقصر', 'Madd and shortening', 'Madd et court', 'Med ve kasr', 'Madd y corto', 'Madd und Kürze'), lt('الوقف والوصل', 'Pause and continuation', 'Arrêt et liaison', 'Vakıf ve vasıl', 'Pausa y unión', 'Pause und Verbindung')], correctIndex: 0, explanation: lt('هو مرتبة وسطى بينهما.', 'It is between them.', 'Il est entre les deux.', 'Aradadır.', 'Está entre ambos.', 'Dazwischen.'))],
  ),
  TajweedRule(
    id: 'meem_ikhfa',
    color: const Color(0xFF14B8A6),
    category: 'meem',
    title: lt('الإخفاء الشفوي', 'Labial concealment', 'Ikhfa labial', 'Şefevî ihfa', 'Ikhfa labial', 'Lippen-Ikhfa'),
    short: lt('إخفاء الميم الساكنة عند الباء مع غنة.', 'Concealing silent meem before baa with ghunnah.', 'Mîm caché devant ب.', 'Sakin mim ب önünde gizlenir.', 'Mim oculta ante ب.', 'Mīm vor ب verborgen.'),
    deep: lt('الإخفاء الشفوي خاص بالميم الساكنة إذا جاء بعدها الباء. يخرج الصوت من الشفتين بغنة لطيفة مع عدم الإطباق الشديد. الفرق بينه وبين الإقلاب أن أصل الحرف هنا ميم لا نون، ولذلك يبقى العمل في منطقة الشفتين.', 'Labial ikhfa occurs when silent meem is followed by baa. Keep a soft nasal sound and avoid tight lip closure.', 'Mîm sākin devant ب avec ghunna douce.', 'Sakin mim ب önünde yumuşak gunneyle gizlenir.', 'Mim sakina ante ب con nasalización suave.', 'Mīm sākin vor ب mit sanfter Ghunnah.'),
    examples: ['تَرْمِيهِمْ بِحِجَارَةٍ', 'وَهُمْ بِالْآخِرَةِ'],
    commonMistakes: [lt('إظهار الميم بقوة أو إغلاق الشفتين بشدة.', 'Pronouncing meem too strongly.', 'Prononcer trop fort.', 'Mimi fazla açık okumak.', 'Pronunciar muy fuerte.', 'Zu stark aussprechen.')],
    questions: [QuizQuestion(id: 'q_mikh_1', question: lt('الإخفاء الشفوي مع أي حرف بعد الميم؟', 'Which following letter?', 'Quelle lettre?', 'Hangi harf?', '¿Qué letra?', 'Welcher Buchstabe?'), options: [lt('الباء', 'Baa', 'Baa', 'Be', 'Baa', 'Bā'), lt('الميم', 'Meem', 'Mîm', 'Mim', 'Mim', 'Mīm'), lt('الألف', 'Alif', 'Alif', 'Elif', 'Alif', 'Alif')], correctIndex: 0, explanation: lt('يكون عند الباء.', 'Before baa.', 'Devant ب.', 'ب önünde.', 'Ante ب.', 'Vor ب.'))],
  ),
  TajweedRule(
    id: 'meem_idgham',
    color: const Color(0xFF06B6D4),
    category: 'meem',
    title: lt('إدغام المثلين الصغير', 'Meem merging', 'Fusion des deux mîm', 'Mim idğamı', 'Fusión de dos mim', 'Mīm-Verschmelzung'),
    short: lt('إدغام الميم الساكنة في ميم بعدها مع غنة.', 'Merging silent meem into a following meem with ghunnah.', 'Fusion de mîm avec mîm.', 'Sakin mim sonraki mime katılır.', 'Mim sakina se fusiona con mim.', 'Mīm verschmilzt mit Mīm.'),
    deep: lt('إذا جاءت ميم ساكنة وبعدها ميم متحركة فإنهما تصيران ميمًا واحدة مشددة مع غنة حركتين. يراعى عدم فصل الكلمتين وعدم اختصار الغنة.', 'Silent meem followed by another meem becomes one doubled meem with two-count ghunnah.', 'Deux mîm deviennent un mîm renforcé.', 'İki mim şeddeli mim gibi okunur.', 'Dos mim se leen como una mim reforzada.', 'Zwei Mīm werden zu einem verdoppelten Mīm.'),
    examples: ['لَهُمْ مَّا', 'كَمْ مِّنْ'],
    commonMistakes: [lt('فصل الميمين كأن لا إدغام.', 'Separating the two meems.', 'Séparer les deux mîm.', 'İki mimi ayırmak.', 'Separar las dos mim.', 'Die Mīm trennen.')],
    questions: [QuizQuestion(id: 'q_midg_1', question: lt('مقدار الغنة في إدغام الميم؟', 'Ghunnah length?', 'Durée?', 'Süre?', 'Duración?', 'Dauer?'), options: [lt('حركتان', 'Two counts', 'Deux temps', 'İki hareke', 'Dos tiempos', 'Zwei'), lt('أربع', 'Four', 'Quatre', 'Dört', 'Cuatro', 'Vier'), lt('لا يوجد', 'None', 'Aucune', 'Yok', 'Ninguna', 'Keine')], correctIndex: 0, explanation: lt('غنة بمقدار حركتين.', 'Two counts.', 'Deux.', 'İki.', 'Dos.', 'Zwei.'))],
  ),
  TajweedRule(
    id: 'madd',
    color: const Color(0xFFEAB308),
    category: 'madd',
    title: lt('المد الطبيعي', 'Natural Madd', 'Madd naturel', 'Tabii med', 'Madd natural', 'Natürlicher Madd'),
    short: lt('مد حرف المد مقدار حركتين إذا لم يأت بعده سبب من همز أو سكون.', 'Lengthening a madd letter for two counts when no hamzah or sukun cause follows.', 'Allongement naturel de deux temps.', 'Sebepsiz iki hareke uzatma.', 'Alargamiento natural de dos tiempos.', 'Natürliche Dehnung zwei Zählzeiten.'),
    deep: lt('المد الطبيعي أصل باب المدود، وحروفه الألف الساكنة المفتوح ما قبلها، والواو الساكنة المضموم ما قبلها، والياء الساكنة المكسور ما قبلها. يمد مقدار حركتين فقط، ولا يزاد إلا إذا وجد سبب معتبر مثل الهمز أو السكون. ضبطه مهم جدًا لأنه يعلّم الأذن ميزان الحركة.', 'Natural madd is the base of elongation rules. It occurs with alif, waw, or ya as madd letters and is held for two counts unless hamzah or sukun requires more.', 'Madd naturel: deux temps avec les lettres de prolongation.', 'Tabii med, med harflerinde iki harekedir.', 'Madd natural dura dos tiempos.', 'Natürlicher Madd dauert zwei Zählzeiten.'),
    examples: ['قَالَ', 'يَقُولُ', 'قِيلَ', 'الرَّحْمَـٰنِ'],
    commonMistakes: [lt('زيادة المد الطبيعي أكثر من حركتين بلا سبب.', 'Extending it more than two counts without cause.', 'Allonger sans raison.', 'Sebepsiz fazla uzatmak.', 'Alargar sin causa.', 'Ohne Grund verlängern.')],
    questions: [QuizQuestion(id: 'q_madd_1', question: lt('كم مقدار المد الطبيعي؟', 'How long is natural madd?', 'Durée?', 'Süre?', 'Duración?', 'Dauer?'), options: [lt('حركتان', 'Two counts', 'Deux temps', 'İki hareke', 'Dos tiempos', 'Zwei'), lt('ست حركات دائمًا', 'Always six', 'Toujours six', 'Her zaman altı', 'Siempre seis', 'Immer sechs'), lt('لا يمد', 'Not lengthened', 'Aucun', 'Uzatılmaz', 'No se alarga', 'Keine')], correctIndex: 0, explanation: lt('الأصل فيه حركتان.', 'It is two counts.', 'Deux temps.', 'İki.', 'Dos.', 'Zwei.'))],
  ),
  TajweedRule(
    id: 'qalqalah',
    color: const Color(0xFFEF4444),
    category: 'sifat',
    title: lt('القلقلة', 'Qalqalah echo', 'Qalqalah', 'Kalkale', 'Qalqalah', 'Qalqalah'),
    short: lt('اضطراب صوتي لطيف في حروف قطب جد عند السكون.', 'A light echo on ق ط ب ج د when sakin.', 'Petit rebond sonore.', 'Sakin ق ط ب ج د harflerinde titreşim.', 'Eco suave en ق ط ب ج د.', 'Leichter Klangimpuls bei ق ط ب ج د.'),
    deep: lt('القلقلة صفة لازمة لحروف: ق ط ب ج د إذا كانت ساكنة، وتظهر أكثر عند الوقف. ليست زيادة حرف ولا همزة، بل اهتزاز لطيف يخرج الحرف بوضوح دون مبالغة. يبدأ الطالب بتدريب القلقلة الصغرى في وسط الكلام، ثم الكبرى عند الوقف، مع مراعاة عدم تحويلها إلى حركة ظاهرة.', 'Qalqalah is a light echo for ق ط ب ج د when they are sakin, especially at pause. It should not become an added vowel or hamzah.', 'Qalqalah est un léger rebond des lettres ق ط ب ج د au sukûn.', 'Kalkale sakin ق ط ب ج د harflerinde hafif sestir.', 'Qalqalah es un rebote suave.', 'Qalqalah ist ein leichter Klangimpuls.'),
    examples: ['أَحَدْ', 'يَجْعَلُونَ', 'قَدْ أَفْلَحَ', 'وَالطَّارِقِ'],
    commonMistakes: [lt('المبالغة حتى تصير القلقلة حرفًا زائدًا.', 'Overdoing until it becomes an extra sound.', 'Exagérer.', 'Aşırı yapmak.', 'Exagerar.', 'Übertreiben.')],
    questions: [QuizQuestion(id: 'q_qal_1', question: lt('ما حروف القلقلة؟', 'Which letters?', 'Quelles lettres?', 'Hangi harfler?', '¿Qué letras?', 'Welche?'), options: [lt('ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د', 'ق ط ب ج د'), lt('ء ه ع ح', 'ء ه ع ح', 'ء ه ع ح', 'ء ه ع ح', 'ء ه ع ح', 'ء ه ع ح'), lt('ي و ن م', 'ي و ن م', 'ي و ن م', 'ي و ن م', 'ي و ن م', 'ي و ن م')], correctIndex: 0, explanation: lt('مجموعة في عبارة قطب جد.', 'They form قطب جد.', 'Formule قطب جد.', 'قطب جد.', 'قطب جد.', 'قطب جد.'))],
  ),
  TajweedRule(
    id: 'ghunnah',
    color: const Color(0xFFEC4899),
    category: 'sifat',
    title: lt('الغنة', 'Ghunnah', 'Ghunnah', 'Gunne', 'Ghunnah', 'Ghunnah'),
    short: lt('صوت يخرج من الخيشوم ملازم للنون والميم، ويظهر بقوة مع التشديد.', 'A nasal sound from the nasal passage associated with noon and meem.', 'Son nasal lié à nûn et mîm.', 'Nun ve mimde burun sesi.', 'Sonido nasal de nûn y mim.', 'Nasaler Klang bei Nūn und Mīm.'),
    deep: lt('الغنة صفة للنون والميم، وأكمل ما تكون في النون والميم المشددتين. مقدارها غالبًا حركتان في مواضع كثيرة. المتعلم يضبطها بالسماع والتلقي؛ فلا تكون قصيرة جدًا تضيع، ولا طويلة جدًا تخل بالإيقاع. وجود الشدة على ن أو م علامة قوية على ضرورة إظهار الغنة.', 'Ghunnah is a nasal sound linked to noon and meem, strongest when doubled. It is controlled by listening and recitation practice.', 'La ghunna est un son nasal du nûn et mîm.', 'Gunne nun ve mimde burun sesidir.', 'Ghunnah es sonido nasal.', 'Ghunnah ist nasaler Klang.'),
    examples: ['إِنَّ', 'ثُمَّ', 'جَنَّاتٍ', 'أَمَّا'],
    commonMistakes: [lt('إهمال الغنة في النون أو الميم المشددتين.', 'Neglecting ghunnah on doubled noon/meem.', 'Négliger la ghunna.', 'Gunneyi ihmal etmek.', 'Omitir ghunnah.', 'Ghunnah auslassen.')],
    questions: [QuizQuestion(id: 'q_gh_1', question: lt('أقوى مواضع الغنة تكون في؟', 'Strongest ghunnah occurs in?', 'Où est-elle forte?', 'En güçlü nerede?', '¿Dónde es más fuerte?', 'Wo am stärksten?'), options: [lt('النون والميم المشددتين', 'Doubled noon and meem', 'Nûn et mîm renforcés', 'Şeddeli nun ve mim', 'Nûn y mim con shadda', 'Verdoppeltes Nūn/Mīm'), lt('الألف واللام', 'Alif and lam', 'Alif et lam', 'Elif ve lam', 'Alif y lam', 'Alif und Lam'), lt('حروف المد فقط', 'Only madd letters', 'Lettres de madd', 'Sadece med', 'Solo madd', 'Nur Madd')], correctIndex: 0, explanation: lt('الشدة على ن أو م تدل على غنة أكمل.', 'Doubled noon/meem have strong ghunnah.', 'Fort avec shadda.', 'Şedde güçlüdür.', 'Con shadda fuerte.', 'Mit Schadda stark.'))],
  ),
  TajweedRule(
    id: 'lam_jalalah',
    color: const Color(0xFF6366F1),
    category: 'lam',
    title: lt('لام لفظ الجلالة', 'Lam of Allah', 'Lâm du Nom divin', 'Lafzatullah lamı', 'Lam de Allah', 'Lam im Gottesnamen'),
    short: lt('تفخم لام لفظ الجلالة بعد فتح أو ضم، وترقق بعد كسر.', 'Lam in Allah is heavy after fatḥah/dammah and light after kasrah.', 'Lâm épais ou léger selon la voyelle.', 'Önceki harekeye göre kalın/ince.', 'Lam gruesa o ligera.', 'Je nach Vokal dick/dünn.'),
    deep: lt('لام لفظ الجلالة لها حالتان: التفخيم إذا سبقها فتح أو ضم، والترقيق إذا سبقها كسر. المقصود ضبط امتلاء الصوت عند التفخيم دون مبالغة، وتخفيفه عند الترقيق دون إضعاف. هذا الحكم يتكرر كثيرًا، لذلك يظهر أثره في جمال التلاوة واستقامة النطق.', 'The lam in the Divine Name is heavy after fatḥah or dammah and light after kasrah. This frequent rule shapes the sound of recitation.', 'Le lâm du Nom divin est emphatique ou léger selon la voyelle précédente.', 'Allah lafzındaki lam önceki harekeye göre kalın veya incedir.', 'La lam del Nombre divino depende de la vocal previa.', 'Lam im Gottesnamen hängt vom vorherigen Vokal ab.'),
    examples: ['قَالَ اللَّهُ', 'عَبْدُ اللَّهِ', 'بِاللَّهِ'],
    commonMistakes: [lt('تفخيم اللام بعد الكسر.', 'Making it heavy after kasrah.', 'L’épaissir après kasra.', 'Kesreden sonra kalın okumak.', 'Engrosarla tras kasra.', 'Nach Kasra dick lesen.')],
    questions: [QuizQuestion(id: 'q_lam_1', question: lt('ترقق لام لفظ الجلالة بعد ماذا؟', 'When is it light?', 'Quand légère?', 'Ne zaman ince?', '¿Cuándo ligera?', 'Wann dünn?'), options: [lt('الكسر', 'Kasrah', 'Kasra', 'Kesre', 'Kasra', 'Kasra'), lt('الفتح', 'Fatḥah', 'Fatha', 'Fetha', 'Fatha', 'Fatha'), lt('الضم', 'Dammah', 'Damma', 'Ötre', 'Damma', 'Damma')], correctIndex: 0, explanation: lt('ترقق بعد الكسر.', 'Light after kasrah.', 'Après kasra.', 'Kesreden sonra.', 'Tras kasra.', 'Nach Kasra.'))],
  ),
  TajweedRule(
    id: 'raa',
    color: const Color(0xFF64748B),
    category: 'raa',
    title: lt('أحكام الراء', 'Rules of Raa', 'Règles du râ', 'Ra hükümleri', 'Reglas de ra', 'Regeln des Rā'),
    short: lt('تفخم الراء أو ترقق حسب حركتها وما قبلها وحال الوقف.', 'Raa is heavy or light depending on vowels and pause conditions.', 'Râ emphatique ou léger.', 'Ra kalın veya ince.', 'Ra gruesa o ligera.', 'Rā dick oder dünn.'),
    deep: lt('أحكام الراء من أبواب الضبط الدقيقة؛ فالأصل أنها تفخم إذا كانت مفتوحة أو مضمومة، وترقق إذا كانت مكسورة، ولها تفصيلات عند السكون والوقف. لا يكفي حفظ القاعدة العامة، بل ينبغي تدريب الأذن على الفرق بين الراء المفخمة والمرققة في أمثلة متعددة.', 'Raa requires careful practice. It is generally heavy with fatḥah/dammah and light with kasrah, with details for sukun and stopping.', 'Le râ nécessite pratique et écoute.', 'Ra hükümleri dikkat ister.', 'La ra requiere práctica.', 'Rā erfordert Übung.'),
    examples: ['رَبِّ', 'غَيْرِ', 'قُرْآنٌ', 'خَبِيرٌ'],
    commonMistakes: [lt('تفخيم كل راء أو ترقيق كل راء بلا نظر للحركة.', 'Making every raa heavy or every raa light.', 'Tout épaissir ou tout alléger.', 'Her ra’yı aynı okumak.', 'Leer todas igual.', 'Alle gleich lesen.')],
    questions: [QuizQuestion(id: 'q_raa_1', question: lt('غالبًا ترقق الراء إذا كانت؟', 'Raa is usually light when?', 'Quand légère?', 'Ne zaman ince?', '¿Cuándo ligera?', 'Wann dünn?'), options: [lt('مكسورة', 'With kasrah', 'Avec kasra', 'Kesreli', 'Con kasra', 'Mit Kasra'), lt('مفتوحة', 'With fatḥah', 'Avec fatha', 'Fethalı', 'Con fatha', 'Mit Fatha'), lt('مضمومة', 'With dammah', 'Avec damma', 'Ötreli', 'Con damma', 'Mit Damma')], correctIndex: 0, explanation: lt('الكسر من أسباب الترقيق.', 'Kasrah causes lightness.', 'Kasra allège.', 'Kesre inceltir.', 'Kasra aligera.', 'Kasra macht dünn.'))],
  ),
];

TajweedRule ruleById(String id) => tajweedRules.firstWhere((r) => r.id == id, orElse: () => tajweedRules.first);

final List<Lesson> lessons = [
  for (int i = 0; i < 12; i++)
    Lesson(
      id: 'lesson_${i + 1}',
      order: i + 1,
      title: lt(
        ['مدخل علم التجويد','النون الساكنة والتنوين','الإظهار والإدغام','الإقلاب والإخفاء','الميم الساكنة','المدود الأساسية','المدود المتقدمة','القلقلة والصفات','التفخيم والترقيق','أحكام الراء واللام','الوقف والابتداء','مراجعة شاملة'][i],
        ['Introduction to Tajweed','Noon Sakin and Tanween','Izhar and Idgham','Iqlab and Ikhfa','Silent Meem','Basic Madd','Advanced Madd','Qalqalah and attributes','Heaviness and lightness','Raa and Lam','Pausing and starting','Full review'][i],
        ['Introduction','Nûn et tanwîn','Izhar et Idgham','Iqlab et Ikhfa','Mîm sākin','Madd de base','Madd avancé','Qalqalah','Emphase','Râ et Lâm','Arrêt','Révision'][i],
        ['Giriş','Sakin nun ve tenvin','İzhar ve idğam','İklab ve ihfa','Sakin mim','Temel med','İleri med','Kalkale','Kalınlık-incelik','Ra ve Lam','Vakıf','Genel tekrar'][i],
        ['Introducción','Nûn y tanwîn','Izhar e Idgham','Iqlab e Ikhfa','Mim sakina','Madd básico','Madd avanzado','Qalqalah','Énfasis','Ra y Lam','Pausa','Repaso'][i],
        ['Einführung','Nūn und Tanwīn','Izhar und Idgham','Iqlab und Ikhfa','Mīm sākin','Basis-Madd','Fortgeschrittener Madd','Qalqalah','Dicke und Dünne','Rā und Lam','Pausen','Wiederholung'][i],
      ),
      summary: lt('درس عملي منظم مع شرح وأمثلة وتدريب وأسئلة قصيرة.', 'A structured practical lesson with explanation, examples, drills, and questions.', 'Leçon structurée avec exercices.', 'Açıklamalı ve alıştırmalı ders.', 'Lección con ejemplos y preguntas.', 'Strukturierte Lektion mit Übungen.'),
      sections: [
        LessonSection(heading: lt('الهدف', 'Objective', 'Objectif', 'Amaç', 'Objetivo', 'Ziel'), body: lt('فهم الحكم نظريًا ثم تطبيقه على أمثلة من القرآن مع الانتباه إلى المخرج والصفة والزمن الصوتي.', 'Understand the rule and apply it to Quranic examples while controlling articulation, attributes, and timing.', 'Comprendre puis appliquer.', 'Kuralı anlayıp uygulamak.', 'Comprender y aplicar.', 'Verstehen und anwenden.')),
        LessonSection(heading: lt('خطوات التطبيق', 'Practice steps', 'Étapes', 'Adımlar', 'Pasos', 'Schritte'), body: lt('١) حدّد الحرف أو العلامة. ٢) انظر إلى الحرف التالي. ٣) اختر الحكم. ٤) اقرأ ببطء. ٥) أعد القراءة بسرعة طبيعية.', '1) Locate the sign. 2) Check the next letter. 3) Decide the rule. 4) Read slowly. 5) Repeat naturally.', 'Identifier, vérifier, appliquer.', 'Bul, kontrol et, uygula.', 'Identifica, verifica y aplica.', 'Erkennen, prüfen, anwenden.')),
        LessonSection(heading: lt('تدريب تثبيت', 'Mastery drill', 'Exercice', 'Pekiştirme', 'Práctica', 'Übung'), body: lt('سجّل تلاوتك لنصف صفحة، ثم استمع وحدّد ثلاثة مواضع تحتاج إلى تحسين. كرر التدريب حتى يستقر الحكم في السمع واللسان.', 'Record half a page, listen back, and identify three points to improve. Repeat until the rule becomes stable.', 'Enregistrez et corrigez.', 'Kaydedip düzeltin.', 'Graba y corrige.', 'Aufnehmen und korrigieren.')),
      ],
      examples: ['مِنْ آمَنَ', 'مَنْ يَقُولُ', 'مِنْ بَعْدِ', 'تَرْمِيهِمْ بِحِجَارَةٍ', 'قَالَ', 'أَحَدْ'],
      questions: [
        QuizQuestion(id: 'lesson_q_${i + 1}', question: lt('ما أول خطوة لمعرفة الحكم؟', 'What is the first step?', 'Première étape?', 'İlk adım?', 'Primer paso?', 'Erster Schritt?'), options: [lt('تحديد الحرف أو العلامة', 'Locate the letter/sign', 'Identifier le signe', 'Harfi/işareti bulmak', 'Identificar signo', 'Zeichen finden'), lt('الإسراع في القراءة', 'Read fast', 'Lire vite', 'Hızlı okumak', 'Leer rápido', 'Schnell lesen'), lt('ترك المثال', 'Skip example', 'Sauter', 'Atlamak', 'Saltar', 'Überspringen')], correctIndex: 0, explanation: lt('لا يمكن الحكم دون تحديد الموضع.', 'You need to locate the place first.', 'Il faut localiser.', 'Önce yer bulunur.', 'Primero localizar.', 'Zuerst lokalisieren.')),
      ],
      relatedRuleIds: tajweedRules.map((r) => r.id).skip(i % tajweedRules.length).take(3).toList(),
    ),
];

final List<LearningDay> learningPlan = List.generate(30, (index) {
  final day = index + 1;
  final lesson = lessons[index % lessons.length];
  return LearningDay(
    day: day,
    title: lt('اليوم $day: ${lesson.title.tr('ar')}', 'Day $day: ${lesson.title.tr('en')}', 'Jour $day', 'Gün $day', 'Día $day', 'Tag $day'),
    objective: lt('إنجاز درس قصير وتطبيقه على خمسة مواضع من المصحف.', 'Complete one short lesson and apply it to five Quranic places.', 'Terminer une leçon.', 'Bir dersi tamamla.', 'Completar una lección.', 'Eine Lektion abschließen.'),
    body: lt('اقرأ شرح الدرس، ثم افتح صفحة المصحف وابحث عن أمثلة مشابهة. الهدف أن تنتقل من معرفة اسم الحكم إلى تمييزه أثناء التلاوة.', 'Read the lesson, then open the Mushaf and find similar examples. Move from naming the rule to recognizing it during recitation.', 'Lisez puis appliquez.', 'Oku ve uygula.', 'Lee y aplica.', 'Lesen und anwenden.'),
    examples: lesson.examples,
    tasks: [
      lt('اقرأ الشرح مرة بتركيز.', 'Read the explanation carefully.', 'Lire attentivement.', 'Dikkatle oku.', 'Leer con atención.', 'Aufmerksam lesen.'),
      lt('استخرج خمسة مواضع من سورة قصيرة.', 'Find five places in a short surah.', 'Trouver cinq exemples.', 'Beş örnek bul.', 'Encontrar cinco ejemplos.', 'Fünf Beispiele finden.'),
      lt('أجب عن الأسئلة ثم علّم اليوم كمكتمل.', 'Answer the questions and mark complete.', 'Répondre et terminer.', 'Cevapla ve tamamla.', 'Responder y completar.', 'Antworten und abschließen.'),
    ],
    questions: lesson.questions,
  );
});

final List<Exam> exams = [
  Exam(id: 'placement', level: 'Beginner', minutes: 8, title: lt('اختبار تحديد المستوى', 'Placement test', 'Test de niveau', 'Seviye testi', 'Prueba de nivel', 'Einstufungstest'), description: lt('اختبار قصير يقيس معرفتك الأساسية بالأحكام.', 'A short exam for core knowledge.', 'Test court.', 'Kısa sınav.', 'Prueba corta.', 'Kurzer Test.'), questions: tajweedRules.take(6).expand((r) => r.questions).toList()),
  Exam(id: 'nun', level: 'Intermediate', minutes: 12, title: lt('امتحان النون والتنوين', 'Noon and Tanween exam', 'Nûn et tanwîn', 'Nun ve tenvin', 'Nûn y tanwîn', 'Nūn und Tanwīn'), description: lt('يركز على الإظهار والإدغام والإقلاب والإخفاء.', 'Focuses on izhar, idgham, iqlab, and ikhfa.', 'Nûn et règles.', 'Nun hükümleri.', 'Reglas de nûn.', 'Nūn-Regeln.'), questions: tajweedRules.where((r) => r.category == 'nun').expand((r) => r.questions).toList()),
  Exam(id: 'meem_madd', level: 'Intermediate', minutes: 12, title: lt('امتحان الميم والمدود', 'Meem and Madd exam', 'Mîm et Madd', 'Mim ve med', 'Mim y Madd', 'Mīm und Madd'), description: lt('أسئلة الميم الساكنة والمد الطبيعي.', 'Silent meem and natural madd.', 'Mîm et madd.', 'Mim ve med.', 'Mim y Madd.', 'Mīm und Madd.'), questions: tajweedRules.where((r) => ['meem','madd'].contains(r.category)).expand((r) => r.questions).toList()),
  Exam(id: 'advanced', level: 'Advanced', minutes: 15, title: lt('امتحان الأحكام المتقدمة', 'Advanced rules exam', 'Avancé', 'İleri', 'Avanzado', 'Fortgeschritten'), description: lt('يركز على الصفات واللام والراء.', 'Attributes, lam, and raa.', 'Attributs.', 'Sıfatlar.', 'Atributos.', 'Eigenschaften.'), questions: tajweedRules.where((r) => ['sifat','lam','raa'].contains(r.category)).expand((r) => r.questions).toList()),
  Exam(id: 'final', level: 'Final', minutes: 25, title: lt('الامتحان النهائي الشامل', 'Final comprehensive exam', 'Final complet', 'Final sınav', 'Examen final', 'Abschlussprüfung'), description: lt('امتحان شامل لكل أبواب التطبيق مع شهادة عند 80٪ فأكثر.', 'A full exam with certificate at 80% or more.', 'Examen complet.', 'Kapsamlı sınav.', 'Examen completo.', 'Umfassende Prüfung.'), questions: tajweedRules.expand((r) => r.questions).toList()),
];
