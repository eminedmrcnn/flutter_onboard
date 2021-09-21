abstract class INavigationService {
  Future<void> navigatePage({String path, Object data});
  Future<void> navigatePageClear({String path, Object data});
}