import { ColorMask, Guide, guideController } from 'guide';
import { CustomGuideParams } from './CustomGuideParams';

@Builder
function builder(params: CustomGuideParams) {
  Column() {
    Text(`${params.count}`)
      .fontColor(Color.White)

    Image($r('sys.media.ohos_ic_public_close'))
      .size({
        width: 100,
        height: 100
      })
      .onClick(() => {
        guideController.dismiss();
      })
  }
  .justifyContent(FlexAlign.Center)
  .height('100%')
  .width('100%')
  .onClick(() => {
    params.count++;
    guideController.rebuild();
  })
}

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';
  private params: CustomGuideParams = new CustomGuideParams();

  aboutToAppear(): void {

  }

  build() {
    Stack() {
      Guide() {
        RelativeContainer() {
          Text(this.message)
            .id('HelloWorld')
            .fontSize($r('app.float.page_text_font_size'))
            .fontWeight(FontWeight.Bold)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
            .onClick(() => {
              this.message = 'Welcome';
              guideController.setMask(new ColorMask())
                .setGuideBuilder(wrapBuilder(builder))
                .setGuideBuilderParams(this.params)
                .show();
            })
        }
        .height('100%')
        .width('100%')

        Column(){}
        .height('100%')
        .width('100%')
      }
    }
  }
}