abstract class GetAll<T> {
  Future<List<T>> getAll();
}

abstract class GetAllWithPagination<T> {
  Future<T> getAll(int page, int pageSize);
}
