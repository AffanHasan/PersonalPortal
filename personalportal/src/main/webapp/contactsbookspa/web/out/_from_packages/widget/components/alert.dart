// Auto-generated from alert.html.
// DO NOT EDIT.

library x_alert;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'dart:async';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:bot/bot.dart';
import 'package:widget/effects.dart';
import 'package:widget/widget.dart';



/**
 * [Alert] follows the same convention as [its inspiration](http://twitter.github.com/bootstrap/javascript.html#alerts) in Bootstrap.
 *
 * Clicking on a nested element with the attribute `data-dismiss='alert'` will cause [Alert] to close.
 */
class Alert extends WebComponent implements ShowHideComponent {
  /** Autogenerated from the template. */

  /** CSS class constants. */
  static Map<String, String> _css = {};

  /** This field is deprecated, use getShadowRoot instead. */
  get _root => getShadowRoot("x-alert");
  static final __shadowTemplate = new autogenerated.DocumentFragment.html('''
        <div class="alert">
          <content></content>
        </div>
      ''');
  autogenerated.Template __t;

  void created_autogenerated() {
    var __root = createShadowRoot("x-alert");
    __t = new autogenerated.Template(__root);
    __root.nodes.add(__shadowTemplate.clone(true));
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = null;
  }

  /** Original code from the component. */


  bool _isShown = true;

  bool get isShown => _isShown;

  void set isShown(bool value) {
    assert(value != null);
    if(value != _isShown) {
      _isShown = value;
      final action = _isShown ? ShowHideAction.SHOW : ShowHideAction.HIDE;
      ShowHide.begin(action, this, effect: new ScaleEffect());

      ShowHideComponent.dispatchToggleEvent(this);
    }
  }

  Stream<Event> get onToggle => ShowHideComponent.toggleEvent.forTarget(this);

  void hide() {
    isShown = false;
  }

  void show() {
    isShown = true;
  }

  void toggle() {
    isShown = !isShown;
  }

  @protected
  void created() {
    this.onClick.listen(_onClick);
  }

  void _onClick(MouseEvent event) {
    if(!event.defaultPrevented) {
      final Element target = event.target as Element;
      if(target != null && target.dataset['dismiss'] == 'alert') {
        hide();
      }
    }
  }
}

//@ sourceMappingURL=alert.dart.map