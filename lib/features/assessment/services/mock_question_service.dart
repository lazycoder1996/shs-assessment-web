// import '../data/models/question.dart';
// import '../data/models/question_preamble.dart';

// class MockQuestionService {
//   Future<List<QuestionPreamble>> getPreambles(
//     String assessmentId,
//   ) async {
//     await Future.delayed(
//       const Duration(milliseconds: 200),
//     );

//     return const [
//       QuestionPreamble(
//         id: 'preamble-1',
//         title: 'Read the passage below and answer Questions 1–2.',
//         content:
//             'Education plays an important role in the development of every society. '
//             'It provides individuals with knowledge, skills and values that enable '
//             'them to contribute meaningfully to their communities. However, access '
//             'to quality education remains a challenge in many parts of the world.',
//       ),
//     ];
//   }

//   Future<List<Question>> getQuestions(
//     String assessmentId,
//   ) async {
//     await Future.delayed(
//       const Duration(milliseconds: 400),
//     );

//     return const [
//       Question(
//         id: 'q1',
//         number: 1,
//         text:
//             'According to the passage, what is one major benefit of education?',
//         type: QuestionType.multipleChoice,
//         marks: 1,
//         correctOptionId: 'q1a',
//         preambleId: 'preamble-1',
//         options: [
//           QuestionOption(
//             id: 'q1a',
//             text: 'It provides knowledge and skills.',
//           ),
//           QuestionOption(
//             id: 'q1b',
//             text: 'It eliminates every social problem.',
//           ),
//           QuestionOption(
//             id: 'q1c',
//             text: 'It guarantees employment for everyone.',
//           ),
//           QuestionOption(
//             id: 'q1d',
//             text: 'It prevents people from contributing to society.',
//           ),
//         ],
//       ),

//       Question(
//         id: 'q2',
//         number: 2,
//         text:
//             'What challenge is mentioned in the passage?',
//         type: QuestionType.multipleChoice,
//         marks: 1,
//         correctOptionId: 'q2b',
//         preambleId: 'preamble-1',
//         options: [
//           QuestionOption(
//             id: 'q2a',
//             text: 'Lack of interest in education.',
//           ),
//           QuestionOption(
//             id: 'q2b',
//             text: 'Limited access to quality education.',
//           ),
//           QuestionOption(
//             id: 'q2c',
//             text: 'Too many schools.',
//           ),
//           QuestionOption(
//             id: 'q2d',
//             text: 'Lack of teachers everywhere.',
//           ),
//         ],
//       ),

//       Question(
//         id: 'q3',
//         number: 3,
//         text:
//             'If f(x) = 2x + 3, what is the value of f(4)?',
//         type: QuestionType.multipleChoice,
//         marks: 1,
//         correctOptionId: 'q3b',
//         options: [
//           QuestionOption(
//             id: 'q3a',
//             text: '7',
//           ),
//           QuestionOption(
//             id: 'q3b',
//             text: '11',
//           ),
//           QuestionOption(
//             id: 'q3c',
//             text: '12',
//           ),
//           QuestionOption(
//             id: 'q3d',
//             text: '14',
//           ),
//         ],
//       ),
//     ];
//   }
// }