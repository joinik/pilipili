export interface WatchedShowOb {
  switch:boolean
  num:number
  text_small:string
  text_large:string
  icon:string
  icon_location:number
  icon_web:string
}
export interface VerifyOb {
  role:string;
  type: number;
  desc: string;
}
export interface HeadBoxOb {
  name:string
  value:string
  desc:string
}
export interface LiveItemModel {
  roomid: number;
  uid: number;
  title:string;
  uname:string;
  online:number;
  user_cover:string;
  user_cover_flag:number;
  system_cover: string;
  cover:string;
  link:string;
  face:string;
  parent_id:number;
  parent_name:string;
  area_id:number;
  area_name:string;
  area_v2_parent_id:number,
  area_v2_parent_name: string;
  area_v2_id:string;
  area_v2_name: string;
  session_id:string;
  group_id:number;
  pk_id:number;
  show_callback:string;
  click_callback:string;
  web_pendent:string;
  pendant_info: Object;
  verify: VerifyOb;
  head_box: HeadBoxOb |null;
  head_box_type: number;
  is_auto_play:number;
  flag:number;
  watched_show: WatchedShowOb;
  is_nft: number;
  nft_dmark: string;
  play_together_goods: null,
  watermark: string
}