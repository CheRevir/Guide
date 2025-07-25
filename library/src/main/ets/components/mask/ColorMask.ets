import { MaskRender } from './MaskRender';
import { DrawContext } from '@ohos.arkui.node';
import { common2D } from '@kit.ArkGraphics2D';

/**
 * 颜色蒙版
 */
export class ColorMask extends MaskRender {
  /**
   * 蒙版颜色
   */
  private color: common2D.Color;

  /**
   * @param color 蒙版颜色，默认rgba(0x00,0x00,0x00,0x99)
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