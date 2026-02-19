import Foundation

// MARK: - Passage Library
// All content is original educational writing based on public domain knowledge.
// Sources cited are public domain works, historical facts, or scientific principles.

struct PassageLibrary {
    
    static let all: [Passage] = science + history + philosophy + economics + psychology + literature + mathematics + technology
    
    // ═══════════════════════════════════════════════════════════
    // SCIENCE (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let science: [Passage] = [
        Passage(
            id: 1, category: .science,
            title: "The Dopamine Trap",
            subtitle: "Why your phone feels impossible to put down",
            content: """
            Every time you pick up your phone and scroll through social media, a tiny burst of dopamine floods your brain's reward center. This isn't an accident — it's by design.

            Tech companies employ thousands of behavioral psychologists whose sole job is to make their products as addictive as possible. Variable reward schedules, the same mechanism that makes slot machines compelling, are baked into every pull-to-refresh gesture and notification ping.

            The prefrontal cortex, responsible for self-control and long-term planning, doesn't fully develop until age 25. This means teenagers are neurologically disadvantaged when facing apps engineered to exploit the brain's reward circuitry.

            Studies from the National Institute of Health show that heavy smartphone users exhibit reduced gray matter volume in areas associated with cognitive control. The brain literally reshapes itself around the habit.

            But here's the hopeful part: neuroplasticity works both ways. Just as the brain adapts to excessive screen time, it can recover. Structured breaks, mindful usage, and replacing scroll time with focused activities can rebuild the neural pathways that support deep thinking and sustained attention.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 101, text: "What mechanism do tech companies use that's similar to slot machines?", options: ["Fixed interval rewards", "Variable reward schedules", "Predictable notifications", "Constant dopamine release"], correctIndex: 1),
                Question(id: 102, text: "At what age does the prefrontal cortex fully develop?", options: ["18", "21", "25", "30"], correctIndex: 2),
                Question(id: 103, text: "What did NIH studies find about heavy smartphone users?", options: ["Increased gray matter", "No brain changes", "Reduced gray matter in cognitive control areas", "Enhanced memory function"], correctIndex: 2),
            ],
            source: "Public domain neuroscience research"
        ),
        
        Passage(
            id: 2, category: .science,
            title: "Darwin's Dangerous Idea",
            subtitle: "How natural selection reshaped everything we know",
            content: """
            In 1859, Charles Darwin published "On the Origin of Species," a book that fundamentally changed humanity's understanding of life. His central insight was elegant in its simplicity: organisms that are better adapted to their environment tend to survive and reproduce more successfully.

            Darwin spent over twenty years gathering evidence before publishing. During his famous voyage on HMS Beagle, he observed that finches on different Galápagos islands had developed distinct beak shapes suited to their specific food sources. This was a living demonstration of adaptation.

            The mechanism Darwin proposed — natural selection — requires three conditions: variation within a population, heritability of traits, and differential survival. When all three are present, evolution is not just possible but inevitable.

            What Darwin couldn't explain was the source of variation itself. He had no knowledge of genetics or DNA. It wasn't until the twentieth century that Mendel's work on inheritance was rediscovered and combined with Darwin's theory, creating the "modern synthesis" that forms the backbone of contemporary biology.

            Today, evolutionary theory is supported by evidence from genetics, paleontology, comparative anatomy, and molecular biology. DNA sequencing has revealed that humans share roughly 98.7% of their genome with chimpanzees, confirming the common ancestry Darwin proposed over 160 years ago.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 104, text: "When was 'On the Origin of Species' published?", options: ["1831", "1859", "1871", "1882"], correctIndex: 1),
                Question(id: 105, text: "What three conditions does natural selection require?", options: ["Mutation, migration, drift", "Variation, heritability, differential survival", "Competition, predation, disease", "Isolation, time, resources"], correctIndex: 1),
                Question(id: 106, text: "What percentage of DNA do humans share with chimpanzees?", options: ["85%", "92%", "98.7%", "99.9%"], correctIndex: 2),
            ],
            source: "On the Origin of Species — Charles Darwin (1859, public domain)"
        ),
        
        Passage(
            id: 3, category: .science,
            title: "The Speed of Light",
            subtitle: "Einstein's insight that changed physics forever",
            content: """
            In 1905, a 26-year-old patent clerk named Albert Einstein published four papers that revolutionized physics. The most famous introduced special relativity, built on a deceptively simple premise: the speed of light is constant for all observers, regardless of their motion.

            This single postulate leads to astonishing conclusions. Time passes more slowly for objects moving at high speeds — a phenomenon called time dilation. A clock on a fast-moving spaceship ticks slower than an identical clock on Earth. This isn't an illusion; the effect has been measured using atomic clocks on airplanes.

            Mass and energy, previously thought to be completely separate quantities, are actually interconvertible. Einstein's equation E=mc² shows that a small amount of mass contains an enormous amount of energy. The "c²" term — the speed of light squared — is approximately 9 × 10¹⁶, which is why nuclear reactions release such extraordinary power from tiny amounts of material.

            Special relativity also reveals that nothing with mass can reach the speed of light. As an object accelerates, its relativistic mass increases, requiring ever more energy to go faster. At the speed of light, the energy required would be infinite.

            GPS satellites must account for relativistic effects to maintain accuracy. Without corrections for both special and general relativity, GPS positions would drift by roughly 10 kilometers per day.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 107, text: "What year did Einstein publish his special relativity paper?", options: ["1895", "1905", "1915", "1925"], correctIndex: 1),
                Question(id: 108, text: "What happens to time for objects moving at high speeds?", options: ["It speeds up", "It stops completely", "It slows down", "It reverses"], correctIndex: 2),
                Question(id: 109, text: "How much would GPS drift per day without relativistic corrections?", options: ["1 meter", "100 meters", "1 kilometer", "10 kilometers"], correctIndex: 3),
            ],
            source: "Public domain physics principles"
        ),
        
        Passage(
            id: 4, category: .science,
            title: "The Double Helix",
            subtitle: "Cracking the code of life itself",
            content: """
            In 1953, James Watson and Francis Crick proposed the structure of DNA — a discovery that launched modern molecular biology. The molecule's elegant double helix shape, with its paired bases running like a twisted ladder, immediately suggested how genetic information could be copied.

            DNA uses just four chemical bases: adenine (A), thymine (T), guanine (G), and cytosine (C). These bases pair in a specific way — A always bonds with T, and G always bonds with C. This complementary pairing means each strand contains the information needed to reconstruct the other.

            The human genome contains approximately 3 billion base pairs, encoding roughly 20,000 to 25,000 genes. If you stretched out all the DNA from a single human cell, it would extend about two meters. Yet it's packed into a nucleus just six micrometers across — a compression ratio that dwarfs any human technology.

            Rosalind Franklin's X-ray crystallography images were crucial to the discovery. Her Photo 51 revealed the helical structure, providing the key experimental evidence that Watson and Crick used to build their model.

            Today, sequencing a human genome takes hours and costs under a thousand dollars. The first complete human genome, finished in 2003 through the Human Genome Project, required thirteen years and roughly three billion dollars.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 110, text: "How many base pairs are in the human genome?", options: ["3 million", "3 billion", "30 billion", "300 billion"], correctIndex: 1),
                Question(id: 111, text: "Whose X-ray image was crucial to the DNA discovery?", options: ["Marie Curie", "Rosalind Franklin", "Barbara McClintock", "Dorothy Hodgkin"], correctIndex: 1),
                Question(id: 112, text: "How do DNA bases pair?", options: ["A with G, T with C", "A with C, T with G", "A with T, G with C", "Randomly"], correctIndex: 2),
            ],
            source: "Public domain molecular biology"
        ),
        
        Passage(
            id: 5, category: .science,
            title: "The Pale Blue Dot",
            subtitle: "Earth as seen from 6 billion kilometers away",
            content: """
            On February 14, 1990, the Voyager 1 spacecraft turned its camera back toward Earth from a distance of about 6 billion kilometers. The resulting photograph shows Earth as a tiny point of light, less than a single pixel, suspended in a beam of sunlight.

            Carl Sagan, who had lobbied NASA to take the image, wrote movingly about its significance. That pixel contains everyone who ever lived, every civilization ever built, every war ever fought. All of human history occurred on that pale blue speck.

            Voyager 1 was launched in 1977 and is now the most distant human-made object. It has crossed the heliopause — the boundary where the Sun's influence gives way to interstellar space — and continues traveling at about 17 kilometers per second. Even at that speed, it would take over 70,000 years to reach the nearest star.

            The spacecraft carries a golden record containing sounds and images selected to portray the diversity of life and culture on Earth. The contents include greetings in 55 languages, music from various cultures, natural sounds, and 115 images. Instructions for playing the record are encoded in the cover using mathematical and scientific symbols.

            Voyager 1's power source — three radioisotope thermoelectric generators — will likely be exhausted by around 2025, after which it will continue drifting silently through space, carrying its golden record as humanity's message in a bottle.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 113, text: "When was the Pale Blue Dot photograph taken?", options: ["1977", "1985", "1990", "2000"], correctIndex: 2),
                Question(id: 114, text: "How many languages are on the Voyager golden record?", options: ["12", "27", "55", "100"], correctIndex: 2),
                Question(id: 115, text: "How long would it take Voyager to reach the nearest star?", options: ["1,000 years", "10,000 years", "70,000 years", "1 million years"], correctIndex: 2),
            ],
            source: "NASA Voyager mission — public domain"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // HISTORY (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let history: [Passage] = [
        Passage(
            id: 6, category: .history,
            title: "The Library of Alexandria",
            subtitle: "When humanity almost lost everything",
            content: """
            The Great Library of Alexandria was the intellectual heart of the ancient world. Founded in the 3rd century BCE by Ptolemy I, it aimed to collect every piece of written knowledge in existence.

            At its peak, the library housed an estimated 400,000 to 700,000 scrolls — the equivalent of roughly 100,000 modern books. Scholars from across the Mediterranean came to study mathematics, astronomy, medicine, and philosophy within its walls.

            Eratosthenes, the library's third head librarian, calculated the Earth's circumference with remarkable accuracy using nothing more than shadows, geometry, and a well-timed walk. Euclid wrote his "Elements" there, laying the foundation for geometry still taught today.

            The library's destruction wasn't a single catastrophic event as popular culture suggests. Rather, it declined over centuries through a combination of reduced funding, political turmoil, and multiple fires. Julius Caesar's siege in 48 BCE damaged part of the collection, and subsequent conflicts gradually diminished its relevance.

            The loss represents one of history's great tragedies — countless works of science, literature, and philosophy were lost forever. We know of these works only through references in texts that survived, tantalizing glimpses of knowledge that once existed but can never be recovered.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 201, text: "Who founded the Great Library of Alexandria?", options: ["Alexander the Great", "Julius Caesar", "Ptolemy I", "Eratosthenes"], correctIndex: 2),
                Question(id: 202, text: "What did Eratosthenes calculate?", options: ["Speed of light", "Earth's circumference", "Distance to the moon", "Age of the universe"], correctIndex: 1),
                Question(id: 203, text: "How was the library destroyed?", options: ["A single great fire", "An earthquake", "Gradual decline over centuries", "A flood"], correctIndex: 2),
            ],
            source: "Ancient historical accounts — public domain"
        ),
        
        Passage(
            id: 7, category: .history,
            title: "The Printing Press Revolution",
            subtitle: "How movable type changed civilization",
            content: """
            Around 1440, Johannes Gutenberg developed a printing press with movable metal type in Mainz, Germany. While printing existed in East Asia centuries earlier, Gutenberg's innovation combined oil-based ink, a wooden press adapted from wine presses, and individually cast metal letters into a system that could mass-produce books.

            Before Gutenberg, a single book could take a scribe months to copy by hand. A Gutenberg press could produce 3,600 pages per workday. The cost of books plummeted, and literacy began its long climb from a luxury of the elite to a near-universal skill.

            The Gutenberg Bible, completed around 1455, was among the first major books printed with movable type. About 180 copies were produced. Forty-nine survive today, making them among the most valuable books in existence.

            The printing press didn't just spread existing knowledge — it transformed how people thought. Martin Luther's 95 Theses, posted in 1517, might have remained a local academic dispute. Instead, printed copies spread across Europe within weeks, igniting the Protestant Reformation.

            Within fifty years of Gutenberg's innovation, an estimated twenty million volumes had been printed. By 1500, printing presses operated in over 270 cities across Europe. The information revolution had begun, and its effects were every bit as transformative as the internet would be five centuries later.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 204, text: "When did Gutenberg develop his printing press?", options: ["Around 1340", "Around 1440", "Around 1540", "Around 1640"], correctIndex: 1),
                Question(id: 205, text: "How many Gutenberg Bibles survive today?", options: ["12", "49", "180", "500"], correctIndex: 1),
                Question(id: 206, text: "How many pages could Gutenberg's press produce per workday?", options: ["360", "1,000", "3,600", "10,000"], correctIndex: 2),
            ],
            source: "Public domain historical records"
        ),
        
        Passage(
            id: 8, category: .history,
            title: "The Fall of Rome",
            subtitle: "Five centuries of decline in a single empire",
            content: """
            The Western Roman Empire didn't fall in a day, a year, or even a century. Its collapse was a gradual process spanning roughly 300 years, from the Crisis of the Third Century (235-284 CE) to the deposition of the last emperor, Romulus Augustulus, in 476 CE.

            At its peak under Emperor Trajan around 117 CE, Rome controlled approximately five million square kilometers, stretching from Britain to Mesopotamia. Its population exceeded 55 million people, connected by 80,000 kilometers of roads.

            Historians have proposed over 200 different reasons for Rome's fall. Edward Gibbon famously blamed Christianity and moral decay. Modern scholars emphasize economic factors: debasement of currency, unsustainable military spending, and the disruption of trade networks.

            Climate change also played a role. The Roman Climate Optimum — a period of warm, stable weather that supported agricultural productivity — gave way to cooler, more unpredictable conditions starting around 250 CE. This coincided with devastating pandemics, including the Antonine Plague and the Plague of Cyprian.

            Perhaps most importantly, the empire became too large to govern effectively. Communication from Rome to distant provinces took weeks. Local commanders accumulated power, and civil wars became endemic — in the fifty years of the Third Century Crisis, at least 26 men claimed the title of Emperor.
            """,
            readTimeMinutes: 4, difficulty: .medium,
            questions: [
                Question(id: 207, text: "When was the last Western Roman Emperor deposed?", options: ["410 CE", "455 CE", "476 CE", "500 CE"], correctIndex: 2),
                Question(id: 208, text: "How many kilometers of roads did Rome build?", options: ["20,000", "50,000", "80,000", "120,000"], correctIndex: 2),
                Question(id: 209, text: "How many men claimed Emperor during the Third Century Crisis?", options: ["8", "15", "26", "50"], correctIndex: 2),
            ],
            source: "Public domain ancient history"
        ),
        
        Passage(
            id: 9, category: .history,
            title: "The Rosetta Stone",
            subtitle: "The key that unlocked ancient Egypt",
            content: """
            In July 1799, a French soldier discovered a granodiorite slab during construction work near the town of Rashid (Rosetta) in Egypt. The stone bore the same text in three scripts: Ancient Egyptian hieroglyphics, Demotic script, and Ancient Greek. It would take over two decades to fully decipher, but the stone ultimately unlocked 3,000 years of Egyptian history.

            The text itself is mundane — a decree from 196 BCE affirming the royal cult of the young Pharaoh Ptolemy V. But its value was incalculable because scholars could already read Ancient Greek. If the three texts said the same thing, the Greek could serve as a key to the hieroglyphics.

            Jean-François Champollion, a French linguist who had studied Coptic (a descendant of the ancient Egyptian language), made the breakthrough in 1822. He realized that hieroglyphics were not purely symbolic — they represented sounds as well as ideas. This phonetic principle was the crucial insight that predecessors had missed.

            Before the Rosetta Stone's decipherment, hieroglyphics had been unreadable for roughly 1,400 years. The last known hieroglyphic inscription dates to 394 CE at the Temple of Philae. After that, the knowledge of how to read them was lost entirely.

            Today the Rosetta Stone resides in the British Museum in London, where it has been displayed almost continuously since 1802. It remains one of the most visited objects in the museum.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 210, text: "When was the Rosetta Stone discovered?", options: ["1752", "1799", "1822", "1850"], correctIndex: 1),
                Question(id: 211, text: "Who deciphered the hieroglyphics?", options: ["Napoleon Bonaparte", "Thomas Young", "Jean-François Champollion", "Howard Carter"], correctIndex: 2),
                Question(id: 212, text: "How many scripts appear on the Rosetta Stone?", options: ["Two", "Three", "Four", "Five"], correctIndex: 1),
            ],
            source: "Public domain Egyptology"
        ),
        
        Passage(
            id: 10, category: .history,
            title: "The Silk Road",
            subtitle: "4,000 miles of trade that connected civilizations",
            content: """
            The Silk Road was not a single road but a network of trade routes stretching roughly 6,400 kilometers from Chang'an (modern Xi'an) in China to the Mediterranean. Active for over 1,500 years, it facilitated not just commerce but the exchange of ideas, religions, technologies, and diseases between East and West.

            Silk gave the route its name, but merchants carried far more: spices, precious metals, gemstones, glass, textiles, and paper. Chinese innovations like the compass, gunpowder, and papermaking traveled westward. In return, Central Asian horses, Indian cotton, and Roman glassware moved east.

            Buddhism spread from India to China along the Silk Road, fundamentally shaping East Asian culture. Islam later followed similar routes into Central and Southeast Asia. Christianity, Zoroastrianism, and Manichaeism also traveled these paths.

            The journey was extraordinarily dangerous. Merchants faced scorching deserts, mountain passes above 4,500 meters, bandits, and political instability. Most goods changed hands multiple times through intermediaries — very few merchants traveled the entire route.

            The Silk Road's decline began with the fall of the Mongol Empire in the 14th century, which had provided unified security across Central Asia. The rise of maritime trade routes offered faster, cheaper alternatives. By the time European ships regularly rounded Africa and crossed the Pacific, the overland routes had become economically marginal.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 213, text: "How long was the Silk Road network?", options: ["2,000 km", "4,000 km", "6,400 km", "10,000 km"], correctIndex: 2),
                Question(id: 214, text: "Which religion spread from India to China along the Silk Road?", options: ["Islam", "Christianity", "Buddhism", "Zoroastrianism"], correctIndex: 2),
                Question(id: 215, text: "What caused the Silk Road's decline?", options: ["A plague", "Fall of the Mongol Empire and maritime trade", "An earthquake", "Deforestation"], correctIndex: 1),
            ],
            source: "Public domain world history"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // PHILOSOPHY (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let philosophy: [Passage] = [
        Passage(
            id: 11, category: .philosophy,
            title: "Plato's Cave",
            subtitle: "Are you seeing reality or just shadows?",
            content: """
            In Book VII of "The Republic," Plato presents his most famous allegory. Imagine prisoners chained in a cave since birth, facing a blank wall. Behind them, a fire casts shadows of objects carried by unseen people. The prisoners, having never seen anything else, believe the shadows are reality itself.

            One prisoner breaks free and turns to see the fire, the objects, and eventually climbs out of the cave into sunlight. At first, the light is blinding and painful. Gradually, the freed prisoner's eyes adjust, and they see the real world for the first time — trees, mountains, the sun.

            The allegory illustrates Plato's theory of Forms: the physical world we perceive is like the shadows, an imperfect reflection of a higher, more real realm of abstract Forms or Ideas. The Form of a circle, for instance, is perfect and eternal; every circle we draw is merely an approximation.

            When the freed prisoner returns to the cave to liberate the others, they don't believe the account. The shadows are all they've ever known. They may even become hostile toward the one who challenges their understanding of reality.

            Plato intended this as a metaphor for philosophical education. The journey from ignorance to knowledge is difficult and disorienting. But once someone has seen the truth, they have a responsibility to help others, even if those others resist.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 301, text: "Where does Plato's Cave allegory appear?", options: ["The Symposium", "The Republic", "Phaedrus", "Timaeus"], correctIndex: 1),
                Question(id: 302, text: "What do the shadows represent in the allegory?", options: ["Dreams", "Imperfect perceptions of reality", "Memories", "Future events"], correctIndex: 1),
                Question(id: 303, text: "What happens when the freed prisoner returns to the cave?", options: ["Everyone follows", "They celebrate", "The others don't believe", "The cave collapses"], correctIndex: 2),
            ],
            source: "The Republic — Plato (c. 375 BCE, public domain)"
        ),
        
        Passage(
            id: 12, category: .philosophy,
            title: "Stoic Resilience",
            subtitle: "Ancient wisdom for modern anxiety",
            content: """
            Marcus Aurelius ruled the Roman Empire from 161 to 180 CE while simultaneously writing one of history's most enduring works of practical philosophy. His "Meditations" — private journal entries never intended for publication — offer a window into how a Stoic mind confronts difficulty.

            The core Stoic insight is the dichotomy of control: some things are within our power (our judgments, intentions, desires), and some are not (other people's actions, natural events, our reputation). Suffering arises primarily from trying to control what we cannot.

            Aurelius wrote during one of Rome's most difficult periods — the Antonine Plague killed millions, Germanic tribes pressed the northern frontier, and a trusted general attempted a coup. Yet his writings return constantly to the same theme: focus on what you can control and accept what you cannot.

            Epictetus, a former slave who became one of Stoicism's greatest teachers, put it starkly: "It's not what happens to you, but how you react to it that matters." This doesn't mean suppressing emotions — it means examining whether our emotional reactions are proportionate and productive.

            Modern cognitive behavioral therapy draws heavily from Stoic principles. The idea that our thoughts shape our emotional responses — not events themselves — is essentially the Stoic position, formalized with clinical methodology.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 304, text: "When did Marcus Aurelius rule Rome?", options: ["27 BCE–14 CE", "98–117 CE", "161–180 CE", "284–305 CE"], correctIndex: 2),
                Question(id: 305, text: "What is the 'dichotomy of control'?", options: ["Good vs evil", "Things we can vs cannot control", "Mind vs body", "Reason vs emotion"], correctIndex: 1),
                Question(id: 306, text: "What modern therapy draws from Stoic principles?", options: ["Psychoanalysis", "CBT", "EMDR", "Art therapy"], correctIndex: 1),
            ],
            source: "Meditations — Marcus Aurelius (c. 170 CE, public domain)"
        ),
        
        Passage(
            id: 13, category: .philosophy,
            title: "Descartes' Doubt",
            subtitle: "The one thing you cannot question",
            content: """
            In 1641, René Descartes published his "Meditations on First Philosophy," in which he attempted to strip away every belief that could possibly be doubted, searching for something absolutely certain.

            His method was radical. Could his senses be deceiving him? Yes — optical illusions and dreams prove that sensory experience is fallible. Could mathematics be wrong? Descartes imagined an evil demon with unlimited power, deliberately feeding him false mathematical intuitions. Even 2+2=4 might be a deception.

            But then Descartes found his bedrock: the very act of doubting proves that something is doing the doubting. Even if everything he perceives is an illusion, the fact that he's thinking about it cannot be doubted. "Cogito, ergo sum" — I think, therefore I am.

            From this single certainty, Descartes attempted to rebuild all of human knowledge. His success in that project is debatable, but the method itself was revolutionary. Rather than accepting inherited wisdom, he demanded that every belief justify itself from first principles.

            This approach helped birth modern philosophy and influenced the scientific method. The insistence on rigorous doubt, systematic questioning, and building knowledge from secure foundations echoes through every laboratory and research institution today.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 307, text: "When were the 'Meditations' published?", options: ["1541", "1641", "1741", "1841"], correctIndex: 1),
                Question(id: 308, text: "What does 'Cogito, ergo sum' mean?", options: ["Knowledge is power", "I think, therefore I am", "The truth will set you free", "To err is human"], correctIndex: 1),
                Question(id: 309, text: "What did Descartes use as an impossible-to-doubt certainty?", options: ["God's existence", "Mathematical truth", "The act of thinking itself", "Sensory experience"], correctIndex: 2),
            ],
            source: "Meditations on First Philosophy — Descartes (1641, public domain)"
        ),
        
        Passage(
            id: 14, category: .philosophy,
            title: "The Trolley Problem",
            subtitle: "When doing nothing is still a choice",
            content: """
            Philippa Foot introduced the trolley problem in 1967, and it has become philosophy's most famous thought experiment. A runaway trolley is heading toward five people tied to the tracks. You can pull a lever to divert it to a side track where only one person is tied. Should you pull the lever?

            Most people say yes — saving five at the cost of one seems like simple arithmetic. But Judith Jarvis Thomson introduced a variation: you're standing on a bridge above the tracks, and the only way to stop the trolley is to push a large person off the bridge and onto the tracks. The outcome is identical — one dies, five are saved — but far fewer people consider this acceptable.

            The difference reveals a tension between two major ethical frameworks. Utilitarianism, associated with John Stuart Mill, judges actions by their consequences: the greatest good for the greatest number. By this logic, both scenarios should be treated the same.

            Deontological ethics, rooted in Immanuel Kant's work, focuses on the nature of the action itself. Using a person as a means to an end — literally pushing them to their death — violates human dignity, regardless of the outcome.

            The trolley problem isn't just academic. Self-driving cars face analogous decisions. Medical ethics involves similar trade-offs in organ donation and triage. Understanding these competing moral frameworks helps us navigate real decisions where lives are at stake.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 310, text: "Who introduced the trolley problem?", options: ["Immanuel Kant", "John Stuart Mill", "Philippa Foot", "Peter Singer"], correctIndex: 2),
                Question(id: 311, text: "Which framework judges actions by consequences?", options: ["Deontology", "Utilitarianism", "Virtue ethics", "Existentialism"], correctIndex: 1),
                Question(id: 312, text: "Why do fewer people accept the bridge variation?", options: ["More people die", "It involves physical contact and using someone as a means", "It takes longer", "It's illegal"], correctIndex: 1),
            ],
            source: "Public domain philosophy"
        ),
        
        Passage(
            id: 15, category: .philosophy,
            title: "Nietzsche's Eternal Return",
            subtitle: "Would you live your life again, infinitely?",
            content: """
            Friedrich Nietzsche proposed one of philosophy's most challenging thought experiments in "The Gay Science" (1882): imagine that you will have to live your exact life again and again, infinitely. Every joy and every suffering, every triumph and every failure, in exactly the same sequence, forever.

            This isn't presented as a metaphysical claim about reality. Nietzsche uses it as a test of how you feel about your life. If the thought fills you with despair, something needs to change. If you can embrace it — if you can say "yes" to the eternal recurrence of everything you've experienced — then you've achieved what Nietzsche calls amor fati, love of fate.

            The concept challenges us to take ownership of our lives with radical completeness. You cannot wish away the difficult parts without also losing the good parts that grew from them. Every setback, every loss, every mistake is inseparable from who you became.

            Nietzsche saw this as the ultimate affirmation of life. Rather than placing value in an afterlife or some future ideal state, the eternal return asks you to find meaning in existence as it actually is — messy, painful, beautiful, and finite.

            The idea connects to his broader project of "revaluing values" — questioning inherited assumptions about good and evil, suffering and meaning, to create a life that you would genuinely want to repeat forever.
            """,
            readTimeMinutes: 3, difficulty: .hard,
            questions: [
                Question(id: 313, text: "In which book does Nietzsche introduce the eternal return?", options: ["Thus Spoke Zarathustra", "The Gay Science", "Beyond Good and Evil", "Ecce Homo"], correctIndex: 1),
                Question(id: 314, text: "What does 'amor fati' mean?", options: ["Fear of death", "Love of fate", "Will to power", "Beyond good and evil"], correctIndex: 1),
                Question(id: 315, text: "What is the eternal return meant to test?", options: ["Your intelligence", "Your memory", "How you feel about your life", "Your physical endurance"], correctIndex: 2),
            ],
            source: "The Gay Science — Friedrich Nietzsche (1882, public domain)"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // ECONOMICS (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let economics: [Passage] = [
        Passage(
            id: 16, category: .economics,
            title: "The Invisible Hand",
            subtitle: "How self-interest can serve the common good",
            content: """
            In 1776, Adam Smith published "The Wealth of Nations," introducing one of economics' most enduring metaphors: the invisible hand. Smith argued that individuals pursuing their own self-interest often promote society's welfare more effectively than when they consciously try to do so.

            Consider a baker. She doesn't wake up at 4 AM to knead dough out of pure altruism — she does it to earn a living. Yet by pursuing her self-interest, she provides bread that feeds her community. The price mechanism coordinates this activity without any central planner.

            This insight laid the groundwork for modern market economics. When prices rise, producers are incentivized to supply more and consumers buy less. When prices fall, the opposite occurs. This self-correcting mechanism allocates resources with remarkable efficiency.

            However, Smith himself recognized important limitations. Markets fail when externalities exist — costs or benefits that affect parties not involved in a transaction. Pollution is a classic example: a factory's production benefits its owner and customers, but nearby residents bear the health costs.

            Modern economists understand that the invisible hand works best within a framework of well-designed institutions, property rights, and regulations that address market failures. The debate isn't whether markets work, but rather what conditions are needed for them to work well.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 401, text: "When was 'The Wealth of Nations' published?", options: ["1750", "1776", "1800", "1812"], correctIndex: 1),
                Question(id: 402, text: "What is an externality?", options: ["A foreign trade agreement", "Government regulation", "Costs/benefits affecting uninvolved parties", "A type of tax"], correctIndex: 2),
                Question(id: 403, text: "What does the invisible hand need to work well?", options: ["No government at all", "Well-designed institutions and regulations", "Complete deregulation", "Central planning"], correctIndex: 1),
            ],
            source: "The Wealth of Nations — Adam Smith (1776, public domain)"
        ),
        
        Passage(
            id: 17, category: .economics,
            title: "The Tragedy of the Commons",
            subtitle: "Why shared resources get destroyed",
            content: """
            In 1968, ecologist Garrett Hardin published an influential essay describing what he called "the tragedy of the commons." Imagine a shared pasture open to all herders. Each herder benefits fully from adding one more cow but shares the cost of overgrazing with everyone. Individually rational decisions lead to collective disaster.

            The concept applies far beyond pastures. Overfishing depletes ocean stocks because each fishing vessel captures the full benefit of its catch while the depletion cost is distributed across all fishers. Climate change follows the same logic — each factory or vehicle benefits from cheap energy while everyone shares the atmospheric consequences.

            Hardin's original essay suggested only two solutions: privatization or government regulation. But economist Elinor Ostrom, who won the Nobel Prize in 2009, demonstrated that communities often develop effective self-governance systems to manage shared resources without either markets or states.

            Ostrom studied successful commons management around the world — from Swiss alpine meadows to Japanese fisheries to Philippine irrigation systems. She identified design principles that these successful systems shared, including clear group boundaries, locally adapted rules, and accessible conflict resolution mechanisms.

            The tragedy of the commons isn't inevitable. It's a pattern that emerges when governance is absent, and it can be solved through thoughtful institutional design. The challenge is implementing such solutions at the global scale needed for problems like climate change.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 404, text: "Who described the tragedy of the commons?", options: ["Adam Smith", "Garrett Hardin", "Elinor Ostrom", "John Nash"], correctIndex: 1),
                Question(id: 405, text: "What did Elinor Ostrom's research show?", options: ["Only markets can solve commons problems", "Communities can self-govern shared resources", "Government control is always needed", "The commons tragedy is unsolvable"], correctIndex: 1),
                Question(id: 406, text: "Which is NOT an example of a commons tragedy?", options: ["Overfishing", "Climate change", "Overgrazing", "Personal savings"], correctIndex: 3),
            ],
            source: "Public domain economics"
        ),
        
        Passage(
            id: 18, category: .economics,
            title: "Compound Interest",
            subtitle: "The eighth wonder of the world",
            content: """
            Albert Einstein allegedly called compound interest the eighth wonder of the world, adding "he who understands it, earns it; he who doesn't, pays it." Whether Einstein actually said this is debatable, but the mathematics behind it is indisputable.

            Compound interest means earning interest on your interest. If you invest $1,000 at 7% annual return, after one year you have $1,070. After two years, you earn 7% on $1,070 — not just the original $1,000 — giving you $1,144.90. The difference seems small early on, but over decades it becomes enormous.

            The Rule of 72 provides a quick estimate: divide 72 by the interest rate to find how many years it takes to double your money. At 7%, your money doubles roughly every 10.3 years. After 30 years, that $1,000 becomes about $7,612 — without adding a single dollar.

            This principle works in reverse with debt. Credit card interest, typically 20-25% annually, means unpaid balances grow rapidly. A $5,000 balance at 22% interest, with only minimum payments, can take over 30 years to repay and cost more than $12,000 in interest alone.

            Time is the most important variable in compounding. Starting to invest at 22 instead of 32 — just ten years earlier — can result in roughly twice as much wealth at retirement, even if you invest the same amount monthly. The earlier you start, the more time compound interest has to work.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 407, text: "What does the Rule of 72 estimate?", options: ["Annual return rate", "Time to double your money", "Inflation rate", "Tax rate"], correctIndex: 1),
                Question(id: 408, text: "What does $1,000 at 7% become after 30 years?", options: ["$3,000", "$5,000", "About $7,612", "$10,000"], correctIndex: 2),
                Question(id: 409, text: "What is the most important variable in compounding?", options: ["Interest rate", "Principal amount", "Time", "Tax bracket"], correctIndex: 2),
            ],
            source: "Public domain financial mathematics"
        ),
        
        Passage(
            id: 19, category: .economics,
            title: "The Prisoner's Dilemma",
            subtitle: "Why rational people make irrational choices",
            content: """
            Two suspects are arrested and held separately. Each is offered a deal: betray your partner and go free while they serve three years, or stay silent. If both betray, each serves two years. If both stay silent, each serves only one year. The rational choice for each individual is to betray — yet mutual betrayal produces a worse outcome than mutual cooperation.

            This paradox, formalized by mathematicians in 1950 at the RAND Corporation, reveals a fundamental tension between individual and collective rationality. It appears everywhere: arms races, price wars, environmental agreements, and even biological evolution.

            Robert Axelrod's famous 1984 tournament invited game theorists to submit strategies for repeated prisoner's dilemmas. The winner was the simplest strategy submitted: Tit for Tat. It cooperates on the first move, then copies whatever the opponent did last. It's nice (never betrays first), retaliatory (punishes betrayal), forgiving (returns to cooperation after punishment), and clear (opponents quickly learn its pattern).

            The key insight is that repetition changes everything. In a one-shot game, betrayal dominates. But when players interact repeatedly and value future outcomes, cooperation can emerge and stabilize. Trust becomes rational when relationships have a future.

            This has profound implications for institutions. Contract law, trade agreements, and social norms all function as mechanisms to transform one-shot interactions into repeated games, making cooperation the rational choice.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 410, text: "Where was the Prisoner's Dilemma formalized?", options: ["MIT", "RAND Corporation", "Princeton", "Harvard"], correctIndex: 1),
                Question(id: 411, text: "Which strategy won Axelrod's tournament?", options: ["Always Betray", "Random", "Tit for Tat", "Always Cooperate"], correctIndex: 2),
                Question(id: 412, text: "What makes cooperation rational in repeated games?", options: ["Legal requirements", "Moral obligation", "Valuing future interactions", "Higher IQ"], correctIndex: 2),
            ],
            source: "Public domain game theory"
        ),
        
        Passage(
            id: 20, category: .economics,
            title: "Hyperinflation in Weimar Germany",
            subtitle: "When money becomes worthless",
            content: """
            In January 1919, one US dollar was worth about 8.9 German marks. By November 1923, one dollar was worth 4.2 trillion marks. Prices doubled every few days. Workers were paid twice daily and rushed to buy goods before their wages became worthless. People burned banknotes for heat because the paper was worth more as fuel than as currency.

            The Weimar Republic's hyperinflation didn't begin with reckless money printing — it began with war debt. After World War I, the Treaty of Versailles imposed crippling reparations payments on Germany. The government, unable to raise sufficient taxes, began printing money to buy foreign currency for reparations.

            Once inflation took hold, it created a vicious cycle. The government needed more money to function, so it printed more, which further eroded the currency's value, which required printing still more. The velocity of money — how quickly it changes hands — accelerated as people tried to spend marks before they lost more value.

            The crisis was eventually resolved through a dramatic monetary reform in November 1923. The old Reichsmark was replaced by the Rentenmark at a rate of one trillion to one. The new currency was backed by a mortgage on Germany's industrial and agricultural assets, restoring confidence.

            The psychological scars lasted far longer than the economic crisis itself. The German public's deep fear of inflation — which persists to this day — influenced the design of the European Central Bank, headquartered in Frankfurt, which prioritizes price stability above all other objectives.
            """,
            readTimeMinutes: 4, difficulty: .medium,
            questions: [
                Question(id: 413, text: "What exchange rate did the mark reach against the dollar in 1923?", options: ["1,000 to 1", "1 million to 1", "1 billion to 1", "4.2 trillion to 1"], correctIndex: 3),
                Question(id: 414, text: "What triggered the hyperinflation?", options: ["Stock market crash", "War reparations and money printing", "Oil crisis", "Bank failures"], correctIndex: 1),
                Question(id: 415, text: "At what rate was the old mark exchanged for the Rentenmark?", options: ["100 to 1", "1 million to 1", "1 billion to 1", "1 trillion to 1"], correctIndex: 3),
            ],
            source: "Public domain economic history"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // PSYCHOLOGY (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let psychology: [Passage] = [
        Passage(
            id: 21, category: .psychology,
            title: "The Marshmallow Test",
            subtitle: "Delayed gratification and life outcomes",
            content: """
            In the late 1960s, psychologist Walter Mischel conducted a deceptively simple experiment at Stanford University. He placed a marshmallow in front of young children and gave them a choice: eat it now, or wait 15 minutes and receive two marshmallows.

            The original study followed these children for decades. Those who waited tended to have higher SAT scores, lower rates of substance abuse, better social skills, and healthier body weights. The ability to delay gratification appeared to be a powerful predictor of life success.

            But the story is more nuanced than the popular version suggests. Follow-up research by Tyler Watts and others in 2018 found that when controlling for socioeconomic factors, the predictive power of the marshmallow test diminished significantly.

            Children from wealthier, more stable homes had more reason to trust that the second marshmallow would actually appear — they'd learned from experience that promises were kept. Children from less stable environments had rationally learned that taking what's available now is often the smarter strategy.

            The revised understanding reveals that self-control isn't purely an individual trait — it's shaped by environment, trust, and accumulated experience. Building environments where delayed gratification is reliably rewarded may matter more than training willpower in isolation.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 501, text: "Who conducted the marshmallow experiment?", options: ["B.F. Skinner", "Walter Mischel", "Daniel Kahneman", "Philip Zimbardo"], correctIndex: 1),
                Question(id: 502, text: "What did 2018 follow-up research find?", options: ["Original results confirmed", "Socioeconomic factors reduced predictive power", "Self-control is genetic", "The test was invalid"], correctIndex: 1),
                Question(id: 503, text: "Why might children from less stable homes eat immediately?", options: ["Lower intelligence", "More hunger", "Rational distrust that promises would be kept", "Lack of discipline"], correctIndex: 2),
            ],
            source: "Public domain psychology research"
        ),
        
        Passage(
            id: 22, category: .psychology,
            title: "The Bystander Effect",
            subtitle: "Why crowds don't help",
            content: """
            In 1964, Kitty Genovese was attacked outside her apartment in Queens, New York. Initial reports claimed 38 witnesses watched or heard the attack and did nothing. While later investigation showed this number was exaggerated, the incident inspired research into why people fail to help in emergencies.

            Psychologists John Darley and Bibb Latané conducted experiments showing that the more bystanders present, the less likely any individual is to help. In one study, participants who believed they were the only witness to a seizure helped 85% of the time. When they believed four others were also listening, the rate dropped to 31%.

            Three psychological mechanisms drive the effect. First, diffusion of responsibility: each person assumes someone else will act. Second, pluralistic ignorance: people look to others for cues, and when everyone is looking at everyone else doing nothing, inaction seems appropriate. Third, evaluation apprehension: people fear looking foolish if the situation turns out not to be an emergency.

            The practical solution is surprisingly straightforward: be specific. Instead of shouting "Someone call 911," point at a specific person and say "You in the red shirt — call 911." This eliminates the diffusion of responsibility that causes crowds to freeze.

            Understanding the bystander effect isn't about condemning human nature — it's about recognizing a predictable pattern in group behavior and designing situations that overcome it.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 504, text: "What did Darley and Latané's experiments show?", options: ["More bystanders = more help", "More bystanders = less individual help", "Group size doesn't matter", "Men help more than women"], correctIndex: 1),
                Question(id: 505, text: "What is 'diffusion of responsibility'?", options: ["Everyone feels equally responsible", "Each person assumes someone else will act", "No one knows what to do", "People forget to help"], correctIndex: 1),
                Question(id: 506, text: "What's the practical solution to the bystander effect?", options: ["Yell louder", "Call police yourself", "Point at a specific person and give instructions", "Wait for a leader"], correctIndex: 2),
            ],
            source: "Public domain psychology research"
        ),
        
        Passage(
            id: 23, category: .psychology,
            title: "Cognitive Biases",
            subtitle: "The systematic errors in human thinking",
            content: """
            Daniel Kahneman and Amos Tversky spent decades mapping the systematic errors in human judgment. Their work, which earned Kahneman the Nobel Prize in Economics in 2002, revealed that human thinking relies on mental shortcuts — heuristics — that are usually helpful but can lead to predictable mistakes.

            Confirmation bias is perhaps the most pervasive: we seek out information that confirms what we already believe and ignore or dismiss contradicting evidence. A person convinced that a particular diet works will notice every success story and dismiss failures as "doing it wrong."

            The availability heuristic causes us to overestimate the probability of events that come easily to mind. After seeing news coverage of plane crashes, people overestimate the danger of flying, even though driving is statistically far more dangerous. Our brains confuse "easy to remember" with "likely to happen."

            Anchoring demonstrates how arbitrary numbers influence judgment. In experiments, people who were first asked "Is the Mississippi River longer or shorter than 5,000 miles?" gave much higher estimates of its actual length than those asked if it was longer or shorter than 500 miles. The initial number anchors subsequent thinking.

            Awareness of cognitive biases doesn't eliminate them — even Kahneman admitted to falling prey to his own documented biases. But awareness allows us to build systems and processes that compensate: checklists, structured decision frameworks, and devil's advocate practices.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 507, text: "Who won the Nobel Prize for work on cognitive biases?", options: ["Amos Tversky", "Daniel Kahneman", "Richard Thaler", "Herbert Simon"], correctIndex: 1),
                Question(id: 508, text: "What is the availability heuristic?", options: ["Remembering everything equally", "Overestimating probability of easily recalled events", "Only trusting available data", "Making information more available"], correctIndex: 1),
                Question(id: 509, text: "Does knowing about biases eliminate them?", options: ["Yes, completely", "Only for experts", "No, but awareness helps build compensating systems", "Only with meditation"], correctIndex: 2),
            ],
            source: "Public domain psychology research"
        ),
        
        Passage(
            id: 24, category: .psychology,
            title: "Flow State",
            subtitle: "The psychology of optimal experience",
            content: """
            Mihaly Csikszentmihalyi spent decades studying what makes experiences genuinely satisfying. He found that the happiest moments aren't passive or relaxing — they occur when we're fully absorbed in a challenging activity that matches our skill level. He called this state "flow."

            Flow has several characteristics: complete concentration on the task, a merging of action and awareness, loss of self-consciousness, a distorted sense of time (hours feel like minutes), and a sense that the activity is intrinsically rewarding. The experience is so engaging that people do it for its own sake.

            The key to flow is the balance between challenge and skill. If the challenge is too high relative to skill, we feel anxiety. If skill exceeds challenge, we feel boredom. Flow occupies the sweet spot where both are high and matched — a state Csikszentmihalyi called the "flow channel."

            Surgeons, rock climbers, chess players, musicians, and programmers all report flow experiences. The activity doesn't matter — what matters is the match between challenge and capability, clear goals, and immediate feedback about performance.

            Modern research has shown that flow states correlate with increased productivity, creativity, and learning. The experience also activates the brain's reward systems, releasing dopamine, norepinephrine, and endorphins — creating a natural high that reinforces the behavior. This may explain why people voluntarily pursue difficult, demanding activities.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 510, text: "Who coined the concept of 'flow'?", options: ["Abraham Maslow", "Mihaly Csikszentmihalyi", "Carl Rogers", "Martin Seligman"], correctIndex: 1),
                Question(id: 511, text: "What happens when challenge exceeds skill?", options: ["Flow", "Boredom", "Anxiety", "Relaxation"], correctIndex: 2),
                Question(id: 512, text: "What is required for a flow state?", options: ["Low difficulty", "High challenge matched with high skill", "Complete relaxation", "External rewards"], correctIndex: 1),
            ],
            source: "Public domain psychology research"
        ),
        
        Passage(
            id: 25, category: .psychology,
            title: "The Dunning-Kruger Effect",
            subtitle: "Why incompetent people think they're experts",
            content: """
            In 1999, psychologists David Dunning and Justin Kruger published a study with a striking finding: people with the least competence in a domain tend to overestimate their ability the most. Meanwhile, highly competent people tend to slightly underestimate theirs.

            The mechanism is straightforward but profound. The skills needed to produce correct judgments are the same skills needed to recognize correct judgments. If you don't know much about logic, you lack the tools to evaluate whether your reasoning is logical. You're not just wrong — you're unaware that you're wrong.

            In their original study, participants who scored in the bottom quartile on tests of logic, grammar, and humor estimated they had performed above average. Even after seeing the superior performance of others, the lowest performers barely revised their self-assessments.

            The effect has been replicated across many domains: medical diagnosis, chess, driving ability, emotional intelligence, and even wine tasting. It appears to be a fundamental feature of human cognition rather than a quirk of specific populations.

            The antidote is metacognition — thinking about thinking. As people gain genuine expertise, they also develop the ability to recognize the gaps in their knowledge. True experts understand the boundaries of what they know and what they don't, which is why they often express more uncertainty than novices.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 513, text: "When was the Dunning-Kruger effect published?", options: ["1989", "1999", "2004", "2010"], correctIndex: 1),
                Question(id: 514, text: "Why do incompetent people overestimate themselves?", options: ["They're arrogant", "They lack the skills to evaluate their own performance", "They want to impress others", "They were never tested"], correctIndex: 1),
                Question(id: 515, text: "What is the antidote to the Dunning-Kruger effect?", options: ["More testing", "Metacognition", "External validation", "Competition"], correctIndex: 1),
            ],
            source: "Public domain psychology research"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // LITERATURE (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let literature: [Passage] = [
        Passage(
            id: 26, category: .literature,
            title: "Homer's Odyssey",
            subtitle: "The 3,000-year-old story that defined storytelling",
            content: """
            The Odyssey, composed around the 8th century BCE, tells the story of Odysseus's ten-year journey home after the Trojan War. It is one of the oldest surviving works of Western literature and arguably the most influential story ever told.

            The epic introduces narrative techniques still used today. It begins in medias res — in the middle of the action — rather than at the chronological beginning. The story unfolds through flashbacks as Odysseus recounts his adventures to the Phaeacians. This nonlinear structure was revolutionary and remains a staple of modern storytelling.

            Odysseus encounters a catalog of trials: the Cyclops Polyphemus, the enchantress Circe who turns his men into pigs, the deadly song of the Sirens, the monster Scylla and the whirlpool Charybdis, and the cattle of the sun god Helios. Each challenge tests different aspects of his character — cunning, leadership, self-control, and perseverance.

            The poem is fundamentally about identity and homecoming. Odysseus must not only physically reach Ithaca but reclaim his identity as king, husband, and father. His wife Penelope, who has waited twenty years while fending off suitors, has her own parallel journey of faithfulness and cunning.

            The Odyssey gave the English language the word "odyssey" for any long, eventful journey. Its themes of wandering, temptation, resilience, and the longing for home resonate as powerfully in the 21st century as they did three millennia ago.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 601, text: "When was the Odyssey composed?", options: ["1200 BCE", "8th century BCE", "5th century BCE", "1st century CE"], correctIndex: 1),
                Question(id: 602, text: "What narrative technique does the Odyssey use?", options: ["Chronological order", "In medias res", "Stream of consciousness", "Second person"], correctIndex: 1),
                Question(id: 603, text: "Who is waiting for Odysseus in Ithaca?", options: ["Helen", "Circe", "Penelope", "Athena"], correctIndex: 2),
            ],
            source: "The Odyssey — Homer (c. 8th century BCE, public domain)"
        ),
        
        Passage(
            id: 27, category: .literature,
            title: "Shakespeare's Language",
            subtitle: "The man who invented 1,700 English words",
            content: """
            William Shakespeare didn't just write plays — he expanded the English language itself. Scholars estimate he coined approximately 1,700 words that are still in use today. "Eyeball," "bedroom," "lonely," "generous," "gloomy," "assassination," and "addiction" were all either invented or first recorded in his works.

            Shakespeare also popularized phrases that became so embedded in English that most speakers don't realize their origin. "Break the ice," "wild goose chase," "heart of gold," "method in the madness," "love is blind," and "all that glitters is not gold" all come from his plays.

            His vocabulary was extraordinary. Shakespeare used approximately 31,000 different words across his works — roughly double the vocabulary of a typical educated English speaker. He achieved this partly through invention, partly through borrowing from Latin, French, and Italian, and partly through creative compounding of existing words.

            Beyond vocabulary, Shakespeare transformed English dramatic verse. His use of iambic pentameter — five pairs of unstressed-stressed syllables per line — created a rhythm that mirrors natural English speech while elevating it to poetry. When he broke from this meter, the disruption signaled emotional intensity.

            Shakespeare wrote approximately 37 plays, 154 sonnets, and several longer poems between roughly 1589 and 1613. Four centuries later, his works remain the most performed, adapted, and quoted in the English language — testament to his unmatched understanding of human nature expressed through words he often had to invent.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 604, text: "How many words did Shakespeare reportedly coin?", options: ["500", "1,000", "1,700", "3,000"], correctIndex: 2),
                Question(id: 605, text: "How many different words did Shakespeare use in his works?", options: ["10,000", "20,000", "31,000", "50,000"], correctIndex: 2),
                Question(id: 606, text: "What verse form did Shakespeare primarily use?", options: ["Free verse", "Haiku", "Iambic pentameter", "Alexandrine"], correctIndex: 2),
            ],
            source: "Public domain literary history"
        ),
        
        Passage(
            id: 28, category: .literature,
            title: "Frankenstein's Warning",
            subtitle: "The first science fiction novel was written by a teenager",
            content: """
            Mary Shelley was just eighteen years old when she conceived the idea for Frankenstein during a ghost story contest at Lord Byron's villa near Lake Geneva in 1816. Published anonymously in 1818, it is widely considered the first true science fiction novel.

            The novel's full title — "Frankenstein; or, The Modern Prometheus" — signals its ambitions. Like Prometheus, who stole fire from the gods, Victor Frankenstein reaches beyond human limitations by creating life. And like Prometheus, he suffers terribly for his transgression.

            The creature is not the mindless monster of popular culture. In Shelley's novel, he is articulate, sensitive, and deeply lonely. He teaches himself to read using Milton's "Paradise Lost," Plutarch's "Lives," and Goethe's "Sorrows of Young Werther." His violence stems not from his nature but from the rejection and cruelty he faces from humanity.

            Shelley's novel anticipated anxieties that would only grow more relevant over time: the ethics of creating life, the responsibility of creators toward their creations, the danger of scientific ambition unchecked by moral reflection, and society's tendency to reject what it doesn't understand.

            Written during the early Industrial Revolution, when steam power and galvanism were transforming society, Frankenstein asked questions we still haven't fully answered. As artificial intelligence and genetic engineering advance, Shelley's 200-year-old warning grows more prescient, not less.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 607, text: "How old was Mary Shelley when she conceived Frankenstein?", options: ["15", "18", "21", "25"], correctIndex: 1),
                Question(id: 608, text: "What is the novel's subtitle?", options: ["The Monster", "The Modern Prometheus", "The Creation", "A Gothic Tale"], correctIndex: 1),
                Question(id: 609, text: "What does the creature teach himself to read?", options: ["The Bible", "Shakespeare", "Milton's Paradise Lost, among others", "Scientific journals"], correctIndex: 2),
            ],
            source: "Frankenstein — Mary Shelley (1818, public domain)"
        ),
        
        Passage(
            id: 29, category: .literature,
            title: "Tolstoy's Opening Line",
            subtitle: "Why great novels begin with universal truths",
            content: """
            "Happy families are all alike; every unhappy family is unhappy in its own way." The opening line of Anna Karenina, published in 1877, is one of the most quoted sentences in literary history. But it's more than elegant prose — it contains a genuine philosophical insight.

            What Tolstoy describes has been called the "Anna Karenina principle": for a system to succeed, many factors must align simultaneously. For it to fail, only one thing needs to go wrong. A happy family requires compatible partners, financial stability, good health, shared values, effective communication, and mutual respect — all at once. Remove any single element, and unhappiness finds its own unique form.

            This principle extends far beyond families. Jared Diamond applied it to animal domestication in "Guns, Germs, and Steel": a wild animal must meet six criteria to be domesticated (diet, growth rate, temperament, tendency to panic, social hierarchy, and willingness to breed in captivity). Failure on any one criterion is disqualifying, which is why so few species have been successfully domesticated.

            Tolstoy's novel itself demonstrates the principle through parallel storylines. Anna Karenina's marriage fails spectacularly — her passionate affair with Count Vronsky leads to social exile and tragedy. Meanwhile, Levin's storyline shows the quieter, harder work of building a functioning life and relationship.

            The opening line works as literature because it invites the reader into a truth they recognize but haven't articulated. Great opening lines don't just begin a story — they establish a lens through which everything that follows will be understood.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 610, text: "When was Anna Karenina published?", options: ["1857", "1867", "1877", "1887"], correctIndex: 2),
                Question(id: 611, text: "What does the Anna Karenina principle state?", options: ["Success requires many factors; failure needs just one", "All families are the same", "Love conquers all", "History repeats itself"], correctIndex: 0),
                Question(id: 612, text: "Who applied this principle to animal domestication?", options: ["Charles Darwin", "Jared Diamond", "Richard Dawkins", "E.O. Wilson"], correctIndex: 1),
            ],
            source: "Anna Karenina — Leo Tolstoy (1877, public domain)"
        ),
        
        Passage(
            id: 30, category: .literature,
            title: "The Art of the Short Story",
            subtitle: "Chekhov's gun and the economy of language",
            content: """
            Anton Chekhov, the Russian playwright and short story master, articulated a principle that every writer learns: "If in the first act you have hung a pistol on the wall, then in the following one it should be fired." This isn't about guns — it's about the discipline of including only what matters.

            Chekhov's stories are remarkable for what they leave out. His characters rarely explain themselves. Events happen without dramatic buildup. Endings arrive without neat resolution. Yet these apparent absences create something powerful — space for the reader's own understanding to fill.

            In "The Lady with the Dog," a cynical middle-aged man begins an affair at a resort, expecting it to be meaningless like his others. The story ends not with dramatic confrontation but with the quiet realization that their love is real and their lives are impossibly complicated. The last line doesn't resolve anything — it opens everything up.

            This approach revolutionized fiction. Before Chekhov, stories were expected to have clear morals, dramatic climaxes, and definitive endings. Chekhov showed that life doesn't work that way, and literature doesn't have to either.

            Ernest Hemingway acknowledged his debt to Chekhov, developing his own "iceberg theory" — the idea that the dignity of movement of an iceberg is due to only one-eighth being above water. The most powerful elements of a story are what the writer knows but doesn't explicitly state.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 613, text: "What is 'Chekhov's gun' about?", options: ["Always include weapons", "Only include what matters in a story", "Russian military history", "Stage props"], correctIndex: 1),
                Question(id: 614, text: "What characterizes Chekhov's story endings?", options: ["Dramatic climaxes", "Clear morals", "Lack of neat resolution", "Happy endings"], correctIndex: 2),
                Question(id: 615, text: "What is Hemingway's 'iceberg theory'?", options: ["Stories should be cold", "Most power comes from what's unstated", "Only write about nature", "Always use simple words"], correctIndex: 1),
            ],
            source: "Public domain literary criticism"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // MATHEMATICS (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let mathematics: [Passage] = [
        Passage(
            id: 31, category: .mathematics,
            title: "The Proof That Changed Everything",
            subtitle: "Euclid's demonstration that primes are infinite",
            content: """
            Around 300 BCE, Euclid proved something remarkable: there are infinitely many prime numbers. His proof, found in Book IX of "The Elements," is considered one of the most elegant arguments in all of mathematics.

            The proof works by contradiction. Suppose there are only finitely many primes — call them p₁, p₂, ..., pₙ. Now multiply them all together and add 1: N = (p₁ × p₂ × ... × pₙ) + 1. This number N is not divisible by any of the primes on our list, because dividing N by any pᵢ always leaves a remainder of 1.

            So either N itself is prime (a new prime not on our list), or N has a prime factor that wasn't on our list. Either way, our assumption that we had all the primes was wrong. Therefore, there must be infinitely many primes.

            What makes this proof extraordinary is its simplicity and generality. It doesn't construct all the primes or even find a new one — it simply shows that any finite list must be incomplete. The argument has been called "proof from the Book" — the idea being that God keeps a book of the most perfect proofs, and this one belongs in it.

            Primes remain central to modern mathematics and technology. RSA encryption, which secures most internet transactions, relies on the fact that multiplying two large primes is easy, but factoring their product back into primes is computationally infeasible. Euclid's 2,300-year-old insight underpins your online banking.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 701, text: "What proof technique did Euclid use?", options: ["Direct proof", "Mathematical induction", "Proof by contradiction", "Proof by exhaustion"], correctIndex: 2),
                Question(id: 702, text: "In Euclid's proof, what happens when you multiply all primes and add 1?", options: ["You get a prime", "You get a number not divisible by any listed prime", "You get an even number", "You get infinity"], correctIndex: 1),
                Question(id: 703, text: "What modern technology relies on prime numbers?", options: ["GPS", "WiFi", "RSA encryption", "Bluetooth"], correctIndex: 2),
            ],
            source: "The Elements — Euclid (c. 300 BCE, public domain)"
        ),
        
        Passage(
            id: 32, category: .mathematics,
            title: "The Golden Ratio",
            subtitle: "The number that appears everywhere",
            content: """
            The golden ratio, approximately 1.618, is defined as the number φ (phi) where a + b is to a as a is to b. In equation form: φ = (1 + √5) / 2. This seemingly arbitrary irrational number appears with surprising frequency in nature, art, and mathematics.

            The Fibonacci sequence — 1, 1, 2, 3, 5, 8, 13, 21, 34, 55... — where each number is the sum of the two preceding ones, has a deep connection to the golden ratio. As the sequence progresses, the ratio between consecutive terms converges to φ. The ratio of 55 to 34 is 1.6176..., already very close.

            In nature, the golden ratio appears in the spiral arrangement of seeds in sunflower heads, the branching patterns of trees, the spiral of nautilus shells, and the proportions of hurricanes. These appearances aren't mystical — they arise because growth processes that follow simple recursive rules naturally produce golden-ratio proportions.

            Artists and architects have used the golden ratio for millennia. The Parthenon's facade fits within a golden rectangle. Leonardo da Vinci's illustrations for "De Divina Proportione" explicitly explored the ratio's aesthetic properties. Whether the ratio is inherently "beautiful" or simply familiar is still debated.

            The golden ratio has a remarkable mathematical property: it is the "most irrational" number, meaning it is the hardest to approximate with fractions. This property makes it optimal for certain natural packing problems, explaining why plants often arrange leaves and seeds in golden-ratio spirals — it minimizes overlap and maximizes sunlight exposure.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 704, text: "What is the approximate value of the golden ratio?", options: ["1.414", "1.618", "2.718", "3.14159"], correctIndex: 1),
                Question(id: 705, text: "How is the golden ratio related to Fibonacci numbers?", options: ["They're the same thing", "Consecutive Fibonacci ratios converge to φ", "Fibonacci numbers are multiples of φ", "There's no relationship"], correctIndex: 1),
                Question(id: 706, text: "Why do plants use golden-ratio spirals?", options: ["For beauty", "To attract pollinators", "To minimize overlap and maximize sunlight", "Random chance"], correctIndex: 2),
            ],
            source: "Public domain mathematics"
        ),
        
        Passage(
            id: 33, category: .mathematics,
            title: "Zero: The Number That Almost Wasn't",
            subtitle: "How nothing became the most important something",
            content: """
            For most of human mathematical history, zero didn't exist as a number. The Babylonians used a placeholder symbol in their positional notation as early as 300 BCE, but they didn't treat it as a number in its own right. The ancient Greeks, despite their mathematical sophistication, philosophically rejected the concept of "nothing" having numerical existence.

            It was Indian mathematicians who first treated zero as a full number. Brahmagupta, writing around 628 CE, laid out rules for arithmetic with zero: any number plus zero equals itself, any number times zero equals zero, and zero divided by zero is zero (this last rule was later corrected).

            The concept reached Europe through Arabic mathematicians, particularly al-Khwarizmi, whose name gives us the word "algorithm." The Hindu-Arabic numeral system, with zero as its foundation, gradually replaced Roman numerals throughout Europe between the 10th and 15th centuries — though not without resistance. Florence banned the system in 1299, fearing that the easily altered 0 would enable fraud.

            Zero's importance extends far beyond arithmetic. It's essential to the concept of place value — without it, we can't distinguish between 12, 102, and 1,020. It's the foundation of calculus, where the behavior of functions as values approach zero is central. And in computer science, every piece of digital information is encoded as sequences of zeros and ones.

            A universe without zero would be a universe without modern mathematics, science, engineering, and computing. The recognition that "nothing" is "something" was perhaps humanity's greatest intellectual leap.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 707, text: "Who first treated zero as a full number?", options: ["Greeks", "Romans", "Indian mathematicians", "Egyptians"], correctIndex: 2),
                Question(id: 708, text: "When did Brahmagupta write rules for zero arithmetic?", options: ["300 BCE", "100 CE", "628 CE", "1000 CE"], correctIndex: 2),
                Question(id: 709, text: "Why did Florence ban Hindu-Arabic numerals in 1299?", options: ["Religious reasons", "Fear of fraud with easily altered 0", "Loyalty to Roman numerals", "Lack of teachers"], correctIndex: 1),
            ],
            source: "Public domain mathematics history"
        ),
        
        Passage(
            id: 34, category: .mathematics,
            title: "Gödel's Incompleteness",
            subtitle: "The proof that shattered mathematical certainty",
            content: """
            In 1931, Kurt Gödel, a 25-year-old Austrian mathematician, published a proof that shook the foundations of mathematics. He demonstrated that in any consistent mathematical system powerful enough to describe basic arithmetic, there exist true statements that cannot be proved within that system.

            To understand why this was so shocking, consider the project it demolished. David Hilbert, the era's most influential mathematician, had proposed that all of mathematics could eventually be derived from a finite set of axioms — that mathematics was, in principle, complete and decidable.

            Gödel's proof used a brilliant self-referential trick. He constructed a mathematical statement that essentially says "This statement is not provable." If the statement is provable, then it's false, and the system proves a falsehood (making it inconsistent). If it's not provable, then it's true — a true statement that can't be proved.

            The second incompleteness theorem went further: a consistent system cannot prove its own consistency. Mathematics cannot guarantee its own reliability from within.

            These results didn't break mathematics — it still works perfectly well for engineering, physics, and everyday calculation. But they established permanent limits on what formal systems can achieve. There will always be mathematical truths that escape any finite set of rules. Certainty, the ultimate goal of the Hilbert program, was shown to be fundamentally unattainable.
            """,
            readTimeMinutes: 4, difficulty: .hard,
            questions: [
                Question(id: 710, text: "When did Gödel publish his incompleteness theorems?", options: ["1905", "1921", "1931", "1945"], correctIndex: 2),
                Question(id: 711, text: "Whose program did Gödel's work demolish?", options: ["Einstein's", "Russell's", "Hilbert's", "Cantor's"], correctIndex: 2),
                Question(id: 712, text: "What does the first incompleteness theorem state?", options: ["Math is inconsistent", "Some true statements can't be proved within the system", "All theorems are provable", "Axioms are unnecessary"], correctIndex: 1),
            ],
            source: "Public domain mathematics"
        ),
        
        Passage(
            id: 35, category: .mathematics,
            title: "The Birthday Paradox",
            subtitle: "Why probability defies your intuition",
            content: """
            How many people do you need in a room before there's a 50% chance that two of them share a birthday? Most people guess around 183 — half of 365. The actual answer is just 23. This counterintuitive result, known as the birthday paradox, reveals how poorly human intuition handles probability.

            The key insight is that we're not asking about a specific birthday — we're asking about any matching pair. With 23 people, there are 253 possible pairs (23 × 22 ÷ 2). Each pair has a 364/365 chance of NOT sharing a birthday, but with 253 independent opportunities for a match, the probabilities compound rapidly.

            With 50 people, the probability exceeds 97%. With 70 people, it's 99.9%. The growth is driven by the combinatorial explosion of pairings — while the group grows linearly, the number of pairs grows quadratically.

            The birthday paradox has practical applications in computer science. Hash collisions — when two different inputs produce the same output in a hash function — follow birthday-paradox mathematics. A hash function producing n possible outputs will likely see a collision after roughly √n inputs, much sooner than the n inputs intuition would suggest.

            This matters for cryptographic security. A hash function must have an output space large enough that birthday-attack collisions remain computationally infeasible. Understanding the birthday paradox is essential for designing secure systems — intuition about probability simply isn't reliable enough.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 713, text: "How many people needed for 50% chance of shared birthday?", options: ["23", "50", "100", "183"], correctIndex: 0),
                Question(id: 714, text: "How many pairs exist with 23 people?", options: ["23", "46", "253", "365"], correctIndex: 2),
                Question(id: 715, text: "What computer science concept uses birthday-paradox math?", options: ["Sorting algorithms", "Hash collisions", "Neural networks", "Database indexing"], correctIndex: 1),
            ],
            source: "Public domain probability theory"
        ),
    ]
    
    // ═══════════════════════════════════════════════════════════
    // TECHNOLOGY (5 passages)
    // ═══════════════════════════════════════════════════════════
    
    static let technology: [Passage] = [
        Passage(
            id: 36, category: .technology,
            title: "The Turing Test",
            subtitle: "When does a machine become intelligent?",
            content: """
            In 1950, Alan Turing published a paper titled "Computing Machinery and Intelligence" that began with a deceptively simple question: "Can machines think?" Rather than debating the philosophical meaning of "think," Turing proposed a practical test.

            In what he called the "imitation game," a human interrogator communicates via text with two hidden entities — one human and one machine. If the interrogator cannot reliably distinguish between them, Turing argued, the machine should be considered intelligent. The test elegantly sidesteps unanswerable questions about consciousness by focusing on observable behavior.

            Turing predicted that by the year 2000, computers would fool 30% of interrogators during five-minute conversations. This prediction proved optimistic, though chatbots have occasionally claimed success under specific conditions.

            Critics have raised important objections. John Searle's "Chinese Room" argument posits that a person who doesn't speak Chinese could follow a rule book to produce correct Chinese responses without understanding a word. Similarly, a machine might pass the Turing test through sophisticated pattern matching without genuine understanding.

            The debate has become more urgent with modern large language models. These systems produce remarkably human-like text, yet their developers acknowledge they don't "understand" in the way humans do. Whether this distinction matters — or whether the Turing test asked the right question in the first place — remains one of the most important open questions in technology.
            """,
            readTimeMinutes: 3, difficulty: .medium,
            questions: [
                Question(id: 801, text: "When did Turing publish his influential paper?", options: ["1936", "1945", "1950", "1956"], correctIndex: 2),
                Question(id: 802, text: "What is the 'Chinese Room' argument about?", options: ["Translation software", "Following rules without understanding", "Chinese computing history", "Language learning"], correctIndex: 1),
                Question(id: 803, text: "What did Turing predict about machines by 2000?", options: ["Full consciousness", "Fooling 30% of interrogators", "Replacing all workers", "Self-replication"], correctIndex: 1),
            ],
            source: "Computing Machinery and Intelligence — Alan Turing (1950, public domain)"
        ),
        
        Passage(
            id: 37, category: .technology,
            title: "Moore's Law",
            subtitle: "The prediction that powered the digital age",
            content: """
            In 1965, Gordon Moore, co-founder of Intel, observed that the number of transistors on an integrated circuit had been doubling approximately every two years. He predicted this trend would continue, and for over five decades, it did — a regularity so consistent it became known as Moore's Law.

            The implications were staggering. Exponential growth is difficult for humans to intuit. A computer from 1975 had roughly 10,000 transistors. By 2020, Apple's M1 chip contained 16 billion. If cars had improved at the same rate, a 1975 car that went 100 mph would now travel at 3.3 billion mph — faster than the speed of light.

            Moore's Law wasn't a law of physics but a self-fulfilling prophecy. The semiconductor industry organized its research roadmaps around the prediction, creating a coordination mechanism that aligned billions of dollars in investment toward a shared target.

            The trend is now slowing. Transistors have approached atomic scales — modern chips have features just a few nanometers wide, with silicon atoms roughly 0.2 nanometers across. Quantum effects, heat dissipation, and manufacturing costs impose increasingly hard limits.

            The industry's response has been architectural innovation. Rather than making individual transistors smaller, designers use multiple cores, specialized processing units, chiplets, and 3D stacking. The era of simple transistor scaling may be ending, but computational progress continues through different means.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 804, text: "How often did transistor counts double according to Moore's Law?", options: ["Every 6 months", "Every year", "Every 2 years", "Every 5 years"], correctIndex: 2),
                Question(id: 805, text: "How many transistors does Apple's M1 chip contain?", options: ["1 million", "100 million", "1 billion", "16 billion"], correctIndex: 3),
                Question(id: 806, text: "Why is Moore's Law slowing down?", options: ["Lack of funding", "No demand", "Transistors approaching atomic scale limits", "Legal restrictions"], correctIndex: 2),
            ],
            source: "Public domain technology history"
        ),
        
        Passage(
            id: 38, category: .technology,
            title: "The Internet's Origin",
            subtitle: "How a military project became everyone's network",
            content: """
            The internet began as ARPANET, a project funded by the U.S. Department of Defense's Advanced Research Projects Agency. On October 29, 1969, the first message was sent between computers at UCLA and Stanford Research Institute. The intended message was "LOGIN" — but the system crashed after "LO."

            ARPANET's revolutionary feature was packet switching, developed independently by Paul Baran and Donald Davies. Instead of establishing a dedicated circuit between two points (like a phone call), data was broken into small packets that could travel different routes through the network and reassemble at their destination. This made the network resilient — if one path was destroyed, packets could find another.

            Tim Berners-Lee transformed the internet from an academic tool to a mass medium. In 1989, working at CERN in Switzerland, he proposed a system of interlinked hypertext documents accessible via the internet. He created HTML, HTTP, and the first web browser. By 1991, the World Wide Web was available to the public.

            Berners-Lee made a decision that shaped history: he released his invention without patents or licensing fees. Had the web been proprietary, its explosive growth would have been impossible. This single act of openness enabled the most rapid transformation of human communication since the printing press.

            By 2025, over five billion people use the internet — roughly 65% of the global population. The network that began with a two-letter message between two universities now carries virtually all human commerce, communication, and culture.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 807, text: "What was the first ARPANET message?", options: ["HELLO", "LO (system crashed before LOGIN)", "TEST", "SEND"], correctIndex: 1),
                Question(id: 808, text: "Who invented the World Wide Web?", options: ["Vint Cerf", "Tim Berners-Lee", "Bill Gates", "Steve Jobs"], correctIndex: 1),
                Question(id: 809, text: "What technology makes the internet resilient?", options: ["Fiber optics", "Satellites", "Packet switching", "Encryption"], correctIndex: 2),
            ],
            source: "Public domain technology history"
        ),
        
        Passage(
            id: 39, category: .technology,
            title: "How Encryption Works",
            subtitle: "The math that keeps your secrets safe",
            content: """
            Every time you send a message, make a purchase, or log into an account online, encryption protects your data. The fundamental idea is simple: transform readable information (plaintext) into unreadable gibberish (ciphertext) using a mathematical key, such that only someone with the correct key can reverse the transformation.

            Modern encryption relies on mathematical operations that are easy to perform in one direction but practically impossible to reverse. Multiplying two large prime numbers takes milliseconds. Factoring their product back into those specific primes would take the world's fastest computers billions of years for sufficiently large numbers.

            Public-key cryptography, invented in the 1970s by Diffie and Hellman (and independently by Ellis, Cocks, and Williamson at GCHQ), solved a fundamental problem: how do two parties who've never met establish a shared secret? The solution uses paired keys — a public key that anyone can use to encrypt, and a private key that only the recipient can use to decrypt.

            When you see the padlock icon in your browser, your computer and the server have performed this key exchange in milliseconds. The math involves modular exponentiation — operations where numbers are raised to enormous powers and then divided, keeping only the remainder. These operations are easy to compute but virtually impossible to reverse.

            Quantum computing poses a theoretical threat to current encryption methods. Shor's algorithm, if implemented on a sufficiently powerful quantum computer, could factor large numbers efficiently. This has spurred development of "post-quantum" encryption algorithms designed to resist quantum attacks.
            """,
            readTimeMinutes: 3, difficulty: .hard,
            questions: [
                Question(id: 810, text: "What makes modern encryption secure?", options: ["Complex passwords", "Operations easy to do but hard to reverse", "Government regulation", "Physical security"], correctIndex: 1),
                Question(id: 811, text: "Who invented public-key cryptography?", options: ["Alan Turing", "Diffie and Hellman", "RSA team", "NSA"], correctIndex: 1),
                Question(id: 812, text: "What threatens current encryption?", options: ["Faster CPUs", "AI", "Quantum computing", "Social engineering"], correctIndex: 2),
            ],
            source: "Public domain cryptography"
        ),
        
        Passage(
            id: 40, category: .technology,
            title: "Open Source Revolution",
            subtitle: "How free software changed the world",
            content: """
            In 1991, a 21-year-old Finnish student named Linus Torvalds posted a message to a newsgroup: "I'm doing a (free) operating system (just a hobby, won't be big and professional)." That hobby project became Linux, which now runs the majority of the world's servers, all Android phones, most embedded systems, and all of the world's top 500 supercomputers.

            The open source model — where source code is publicly available for anyone to inspect, modify, and distribute — was considered naive and economically unsustainable by many in the 1990s software industry. Microsoft's CEO Steve Ballmer famously called Linux "a cancer." Yet the model proved extraordinarily effective.

            The economics work because open source isn't about free labor — it's about shared infrastructure. Companies contribute to projects they depend on because collaboration is cheaper than building everything alone. Google, Microsoft, Meta, and Amazon are now among the largest contributors to open source projects.

            The impact extends beyond software. Wikipedia operates on open-source principles. Open-access scientific publishing challenges the traditional journal model. Creative Commons licenses enable sharing of creative works. The underlying philosophy — that knowledge and tools improve when openly shared — has influenced fields far beyond technology.

            Today, virtually every piece of software you use depends on open source components. The web server delivering this text, the encryption securing the connection, and the programming languages used to build both are overwhelmingly open source. What began as one student's hobby reshaped the entire technology industry.
            """,
            readTimeMinutes: 3, difficulty: .easy,
            questions: [
                Question(id: 813, text: "Who created Linux?", options: ["Bill Gates", "Steve Jobs", "Linus Torvalds", "Dennis Ritchie"], correctIndex: 2),
                Question(id: 814, text: "What percentage of top 500 supercomputers run Linux?", options: ["50%", "75%", "90%", "100%"], correctIndex: 3),
                Question(id: 815, text: "Why do large companies contribute to open source?", options: ["Legal requirement", "Shared infrastructure is cheaper than building alone", "Government mandate", "For advertising"], correctIndex: 1),
            ],
            source: "Public domain technology history"
        ),
    ]
}
