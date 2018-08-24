module Types where

type Username = String
type Password = String
type Credentials = (Username, Password)
type RegisteredUser r = (Credentials, r)
data Authenticated r = Authenticated r deriving Show
data Permission resource r = Permission resource r
data Authorized resource = Authorized resource deriving (Eq, Show)