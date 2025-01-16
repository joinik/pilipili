import { promptAction, router } from '@kit.ArkUI'
import { LoginHttp } from './services/Login'

@Entry
@ComponentV2
export struct LoginPage {
  @Local iphone: string = ''
  @Local pwd: string = ''
  @Local PwdFlag: boolean = false

  build() {
    Scroll() {
      Column({ space: 8 }) {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          if (this.PwdFlag) {
            Text('󰃊').onClick(() => {
              router.back()
            })
          } else {
            Text($r('sys.symbol.xmark')).onClick(() => {
              router.back()
            })
          }
          Row({ space: 18 }) {
            Text($r('app.media.worldclock'))
              .fontSize(16)
              .width(16)
            Text($r('app.media.qrcode'))
              .fontSize(16)
              .width(16)
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
            .inputFilter('[0-9]', e => {
              promptAction.showToast({ message: '请输入数字' });
            })

          Button('上一步')
            .onClick((event: ClickEvent) => {
              this.PwdFlag = false
            })
            .offset({ x: 220, y: 590 })
          Button('确认登录')
            .onClick(() => {
              LoginHttp.loginInByMobPwd({ tel: this.iphone, password: this.pwd })
              console.log('确认登录')
            })

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

          Button('下一步').onClick((event: ClickEvent) => {
            const urlRegex = /^1[3-9]\d{9}$/
            if (urlRegex.test(this.iphone)) {
              console.log('手机号格式正确')
              this.PwdFlag = true
            } else {
              console.log('手机号格式不正确')
              this.iphone = ''
            }

          }).offset({ x: 280, y: 590 })
          // }

        }
      }
      .padding(10)
      .height('100%')
      .width('100%')
      .alignItems(HorizontalAlign.Start)

    }.height('100%')
    .width('100%')
  }
}