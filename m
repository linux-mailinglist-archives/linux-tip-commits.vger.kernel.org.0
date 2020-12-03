Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF9E2CD3CD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbgLCKgh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgLCKg3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:29 -0500
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DDKbQUFzMKOZqHEtyv7n2+4hbTuq4Bw19UhLiDKgRU4=;
        b=Zo+1eEtxEvQVMRaisDeIy6mpY39uFv7gOJiU9i8UFGtKJ4JxoRUg441ARIJblG8fVCCUJV
        UYwLLgr3cKv9GU8w3h2mzcQ5vrNnWUmcSP0mQQvuQxMwzniY/tqchbUEuFp9nYXMnhd/q5
        DNU7wpvJhXV5DiMQCegkVer+/079rC4GWvMt5fzaVhtBKT6FxO+YNqdPE4LYrV+Ogop2G2
        DWDxRVLRrLdq6tBYM2SMzhU7qYSBgNDbkPDR0PuDBX2HGsGuEbI8V9MRUbbCtWy6eskv2m
        LXBmHW48O4R8E/DCFv9UXEGG66UzmPrT0vOH45EWMHcsp9sGmS8hvLZIQ9ZvvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DDKbQUFzMKOZqHEtyv7n2+4hbTuq4Bw19UhLiDKgRU4=;
        b=Muo30ITHnirmrvL4Wyhkg7ujiMZrknwTm+xlIDdi7jAfGExMtAvNscjw/RApWV2NqZdI9Z
        Gtvu6cghz/xdKrAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] atomic: Delete obsolete documentation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160699174430.3364.7288933653901663589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f0400a77ebdc0a54383c978c7c0d3fc4af203e6b
Gitweb:        https://git.kernel.org/tip/f0400a77ebdc0a54383c978c7c0d3fc4af203e6b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Nov 2020 15:57:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:51 +01:00

atomic: Delete obsolete documentation

It's been superseded by Documentation/atomic_*.txt.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/core-api/atomic_ops.rst | 664 +-------------------------
 1 file changed, 664 deletions(-)
 delete mode 100644 Documentation/core-api/atomic_ops.rst

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
deleted file mode 100644
index 7245834..0000000
--- a/Documentation/core-api/atomic_ops.rst
+++ /dev/null
@@ -1,664 +0,0 @@
-=======================================================
-Semantics and Behavior of Atomic and Bitmask Operations
-=======================================================
-
-:Author: David S. Miller
-
-This document is intended to serve as a guide to Linux port
-maintainers on how to implement atomic counter, bitops, and spinlock
-interfaces properly.
-
-Atomic Type And Operations
-==========================
-
-The atomic_t type should be defined as a signed integer and
-the atomic_long_t type as a signed long integer.  Also, they should
-be made opaque such that any kind of cast to a normal C integer type
-will fail.  Something like the following should suffice::
-
-	typedef struct { int counter; } atomic_t;
-	typedef struct { long counter; } atomic_long_t;
-
-Historically, counter has been declared volatile.  This is now discouraged.
-See :ref:`Documentation/process/volatile-considered-harmful.rst
-<volatile_considered_harmful>` for the complete rationale.
-
-local_t is very similar to atomic_t. If the counter is per CPU and only
-updated by one CPU, local_t is probably more appropriate. Please see
-:ref:`Documentation/core-api/local_ops.rst <local_ops>` for the semantics of
-local_t.
-
-The first operations to implement for atomic_t's are the initializers and
-plain writes. ::
-
-	#define ATOMIC_INIT(i)		{ (i) }
-	#define atomic_set(v, i)	((v)->counter = (i))
-
-The first macro is used in definitions, such as::
-
-	static atomic_t my_counter = ATOMIC_INIT(1);
-
-The initializer is atomic in that the return values of the atomic operations
-are guaranteed to be correct reflecting the initialized value if the
-initializer is used before runtime.  If the initializer is used at runtime, a
-proper implicit or explicit read memory barrier is needed before reading the
-value with atomic_read from another thread.
-
-As with all of the ``atomic_`` interfaces, replace the leading ``atomic_``
-with ``atomic_long_`` to operate on atomic_long_t.
-
-The second interface can be used at runtime, as in::
-
-	struct foo { atomic_t counter; };
-	...
-
-	struct foo *k;
-
-	k = kmalloc(sizeof(*k), GFP_KERNEL);
-	if (!k)
-		return -ENOMEM;
-	atomic_set(&k->counter, 0);
-
-The setting is atomic in that the return values of the atomic operations by
-all threads are guaranteed to be correct reflecting either the value that has
-been set with this operation or set with another operation.  A proper implicit
-or explicit memory barrier is needed before the value set with the operation
-is guaranteed to be readable with atomic_read from another thread.
-
-Next, we have::
-
-	#define atomic_read(v)	((v)->counter)
-
-which simply reads the counter value currently visible to the calling thread.
-The read is atomic in that the return value is guaranteed to be one of the
-values initialized or modified with the interface operations if a proper
-implicit or explicit memory barrier is used after possible runtime
-initialization by any other thread and the value is modified only with the
-interface operations.  atomic_read does not guarantee that the runtime
-initialization by any other thread is visible yet, so the user of the
-interface must take care of that with a proper implicit or explicit memory
-barrier.
-
-.. warning::
-
-	``atomic_read()`` and ``atomic_set()`` DO NOT IMPLY BARRIERS!
-
-	Some architectures may choose to use the volatile keyword, barriers, or
-	inline assembly to guarantee some degree of immediacy for atomic_read()
-	and atomic_set().  This is not uniformly guaranteed, and may change in
-	the future, so all users of atomic_t should treat atomic_read() and
-	atomic_set() as simple C statements that may be reordered or optimized
-	away entirely by the compiler or processor, and explicitly invoke the
-	appropriate compiler and/or memory barrier for each use case.  Failure
-	to do so will result in code that may suddenly break when used with
-	different architectures or compiler optimizations, or even changes in
-	unrelated code which changes how the compiler optimizes the section
-	accessing atomic_t variables.
-
-Properly aligned pointers, longs, ints, and chars (and unsigned
-equivalents) may be atomically loaded from and stored to in the same
-sense as described for atomic_read() and atomic_set().  The READ_ONCE()
-and WRITE_ONCE() macros should be used to prevent the compiler from using
-optimizations that might otherwise optimize accesses out of existence on
-the one hand, or that might create unsolicited accesses on the other.
-
-For example consider the following code::
-
-	while (a > 0)
-		do_something();
-
-If the compiler can prove that do_something() does not store to the
-variable a, then the compiler is within its rights transforming this to
-the following::
-
-	if (a > 0)
-		for (;;)
-			do_something();
-
-If you don't want the compiler to do this (and you probably don't), then
-you should use something like the following::
-
-	while (READ_ONCE(a) > 0)
-		do_something();
-
-Alternatively, you could place a barrier() call in the loop.
-
-For another example, consider the following code::
-
-	tmp_a = a;
-	do_something_with(tmp_a);
-	do_something_else_with(tmp_a);
-
-If the compiler can prove that do_something_with() does not store to the
-variable a, then the compiler is within its rights to manufacture an
-additional load as follows::
-
-	tmp_a = a;
-	do_something_with(tmp_a);
-	tmp_a = a;
-	do_something_else_with(tmp_a);
-
-This could fatally confuse your code if it expected the same value
-to be passed to do_something_with() and do_something_else_with().
-
-The compiler would be likely to manufacture this additional load if
-do_something_with() was an inline function that made very heavy use
-of registers: reloading from variable a could save a flush to the
-stack and later reload.  To prevent the compiler from attacking your
-code in this manner, write the following::
-
-	tmp_a = READ_ONCE(a);
-	do_something_with(tmp_a);
-	do_something_else_with(tmp_a);
-
-For a final example, consider the following code, assuming that the
-variable a is set at boot time before the second CPU is brought online
-and never changed later, so that memory barriers are not needed::
-
-	if (a)
-		b = 9;
-	else
-		b = 42;
-
-The compiler is within its rights to manufacture an additional store
-by transforming the above code into the following::
-
-	b = 42;
-	if (a)
-		b = 9;
-
-This could come as a fatal surprise to other code running concurrently
-that expected b to never have the value 42 if a was zero.  To prevent
-the compiler from doing this, write something like::
-
-	if (a)
-		WRITE_ONCE(b, 9);
-	else
-		WRITE_ONCE(b, 42);
-
-Don't even -think- about doing this without proper use of memory barriers,
-locks, or atomic operations if variable a can change at runtime!
-
-.. warning::
-
-	``READ_ONCE()`` OR ``WRITE_ONCE()`` DO NOT IMPLY A BARRIER!
-
-Now, we move onto the atomic operation interfaces typically implemented with
-the help of assembly code. ::
-
-	void atomic_add(int i, atomic_t *v);
-	void atomic_sub(int i, atomic_t *v);
-	void atomic_inc(atomic_t *v);
-	void atomic_dec(atomic_t *v);
-
-These four routines add and subtract integral values to/from the given
-atomic_t value.  The first two routines pass explicit integers by
-which to make the adjustment, whereas the latter two use an implicit
-adjustment value of "1".
-
-One very important aspect of these two routines is that they DO NOT
-require any explicit memory barriers.  They need only perform the
-atomic_t counter update in an SMP safe manner.
-
-Next, we have::
-
-	int atomic_inc_return(atomic_t *v);
-	int atomic_dec_return(atomic_t *v);
-
-These routines add 1 and subtract 1, respectively, from the given
-atomic_t and return the new counter value after the operation is
-performed.
-
-Unlike the above routines, it is required that these primitives
-include explicit memory barriers that are performed before and after
-the operation.  It must be done such that all memory operations before
-and after the atomic operation calls are strongly ordered with respect
-to the atomic operation itself.
-
-For example, it should behave as if a smp_mb() call existed both
-before and after the atomic operation.
-
-If the atomic instructions used in an implementation provide explicit
-memory barrier semantics which satisfy the above requirements, that is
-fine as well.
-
-Let's move on::
-
-	int atomic_add_return(int i, atomic_t *v);
-	int atomic_sub_return(int i, atomic_t *v);
-
-These behave just like atomic_{inc,dec}_return() except that an
-explicit counter adjustment is given instead of the implicit "1".
-This means that like atomic_{inc,dec}_return(), the memory barrier
-semantics are required.
-
-Next::
-
-	int atomic_inc_and_test(atomic_t *v);
-	int atomic_dec_and_test(atomic_t *v);
-
-These two routines increment and decrement by 1, respectively, the
-given atomic counter.  They return a boolean indicating whether the
-resulting counter value was zero or not.
-
-Again, these primitives provide explicit memory barrier semantics around
-the atomic operation::
-
-	int atomic_sub_and_test(int i, atomic_t *v);
-
-This is identical to atomic_dec_and_test() except that an explicit
-decrement is given instead of the implicit "1".  This primitive must
-provide explicit memory barrier semantics around the operation::
-
-	int atomic_add_negative(int i, atomic_t *v);
-
-The given increment is added to the given atomic counter value.  A boolean
-is return which indicates whether the resulting counter value is negative.
-This primitive must provide explicit memory barrier semantics around
-the operation.
-
-Then::
-
-	int atomic_xchg(atomic_t *v, int new);
-
-This performs an atomic exchange operation on the atomic variable v, setting
-the given new value.  It returns the old value that the atomic variable v had
-just before the operation.
-
-atomic_xchg must provide explicit memory barriers around the operation. ::
-
-	int atomic_cmpxchg(atomic_t *v, int old, int new);
-
-This performs an atomic compare exchange operation on the atomic value v,
-with the given old and new values. Like all atomic_xxx operations,
-atomic_cmpxchg will only satisfy its atomicity semantics as long as all
-other accesses of \*v are performed through atomic_xxx operations.
-
-atomic_cmpxchg must provide explicit memory barriers around the operation,
-although if the comparison fails then no memory ordering guarantees are
-required.
-
-The semantics for atomic_cmpxchg are the same as those defined for 'cas'
-below.
-
-Finally::
-
-	int atomic_add_unless(atomic_t *v, int a, int u);
-
-If the atomic value v is not equal to u, this function adds a to v, and
-returns non zero. If v is equal to u then it returns zero. This is done as
-an atomic operation.
-
-atomic_add_unless must provide explicit memory barriers around the
-operation unless it fails (returns 0).
-
-atomic_inc_not_zero, equivalent to atomic_add_unless(v, 1, 0)
-
-
-If a caller requires memory barrier semantics around an atomic_t
-operation which does not return a value, a set of interfaces are
-defined which accomplish this::
-
-	void smp_mb__before_atomic(void);
-	void smp_mb__after_atomic(void);
-
-Preceding a non-value-returning read-modify-write atomic operation with
-smp_mb__before_atomic() and following it with smp_mb__after_atomic()
-provides the same full ordering that is provided by value-returning
-read-modify-write atomic operations.
-
-For example, smp_mb__before_atomic() can be used like so::
-
-	obj->dead = 1;
-	smp_mb__before_atomic();
-	atomic_dec(&obj->ref_count);
-
-It makes sure that all memory operations preceding the atomic_dec()
-call are strongly ordered with respect to the atomic counter
-operation.  In the above example, it guarantees that the assignment of
-"1" to obj->dead will be globally visible to other cpus before the
-atomic counter decrement.
-
-Without the explicit smp_mb__before_atomic() call, the
-implementation could legally allow the atomic counter update visible
-to other cpus before the "obj->dead = 1;" assignment.
-
-A missing memory barrier in the cases where they are required by the
-atomic_t implementation above can have disastrous results.  Here is
-an example, which follows a pattern occurring frequently in the Linux
-kernel.  It is the use of atomic counters to implement reference
-counting, and it works such that once the counter falls to zero it can
-be guaranteed that no other entity can be accessing the object::
-
-	static void obj_list_add(struct obj *obj, struct list_head *head)
-	{
-		obj->active = 1;
-		list_add(&obj->list, head);
-	}
-
-	static void obj_list_del(struct obj *obj)
-	{
-		list_del(&obj->list);
-		obj->active = 0;
-	}
-
-	static void obj_destroy(struct obj *obj)
-	{
-		BUG_ON(obj->active);
-		kfree(obj);
-	}
-
-	struct obj *obj_list_peek(struct list_head *head)
-	{
-		if (!list_empty(head)) {
-			struct obj *obj;
-
-			obj = list_entry(head->next, struct obj, list);
-			atomic_inc(&obj->refcnt);
-			return obj;
-		}
-		return NULL;
-	}
-
-	void obj_poke(void)
-	{
-		struct obj *obj;
-
-		spin_lock(&global_list_lock);
-		obj = obj_list_peek(&global_list);
-		spin_unlock(&global_list_lock);
-
-		if (obj) {
-			obj->ops->poke(obj);
-			if (atomic_dec_and_test(&obj->refcnt))
-				obj_destroy(obj);
-		}
-	}
-
-	void obj_timeout(struct obj *obj)
-	{
-		spin_lock(&global_list_lock);
-		obj_list_del(obj);
-		spin_unlock(&global_list_lock);
-
-		if (atomic_dec_and_test(&obj->refcnt))
-			obj_destroy(obj);
-	}
-
-.. note::
-
-	This is a simplification of the ARP queue management in the generic
-	neighbour discover code of the networking.  Olaf Kirch found a bug wrt.
-	memory barriers in kfree_skb() that exposed the atomic_t memory barrier
-	requirements quite clearly.
-
-Given the above scheme, it must be the case that the obj->active
-update done by the obj list deletion be visible to other processors
-before the atomic counter decrement is performed.
-
-Otherwise, the counter could fall to zero, yet obj->active would still
-be set, thus triggering the assertion in obj_destroy().  The error
-sequence looks like this::
-
-	cpu 0				cpu 1
-	obj_poke()			obj_timeout()
-	obj = obj_list_peek();
-	... gains ref to obj, refcnt=2
-					obj_list_del(obj);
-					obj->active = 0 ...
-					... visibility delayed ...
-					atomic_dec_and_test()
-					... refcnt drops to 1 ...
-	atomic_dec_and_test()
-	... refcount drops to 0 ...
-	obj_destroy()
-	BUG() triggers since obj->active
-	still seen as one
-					obj->active update visibility occurs
-
-With the memory barrier semantics required of the atomic_t operations
-which return values, the above sequence of memory visibility can never
-happen.  Specifically, in the above case the atomic_dec_and_test()
-counter decrement would not become globally visible until the
-obj->active update does.
-
-As a historical note, 32-bit Sparc used to only allow usage of
-24-bits of its atomic_t type.  This was because it used 8 bits
-as a spinlock for SMP safety.  Sparc32 lacked a "compare and swap"
-type instruction.  However, 32-bit Sparc has since been moved over
-to a "hash table of spinlocks" scheme, that allows the full 32-bit
-counter to be realized.  Essentially, an array of spinlocks are
-indexed into based upon the address of the atomic_t being operated
-on, and that lock protects the atomic operation.  Parisc uses the
-same scheme.
-
-Another note is that the atomic_t operations returning values are
-extremely slow on an old 386.
-
-
-Atomic Bitmask
-==============
-
-We will now cover the atomic bitmask operations.  You will find that
-their SMP and memory barrier semantics are similar in shape and scope
-to the atomic_t ops above.
-
-Native atomic bit operations are defined to operate on objects aligned
-to the size of an "unsigned long" C data type, and are least of that
-size.  The endianness of the bits within each "unsigned long" are the
-native endianness of the cpu. ::
-
-	void set_bit(unsigned long nr, volatile unsigned long *addr);
-	void clear_bit(unsigned long nr, volatile unsigned long *addr);
-	void change_bit(unsigned long nr, volatile unsigned long *addr);
-
-These routines set, clear, and change, respectively, the bit number
-indicated by "nr" on the bit mask pointed to by "ADDR".
-
-They must execute atomically, yet there are no implicit memory barrier
-semantics required of these interfaces. ::
-
-	int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
-	int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
-	int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
-
-Like the above, except that these routines return a boolean which
-indicates whether the changed bit was set _BEFORE_ the atomic bit
-operation.
-
-
-.. warning::
-        It is incredibly important that the value be a boolean, ie. "0" or "1".
-        Do not try to be fancy and save a few instructions by declaring the
-        above to return "long" and just returning something like "old_val &
-        mask" because that will not work.
-
-For one thing, this return value gets truncated to int in many code
-paths using these interfaces, so on 64-bit if the bit is set in the
-upper 32-bits then testers will never see that.
-
-One great example of where this problem crops up are the thread_info
-flag operations.  Routines such as test_and_set_ti_thread_flag() chop
-the return value into an int.  There are other places where things
-like this occur as well.
-
-These routines, like the atomic_t counter operations returning values,
-must provide explicit memory barrier semantics around their execution.
-All memory operations before the atomic bit operation call must be
-made visible globally before the atomic bit operation is made visible.
-Likewise, the atomic bit operation must be visible globally before any
-subsequent memory operation is made visible.  For example::
-
-	obj->dead = 1;
-	if (test_and_set_bit(0, &obj->flags))
-		/* ... */;
-	obj->killed = 1;
-
-The implementation of test_and_set_bit() must guarantee that
-"obj->dead = 1;" is visible to cpus before the atomic memory operation
-done by test_and_set_bit() becomes visible.  Likewise, the atomic
-memory operation done by test_and_set_bit() must become visible before
-"obj->killed = 1;" is visible.
-
-Finally there is the basic operation::
-
-	int test_bit(unsigned long nr, __const__ volatile unsigned long *addr);
-
-Which returns a boolean indicating if bit "nr" is set in the bitmask
-pointed to by "addr".
-
-If explicit memory barriers are required around {set,clear}_bit() (which do
-not return a value, and thus does not need to provide memory barrier
-semantics), two interfaces are provided::
-
-	void smp_mb__before_atomic(void);
-	void smp_mb__after_atomic(void);
-
-They are used as follows, and are akin to their atomic_t operation
-brothers::
-
-	/* All memory operations before this call will
-	 * be globally visible before the clear_bit().
-	 */
-	smp_mb__before_atomic();
-	clear_bit( ... );
-
-	/* The clear_bit() will be visible before all
-	 * subsequent memory operations.
-	 */
-	 smp_mb__after_atomic();
-
-There are two special bitops with lock barrier semantics (acquire/release,
-same as spinlocks). These operate in the same way as their non-_lock/unlock
-postfixed variants, except that they are to provide acquire/release semantics,
-respectively. This means they can be used for bit_spin_trylock and
-bit_spin_unlock type operations without specifying any more barriers. ::
-
-	int test_and_set_bit_lock(unsigned long nr, unsigned long *addr);
-	void clear_bit_unlock(unsigned long nr, unsigned long *addr);
-	void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
-
-The __clear_bit_unlock version is non-atomic, however it still implements
-unlock barrier semantics. This can be useful if the lock itself is protecting
-the other bits in the word.
-
-Finally, there are non-atomic versions of the bitmask operations
-provided.  They are used in contexts where some other higher-level SMP
-locking scheme is being used to protect the bitmask, and thus less
-expensive non-atomic operations may be used in the implementation.
-They have names similar to the above bitmask operation interfaces,
-except that two underscores are prefixed to the interface name. ::
-
-	void __set_bit(unsigned long nr, volatile unsigned long *addr);
-	void __clear_bit(unsigned long nr, volatile unsigned long *addr);
-	void __change_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
-
-These non-atomic variants also do not require any special memory
-barrier semantics.
-
-The routines xchg() and cmpxchg() must provide the same exact
-memory-barrier semantics as the atomic and bit operations returning
-values.
-
-.. note::
-
-	If someone wants to use xchg(), cmpxchg() and their variants,
-	linux/atomic.h should be included rather than asm/cmpxchg.h, unless the
-	code is in arch/* and can take care of itself.
-
-Spinlocks and rwlocks have memory barrier expectations as well.
-The rule to follow is simple:
-
-1) When acquiring a lock, the implementation must make it globally
-   visible before any subsequent memory operation.
-
-2) When releasing a lock, the implementation must make it such that
-   all previous memory operations are globally visible before the
-   lock release.
-
-Which finally brings us to _atomic_dec_and_lock().  There is an
-architecture-neutral version implemented in lib/dec_and_lock.c,
-but most platforms will wish to optimize this in assembler. ::
-
-	int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-
-Atomically decrement the given counter, and if will drop to zero
-atomically acquire the given spinlock and perform the decrement
-of the counter to zero.  If it does not drop to zero, do nothing
-with the spinlock.
-
-It is actually pretty simple to get the memory barrier correct.
-Simply satisfy the spinlock grab requirements, which is make
-sure the spinlock operation is globally visible before any
-subsequent memory operation.
-
-We can demonstrate this operation more clearly if we define
-an abstract atomic operation::
-
-	long cas(long *mem, long old, long new);
-
-"cas" stands for "compare and swap".  It atomically:
-
-1) Compares "old" with the value currently at "mem".
-2) If they are equal, "new" is written to "mem".
-3) Regardless, the current value at "mem" is returned.
-
-As an example usage, here is what an atomic counter update
-might look like::
-
-	void example_atomic_inc(long *counter)
-	{
-		long old, new, ret;
-
-		while (1) {
-			old = *counter;
-			new = old + 1;
-
-			ret = cas(counter, old, new);
-			if (ret == old)
-				break;
-		}
-	}
-
-Let's use cas() in order to build a pseudo-C atomic_dec_and_lock()::
-
-	int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-	{
-		long old, new, ret;
-		int went_to_zero;
-
-		went_to_zero = 0;
-		while (1) {
-			old = atomic_read(atomic);
-			new = old - 1;
-			if (new == 0) {
-				went_to_zero = 1;
-				spin_lock(lock);
-			}
-			ret = cas(atomic, old, new);
-			if (ret == old)
-				break;
-			if (went_to_zero) {
-				spin_unlock(lock);
-				went_to_zero = 0;
-			}
-		}
-
-		return went_to_zero;
-	}
-
-Now, as far as memory barriers go, as long as spin_lock()
-strictly orders all subsequent memory operations (including
-the cas()) with respect to itself, things will be fine.
-
-Said another way, _atomic_dec_and_lock() must guarantee that
-a counter dropping to zero is never made visible before the
-spinlock being acquired.
-
-.. note::
-
-	Note that this also means that for the case where the counter is not
-	dropping to zero, there are no memory ordering requirements.
