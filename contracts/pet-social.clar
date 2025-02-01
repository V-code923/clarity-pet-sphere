;; PetSocial Contract
(define-map posts
  uint
  {
    owner: principal,
    content: (string-utf8 1000),
    image-hash: (optional (string-utf8 100)),
    likes: uint,
    created-at: uint
  }
)

(define-map comments
  { post-id: uint, comment-id: uint }
  {
    owner: principal,
    content: (string-utf8 500),
    created-at: uint
  }
)

(define-data-var post-counter uint u0)

(define-public (create-post (content (string-utf8 1000)) (image-hash (optional (string-utf8 100))))
  (let
    (
      (post-id (var-get post-counter))
      (new-post {
        owner: tx-sender,
        content: content,
        image-hash: image-hash,
        likes: u0,
        created-at: block-height
      })
    )
    (map-set posts post-id new-post)
    (var-set post-counter (+ post-id u1))
    (ok post-id)
  )
)

(define-public (like-post (post-id uint))
  (let
    ((post (unwrap! (map-get? posts post-id) (err u404))))
    (map-set posts post-id (merge post { likes: (+ (get likes post) u1) }))
    (ok true)
  )
)
