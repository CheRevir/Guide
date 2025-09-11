import { common2D, drawing } from '@kit.ArkGraphics2D';
import { GuideArea } from './GuideArea';
import { MaskRender } from './MaskRender';

/**
 * 透明区域蒙版
 */
export class TranAreaMask extends MaskRender {
  /**
   * 蒙版颜色
   */
  private color: common2D.Color;
  /**
   * 透明的区域
   */
  private area: GuideArea

  /**
   * @param area 透明的区域
   * @param color 蒙版颜色，默认rgba(0x00,0x00,0x00,0x99)
   */
  constructor(area: GuideArea, color: common2D.Color = {
    red: 0x00,
    green: 0x00,
    blue: 0x00,
    alpha: 0x99
  }) {
    super();
    this.area = area;
    this.color = color;
  }

  drawMask(context: DrawContext): void {
    const canvas = context.canvas;
    if (this.area.hasCircle()) {
      const region = new drawing.Path();
      const width = this.area.getWidth();
      const height = this.area.getHeight();
      const x = this.area.getX();
      const y = this.area.getY();
      const length = width >= height ? width : height;
      region.addArc({
        left: x,
        right: x + length,
        top: y,
        bottom: y + length
      }, 0, 360);
      region.close();
      canvas.clipPath(region, drawing.ClipOp.DIFFERENCE);
    } else {
      const region = new drawing.Path();
      region.addRoundRect(new drawing.RoundRect({
        left: this.area.getXStart(),
        right: this.area.getXEnd(),
        top: this.area.getYStart(),
        bottom: this.area.getYEnd()
      }, this.area.getRectRadius(), this.area.getRectRadius()))
      region.close();
      canvas.clipPath(region, drawing.ClipOp.DIFFERENCE);
    }
    canvas.drawColor(this.color);
  }
}