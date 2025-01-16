export interface OwnerObject {
  mid: number;
  name: string;
  face: string;
}

export interface StatObject {
  aid: number | null;
  view: number;
  like: number;
  danmaku: number;
  vt: number;
  reply: number | null;
  favorite: number | null;
  coin: number | null;
  share: number | null;
  now_rank: number | null;
  his_rank: number | null;
  dislike: number | null;
  vv: number;


}

export interface RcmdVideoItemModel {
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
  owner: OwnerObject | null,
  stat: StatObject | null,
  is_followed: number,
  rcmd_reason?: Object | null | undefined,
  av_feature: Object | null,
  show_info: number,
  track_id: string,
  pos: number,
  room_info: null | Object,
  ogv_info: null,
  business_info: null | Object,
  is_stock: number,
  enable_vt: number,
  vt_display: number | string,
  dislike_switch: number,
  dislike_switch_pc: number,
}