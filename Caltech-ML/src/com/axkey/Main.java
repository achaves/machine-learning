package com.axkey;

import java.util.Random;

public class Main {

    public static final int NUMBER_OF_ITERATIONS = 100000;
    public static final int NUMBER_OF_FLIPS = 10;
    public static final int NUMBER_OF_COINS = 1000;

    public static void main(String[] args) {
        double headTosses[] = new double[NUMBER_OF_COINS];

        double totalFirst = 0;
        double totalRandom = 0;
        double totalMinimum = 0;

        for (int i = 0; i < NUMBER_OF_ITERATIONS; i++) {
            int minimumHeadsIndex = flip1000Coins10Times(headTosses);

            totalFirst += headTosses[0];
            totalRandom += headTosses[new Random().nextInt(NUMBER_OF_COINS)];
            totalMinimum += headTosses[minimumHeadsIndex];
        }

        // Print first, random, and coin with less heads
        System.out.print(totalFirst / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS) + " ");
        System.out.println(hoeffding(totalFirst / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS), NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS));

        System.out.print(totalMinimum / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS) + " ");
        System.out.println(hoeffding(totalMinimum / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS), NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS));

        System.out.print(totalRandom / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS) + " ");
        System.out.println(hoeffding(totalRandom / (NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS), NUMBER_OF_FLIPS * NUMBER_OF_ITERATIONS));

    }

    private static double hoeffding(double v, int N) {
        return 2 * Math.exp(-2 * N * Math.pow(Math.abs(0.5 - v), 2));
    }

    private static int flip1000Coins10Times(double[] headTosses) {
        for (int i = 0; i < NUMBER_OF_COINS; i++) {
            Random randomGenerator = new Random();
            headTosses[i] = 0.0;
            for (int flip = 0; flip < NUMBER_OF_FLIPS; flip++) {
                if (randomGenerator.nextInt(2) == 1) {
                    headTosses[i]++;
                }
            }
        }

        double minHeads = headTosses[0];
        int minHeadsIndex = 0;
        for (int i = 1; i < NUMBER_OF_COINS; i++) {
            if (headTosses[i] < minHeads) {
                minHeads = headTosses[i];
                minHeadsIndex = i;
            }
        }
        return minHeadsIndex;
    }
}
