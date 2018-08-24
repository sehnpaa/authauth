module Spec (hspec, spec) where

import Data.Maybe (catMaybes)
import Test.Hspec

import Lib
import Types

data CustomResource = CR1 | CR2 | CR3 | CR4 deriving (Enum, Eq, Show)
data SpecificRole = Role1 | Role2 deriving (Eq, Show)
data CustomRole = SpecificRole SpecificRole | All | Group

instance Eq CustomRole where
    All == _ = True
    _ == All = True
    (SpecificRole r1) == (SpecificRole r2) = r1 == r2
    (SpecificRole _) == Group = False
    Group == (SpecificRole _) = False
    Group == Group = True

users :: [RegisteredUser CustomRole]
users =
    [ (pelleCredentials, All)
    , (stinaCredentials, SpecificRole Role1)
    , (svenCredentials, Group)
    ]

permissions :: [Permission CustomResource CustomRole]
permissions =
    [ Permission CR1 (SpecificRole Role1)
    , Permission CR2 (SpecificRole Role2)
    , Permission CR3 All
    , Permission CR4 Group
    ]

allResources :: [CustomResource]
allResources = [toEnum 0..]

listAvailableResources :: Credentials -> [Authorized CustomResource]
listAvailableResources credentials =
    catMaybes $ fmap (\resource -> authenticate credentials users >>= authorize resource permissions) allResources

pelleCredentials, stinaCredentials, svenCredentials, badCredentials :: Credentials
pelleCredentials = ("Pelle", "svan")
stinaCredentials = ("Stina", "fisk")
svenCredentials = ("Sven", "segel")
badCredentials = ("Pelle", "hav")

spec :: Spec
spec =
    describe "available resources" $ do
        it "pelleCredentials" $
            listAvailableResources pelleCredentials `shouldBe` fmap Authorized allResources
        it "stinaCredentials" $
            listAvailableResources stinaCredentials `shouldBe` [Authorized CR1, Authorized CR3]
        it "svenCredentials" $
            listAvailableResources svenCredentials `shouldBe` [Authorized CR3, Authorized CR4]
        it "badCredentials" $
            listAvailableResources badCredentials `shouldBe` []