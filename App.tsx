import { colors } from "./src/tokens";
import { DefaultButton } from "./src/buttons";
import { FontAwesome } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, SafeAreaView, ColorValue, View, Pressable} from 'react-native';
import { useState } from "react";

type Player = {
  name: string
}

type Team = {
  name: string,
  color: ColorValue,
  members: Player[]
}

type Score = {
  teamOne: number,
  teamTwo: number
}

type GameData = {
  name: string,
  teamOne: Team,
  teamTwo: Team,
  score: Score
}


export default function App() {
  const data : GameData = {
    name: "Jogo Normal",
    teamOne: {
      name: "Time 1",
      color: colors.green,
      members: [
        { name: "Arthur" },
        { name: "Vini" },
      ]
    },
    teamTwo: {
      name: "Time 2",
      color: colors.purple,
      members: [
        { name: "Marcelo" },
        { name: "Bruno" },
      ]
    },
    score: {
      teamOne: 0,
      teamTwo: 0
    }
  };


  const [gameData, setData] = useState<GameData>(data);


  function checkPointAvailable(team: 'teamOne' | 'teamTwo',points:number) : boolean {
    if (team == 'teamOne') {
      if (gameData.score.teamOne == 0 && points < 0) {
        return false;
      } else if (gameData.score.teamOne > 11 && points > 0) {
        return false;
      }
      return true;
    }

    if (gameData.score.teamTwo == 0 && points < 0) {
      return false;
    }else if (gameData.score.teamTwo > 11 && points > 0) {
      return false;
    }
    return true;
  }

  function changeScore(
    team: 'teamOne' | 'teamTwo',
    points: number
  ) {
    
    const canAddPoint = checkPointAvailable(team, points);
    if (!canAddPoint) {
      return;
    }

    let state = {
      ...gameData,
    }
  
    if (team == 'teamOne') {
      state.score.teamOne += points;
    } else {
      state.score.teamTwo += points;
    }

    setData(state);
  }

  

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.scoreContainer}>
        <View style={{
          ...styles.row,justifyContent: 'space-between',
        }}>
          <Pressable style={styles.backButton} onPress={() => { }}>
            <FontAwesome name="arrow-circle-left" size={24} color="white" />
          </Pressable>
          <Text style={styles.title}>
            {data.name}  
          </Text>
          <View style={{width:44}}></View>
        </View>
        <View style={{
          ...styles.row,
          marginTop: 16,
          justifyContent: "center"
        }}>
          <View style={{
            ...styles.square,
            backgroundColor: data.teamOne.color
          }} />
          <Text style={styles.scoreText}>
            {gameData.score.teamOne}X{data.score.teamTwo}
          </Text>
          <View style={{
            ...styles.square,
            backgroundColor: data.teamTwo.color
          }}/>
        </View>
      </View>


      <View>
        <View style={styles.row}>
          <DefaultButton
            style={{backgroundColor: colors.disable }}
            onPress={() => changeScore("teamOne", -1)}>
            <FontAwesome name="minus" size={14} color="black" />
          </DefaultButton>
          <Text style={{
            ...styles.counterText,
            color:data.teamOne.color
          }}>
            {gameData.score.teamOne}
          </Text>
          <DefaultButton
            style={{backgroundColor: colors.neutralLightLighter }}
            onPress={ () => changeScore("teamOne", 1)}>
            <FontAwesome name="plus" size={14} color="black" />
          </DefaultButton>
        </View>
      </View>
      

      
      <StatusBar style="light" />
    </SafeAreaView>
  );
}




const styles = StyleSheet.create({
  row: {
    display: 'flex',
    flexDirection: 'row',
    width: '100%',
    alignItems: "center",
  },
  backButton: {
    backgroundColor: colors.neutralDarkDarker,
    padding: 10,
    borderRadius: 4,
  },
  square: {
    height: 14,
    width: 14,
    borderRadius: 4,
  },
  container: {
    flex: 1,
    backgroundColor: colors.background,
    paddingVertical: 32,
    paddingHorizontal: 44,
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  scoreContainer: {
    backgroundColor: "#181818",
    width: "100%",
    padding: 12,
    borderRadius: 8,
  },
  scoreText: {
    fontSize: 24,
    fontWeight: "600",
    color: colors.neutralLightLighter,
    marginHorizontal: 8,
  },
  title: {
    fontSize: 16,
    color: colors.neutralLightLighter,
    textAlign: "center"
  },
  counterText: {
    fontSize: 96,
    fontWeight: "900",
    marginHorizontal: 48,
  }
});
