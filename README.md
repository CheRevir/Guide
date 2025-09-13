# Guide
鸿蒙Next引导组件

# 下载安装

```javascript
ohpm install guide
```

### oh-package.json5

```javascript
"dependencies": {
    "guide": "^1.0.1"
  }
```

# 使用示例

在合适的位置添加Guide组件。注引导只会在Guide组件的范围内，推荐放到页面靠近根组件的位置。

```javascript
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
      }
    }
  }
```

## 引导内容

全局自定义@Builder函数WrappedBuilder，可通过实现GuideParams接口并传递参数。

```javascript
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
```

修改参数后通过rebuild方法来触发引导内容刷新

## GuideController

默认guideController为静态对象，可以根据需求自己创建并传入Guide({controller:})

|**方法**          | 参数              | 功能                      |
|-----------------|-----------------|-------------------------|
|setMask          | MaskRender子类    | 设置引导的蒙版                 |
|setGuideBuilder  | WrappedBuilder  | 设置引导内容全局自定义@Builder函数   |
|setGuideBuilderParams| GuideParams子类 | 设置引导内容全局自定义@Builder函数参数 |
|setMaskSize| Size            | 设置蒙版大小                  |
|show|                 | 显示引导                    |
|dismiss|                 | 隐藏引导                    |
|rebuild|                 | 重绘                      |
|state|          GuideState       | 引导状态                    |

# 蒙版

内置单一颜色蒙版ColorMask和区域透明蒙版TranAreaMask，默认颜色rgba(0x00,0x00,0x00,0x99)。
可通过继承MaskRender并重写drawMask方法来自定义蒙版

```javascript
export class ColorMask extends MaskRender {
  /**
   * 蒙版颜色
   */
  private color: common2D.Color;

  /**
   * @param color 蒙版颜色
   */
  constructor(color: common2D.Color = {
    red: 0x00,
    green: 0x00,
    blue: 0x00,
    alpha: 0x99
  }) {
    super();
    this.color = color;
  }

  drawMask(context: DrawContext): void {
    const canvas = context.canvas;
    canvas.drawColor(this.color);
  }
}
```