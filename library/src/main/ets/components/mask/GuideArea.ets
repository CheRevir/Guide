import { componentUtils } from '@kit.ArkUI';

/**
 * 引导区域
 */
export class GuideArea {
  /**
   * 区域位置信息
   */
  private area: Area;
  /**
   * 内边距
   */
  private padding: Padding;
  /**
   * 矩形圆角
   */
  private rectRadius: number;
  /**
   * 是否圆形透明区域
   */
  private isCircle: boolean;

  constructor(area: Area | undefined, rectRadius: number = 0, padding: Padding = {
    top: 0,
    bottom: 0,
    left: 0,
    right: 0
  },
    isCircle: boolean = false) {
    this.area = area ?? {
      width: 0,
      height: 0,
      position: { x: 0, y: 0 },
      globalPosition: { x: 0, y: 0 }
    };
    this.rectRadius = rectRadius;
    this.padding = padding;
    this.isCircle = isCircle;
  }

  static fromComponentInfo(info: componentUtils.ComponentInfo): GuideArea {
    const area: Area = {
      width: px2vp(info.size.width),
      height: px2vp(info.size.height),
      position: {
        x: px2vp(info.localOffset.x),
        y: px2vp(info.localOffset.y)
      },
      globalPosition: {
        x: px2vp(info.screenOffset.x),
        y: px2vp(info.screenOffset.y)
      }
    };
    return new GuideArea(area);
  }

  setPadding(top: number = 0, bottom: number = 0, left: number = 0, right: number = 0): GuideArea {
    this.padding = {
      top: top,
      bottom: bottom,
      left: left,
      right: right
    }
    return this;
  }

  /**
   * 设置是否圆形透明区域
   * @param value
   * @returns
   */
  setCircle(value: boolean): GuideArea {
    this.isCircle = value;
    return this;
  }

  hasCircle(): boolean {
    return this.isCircle;
  }

  getRectRadius(): number {
    return vp2px(this.rectRadius);
  }

  /**
   * 横坐标开始
   * @returns
   */
  getXStart(): number {
    return this.getX() - this.getLeftPadding();
  }

  /**
   * 横坐标结束
   * @returns
   */
  getXEnd(): number {
    return this.getXStart() + this.getWidth() + this.getLeftPadding() + this.getRightPadding();
  }

  /**
   * 纵坐标开始
   * @returns
   */
  getYStart(): number {
    return this.getY() - this.getTopPadding();
  }

  /**
   * 纵坐标结束
   * @returns
   */
  getYEnd(): number {
    return this.getYStart() + this.getHeight() + this.getTopPadding() + this.getBottomPadding();
  }

  /**
   * 获取区域相对屏幕x坐标
   * @returns
   */
  getX(): number {
    return vp2px(this.area.position.x as number);
  }

  /**
   * 获取区域相对屏幕y坐标
   * @returns
   */
  getY(): number {
    return vp2px(this.area.position.y as number);
  }

  /**
   * 获取区域高度
   * @returns
   */
  getHeight(): number {
    return vp2px(this.area.height as number);
  }

  /**
   * 获取区域宽度
   * @returns
   */
  getWidth(): number {
    return vp2px(this.area.width as number);
  }

  /**
   * 获取顶部内边距
   * @returns
   */
  getTopPadding(): number {
    return vp2px(this.padding.top as number);
  }

  /**
   * 获取底部内边距
   * @returns
   */
  getBottomPadding(): number {
    return vp2px(this.padding.bottom as number);
  }

  /**
   * 获取左边内边距
   * @returns
   */
  getLeftPadding(): number {
    return vp2px(this.padding.left as number);
  }

  /**
   * 获取右边内边距
   * @returns
   */
  getRightPadding(): number {
    return vp2px(this.padding.right as number);
  }
}