import React, { ForwardedRef } from 'react';
import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
  StyleProp,
  NativeSyntheticEvent,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-tv-focus-wrapper' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type Event = NativeSyntheticEvent<
  Readonly<{
    value: number;
    /**
     * Android Only.
     */
    fromUser?: boolean;
  }>
>;
interface TvFocusWrapperProps {
  style?: StyleProp<ViewStyle>;
  children?: object;
  ref?: ForwardedRef<TvFocusWrapperProps>;
  scale?: string;
  onFocus?: (e: Event) => void;
  onBlur?: (e: Event) => void;
  onPress?: (e: Event) => void;
  focusable?: boolean;
  enableFocusStyle?: boolean;
}

const ComponentName = 'TvFocusWrapperView';

const TvFocusWrapperViewComponent =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<TvFocusWrapperProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

const TvFocusWrapperView = React.forwardRef(
  (props: TvFocusWrapperProps, ref: ForwardedRef<TvFocusWrapperProps>) => {
    return (
      <TvFocusWrapperViewComponent
        ref={ref}
        style={props.style}
        focusable={props.focusable ?? true}
        onFocus={props.onFocus}
        onBlur={props.onBlur}
        onPress={props.onPress}
        scale={props.scale ?? '1'}
        enableFocusStyle={props.enableFocusStyle ?? true}
      >
        {props.children}
      </TvFocusWrapperViewComponent>
    );
  }
);

export default TvFocusWrapperView;
