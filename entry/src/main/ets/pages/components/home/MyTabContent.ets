import { RecVideoItemModel } from "../../../models/RecVideoItem";
import VideoHttp from "../../services/home";
import { promptAction } from '@kit.ArkUI';
import { RecVideoSource } from "./MyTabLazy";
import { OfflinePage } from "../OffLinePage";

@Reusable
@Component
export struct MyTabContent {
  @State isShow: boolean = false;
  private scroller: Scroller = new Scroller()
  @Prop flagIndex: number
  @State egLanes: LengthConstrain = { minLength: 150, maxLength: 300 }
  @State recVideos: RecVideoSource = new RecVideoSource()
  @State currentBp: string = 'unknown';
  @State isLoading: boolean = false
  @State isWaitingForLoading: boolean = true
  @State videoList: Array<RecVideoItemModel> = [
    {
      "id": 113599401955948,
      "bvid": "BV13YiRYiEMA",
      "cid": 27191413457,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV13YiRYiEMA",
      "pic": "http://i2.hdslb.com/bfs/archive/ad1eef4caabe115b97f58667e1359e187edfa963.jpg",
      "pic_4_3": "",
      "title": "这么矮的山，为啥不推平修路，钻隧道不是多余吗？【当当地理】",
      "duration": 105,
      "pubdate": 1733479500,
      "owner": {
        "mid": 1097068159,
        "name": "当当地理老师",
        "face": "https://i1.hdslb.com/bfs/face/c6021befdbab125681fe7f801cbe69c8ead84090.jpg"
      },
      "stat": {
        "view": 1228378,
        "like": 61571,
        "danmaku": 361,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 1,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113617034871313,
      "bvid": "BV1CFqsY6EAb",
      "cid": 27238927021,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1CFqsY6EAb",
      "pic": "http://i2.hdslb.com/bfs/archive/1e5af5a24dc57130d16435940c02f05b4014f6d7.jpg",
      "pic_4_3": "",
      "title": "久违的夜宵泡面局，馋这口很久了！",
      "duration": 330,
      "pubdate": 1733713200,
      "owner": {
        "mid": 1137066730,
        "name": "牢头养猪记",
        "face": "https://i1.hdslb.com/bfs/face/8207394e91568a754e498a440a9981013af8cee5.jpg"
      },
      "stat": {
        "view": 117783,
        "like": 7361,
        "danmaku": 544,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113593529928284,
      "bvid": "BV1r5imYvEr6",
      "cid": 27187743694,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1r5imYvEr6",
      "pic": "http://i2.hdslb.com/bfs/archive/49d132adc841dac44d7d201c274095c38bdff28f.jpg",
      "pic_4_3": "",
      "title": "半岛暗变，尹锡悦宣布解除戒严，那么谁能逃离青瓦台魔咒？",
      "duration": 600,
      "pubdate": 1733299928,
      "owner": {
        "mid": 289189019,
        "name": "戏京同志",
        "face": "https://i2.hdslb.com/bfs/face/2f62e073da940299514a06b0ff4d5dc00065c779.jpg"
      },
      "stat": {
        "view": 623601,
        "like": 24364,
        "danmaku": 996,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113592607181141,
      "bvid": "BV1w3zRYaEas",
      "cid": 27171163088,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1w3zRYaEas",
      "pic": "http://i0.hdslb.com/bfs/archive/1a5d37e4fc3a41421290838dc7668c6de87c48a8.jpg",
      "pic_4_3": "",
      "title": "南京站演出顺利结束！",
      "duration": 109,
      "pubdate": 1733285821,
      "owner": {
        "mid": 337312411,
        "name": "翠花不太脆",
        "face": "https://i1.hdslb.com/bfs/face/df1ed77ec248ef0242b7b8b915739e4199d889df.jpg"
      },
      "stat": {
        "view": 664693,
        "like": 17630,
        "danmaku": 43,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113592120639838,
      "bvid": "BV1PPzXYbEyo",
      "cid": 27160347131,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1PPzXYbEyo",
      "pic": "http://i1.hdslb.com/bfs/archive/e2982ee8da0c6c8e44e6c2d9fdc72d149b7293dd.jpg",
      "pic_4_3": "",
      "title": "爷爷花六百多网购的鸵鸟，竟然养死了！！",
      "duration": 258,
      "pubdate": 1733278335,
      "owner": {
        "mid": 454118230,
        "name": "开箱嘤嘤怪",
        "face": "https://i1.hdslb.com/bfs/face/984135ac47fa9f3efa0ec011e604a8c903d57fac.jpg"
      },
      "stat": {
        "view": 3275594,
        "like": 115439,
        "danmaku": 2287,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113598261172826,
      "bvid": "BV1Lci9YzENA",
      "cid": 25721576898,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1Lci9YzENA",
      "pic": "http://i0.hdslb.com/bfs/archive/4482b1d37e6c471951154ca1a177cc2249fc5609.jpg",
      "pic_4_3": "",
      "title": "【散人】悬疑推理 超可爱动物大冒险《水银疗养院》（已更新至P3）",
      "duration": 12165,
      "pubdate": 1733630400,
      "owner": {
        "mid": 168598,
        "name": "逍遥散人",
        "face": "https://i1.hdslb.com/bfs/face/8a5de2d7486251e80307d8600cbf8649eb4035fe.jpg"
      },
      "stat": {
        "view": 202899,
        "like": 14608,
        "danmaku": 2194,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113605257331982,
      "bvid": "BV1JNizY6EcT",
      "cid": 27208058477,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1JNizY6EcT",
      "pic": "http://i2.hdslb.com/bfs/archive/9738763b789d8abdde864daa724d946933fd2e5e.jpg",
      "pic_4_3": "",
      "title": "南 北 方 的 离 谱 差 异！",
      "duration": 153,
      "pubdate": 1733478794,
      "owner": {
        "mid": 321422126,
        "name": "进击的金厂长",
        "face": "https://i2.hdslb.com/bfs/face/b4a464a48c063c5703a6f560053093c4b36692f9.jpg"
      },
      "stat": {
        "view": 825495,
        "like": 38517,
        "danmaku": 2524,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113609099182645,
      "bvid": "BV1ruiCYpE5v",
      "cid": 27218150812,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1ruiCYpE5v",
      "pic": "http://i1.hdslb.com/bfs/archive/34c3306bd4fc4f31f4898e238830d589117bfb97.jpg",
      "pic_4_3": "",
      "title": "李子柒汉服造型被质疑不好好穿衣服？这身装扮有什么讲究？",
      "duration": 46,
      "pubdate": 1733537350,
      "owner": {
        "mid": 1967171436,
        "name": "小鱼传统文化服饰",
        "face": "https://i0.hdslb.com/bfs/face/385b9b5845fcd1055b482fd10e8c50095fa139bd.jpg"
      },
      "stat": {
        "view": 1446087,
        "like": 166192,
        "danmaku": 643,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113620692238594,
      "bvid": "BV1AZqcYCEvu",
      "cid": 27265600460,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1AZqcYCEvu",
      "pic": "http://i2.hdslb.com/bfs/archive/20a3cc06dba49c8217aa120f92f3e6e7c03e2249.jpg",
      "pic_4_3": "",
      "title": "13min带背肖四马原，全网最清晰逻辑！错过会哭！",
      "duration": 798,
      "pubdate": 1733714298,
      "owner": {
        "mid": 401800534,
        "name": "学长小谭",
        "face": "https://i1.hdslb.com/bfs/face/08b8acc3e729b72cbd88e17cf6800c3153022bed.jpg"
      },
      "stat": {
        "view": 64376,
        "like": 3790,
        "danmaku": 7,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113610844012958,
      "bvid": "BV1JUqVYMEcL",
      "cid": 27224116255,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1JUqVYMEcL",
      "pic": "http://i2.hdslb.com/bfs/archive/8267366729243c8b0d3e557f985c0496edebb94f.jpg",
      "pic_4_3": "",
      "title": "上海蛋糕挑战，50秒吃600克奶油蛋糕，奖500元券，能成功吗？",
      "duration": 357,
      "pubdate": 1733564156,
      "owner": {
        "mid": 8263502,
        "name": "橙飞一下",
        "face": "https://i2.hdslb.com/bfs/face/86fbb87fdf4d5ec1ba3bb7b56131d8265d36ffcd.jpg"
      },
      "stat": {
        "view": 707099,
        "like": 27264,
        "danmaku": 1715,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113606733598706,
      "bvid": "BV1nkizY5EEN",
      "cid": 27214546917,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1nkizY5EEN",
      "pic": "http://i2.hdslb.com/bfs/archive/83eab23dfe7d2905bdf0ea1a406b697835b12021.jpg",
      "pic_4_3": "",
      "title": "杨子麦琳是正缘的四大理由！我从没嗑过这么难嗑的糖！《再见爱人》高能解说",
      "duration": 970,
      "pubdate": 1733537400,
      "owner": {
        "mid": 203337614,
        "name": "开心嘴炮",
        "face": "https://i2.hdslb.com/bfs/face/5cd3053f352bc597bac3d11b824e548108423cb2.jpg"
      },
      "stat": {
        "view": 804796,
        "like": 33262,
        "danmaku": 4451,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113617169024484,
      "bvid": "BV1jGqsYaEWD",
      "cid": 27242399601,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1jGqsYaEWD",
      "pic": "http://i1.hdslb.com/bfs/archive/a0c822daddcf52ada863c98f63c35da4ad2d13b1.jpg",
      "pic_4_3": "",
      "title": "梦想卡壳时，我在LA撞见了现实版的《爱乐之城》！！",
      "duration": 271,
      "pubdate": 1733660780,
      "owner": {
        "mid": 624052719,
        "name": "切片计划",
        "face": "https://i0.hdslb.com/bfs/face/1e6e299a944f139da64a889126ece71fce9d499f.jpg"
      },
      "stat": {
        "view": 74961,
        "like": 11637,
        "danmaku": 84,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113605139826677,
      "bvid": "BV1AZiBYLEVs",
      "cid": 27207664614,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1AZiBYLEVs",
      "pic": "http://i2.hdslb.com/bfs/archive/f6d108e155e3df29261ac7f8cd77e75f2e64bbf7.jpg",
      "pic_4_3": "",
      "title": "《没一个是人》",
      "duration": 225,
      "pubdate": 1733477837,
      "owner": {
        "mid": 405370021,
        "name": "尴尬的铁根er",
        "face": "https://i1.hdslb.com/bfs/face/cbe228260be3e8d2b49cb2f8dde7a0a41bee1d93.jpg"
      },
      "stat": {
        "view": 2116711,
        "like": 79826,
        "danmaku": 875,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113612085594400,
      "bvid": "BV1wNqLYjEwL",
      "cid": 27229293948,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1wNqLYjEwL",
      "pic": "http://i1.hdslb.com/bfs/archive/592ca064b2b1fc0d250ba1fca684747debb7c95c.jpg",
      "pic_4_3": "",
      "title": "起诉我的世界，他们违反了法律并激怒了开发者",
      "duration": 380,
      "pubdate": 1733583172,
      "owner": {
        "mid": 686127,
        "name": "籽岷",
        "face": "https://i0.hdslb.com/bfs/face/7efb679569b2faeff38fa08f6f992fa1ada5e948.webp"
      },
      "stat": {
        "view": 646731,
        "like": 41038,
        "danmaku": 533,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113604116351149,
      "bvid": "BV1vMiqYfEVn",
      "cid": 27203470380,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1vMiqYfEVn",
      "pic": "http://i1.hdslb.com/bfs/archive/85db9a208afa1ed6be1de3c31538492069d440b5.jpg",
      "pic_4_3": "",
      "title": "TWICE最新回归曲Strategy MV公开",
      "duration": 231,
      "pubdate": 1733461693,
      "owner": {
        "mid": 16720403,
        "name": "pcyxjy",
        "face": "http://i2.hdslb.com/bfs/face/f4475f7a56a13d0553f471b0ae851fc14decb4d5.jpg"
      },
      "stat": {
        "view": 1077952,
        "like": 67899,
        "danmaku": 6194,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113616565045564,
      "bvid": "BV1sQqHYMEVH",
      "cid": 27239911233,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1sQqHYMEVH",
      "pic": "http://i1.hdslb.com/bfs/archive/08543f4b5d226329c7a0cd9078b76ddc63a61c89.jpg",
      "pic_4_3": "",
      "title": "“香港是天堂，就是空气脏了点”胜过《功夫》？《旺角黑夜》有啥过人之处？",
      "duration": 2869,
      "pubdate": 1733652026,
      "owner": {
        "mid": 354937645,
        "name": "乱乱解说刊",
        "face": "https://i1.hdslb.com/bfs/face/328f160d7e4d4b4a1b6facd5dc48ec4d0d0fee3c.jpg"
      },
      "stat": {
        "view": 145133,
        "like": 4156,
        "danmaku": 1058,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113601247511664,
      "bvid": "BV1BpifYfEGW",
      "cid": 27198491357,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1BpifYfEGW",
      "pic": "http://i2.hdslb.com/bfs/archive/2d2a406ed1127eb93037cf5cace071565236c39f.jpg",
      "pic_4_3": "",
      "title": "Starliner飞船送上去那俩人，被波音坑惨了！",
      "duration": 638,
      "pubdate": 1733473800,
      "owner": {
        "mid": 234924013,
        "name": "花臂猫猫",
        "face": "https://i1.hdslb.com/bfs/face/51106185014319a39b5ddc84adc6af06b1b28168.jpg"
      },
      "stat": {
        "view": 915531,
        "like": 29707,
        "danmaku": 5412,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113603998979288,
      "bvid": "BV13eieYLECy",
      "cid": 27202489406,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV13eieYLECy",
      "pic": "http://i2.hdslb.com/bfs/archive/d60cb12175faffd600d14d17cc35e6a3ccc502e9.jpg",
      "pic_4_3": "",
      "title": "他，七世纪地球最强碳基生物！",
      "duration": 4077,
      "pubdate": 1733459816,
      "owner": {
        "mid": 34840587,
        "name": "海棠家的大肥鱼",
        "face": "https://i0.hdslb.com/bfs/face/0bd329b6e129196fc64d31fc19122bf4c3fc9054.jpg"
      },
      "stat": {
        "view": 877183,
        "like": 32726,
        "danmaku": 3392,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113620860017238,
      "bvid": "BV1oVqwYaEPc",
      "cid": 27250918324,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1oVqwYaEPc",
      "pic": "http://i1.hdslb.com/bfs/archive/03bf19274b4d0880261f2486f0003981d4f564bc.jpg",
      "pic_4_3": "",
      "title": "别焦虑 听我说 | 龙王还值得抽吗？ | 为什么我说龙王的模组具有绝对性优势？ | 钟离已经不是必抽卡了？|『原神5.2下半 抽卡建议』",
      "duration": 1150,
      "pubdate": 1733716936,
      "owner": {
        "mid": 95931891,
        "name": "唔得比",
        "face": "https://i0.hdslb.com/bfs/face/1185d0e5145939887ff70d090c5ceb75e9a41a00.jpg"
      },
      "stat": {
        "view": 102502,
        "like": 3383,
        "danmaku": 747,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    },
    {
      "id": 113615273200123,
      "bvid": "BV1wYqnYaEmn",
      "cid": 27235648604,
      "goto": "av",
      "uri": "https://www.bilibili.com/video/BV1wYqnYaEmn",
      "pic": "http://i2.hdslb.com/bfs/archive/4d13a9e1312e9323556a2f7f5b98b6b8fa488290.jpg",
      "pic_4_3": "",
      "title": "在襄阳苍蝇馆子吃牛杂火锅，一大锅牛肠牛肚加牛排240元，炸小鱼酥牛肉卤藕片小龙虾配冰镇黄酒吃得舒坦",
      "duration": 387,
      "pubdate": 1733632151,
      "owner": {
        "mid": 1202350411,
        "name": "君在西安",
        "face": "https://i1.hdslb.com/bfs/face/75cb01b7d18e60ce43fbe34a2a7f948036200231.jpg"
      },
      "stat": {
        "view": 293947,
        "like": 14537,
        "danmaku": 504,
        "vt": 0
      },
      "av_feature": null,
      "is_followed": 0,
      "rcmd_reason": null,
      "show_info": 0,
      "track_id": "",
      "pos": 0,
      "room_info": null,
      "ogv_info": null,
      "business_info": null,
      "is_stock": 0,
      "enable_vt": 0,
      "vt_display": "",
      "dislike_switch": 0,
      "dislike_switch_pc": 0
    }
  ];

  // 生命周期函数
  aboutToAppear() {
    switch (this.flagIndex) {
      case 0:
        // 直播tab
        break
      case 1:
        // 推荐tab
        VideoHttp.getRcmdVideoList(20, 1).then(res => {
          this.recVideos.items = res
          console.log('MyTabContent--request')
        }).catch( () => {
          promptAction.showToast({ message: '请确保网络已连接' });
        })
        break
      case 2:
        // 热门tab
        break
      case 3:
        // 番剧tab
        break

    }
    setTimeout(() => {
      this.isWaitingForLoading = false
    }, 30000)
  }

  // aboutToReuse(params: Record<string, Object>): void {
  //   this.item = params.item as string;
  // }


  build() {
    Column() {
      if (this.recVideos.totalCount() == 0) {
        if (this.isWaitingForLoading) {
          LoadingProgress()
            .color(0xf04142)
            .width(70)
            .height(70)
            .margin({ top: 180 })
        } else {
          OfflinePage({ isShow: this.isShow })
        }
      } else {
        List({ space: 8, scroller: this.scroller }) {
          LazyForEach(this.recVideos, (item: RecVideoItemModel, index: number) => {
            ListItem() {
              Column({ space: 5 }) {
                Image(item.pic)
                  .height(100)// .width('100vp')
                  .borderRadius(8)
                Text(item.title)
                  .fontSize(14)
                  .maxLines(2)
                  .constraintSize({ maxWidth: 200 })
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ left: 10, right: 10 })
                Row() {
                  if (item.is_followed) {
                    Text('已关注')
                      .backgroundColor('#cef2d3')
                      .fontColor('#6fa881')
                      .fontSize(12)
                  }
                  Text(item.owner.name)
                    .fontColor('#ff9aa09b')
                    .fontSize(12)
                  // 三点设置按钮
                  Image($r("app.media.more"))
                    .width(13)
                    .height(16)
                }
                .padding({ left: 10, right: 10, bottom: 10 })
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .backgroundColor('#eff4ee')
              .borderRadius('8%')
              .borderWidth({ bottom: 2 })
              .borderColor({ bottom: '#dde0db' })
            }
          }, (item: string) => item)
        }
        // 设置列数，列间距
        .lanes(this.egLanes, 10)
        .scrollBar(BarState.Off)
        .cachedCount(20)
        .onScrollIndex(async (first: number, last: number) => {
          let total: number = this.recVideos.totalCount() - 2
          if (last > total) {
            try {
              const res = await VideoHttp.getRcmdVideoList(20, last)
              console.log('刷新列表数据------>')
              this.recVideos.addBatchData(res)
            } catch (e) {
              promptAction.showToast({ message: '请确保网络已连接' });
            }
          }
        })
      }
    }.height('100%')
  }
}