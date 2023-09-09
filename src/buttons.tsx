import React from 'react';
import { ColorValue, Pressable, StyleSheet } from "react-native"
import { colors } from "./tokens"

type ButtonStyle = {
    backgroundColor?: ColorValue,
    borderRadius?: number,
}


interface ButtonProps{
    style?: ButtonStyle,
    children: string | JSX.Element | JSX.Element[],
    onPress?: () => void,
}

export const DefaultButton = ({style, children, onPress} : ButtonProps) => {
    return <Pressable style={{
        ...styles.button,
        backgroundColor: style?.backgroundColor ?? styles.button.backgroundColor,
    }} onPress={onPress}>
        {children}
    </Pressable>
}

const styles = StyleSheet.create({
    button: {
        backgroundColor: colors.neutralDarkDarker,
        padding: 12,
        borderRadius: 8,
    },
})