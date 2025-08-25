import '../widgets/info_post_card.dart';
import '../models/flashcard.dart';

const List<String> kTopics = [
  'AI Basics', 'System Design', 'JavaScript Essentials', 'SQL Fundamentals', 'Finance 101', 'World History'
];

final List<InfoPost> kInfoPosts = List.generate(10, (i) => InfoPost(
  id: 'post-$i',
  title: 'Featured Topic ${i + 1}',
  summary: 'Quick intro to topic ${i + 1} with practical examples and tips.',
  imageUrl: 'https://picsum.photos/seed/post$i/1200/800',
  meta: '${2 + (i % 3)} min · ${(i + 1) * 5} XP',
));

final List<Map<String, String>> kTestimonials = [
  {
    'quote': 'Crisp, modern, and to the point!',
    'author': 'Chen · Tech Lead'
  },
  {
    'quote': 'Perfect for my commute—learned SQL joins in 10 minutes.',
    'author': 'Riya · Data Analyst'
  },
];

final List<Flashcard> kSampleFlashcards = List.generate(12, (i) => Flashcard(
  id: 'fc-$i',
  title: 'Card ${i + 1}',
  content: 'This is a sample flashcard content number ${i + 1}.',
  category: kTopics[i % kTopics.length],
));

class QuickBite {
  final String id;
  final String title;
  final String badge;
  final String summary;
  final List<String> bullets;
  final String cover;
  const QuickBite({
    required this.id,
    required this.title,
    required this.badge,
    required this.summary,
    required this.bullets,
    required this.cover,
  });
}

final List<QuickBite> kQuickBites = [
  const QuickBite(
    id: 'ai_basics',
    title: 'Basics of AI',
    badge: '3-min',
    summary: 'What AI is, common terms, and where we use it daily.',
    bullets: [
      'AI vs ML vs DL: AI = umbrella, ML = learning from data, DL = neural nets',
      'Common tasks: classification, regression, clustering, generation',
      'Everyday AI: recommendations, spam filters, voice assistants',
    ],
    cover: 'https://picsum.photos/seed/aishorts/800/500',
  ),
  const QuickBite(
    id: 'sql_functions',
    title: 'Basic SQL Functions',
    badge: '3-min',
    summary: 'Aggregate & scalar functions you use all the time.',
    bullets: [
      'COUNT, SUM, AVG, MIN, MAX with GROUP BY',
      'String ops: LOWER, UPPER, CONCAT, SUBSTR',
      'Dates: NOW, DATE_ADD, EXTRACT parts (year, month)',
    ],
    cover: 'https://picsum.photos/seed/sqlfunc/800/500',
  ),
  const QuickBite(
    id: 'js_essentials',
    title: 'JavaScript Essentials',
    badge: '3-min',
    summary: 'Closures, event loop, promises vs async/await—fast.',
    bullets: [
      'Closure captures lexical scope → private state',
      'Event loop: call stack, microtasks, macrotasks',
      'Promises → async/await sugar with try/catch',
    ],
    cover: 'https://picsum.photos/seed/jsshort/800/500',
  ),
];

class LearningPathMock {
  final String title;
  final int lessons;
  final String eta;
  final double progress;
  final String cta;
  final String blurb;
  const LearningPathMock({required this.title, required this.lessons, required this.eta, required this.progress, required this.cta, required this.blurb});
}

final List<LearningPathMock> kLearningPaths = const [
  LearningPathMock(title: 'System Design Starter', lessons: 12, eta: '45–60 min', progress: 0.25, cta: 'Resume', blurb: 'CAP, caching, load balancing, and DB basics.'),
  LearningPathMock(title: 'SQL from Zero', lessons: 10, eta: '40–50 min', progress: 0.6, cta: 'Resume', blurb: 'SELECT to JOINs to aggregation with hands-on snippets.'),
];

final Map<String, List<Map<String, String>>> kTopicCards = {
  'System Design Basics': [
    {'q': 'What is System Design?', 'a': 'The process of defining the architecture, components, and interactions of a system to meet functional and non-functional requirements.'},
    {'q': 'High-Level Design vs Low-Level Design', 'a': 'HLD focuses on the overall architecture and major components; LLD details modules, class diagrams, and internal logic.'},
    {'q': 'Scalability', 'a': 'The ability of a system to handle increased load by scaling up (vertical) or scaling out (horizontal). It matters to maintain performance as users grow.'},
    {'q': 'Load Balancer', 'a': 'Distributes traffic across servers, improves availability and utilizes health checks and routing strategies.'},
  ],
  'SQL from Zero': [
    {'q': 'Primary Key', 'a': 'Uniquely identifies a row in a table.'},
    {'q': 'INDEX', 'a': 'Speeds reads; extra storage and write overhead.'},
    {'q': 'JOIN types', 'a': 'INNER, LEFT, RIGHT, FULL, CROSS.'},
  ],
  'SQL Functions 101': [
    {'q': 'Aggregates', 'a': 'COUNT, SUM, AVG, MIN, MAX with GROUP BY'},
    {'q': 'String functions', 'a': 'LOWER, UPPER, CONCAT, SUBSTR'},
    {'q': 'Date functions', 'a': 'NOW, DATE_ADD, EXTRACT(year, month, day)'},
  ],
  'Data Structures: Arrays & HashMaps': [
    {'q': 'Array basics', 'a': 'Contiguous memory, O(1) access by index.'},
    {'q': 'HashMap basics', 'a': 'Key-value store backed by hash function; average O(1) get/put.'},
    {'q': 'When to use', 'a': 'Arrays for ordered/indexed data; HashMaps for fast lookups by key.'},
  ],
  'JavaScript Async (Promises & Await)': [
    {'q': 'Promise', 'a': 'Represents a value that will be available in the future, with states: pending, fulfilled, rejected.'},
    {'q': 'async/await', 'a': 'Syntactic sugar over Promises to write asynchronous code that looks synchronous.'},
    {'q': 'Microtasks', 'a': 'Promise callbacks run in the microtask queue before macrotasks.'},
  ],
  'Basics of AI & ML': [
    {'q': 'AI vs ML vs DL', 'a': 'AI is the broader field; ML is learning from data; DL uses deep neural networks.'},
    {'q': 'Common tasks', 'a': 'Classification, regression, clustering, generation.'},
    {'q': 'Real-world uses', 'a': 'Recommendations, spam filters, voice assistants.'},
  ],
};

class ContinueLearningMock {
  final String title;
  final int today;
  final int streak;
  final String nextCard;
  final String cta;
  const ContinueLearningMock({required this.title, required this.today, required this.streak, required this.nextCard, required this.cta});
}

const ContinueLearningMock kContinue = ContinueLearningMock(
  title: 'Continue learning',
  today: 8,
  streak: 2,
  nextCard: 'JOIN vs LEFT JOIN: which keeps unmatched left rows?',
  cta: 'Resume',
);

class QotdMock {
  final String question;
  final List<String> choices;
  final int answerIndex;
  final String explain;
  const QotdMock({required this.question, required this.choices, required this.answerIndex, required this.explain});
}

const QotdMock kQotd = QotdMock(
  question: 'Which strategy reduces initial load time for large apps?',
  choices: ['Inlining all JS', 'Code splitting', 'Bigger bundle cache', 'Render-blocking CSS'],
  answerIndex: 1,
  explain: 'Code splitting ships only what’s needed for the current route.',
);
