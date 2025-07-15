import { AppStorageV2, ComponentContent, PromptAction, promptAction } from '@kit.ArkUI'
import { VideoResponse } from './services/Home';
import { LoginHttp } from './services/Login'
import { BusinessError } from '@kit.BasicServicesKit';

interface QRCodeDialogData {
  url: string;
  closeDialog: Function;
}

// 二维码弹窗
@Builder
function buildQRCodeDialog(dialogData: QRCodeDialogData) {
  Column({ space: 10 }) {
    Row() {
      Text('扫码登录').fontSize(20).fontColor('#000')
      Image($r('app.media.arrow_left'))
        .width(18)

    }
    QRCode(dialogData.url)
      .width(200)
      .height(200)
      .padding(10)
      .margin({bottom:20})

    Row({space:20}){
      Text('有效期：111S')
      Text('刷新二维码')
        .fontColor(Color.Blue)
    }
    .justifyContent(FlexAlign.End)
  }
  .border({radius:20})
  .backgroundColor('#e9e9f3')
  .padding({ top: 30, bottom: 30, left: 10, right: 10})
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)

}

@Builder
export function LoginPageBuilder() {
  LoginPage()
}


@ComponentV2
export struct LoginPage {
  // 子页面中获取全局的NavPathStack
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navPathStack', () => new NavPathStack()) as NavPathStack
  @Local iphone: string = ''
  @Local pwd: string = ''
  @Local PwdFlag: boolean = false
  private ctx: UIContext = this.getUIContext();
  private promptAction: PromptAction = this.getUIContext().getPromptAction()
  contentNode: ComponentContent<QRCodeDialogData> | null = null;
  /**
   * 关闭头部弹窗
   */
  closeDialog: Function = () => {
    // 跳转到login页面
    this.promptAction.closeCustomDialog(this.contentNode).then(() => {
      console.info('CloseCustomDialog complete.');
      if (this.contentNode !== null) {
        this.contentNode.dispose(); // 释放contentNode
      }
    });
  }

  // 自定义LoginTitleBuilber
  @Builder
  loginTitleBuilder() {


  }

  build() {
    NavDestination() {
      Column({ space: 8 }) {

        // 导航栏
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {

          // 返回按钮
          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.arrow_left'))
              .width(24)
              .height(24)
          }
          .backgroundColor('#fff')
          .onClick(() => {
            this.pathStack.pop()
          })

          // web登录， 二维码
          Row({ space: 14 }) {
            Image($r('app.media.worldclock'))
              .width(24)
            Image($r('app.media.qrcode'))
              .width(24)
              .onClick(() => {
                LoginHttp.loginByQr().then((res) => {

                  let qrCodeData: QRCodeDialogData = {
                    url: res!.data!.url,
                    closeDialog: this.closeDialog
                  };

                  this.contentNode = new ComponentContent(this.ctx, wrapBuilder(buildQRCodeDialog), qrCodeData)
                  try {
                    this.promptAction.openCustomDialog(this.contentNode, { offset: { dx: 0, dy: 0 } });
                  } catch (error) {
                    let err = error as BusinessError;
                    let message = err.message;
                    let code = err.code;
                    console.error(`OpenCustomDialog args error code is ${code}, message is ${message}`);
                  }
                  ;


                })


              })
          }
        }


        if (this.PwdFlag) {
          Text('密码登录')
            .fontSize(32)
          Row() {
            Text('请使用您的BiliBili密码登录')
              .margin({ bottom: 20 })
            Text('x')
          }

          TextInput({ text: this.pwd!!, placeholder: '输入密码', })
            .type(InputType.Password)
            .caretColor('#495d92')
            .maxLength(11)

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Button('上一步')
              .onClick(() => {
                this.PwdFlag = false
              })
            // .offset({ x: 220, y: 590 })
            Button('确认登录')
              .onClick(() => {
                LoginHttp.loginInByWebPwd(Number(this.iphone), this.pwd)
                console.log('确认登录')
              })

          } //TODO 媒体查询作屏幕适配
          .margin({ top: 490, bottom: 20 })

        } else {

          Text('登录')
            .fontSize(32)
          Text('请使用您的BiliBili账号登录')
            .margin({ bottom: 20 })
          TextInput({ text: this.iphone!!, placeholder: '输入手机号码', })
            .type(InputType.Number)
            .caretColor('#495d92')
            .maxLength(11)
            .inputFilter('[0-9]', e => {
              promptAction.showToast({ message: '请输入数字' });
            })
            .onSubmit((enterKey: EnterKeyType, event: SubmitEvent) => {
              // 用户名不正确会清空输入框和手机号并提示错误文本
              const urlRegex = /^1[3-9]\d{9}$/
              console.log('手机号格式校验', this.iphone)
              if (urlRegex.test(this.iphone)) {
                console.log('手机号格式正确')
              } else {
                this.iphone = ''
                promptAction.showToast({ message: '手机号输入错误' })
                // 调用keepEditableState方法，输入框保持编辑态
                event.keepEditableState()
              }
            })
            .onChange((value) => {
              this.iphone = value
            })

          Button('下一步').onClick(() => {
            const urlRegex = /^1[3-9]\d{9}$/
            if (urlRegex.test(this.iphone)) {
              console.log('手机号格式正确')
              this.PwdFlag = true
            } else {
              console.log('手机号格式不正确')
              this.iphone = ''
            }
          }) // todo 媒体查询 作屏幕适配
            .offset({ x: 290, y: 490 })
        }
      }
      .padding(10)
      .height('100%')
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .hideTitleBar(true)
    .menus(this.loginTitleBuilder())

    // .title({builder:this.loginTitleBuilder(), height: 50})
  }
}