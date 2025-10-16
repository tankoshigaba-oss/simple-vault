;; ---------------------------------------------------
;; SIMPLE VAULT -- Minimal Clarity Contract
;; ---------------------------------------------------
;; Description:
;; A basic vault that allows users to deposit and
;; withdraw STX safely and view their balance.
;;
;; Author: Your Name
;; ---------------------------------------------------

;; Error codes
(define-constant ERR-ZERO-AMOUNT (err u1))
(define-constant ERR-NO-FUNDS (err u2))
(define-constant ERR-NO-BALANCE (err u3))

(define-map balances
  ((user principal))
  ((amount uint)))

;; ---------------------------------------------------
;; ---------------------------------------------------
;; SIMPLE VAULT -- Minimal Clarity Contract
;; ---------------------------------------------------
;; Description:
;; A basic vault that allows users to deposit and
;; withdraw STX safely and view their balance.
;;
;; Author: Your Name
;; ---------------------------------------------------

;; Error codes
(define-constant ERR-ZERO-AMOUNT (err u1))
(define-constant ERR-NO-FUNDS (err u2))
(define-constant ERR-NO-BALANCE (err u3))

(define-map balances
  ((user principal))
  ((amount uint)))

;; ---------------------------------------------------
;; Public Function: deposit
;; Allows users to deposit STX into the vault
;; ---------------------------------------------------
(define-public (deposit (amount uint))
  (if (<= amount u0)
      ERR-ZERO-AMOUNT
      (begin
        ;; transfer STX from caller to this contract
        (try! (stx-transfer? amount tx-sender (as-contract)))
        ;; safely update balance using match on optional map-get? result
        (match (map-get? balances ((user tx-sender)))
          entry
            (let ((current (get amount entry)))
              (map-set balances ((user tx-sender)) ((amount (+ current amount))))
              (ok { user: tx-sender, total: (+ current amount) }))
          none
            (begin
              (map-set balances ((user tx-sender)) ((amount amount)))
              (ok { user: tx-sender, total: amount }))
        )
      )
  )
)

;; ---------------------------------------------------
;; Public Function: withdraw
;; Allows users to withdraw their full balance
;; ---------------------------------------------------
(define-public (withdraw)
  (match (map-get? balances ((user tx-sender)))
    entry
      (let ((balance (get amount entry)))
        (if (> balance u0)
            (begin
              ;; transfer STX from this contract to the caller
              (try! (stx-transfer? balance (as-contract) tx-sender))
              (map-delete balances ((user tx-sender)))
              (ok { user: tx-sender, withdrawn: balance }))
            ERR-NO-FUNDS))
    none
      ERR-NO-BALANCE)
)

;; ---------------------------------------------------
;; Read-only Function: get-balance
;; Returns the balance of a given user
;; ---------------------------------------------------
(define-read-only (get-balance (user principal))
  (match (map-get? balances ((user user)))
    entry (get amount entry)
    none u0)
)
