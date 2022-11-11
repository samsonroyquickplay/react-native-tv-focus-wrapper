import React, { ForwardedRef } from 'react';
import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
  StyleProp,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-tv-focus-wrapper' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

interface TvFocusWrapperProps {
  style?: StyleProp<ViewStyle>;
  children?: object;
  ref?: ForwardedRef<TvFocusWrapperProps>
}

const ComponentName = 'TvFocusWrapperView';

const TvFocusWrapperViewComponent =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<TvFocusWrapperProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

const TvFocusWrapperView = React.forwardRef((props: TvFocusWrapperProps, ref: ForwardedRef<TvFocusWrapperProps>) => {
  return <TvFocusWrapperViewComponent ref={ref} style={props.style}>{props.children}</TvFocusWrapperViewComponent>;
});

export default TvFocusWrapperView;
