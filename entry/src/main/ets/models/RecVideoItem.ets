interface GeneratedTypeLiteralInterface_1 {
  mid: number;
  name: string;
  face: string;
}

interface StatObject {
  view: number,
  like: number,
  danmaku: number,
  vt: number
}

export interface RecVideoItemModel {
  id: number,
  bvid: string,
  cid: number,
  goto: string,
  uri: string,
  pic: string,
  pic_4_3: string,
  title: string,
  duration: number,
  pubdate: number,
  owner: GeneratedTypeLiteralInterface_1,
  stat: StatObject,
  is_followed: number,
  rcmd_reason: object | null,
  av_feature: object | null,
  show_info: number,
  track_id: string,
  pos: number,
  room_info: null,
  ogv_info: null,
  business_info: null,
  is_stock: number,
  enable_vt: number,
  vt_display: number | string,
  dislike_switch: number,
  dislike_switch_pc: number,
}