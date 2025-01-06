
import {HttpString} from './Constants'

export default class Api {
  // 推荐视频
  static readonly recommendListApp = `${HttpString.appBaseUrl}/x/v2/feed/index`;
  static readonly recommendListWeb = '/x/web-interface/index/top/feed/rcmd';

  // 热门视频
  static readonly hotList = '/x/web-interface/popular';

  // 视频流
  static readonly videoUrl = '/x/player/wbi/playurl';

  // 视频详情
  static readonly videoIntro = '/x/web-interface/view';

  // 点赞
  static readonly likeVideo = '/x/web-interface/archive/like';

  // 判断视频是否被点赞
  static readonly hasLikeVideo = '/x/web-interface/archive/has/like';

  // 投币视频
  static readonly coinVideo = '/x/web-interface/coin/add';

  // 判断视频是否被投币
  static readonly hasCoinVideo = '/x/web-interface/archive/coins';

  // 收藏视频
  static readonly favVideo = '/x/v3/fav/resource/deal';

  // 判断视频是否被收藏
  static readonly hasFavVideo = '/x/v2/fav/video/favoured';

  // 一键三连
  static readonly oneThree = '/x/web-interface/archive/like/triple';

  // 获取指定用户创建的所有收藏夹信息
  static readonly videoInFolder = '/x/v3/fav/folder/created/list-all';

  // 视频详情页 相关视频
  static readonly relatedList = '/x/web-interface/archive/related';

  // 查询用户与自己关系_仅查关注
  static readonly hasFollow = '/x/relation';

  // 操作用户关系
  static readonly relationMod = '/x/relation/modify';

  // 评论列表
  static readonly replyList = '/x/v2/reply';

  // 楼中楼
  static readonly replyReplyList = '/x/v2/reply/reply';

  // 评论点赞
  static readonly likeReply = '/x/v2/reply/action';

  // 发表评论
  static readonly replyAdd = '/x/v2/reply/add';

  // 用户(被)关注数、投稿数
  static readonly userStat = '/x/relation/stat';

  // 获取用户信息
  static readonly userInfo = '/x/web-interface/nav';

  // 获取当前用户状态
  static readonly userStatOwner = '/x/web-interface/nav/stat';

  // 收藏夹
  static readonly userFavFolder = '/x/v3/fav/folder/created/list';

  // 收藏夹 详情
  static readonly userFavFolderDetail = '/x/v3/fav/resource/list';

  // 正在直播的up & 关注的up
  static readonly followUp = '/x/polymer/web-dynamic/v1/portal';

  // 关注的up动态
  static readonly followDynamic = '/x/polymer/web-dynamic/v1/feed/all';

  // 动态点赞
  static readonly likeDynamic = `${HttpString.tUrl}/dynamic_like/v1/dynamic_like/thumb`;

  // 获取稍后再看
  static readonly seeYouLater = '/x/v2/history/toview';

  // 获取历史记录
  static readonly historyList = '/x/web-interface/history/cursor';

  // 暂停历史记录
  static readonly pauseHistory = '/x/v2/history/shadow/set';

  // 查询历史记录暂停状态
  static readonly historyStatus = '/x/v2/history/shadow?jsonp=jsonp';

  // 清空历史记录
  static readonly clearHistory = '/x/v2/history/clear';

  // 删除某条历史记录
  static readonly delHistory = '/x/v2/history/delete';

  // 搜索历史记录
  static readonly searchHistory = '/x/web-goblin/history/search';

  // 热搜
  static readonly hotSearchList = 'https://s.search.bilibili.com/main/hotword';

  // 默认搜索词
  static readonly searchDefault = '/x/web-interface/wbi/search/default';

  // 搜索关键词
  static readonly searchSuggest = 'https://s.search.bilibili.com/main/suggest';

  // 分类搜索
  static readonly searchByType = '/x/web-interface/wbi/search/type';

  // 记录视频播放进度
  static readonly heartBeat = '/x/click-interface/web/heartbeat';

  // 查询视频分P列表 (avid/bvid转cid)
  static readonly ab2c = '/x/player/pagelist';

  // 番剧/剧集明细
  static readonly bangumiInfo = '/pgc/view/web/season';

  // 全部关注的up
  static readonly followings = '/x/relation/followings';

  // 指定分类的关注
  static readonly tagFollowings = '/x/relation/tag';

  // 关注分类
  static readonly followingsClass = '/x/relation/tags';

  // 搜索follow
  static readonly followSearch = '/x/relation/followings/search';

  // 粉丝
  static readonly fans = '/x/relation/fans';

  // 直播
  static readonly liveList = `${HttpString.liveBaseUrl}/xlive/web-interface/v1/second/getUserRecommend`;

  // 直播间详情
  static readonly liveRoomInfo = `${HttpString.liveBaseUrl}/xlive/web-room/v2/index/getRoomPlayInfo`;

  // 直播间详情 H5
  static readonly liveRoomInfoH5 = `${HttpString.liveBaseUrl}/xlive/web-room/v1/index/getH5InfoByRoom`;

  // 用户信息 需要Wbi签名
  static readonly memberInfo = '/x/space/wbi/acc/info';

  // 用户名片信息
  static readonly memberCardInfo = '/x/web-interface/card';

  // 用户投稿
  static readonly memberArchive = '/x/space/wbi/arc/search';

  // 用户动态搜索
  static readonly memberDynamicSearch = '/x/space/dynamic/search';

  // 用户动态
  static readonly memberDynamic = '/x/polymer/web-dynamic/v1/feed/space';

  // 稍后再看
  static readonly toViewLater = '/x/v2/history/toview/add';

  // 移除已观看
  static readonly toViewDel = '/x/v2/history/toview/del';

  // 清空稍后再看
  static readonly toViewClear = '/x/v2/history/toview/clear';

  // 追番
  static readonly bangumiAdd = '/pgc/web/follow/add';

  // 取消追番
  static readonly bangumiDel = '/pgc/web/follow/del';

  // 番剧列表
  // https://api.bilibili.com/pgc/season/index/result?
  // st=1&
  // order=3
  // season_version=-1  全部-1 正片1 电影2 其他3
  // spoken_language_type=-1  全部-1 原生1 中文配音2
  // area=-1&
  // is_finish=-1&
  // copyright=-1&
  // season_status=-1&
  // season_month=-1&
  // year=-1&
  // style_id=-1&
  // sort=0&
  // page=1&
  // season_type=1&
  // pagesize=20&
  // type=1

  static readonly bangumiList = '/pgc/season/index/result';
  // static readonly bangumiList = '/pgc/season/index/result?st=1&order=3&season_version=-1&spoken_language_type=-1&area=-1&is_finish=-1&copyright=-1&season_status=-1&season_month=-1&year=-1&style_id=-1&sort=0&season_type=1&pagesize=20&type=1';

  // 我的订阅
  static readonly bangumiFollow = '/x/space/bangumi/follow/list?type=1&follow_status=0&pn=1&ps=15&ts=1691544359969';

  // 黑名单
  static readonly blackLst = '/x/relation/blacks';

  // 移除黑名单
  static readonly removeBlack = '/x/relation/modify';

  // github 获取最新版
  static readonly latestApp = 'https://api.github.com/repos/guozhigq/pilipala/releases/latest';

  // 多少人在看
  static readonly onlineTotal = '/x/player/online/total';

  static readonly webDanmaku = '/x/v2/dm/web/seg.so';

  // 发送视频弹幕
  static readonly shootDanmaku = '/x/v2/dm/post';

  // up主分组
  static readonly followUpTag = '/x/relation/tags';

  // 设置Up主分组
  static readonly addUsers = '/x/relation/tags/addUsers';

  // 获取指定分组下的up
  static readonly followUpGroup = '/x/relation/tag';

  // 私聊
  static readonly sessionList = `${HttpString.tUrl}/session_svr/v1/session_svr/get_sessions`;

  // 私聊用户信息
  static readonly sessionAccountList = `${HttpString.tUrl}/account/v1/user/cards`;

  // 私聊消息
  static readonly sessionMsg = `${HttpString.tUrl}/svr_sync/v1/svr_sync/fetch_session_msgs`;

  // 标记已读
  static readonly updateAck = `${HttpString.tUrl}/session_svr/v1/session_svr/update_ack`;

  // 获取某个动态详情
  static readonly dynamicDetail = '/x/polymer/web-dynamic/v1/detail';

  // AI总结
  static readonly aiConclusion = '/x/web-interface/view/conclusion/get';

  // captcha验证码
  static readonly getCaptcha = `${HttpString.passBaseUrl}/x/passport-login/captcha?source=main_web`;

  // web端短信验证码
  static readonly webSmsCode = `${HttpString.passBaseUrl}/x/passport-login/web/sms/send`;

  // web端验证码登录
  static readonly webSmsLogin = `${HttpString.passBaseUrl}/x/passport-login/web/login/sms`;

  // web端密码登录
  static readonly loginInByWebPwd = `${HttpString.passBaseUrl}/x/passport-login/web/login`;

  // web端二维码
  static readonly qrCodeApi = `${HttpString.passBaseUrl}/x/passport-login/web/qrcode/generate`;

  // 扫码登录
  static readonly loginInByQrcode = `${HttpString.passBaseUrl}/x/passport-login/web/qrcode/poll`;

  // app端短信验证码
  static readonly appSmsCode = `${HttpString.passBaseUrl}/x/passport-login/sms/send`;

  // app端密码登录
  static readonly loginInByPwdApi = `${HttpString.passBaseUrl}/x/passport-login/oauth2/login`;

  // 密码加密密钥
  static readonly getWebKey = `${HttpString.passBaseUrl}/x/passport-login/web/key`;

  // cookie转access_key
  static readonly cookieToKey = `${HttpString.passBaseUrl}/x/passport-tv-login/h5/qrcode/confirm`;

  // 申请二维码(TV端)
  static readonly getTVCode = 'https://passport.snm0516.aisee.tv/x/passport-tv-login/qrcode/auth_code';

  // 扫码登录（TV端）
  static readonly qrcodePoll = `${HttpString.passBaseUrl}/x/passport-tv-login/qrcode/poll`;

  // 置顶视频
  static readonly getTopVideoApi = '/x/space/top/arc';

  // 主页 - 最近投币的视频
  static readonly getRecentCoinVideoApi = '/x/space/coin/video';

  // 最近点赞的视频
  static readonly getRecentLikeVideoApi = '/x/space/like/video';

  // 最近追番
  static readonly getRecentBangumiApi = '/x/space/bangumi/follow/list';

  // 用户专栏
  static readonly getMemberSeasonsApi = '/x/polymer/web-space/home/seasons_series';

  // 获赞数 播放数
  static readonly getMemberViewApi = '/x/space/upstat';

  // 查询某个专栏
  static readonly getSeasonDetailApi = '/x/polymer/web-space/seasons_archives_list';

  // 获取未读动态数
  static readonly getUnreadDynamic = '/x/web-interface/dynamic/entrance';

  // 用户动态主页
  static readonly dynamicSpmPrefix = 'https://space.bilibili.com/1/dynamic';

  // 激活buvid3
  static readonly activateBuvidApi = '/x/internal/gaia-gateway/ExClimbWuzhi';

  // 获取字幕配置
  static readonly getSubtitleConfig = '/x/player/v2';

  // 我的订阅
  static readonly userSubFolder = '/x/v3/fav/folder/collected/list';

  // 我的订阅详情 type 21
  static readonly userSeasonList = '/x/space/fav/season/list';

  // 我的订阅详情 type 11
  static readonly userResourceList = '/x/v3/fav/resource/list';

  // 表情
  static readonly emojiList = '/x/emote/user/panel/web';

  // 已读标记
  static readonly ackSessionMsg = `${HttpString.tUrl}/session_svr/v1/session_svr/update_ack`;

  // 发送私信
  static readonly sendMsg = `${HttpString.tUrl}/web_im/v1/web_im/send_msg`;

  // 排行榜
  static readonly getRankApi = "/x/web-interface/ranking/v2";

  // 取消订阅
  static readonly cancelSub = '/x/v3/fav/season/unfav';

  // 动态转发
  static readonly dynamicForwardUrl = '/x/dynamic/feed/create/submit_check';

  // 创建动态
  static readonly dynamicCreate = '/x/dynamic/feed/create/dyn';

  // 删除收藏夹
  static readonly delFavFolder = '/x/v3/fav/folder/del';

  // 搜索结果计数
  static readonly searchCount = '/x/web-interface/wbi/search/all/v2';

  // 关闭会话
  static readonly removeSession = `${HttpString.tUrl}/session_svr/v1/session_svr/remove_session`;

  // 消息未读数
  static readonly unread = `${HttpString.tUrl}/x/im/web/msgfeed/unread`;

  // 回复我的
  static readonly messageReplyAPi = '/x/msgfeed/reply';

  // 收到的赞
  static readonly messageLikeAPi = '/x/msgfeed/like';
}

