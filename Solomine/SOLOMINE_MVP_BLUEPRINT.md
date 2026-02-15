# Solomine MVP Blueprint

## Product Goal
Build an solominete network competitor to AWIN/Impact/CJ where:
- Solominetes join the network and offer promotional services.
- Companies publish campaign contracts for products they want promoted.
- The platform tracks applications, approvals, and payout terms.

## Core Users
- Solominete: Publishes profile, traffic channels, and applies to contracts.
- Company: Publishes contract terms, reviews solominetes, and manages payouts.
- Admin (later): Fraud checks, disputes, and compliance review.

## MVP Data Model
- `User`: `role` (`SOLOMINETE` or `COMPANY`), auth, profile basics.
- `SolomineteProfile`: channels, niches, audience stats, proof links.
- `CampaignContract`: title, description, channel category, priority, region.
- `CommissionTerms`: type (`CPA`, `REV SHARE`, `HYBRID`), value, cookie window.
- `Application`: solominete -> contract status (`PENDING`, `APPROVED`, `REJECTED`).

## MVP Flows
1. Sign in and choose role (`SOLOMINETE` or `COMPANY`).
2. Company posts campaign contract with commission + terms.
3. Solominete browses contracts and submits application.
4. Company reviews and approves solominetes.
5. Dashboard tracks active contracts and estimated commissions.

## App + Web Parity
- iOS app: browse, apply, post contracts, monitor dashboard.
- Web app: same workflows plus denser management table views for companies.
- Shared backend API for auth, contracts, and applications.

## Suggested Next Build Steps
1. Add persistent `CampaignContract` + `Application` tables in Prisma.
2. Replace mock manager data with API-backed repository layer.
3. Build company review queue (approve/reject solominetes).
4. Add conversion ingestion and payout ledger.
