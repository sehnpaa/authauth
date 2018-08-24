module Lib (authenticate, authorize) where

import Data.List (find)

import Types

authenticate :: (Eq r) => Credentials -> [RegisteredUser r] -> Maybe (Authenticated r)
authenticate (username, password) existingUsers =
    let match = (==) (username, password) . fst
        in getAuthenticatedRole <$> find match existingUsers

getAuthenticatedRole :: RegisteredUser r -> Authenticated r
getAuthenticatedRole = Authenticated . snd

authorize :: (Eq resource, Eq r) => resource -> [Permission resource r] -> Authenticated r -> Maybe (Authorized resource)
authorize resource permissions (Authenticated role) =
    let match (Permission resource' role') = (resource', role') == (resource, role)
        in getAuthorizedResource <$> find match permissions

getAuthorizedResource :: Permission r a -> Authorized r
getAuthorizedResource (Permission resource _) = Authorized resource