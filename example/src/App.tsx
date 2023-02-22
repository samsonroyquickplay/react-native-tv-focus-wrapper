import * as React from 'react';
import 'react-native/tvos-types.d';
import { FlatList, StyleSheet, View, TVFocusGuideView } from 'react-native';
import TvFocusWrapperView from 'react-native-tv-focus-wrapper';

const ItemWrapper: React.FC<{
  setRef: React.Dispatch<React.SetStateAction<null>>;
  isLast: boolean;
}> = ({ setRef, isLast }) => {
  const onRef = React.useCallback(
    (ref) => {
      if (ref) {
        isLast && setRef(ref);
      }
    },
    [isLast, setRef]
  );
  return (
    <TvFocusWrapperView
      scale="1.3"
      ref={onRef}
      style={styles.boxContainer}
      borderStyle={styles.borderStyle}
    >
      <View style={styles.box} />
    </TvFocusWrapperView>
  );
};

const HorizontalCarousel: React.FC<{ index: number }> = ({ index }) => {
  const [lastItemRef, setLastItemRef] = React.useState(null);
  const dataLength = React.useMemo(() => {
    return index % 2 === 0 ? 20 : 3;
  }, [index]);
  const renderInnerItem = React.useCallback(
    ({ index }) => {
      const isLast = dataLength - 1 === index && dataLength !== 20;
      return <ItemWrapper isLast={isLast} setRef={setLastItemRef} />;
    },
    [setLastItemRef, dataLength]
  );

  return (
    <View style={[{ flex: 1, flexDirection: 'row' }, styles.vertical]}>
      <FlatList
        horizontal
        style={{ flexGrow: 0 }}
        data={Array.from({ length: dataLength })}
        renderItem={renderInnerItem}
      />
      <TVFocusGuideView
        destinations={[lastItemRef]}
        style={{ backgroundColor: 'green', flex: 1 }}
      />
    </View>
  );
};

export default function App() {
  const renderItem = ({ index }: { index: number }) => {
    return <HorizontalCarousel index={index} />;
  };

  return (
    <View style={styles.container}>
      <FlatList data={Array.from({ length: 11 })} renderItem={renderItem} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'black',
  },
  box: {
    width: 200,
    height: 200,
    backgroundColor: 'blue',
  },
  boxContainer: {
    marginHorizontal: 30,
    marginVertical: 30,
  },
  vertical: {
    marginVertical: 10,
    backgroundColor: 'red',
  },
  borderStyle: { borderWidth: 4, borderColor: '#98ffcc' },
});
