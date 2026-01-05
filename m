Return-Path: <linux-tip-commits+bounces-7790-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD0CF48D8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8EC309844A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F52DE6FF;
	Mon,  5 Jan 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5Nwkf9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7oRHEQiR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34A33A9C2;
	Mon,  5 Jan 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628460; cv=none; b=RCqsquJXQ4JNTn+kFur5nhLgDLidS6vDoGDsyA1p50+XXFv9g7jCpTkyPZhrJSgT+m1IPXvPJMw/nHaYEZ78Xba+4oHMzSgJfqskSzfreu/OvNGp+QHjGrQS5VA8ELwEFbBASo+FzoQZiYrUIbAuuAfk7r3ioSgbjB+ujnFhXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628460; c=relaxed/simple;
	bh=5JSIQgl137sVTmqrPM4/KddOA7Mi2qj0kKiSSGn7Kkc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gLp/Pl6qxKD3KwCBPxqyniFzj1fjgro3svPWCq3YcD84oSGcWF9ao9X9cNe/aeCl2NlApJ8wCz4J3mcA95NuZnZ8Fuo7DdV+aDQqdWzXjHKp9nv3GjrUxJAU0L9GZemVltecG0lCXzyYHssby3aabI7uhgGgDOmLWTVe2yU6qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5Nwkf9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7oRHEQiR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etdlP0AQEsyGIpj348UQ6dQVJZNC/3pjVbz8yEW842k=;
	b=a5Nwkf9hAXiKJKQsesE7M2IhWiKlJpC9yZgev4o3rFNU7jHvJVY3a2JEMhF+DRokLPP9ej
	ggD9XqQjD7d6qXHXDCStlPAxDQDMaZP4VJbskeoxE8Uz7HzdqtNmXgntU+6ryFDzQwMUXI
	WPEEynqpDjZhDeFJdXIb5tikLiqFK1hijyGx/10UA53s2HKDKK71/M8A3Ve413eHUkAjsJ
	IwaL2Y8ZX+rOwfvS/lH0nR4JLe5MPyqVSG67ChD4tGuOvckAPDbqbe4cDVHFpZHBk0ZDaF
	ZN/KpTg4PzuiLBEolVy5n+bcSvtLhVTpbNu3Fqoe/LKDPgrqJY2yGElexoEYlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etdlP0AQEsyGIpj348UQ6dQVJZNC/3pjVbz8yEW842k=;
	b=7oRHEQiRlwjJL92ntA72mHlP3U/tGXagCR75ZA3ktBQ+16Dzr2MtppqubrdgCf9dJxe3ph
	iF8+RFtAt2i25fBA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rhashtable: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-33-elver@google.com>
References: <20251219154418.3592607-33-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845418.510.953963495171177178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     322366b8f13a8cafe169dc1dc6f6ec0d82ff8734
Gitweb:        https://git.kernel.org/tip/322366b8f13a8cafe169dc1dc6f6ec0d82f=
f8734
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:35 +01:00

rhashtable: Enable context analysis

Enable context analysis for rhashtable, which was used as an initial
test as it contains a combination of RCU, mutex, and bit_spinlock usage.

Users of rhashtable now also benefit from annotations on the API, which
will now warn if the RCU read lock is not held where required.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-33-elver@google.com
---
 include/linux/rhashtable.h | 16 +++++++++++++---
 lib/Makefile               |  2 ++
 lib/rhashtable.c           |  5 +++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 08e664b..133ccb3 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -245,16 +245,17 @@ void *rhashtable_insert_slow(struct rhashtable *ht, con=
st void *key,
 void rhashtable_walk_enter(struct rhashtable *ht,
 			   struct rhashtable_iter *iter);
 void rhashtable_walk_exit(struct rhashtable_iter *iter);
-int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires(RCU=
);
+int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires_sha=
red(RCU);
=20
 static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
+	__acquires_shared(RCU)
 {
 	(void)rhashtable_walk_start_check(iter);
 }
=20
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
-void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
+void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases_shared(RC=
U);
=20
 void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void (*free_fn)(void *ptr, void *arg),
@@ -325,6 +326,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket_i=
nsert(
=20
 static inline unsigned long rht_lock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt)
+	__acquires(__bitlock(0, bkt))
 {
 	unsigned long flags;
=20
@@ -337,6 +339,7 @@ static inline unsigned long rht_lock(struct bucket_table =
*tbl,
 static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 					struct rhash_lock_head __rcu **bucket,
 					unsigned int subclass)
+	__acquires(__bitlock(0, bucket))
 {
 	unsigned long flags;
=20
@@ -349,6 +352,7 @@ static inline unsigned long rht_lock_nested(struct bucket=
_table *tbl,
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt,
 			      unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(0, (unsigned long *)bkt);
@@ -424,13 +428,14 @@ static inline void rht_assign_unlock(struct bucket_tabl=
e *tbl,
 				     struct rhash_lock_head __rcu **bkt,
 				     struct rhash_head *obj,
 				     unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	if (rht_is_a_nulls(obj))
 		obj =3D NULL;
 	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*bkt, (void *)obj);
 	preempt_enable();
-	__release(bitlock);
+	__release(__bitlock(0, bkt));
 	local_irq_restore(flags);
 }
=20
@@ -612,6 +617,7 @@ static __always_inline struct rhash_head *__rhashtable_lo=
okup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params,
 	const enum rht_lookup_freq freq)
+	__must_hold_shared(RCU)
 {
 	struct rhashtable_compare_arg arg =3D {
 		.ht =3D ht,
@@ -666,6 +672,7 @@ restart:
 static __always_inline void *rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he =3D __rhashtable_lookup(ht, key, params,
 						    RHT_LOOKUP_NORMAL);
@@ -676,6 +683,7 @@ static __always_inline void *rhashtable_lookup(
 static __always_inline void *rhashtable_lookup_likely(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he =3D __rhashtable_lookup(ht, key, params,
 						    RHT_LOOKUP_LIKELY);
@@ -727,6 +735,7 @@ static __always_inline void *rhashtable_lookup_fast(
 static __always_inline struct rhlist_head *rhltable_lookup(
 	struct rhltable *hlt, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he =3D __rhashtable_lookup(&hlt->ht, key, params,
 						    RHT_LOOKUP_NORMAL);
@@ -737,6 +746,7 @@ static __always_inline struct rhlist_head *rhltable_looku=
p(
 static __always_inline struct rhlist_head *rhltable_lookup_likely(
 	struct rhltable *hlt, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he =3D __rhashtable_lookup(&hlt->ht, key, params,
 						    RHT_LOOKUP_LIKELY);
diff --git a/lib/Makefile b/lib/Makefile
index e755eee..22d8742 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -50,6 +50,8 @@ lib-$(CONFIG_MIN_HEAP) +=3D min_heap.o
 lib-y	+=3D kobject.o klist.o
 obj-y	+=3D lockref.o
=20
+CONTEXT_ANALYSIS_rhashtable.o :=3D y
+
 obj-y +=3D bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index fde0f0e..6074ed5 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -358,6 +358,7 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 static int rhashtable_rehash_alloc(struct rhashtable *ht,
 				   struct bucket_table *old_tbl,
 				   unsigned int size)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *new_tbl;
 	int err;
@@ -392,6 +393,7 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
  * bucket locks or concurrent RCU protected lookups and traversals.
  */
 static int rhashtable_shrink(struct rhashtable *ht)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *old_tbl =3D rht_dereference(ht->tbl, ht);
 	unsigned int nelems =3D atomic_read(&ht->nelems);
@@ -724,7 +726,7 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_exit);
  * resize events and always continue.
  */
 int rhashtable_walk_start_check(struct rhashtable_iter *iter)
-	__acquires(RCU)
+	__acquires_shared(RCU)
 {
 	struct rhashtable *ht =3D iter->ht;
 	bool rhlist =3D ht->rhlist;
@@ -940,7 +942,6 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
  * hash table.
  */
 void rhashtable_walk_stop(struct rhashtable_iter *iter)
-	__releases(RCU)
 {
 	struct rhashtable *ht;
 	struct bucket_table *tbl =3D iter->walker.tbl;

