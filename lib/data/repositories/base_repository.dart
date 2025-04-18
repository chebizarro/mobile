abstract class BaseRepository<T> {
  /// Insert or update an item in the store.
  Future<void> putItem(String id, T item);

  /// Retrieve an item by [id].
  Future<T?> getItem(String id);

  /// Check if an item exists in the data store by [id].
  Future<bool> hasItem(String id);

  /// Return all items in the store.
  Future<List<T>> getAllItems();

  /// Delete an item by [id].
  Future<void> deleteItem(String id);
}
