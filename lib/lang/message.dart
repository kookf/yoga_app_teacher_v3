import 'package:get/get.dart';

class I18nContent{

  ///底部item
  static const String bottomHomeLabel = '首頁';
  static const String bottomSubscribeLabel = '預約';
  static const String bottomMessageLabel = '通知';
  static const String bottomSettingLabel = '設定';
  static const String noRecords = '暫無信息';
  /// 登錄與註冊
  static const String appTitle = 'MeMo Yoga';
  static const String loginInLabel = '登入';
  static const String loginInSuccessLabel = '登錄成功';
  static const String versionLabel = '學生版';
  static const String emailLabel = '電郵';
  static const String passwordLabel= '密碼';
  static const String enterPasswordLabel = '密碼';
  static const String createNewAccLabel = '創建一個新賬戶';
  static const String studentRegisterLabel = '學生註冊';
  static const String userNameLabel = '用戶名稱';
  static const String userPhoneLabel = '用戶電話';
  static const String notUserLabel = '未有賬戶';
  static const String registerUserLabel = '註冊賬戶';
  static const String errorPleaseEnterTheEmailAddress = '請輸入正確的電郵地址';
  static const String errorEmailAddressNotEmpty = '電郵不能留空';
  static const String errorPassWordNotEmpty = '電郵不能留空';
  /// 首頁
  static const String contactUsLabel = '聯繫我們';
  static const String noticeTitleLabel = '最新公告';
  static const String noticeDetailTitleLabel = '公告';
  /// 預約
  static const String subscribeClassRoom = '預約課堂';
  static const String timeTableLabel = '時間表';
  static const String appointmentRecordLabel = '預約記錄';
  static const String purchaseHistoryLabel = '購買記錄';
  ///設置
  static const String myWalletLabel = '我的錢包';
  static const String sharedWalletLabel = '共享錢包';
  static const String changeAvatarLabel = '更換頭像';
  static const String changePasswordLabel = '密碼修改';
  static const String signOutLabel = '退出登錄';
  ///
  static const String addressLabel = '地址（選填）';
  static const String escLabel = '刪除賬號';

}



class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    //1-配置中文繁體
    'zh_CN':{
      // I18nContent.bottomBarHome:"首頁",
      // I18nContent.bottomBarTQuotation:"問題",
      // I18nContent.bottomBarChat:"聊天",
      // I18nContent.bottomBarFavourite:"喜愛",
      // I18nContent.bottomBarMine:"菜單",
      // I18nContent.chatTitle:'聊天',
      // I18nContent.searchChat:'搜索',
      // I18nContent.searchEdit:'編輯',
      // I18nContent.chatIndividual:'個人',
      // I18nContent.chatQuotation:'語錄',
    },
    //2-配置英文
    'en_US':{
      // I18nContent.bottomBarHome:"Home",
      // I18nContent.bottomBarTQuotation:"Quotation",
      // I18nContent.bottomBarChat:"Chat",
      // I18nContent.bottomBarFavourite:"Favourite",
      // I18nContent.bottomBarMine:"Me",
      // I18nContent.chatTitle:'Chat',
      // I18nContent.searchChat:'Search',
      // I18nContent.searchEdit:'Edit',
      // I18nContent.chatIndividual:'Individual',
      // I18nContent.chatQuotation:'Quotation',
    }
  };
}


