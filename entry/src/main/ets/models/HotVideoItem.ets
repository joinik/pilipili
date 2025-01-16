import { OwnerObject, StatObject } from './RecVideoItem';

export interface dimension {
  width: number;
  height: number;
  rotate: number;
}
export interface rcmd_reason {
  content: string;
  corner_mark: number;
}
export interface HotVideoItem {
  aid: number;
  cid: number;
  bvid: string;
  video: number;
  tid:number ;
  tname: string;
  copyright: number;
  pic: string;
  title: string;
  pubdate: number;
  ctime: number;
  desc: string;
  state: number;
  duration: number;
  owner: OwnerObject;
  stat: StatObject;
  vDynamic: string;
  short_link_v2:string;
  dimension: dimension;
  first_frame: number;
  firstFrame: number;
  pub_location: string;
  season_type: number;
  is_ogv: boolean;
  rcmd_reason: rcmd_reason;
}