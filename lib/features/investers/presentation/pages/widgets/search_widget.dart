// import 'package:flutter/material.dart';

// import 'invester_card.dart';

// class InvestorSearchDelegate extends SearchDelegate<Investor?> {
//   final List<Investor> investors;

//   InvestorSearchDelegate({required this.investors});

//   @override
//   String get searchFieldLabel => 'Search investors';

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       if (query.isNotEmpty)
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () => query = '',
//         ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return BackButton(
//       onPressed: () => close(context, null),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = _filterInvestors(query);

//     if (results.isEmpty) {
//       return _buildNoResults();
//     }

//     return _buildResultList(results);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = _filterInvestors(query);

//     return _buildSuggestionList(suggestions);
//   }

//   List<Investor> _filterInvestors(String query) {
//     final lowerQuery = query.toLowerCase();
//     return investors.where((investor) {
//       return investor.name.toLowerCase().contains(lowerQuery) ||
//           investor.email.toLowerCase().contains(lowerQuery) ||
//           investor.phone.contains(query);
//     }).toList();
//   }

//   Widget _buildNoResults() {
//     return const Center(
//       child: Text('No investors found.'),
//     );
//   }

//   Widget _buildResultList(List<Investor> results) {
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final investor = results[index];
//         return ListTile(
//           title: Text(investor.name),
//           subtitle: Text(investor.email),
//           onTap: () => close(context, investor),
//         );
//       },
//     );
//   }

//   Widget _buildSuggestionList(List<Investor> suggestions) {
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final investor = suggestions[index];
//         return ListTile(
//           title: Text(investor.name),
//           subtitle: Text(investor.email),
//           onTap: () {
//             query = investor.name;
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
