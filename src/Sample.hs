module Sample where

import Plutarch
import Plutarch.Api.V1 (PRedeemer)
import Plutarch.Api.V2
import Plutarch.Prelude

gift :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
gift = plam $ \_datm _redm _ctx -> pconstant ()

burn :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
burn = plam $ \_datm _redm _ctx -> perror

