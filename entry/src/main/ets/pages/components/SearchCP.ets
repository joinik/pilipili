import { AppStorageV2, ComponentContent, PromptAction} from "@kit.ArkUI";
import { BusinessError } from "@kit.BasicServicesKit";
import { LoginPage } from "../pageLogin";
import { hilog } from "@kit.PerformanceAnalysisKit";


// 头像dialog
@Builder
function buildHeadDialog(closeDialog:Function) {
  Column({ space: 10 }) {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text('PILIPILI')
      Row({ space: 38 }) {
        // 深夜模式icon
        Image($r('app.media.moon')).width(16)

        // setting Icon
        Text($r('app.media.setting'))


      }

    }.width("100%")

    Column() {
      Image($r('app.media.noface'))
        .width(100)
        .borderRadius(50)
        .onClick(() => {
          closeDialog()
        })
      Row({ space: 5 }) {
        Text('点击头像登录')
        Image($r('app.media.lv0')).width(16)
      }

      Text('硬币')
    }

    Flex({ justifyContent: FlexAlign.SpaceAround }) {
      Column() {
        Text('-')
        Text('动态')
          .onClick(() => {
            closeDialog()
          })
      }

      Column() {
        Text('-')
        Text('关注')
      }

      Column() {
        Text('-')
        Text('粉丝')
      }
    }.width("100%")

  }
  .height("40%")
  .backgroundColor('#fff')
  .padding({ top: 20, right: 10, left: 10 })
}

@ComponentV2
export default struct SearchCP {

  // 子页面中获取全局的NavPathStack
  pathStack: NavPathStack =  AppStorageV2.connect(NavPathStack, 'navPathStack', ()=> new NavPathStack()) as NavPathStack

  /**
   * 关闭头部弹窗
   */
  closeHeadDialog: Function = () => {
    // 跳转到login页面
    this.pathStack.pushPath({name:'pageLogin'})
    this.promptAction.closeCustomDialog(this.contentNode).then(() => {
      console.info('CloseCustomDialog complete.');
      if (this.contentNode !== null) {
        // this.contentNode.dispose();   // 释放contentNode
      }
    });
  }
  private ctx: UIContext = this.getUIContext();
  promptAction: PromptAction = this.getUIContext().getPromptAction()
  @Local contentNode: ComponentContent<Function> = new ComponentContent(this.ctx, wrapBuilder(buildHeadDialog), this.closeHeadDialog);

  aboutToAppear(): void {

  }

  build() {
    // NavDestination() {
      Row({ space: 5 }) {
        Row() {
          Text('󰀩').width(20).fontWeight(FontWeight.Bold)
          TextInput({ placeholder: "meta70怎么样" })
            .backgroundColor("#e9f4e9")
            .placeholderFont({ size: 12 })
            .layoutWeight(1)
        }
        .backgroundColor("#e9f4e9")
        .width("90%")
        .height(40)
        .borderRadius("50%")
        .padding({ left: 20, right: 20 })

        // 用户头像
        Image($r("app.media.head")).width(30)
          .onClick(() => {
            hilog.info(0xff00, "LoginPage", "onClick")
            try {
              if (this.contentNode == null){
                hilog.info(0xff00, "LoginPage", "contentNode Null")
                this.contentNode = new ComponentContent(this.ctx, wrapBuilder(buildHeadDialog), this.closeHeadDialog);
              }
              this.promptAction.openCustomDialog(this.contentNode, { offset: { dx: 0, dy: 260 }});
            } catch (error) {
              let message = (error as BusinessError).message;
              let code = (error as BusinessError).code;
              console.error(`OpenCustomDialog args error code is ${code}, message is ${message}`);
            };
          })
      }.width("100%")
    // }
  }
}