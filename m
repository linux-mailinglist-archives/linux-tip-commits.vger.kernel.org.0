Return-Path: <linux-tip-commits+bounces-4185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDC8A5F26D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629FC17E601
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23A2673B8;
	Thu, 13 Mar 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HauElHei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BUqmImBP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8AB266EEE;
	Thu, 13 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865490; cv=none; b=QJlnM/ERjDQy/fcfUdxnXRA+82vUDKf5zSI7i8yXqC6k3w1ICY8xbwpiYWMnrVBYcZcIdDP9LlD0wsJsYfcnCRov50Cud3K0Rp76dMsdzGnQTX5PvrT+hPsDtY227qqFbzaWBuOnNp+9uh1Cc8jPZ3OaNRvFjFvT2Fqy4PpkNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865490; c=relaxed/simple;
	bh=/XlReTE1WBtj59ph5HyxiwaFbCop8X22jUj3Uljg85A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OOlXSvfo3rtH1iqoupYOZCqKIWHBTRD3pCGmFeNgK4UJjd1MmznKOVjGzNlMDGhup3SN+AaXbsF/VgjGZBwJBUXAC24eGVJmJ24HlGlIRAdYUoZvldyUOQZrrq6FysBieD5DBrkK9ltX95mF9/olIBd3ztGcH/CeDOue5BqRZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HauElHei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BUqmImBP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2lxDfKuhagon92pCW2GXs/xgX7figTuCKumdFPuEWs=;
	b=HauElHeid8/IpCOETWNamAFG/eYMMyUv+NVB1uSVsReL2409WOwodh/qQwMSD9OREDsEVE
	MkQKwIu4O8gr+JehGSRjUqG93aZu/jr7erttCrGQ+Psg3ZwDC4Chj5NDifEhgC00qWoHYA
	fK+2dwWvb8Ti3p6AtAmJHdLznzM8N+A4CUndxb7ISAPUKY6b82yFirKY1ZTOU0DetZRdKl
	1kszv9GDnLn4Gt4PqGNvKO7DNjerOujvlIOE+Jc4oAy5SDuBoDVORSDcpVCvg6jzeq4517
	ANQm+pwwm5YJ7anXFZMS2VQ+XuO+cjYkO8u1OrHtLqp0eYwXpFUZdBW1muHTrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2lxDfKuhagon92pCW2GXs/xgX7figTuCKumdFPuEWs=;
	b=BUqmImBPW5VXwF4LdfxII27MVOfHMiQft+UMk9tXnlEWUlmUoJf8aewen6cWQlQOjr8Zym
	cok7Dr2+6opBAECg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Improve hash table performance
Cc: Eric Dumazet <edumazet@google.com>, Benjamin Segall <bsegall@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.216091571@linutronix.de>
References: <20250308155624.216091571@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548623.14745.17798231878724350066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1535cb80286e6fbc834f075039f85274538543c7
Gitweb:        https://git.kernel.org/tip/1535cb80286e6fbc834f075039f85274538543c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Improve hash table performance

Eric and Ben reported a significant performance bottleneck on the global
hash, which is used to store posix timers for lookup.

Eric tried to do a lockless validation of a new timer ID before trying to
insert the timer, but that does not solve the problem.

For the non-contended case this is a pointless exercise and for the
contended case this extra lookup just creates enough interleaving that all
tasks can make progress.

There are actually two real solutions to the problem:

  1) Provide a per process (signal struct) xarray storage

  2) Implement a smarter hash like the one in the futex code

#1 works perfectly fine for most cases, but the fact that CRIU enforced a
   linear increasing timer ID to restore timers makes this problematic.

   It's easy enough to create a sparse timer ID space, which amounts very
   fast to a large junk of memory consumed for the xarray. 2048 timers with
   a ID offset of 512 consume more than one megabyte of memory for the
   xarray storage.

#2 The main advantage of the futex hash is that it uses per hash bucket
   locks instead of a global hash lock. Aside of that it is scaled
   according to the number of CPUs at boot time.

Experiments with artifical benchmarks have shown that a scaled hash with
per bucket locks comes pretty close to the xarray performance and in some
scenarios it performes better.

Test 1:

     A single process creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         23 ms       23 ms      9 ms     8 ms
getoverrun     14 ms       14 ms      5 ms     4 ms

Test 2:

     A single process creates 50000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         98 ms      219 ms     20 ms    18 ms
getoverrun     62 ms       62 ms     10 ms     9 ms

Test 3:

     A single process creates 100000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create        313 ms      750 ms     48 ms    33 ms
getoverrun    261 ms      260 ms     20 ms    14 ms

Erics changes create quite some overhead in the create() path due to the
double list walk, as the main issue according to perf is the list walk
itself. With 100k timers each hash bucket contains ~200 timers, which in
the worst case need to be all inspected. The same problem applies for
getoverrun() where the lookup has to walk through the hash buckets to find
the timer it is looking for.

The scaled hash obviously reduces hash collisions and lock contention
significantly. This becomes more prominent with concurrency.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The threads are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per thread:

            mainline        Eric   newhash   xarray
create     180239 ms    38599 ms    579 ms   813 ms
getoverrun   2645 ms     2642 ms     32 ms     7 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The processes are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per process:

            mainline        eric   newhash   xarray
create     157253 ms    40008 ms     83 ms    60 ms
getoverrun   2611 ms     2614 ms     40 ms     4 ms

So clearly the reduction of lock contention with Eric's changes makes a
significant difference for the create() loop, but it does not mitigate the
problem of long list walks, which is clearly visible on the getoverrun()
side because that is purely dominated by the lookup itself. Once the timer
is found, the syscall just reads from the timer structure with no other
locks or code paths involved and returns.

The reason for the difference between the thread and the fork case for the
new hash and the xarray is that both suffer from contention on
sighand::siglock and the xarray suffers additionally from contention on the
xarray lock on insertion.

The only case where the reworked hash slighly outperforms the xarray is a
tight loop which creates and deletes timers.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The threads are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per thread:

            mainline        Eric   newhash   xarray
loop	    5917  ms	 5897 ms   5473 ms  7846 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The processes are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per process:

            mainline        Eric   newhash   xarray
loop	     5137 ms	 7828 ms    891 ms   872 ms

In both test there is not much contention on the hash, but the ucount
accounting for the signal and in the thread case the sighand::siglock
contention (plus the xarray locking) contribute dominantly to the overhead.

As the memory consumption of the xarray in the sparse ID case is
significant, the scaled hash with per bucket locks seems to be the better
overall option. While the xarray has faster lookup times for a large number
of timers, the actual syscall usage, which requires the lookup is not an
extreme hotpath. Most applications utilize signal delivery and all syscalls
except timer_getoverrun(2) are all but cheap.

So implement a scaled hash with per bucket locks, which offers the best
tradeoff between performance and memory consumption.

Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: Benjamin Segall <bsegall@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155624.216091571@linutronix.de


---
 kernel/time/posix-timers.c |  99 ++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 31 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f9a70c1..23f6d8b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -12,10 +12,10 @@
 #include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
-#include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
@@ -40,8 +40,18 @@ static struct kmem_cache *posix_timers_cache;
  * This allows checkpoint/restore to reconstruct the exact timer IDs for
  * a process.
  */
-static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
-static DEFINE_SPINLOCK(hash_lock);
+struct timer_hash_bucket {
+	spinlock_t		lock;
+	struct hlist_head	head;
+};
+
+static struct {
+	struct timer_hash_bucket	*buckets;
+	unsigned long			bits;
+} __timer_data __ro_after_init __aligned(2*sizeof(long));
+
+#define timer_buckets	(__timer_data.buckets)
+#define timer_hashbits	(__timer_data.bits)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -75,18 +85,18 @@ static inline void unlock_timer(struct k_itimer *timr)
 DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(id), timer_t id);
 DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
-static int hash(struct signal_struct *sig, unsigned int nr)
+static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
+	return &timer_buckets[hash_32(hash32_ptr(sig) ^ nr, timer_hashbits)];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
 {
 	struct signal_struct *sig = current->signal;
-	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash) {
+	hlist_for_each_entry_rcu(timer, &bucket->head, t_hash) {
 		/* timer->it_signal can be set concurrently */
 		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
 			return timer;
@@ -105,11 +115,13 @@ static inline struct signal_struct *posix_sig_owner(const struct k_itimer *timer
 	return (struct signal_struct *)(val & ~1UL);
 }
 
-static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *sig, timer_t id)
+static bool posix_timer_hashed(struct timer_hash_bucket *bucket, struct signal_struct *sig,
+			       timer_t id)
 {
+	struct hlist_head *head = &bucket->head;
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&bucket->lock)) {
 		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
 			return true;
 	}
@@ -120,34 +132,34 @@ static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
 
-	/*
-	 * FIXME: Replace this by a per signal struct xarray once there is
-	 * a plan to handle the resulting CRIU regression gracefully.
-	 */
 	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
 		/* Get the next timer ID and clamp it to positive space */
 		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
-		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+		struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 
-		spin_lock(&hash_lock);
-		if (!posix_timer_hashed(head, sig, id)) {
+		scoped_guard (spinlock, &bucket->lock) {
 			/*
-			 * Set the timer ID and the signal pointer to make
-			 * it identifiable in the hash table. The signal
-			 * pointer has bit 0 set to indicate that it is not
-			 * yet fully initialized. posix_timer_hashed()
-			 * masks this bit out, but the syscall lookup fails
-			 * to match due to it being set. This guarantees
-			 * that there can't be duplicate timer IDs handed
-			 * out.
+			 * Validate under the lock as this could have raced
+			 * against another thread ending up with the same
+			 * ID, which is highly unlikely, but possible.
 			 */
-			timer->it_id = (timer_t)id;
-			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-			hlist_add_head_rcu(&timer->t_hash, head);
-			spin_unlock(&hash_lock);
-			return id;
+			if (!posix_timer_hashed(bucket, sig, id)) {
+				/*
+				 * Set the timer ID and the signal pointer to make
+				 * it identifiable in the hash table. The signal
+				 * pointer has bit 0 set to indicate that it is not
+				 * yet fully initialized. posix_timer_hashed()
+				 * masks this bit out, but the syscall lookup fails
+				 * to match due to it being set. This guarantees
+				 * that there can't be duplicate timer IDs handed
+				 * out.
+				 */
+				timer->it_id = (timer_t)id;
+				timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
+				hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+				return id;
+			}
 		}
-		spin_unlock(&hash_lock);
 		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
@@ -405,7 +417,9 @@ void posixtimer_free_timer(struct k_itimer *tmr)
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	scoped_guard (spinlock, &hash_lock)
+	struct timer_hash_bucket *bucket = hash_bucket(posix_sig_owner(tmr), tmr->it_id);
+
+	scoped_guard (spinlock, &bucket->lock)
 		hlist_del_rcu(&tmr->t_hash);
 	posixtimer_putref(tmr);
 }
@@ -1485,3 +1499,26 @@ static const struct k_clock *clockid_to_kclock(const clockid_t id)
 
 	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
+
+static int __init posixtimer_init(void)
+{
+	unsigned long i, size;
+	unsigned int shift;
+
+	if (IS_ENABLED(CONFIG_BASE_SMALL))
+		size = 512;
+	else
+		size = roundup_pow_of_two(512 * num_possible_cpus());
+
+	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
+						size, 0, 0, &shift, NULL, size, size);
+	size = 1UL << shift;
+	timer_hashbits = ilog2(size);
+
+	for (i = 0; i < size; i++) {
+		spin_lock_init(&timer_buckets[i].lock);
+		INIT_HLIST_HEAD(&timer_buckets[i].head);
+	}
+	return 0;
+}
+core_initcall(posixtimer_init);

