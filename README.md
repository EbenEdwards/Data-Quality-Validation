## Phase 1: Data Profiling & Completeness Checks

This phase focused on establishing a baseline understanding of the dataset’s structural integrity and completeness. Key activities included table-level profiling, null value analysis across critical transactional and dimensional fields, identifier completeness checks, and temporal coverage validation.

A continuous date completeness check confirmed full daily coverage between the minimum and maximum transaction dates, indicating no missing transaction dates. This ensures reliable trend and time-series analysis in downstream reporting.

## Phase 2: Referential Integrity & Join Validation

This phase assessed whether the sales table correctly references customers, products, and regions. Orphaned records were checked by performing left joins between the sales fact table and each dimension table. 

No orphaned sales records were found, indicating full referential integrity. This ensures that revenue and performance metrics by customer, product, and region are accurate and reliable.

## Phase 3: Metric Validation & Business Impact

This phase focused on validating key sales metrics and assessing the potential impact of data issues on business decisions.

- Revenue, cost, margin, quantity, and discounts were computed and analyzed.
- No negative margins or invalid discounts were detected, indicating metric reliability.
- Aggregate revenue by product, customer, and region showed expected distributions.
- Potential revenue loss due to orphaned sales records (checked in Phase 2) was quantified, confirming minimal business impact.

By combining metric validation with data integrity checks, we ensured the dataset is both accurate and reliable for analytics and decision-making.
