
# 1. Window Functions vs. GROUP BY

The difference is all about what happens to your rows.

## GROUP BY

It "collapses" or shrinks your data. If you group by Department, you get
one row per department. You lose the ability to see individual employee
names in that same result.

## Window Functions (OVER)

They do not collapse rows. They perform the calculation (like a sum or
average) and put the result right next to the original, detailed row.

### The Granularity

-   **GROUP BY** changes the granularity to the group level.
-   **Window Functions** keep the granularity at the individual row
    level while still showing group totals.

------------------------------------------------------------------------

# 2. Clustered vs. Non-Clustered Indexes

## The Leaf Nodes

Think of an index like a B-Tree (a branching structure). The "Leaf
Nodes" are the very bottom of that tree.

### Clustered Index

The Leaf Nodes are the actual data rows. When you reach the bottom of
the tree, you are looking at the real table.

### Non-Clustered Index

The Leaf Nodes contain pointers (like a book's index). They hold the
value you searched for and a "bookmark" telling the database exactly
where to find the rest of the row in the table.

### Why only one Clustered Index?

A Clustered Index defines the physical order of the data on the disk.
Since a physical row of data can only be sorted in one way (e.g., either
by ID or by Date, but not both at the exact same time), you can only
have one Clustered Index per table.

------------------------------------------------------------------------

# 3. Filtered & Unique Indexes

## Filtered Indexes

A Filtered Index is an index that only covers a specific portion of your
data (using a WHERE clause).

### Storage

It saves space because you aren't indexing every single row---only the
ones that meet your criteria (e.g., indexing only "Active" customers).

### Performance

It's faster because the index tree is much smaller for the SQL engine to
search through.

## Unique Indexes: The Trade-off

### Slows down INSERTs

Every time you add a new email, the database must stop and scan the
entire index to make sure that email doesn't already exist. This "check"
adds extra work for every write.

### Speeds up SELECTs

The database knows that once it finds the email, it can stop looking
immediately because there is guaranteed to be only one.

------------------------------------------------------------------------

# 4. Choosing the Right Index (The "Staging Table")

For a staging table where you are dumping millions of rows quickly, you
should use a Heap Structure (no index at all).

## Why?

Every time you add an index (Clustered or Non-Clustered), the database
has to do extra work to "sort" the data or update the index trees during
the insert. If your goal is to move millions of rows as fast as possible
("Write-Heavy"), an index acts like a speed bump. You only add the index
later if you need to perform heavy searching.

------------------------------------------------------------------------

# 5. Database Transactions (ACID)

## Atomicity ("All or Nothing")

Even if a process has ten steps, they are treated as one single unit. If
step #9 fails, steps #1 through #8 are undone (rolled back) as if they
never happened.

## The Disastrous Scenario: The Bank Transfer

Imagine you send \$500 to a friend.

1.  The bank subtracts \$500 from your account.
2.  The bank adds \$500 to your friend's account.

If the system crashes after Step 1 but before Step 2, and you aren't
using a transaction, your \$500 vanishes into thin air. Your balance is
down, but your friend never got the money. A transaction ensures that if
Step 2 fails, Step 1 is reversed.
