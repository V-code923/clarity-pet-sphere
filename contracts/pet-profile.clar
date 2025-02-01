;; PetProfile Contract
(define-map pet-profiles
  principal
  {
    name: (string-utf8 100),
    pet-type: (string-utf8 50),
    bio: (string-utf8 500),
    created-at: uint
  }
)

(define-map profile-ownership
  principal
  (list 10 principal)
)

(define-public (create-profile (name (string-utf8 100)) (pet-type (string-utf8 50)) (bio (string-utf8 500)))
  (let
    (
      (profile {
        name: name,
        pet-type: pet-type,
        bio: bio,
        created-at: block-height
      })
    )
    (ok (map-set pet-profiles tx-sender profile))
  )
)

(define-read-only (get-profile (owner principal))
  (ok (map-get? pet-profiles owner))
)
