// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import Foundation

struct Animals {
    static let names = """
            bear
            buffalo
            chick
            chicken
            cow
            crocodile
            dog
            duck
            elephant
            frog
            giraffe
            goat
            gorilla
            hippo
            horse
            monkey
            moose
            narwhal
            owl
            panda
            parrot
            penguin
            pig
            rabbit
            rhino
            sloth
            snake
            walrus
            whale
            zebra
        """
        .replacingOccurrences(of: " ", with: "")
        .components(separatedBy: "\n")
}
