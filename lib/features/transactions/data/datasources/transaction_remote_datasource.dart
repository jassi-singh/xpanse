import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:xpanse/core/constants/constants.dart';

import 'package:xpanse/core/util/helpers.dart';

abstract class TransactionRemoteDataSource {
  /// Get the list of transactions for a given month and year.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<DocumentList> getTransactionsBetweenTwoDates(
      DateTime startDate, DateTime endDate, String userId);

  /// Add or update a transaction.
  /// If [documentId] is null, a new document will be created.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<Document> addOrUpdateTransaction(Map<String, dynamic> transaction,
      {String? documentId});

  /// Delete a transaction.
  ///
  /// Throws a [AppwriteException] for all error codes.
  Future<void> deleteTransaction(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Databases _databases;
  TransactionRemoteDataSourceImpl(this._databases);

  @override
  Future<DocumentList> getTransactionsBetweenTwoDates(
      DateTime startDate, DateTime endDate, String userId) async {
    return AppHelper.exceptionCatcher(
      _databases.listDocuments(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.appwriteTransactionCollectionId,
        queries: [
          Query.equal('userId', userId),
          Query.orderDesc('date'),
          Query.greaterThanEqual('date', startDate),
          Query.lessThanEqual('date', endDate),
        ],
      ),
    );
  }

  @override
  Future<Document> addOrUpdateTransaction(Map<String, dynamic> transaction,
      {String? documentId}) {
    if (documentId == null) {
      return AppHelper.exceptionCatcher(
        _databases.createDocument(
          databaseId: AppConstants.appwriteDatabaseId,
          collectionId: AppConstants.appwriteTransactionCollectionId,
          documentId: ID.unique(),
          data: transaction,
        ),
      );
    } else {
      return AppHelper.exceptionCatcher(
        _databases.updateDocument(
          databaseId: AppConstants.appwriteDatabaseId,
          collectionId: AppConstants.appwriteTransactionCollectionId,
          data: transaction,
          documentId: documentId,
        ),
      );
    }
  }

  @override
  Future<void> deleteTransaction(String id) {
    return AppHelper.exceptionCatcher(
      _databases.deleteDocument(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.appwriteTransactionCollectionId,
        documentId: id,
      ),
    );
  }
}
