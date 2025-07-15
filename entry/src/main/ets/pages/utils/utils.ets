import { common } from "@kit.AbilityKit";
import { fileIo as fs } from "@kit.CoreFileKit";

export class UtilsPili {
  private static context:common.UIAbilityContext;

  static init(context:common.UIAbilityContext):void {
    UtilsPili.context = context
  }

  static getCookiePath():string{
    let cookiePath = UtilsPili.context.cacheDir + "/.pili/cookies.json"
    if (!fs.accessSync(cookiePath)) {
      fs.mkdirSync(cookiePath)
    }
    return cookiePath;
  }
}