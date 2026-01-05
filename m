Return-Path: <linux-tip-commits+bounces-7792-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE4CF48EA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E91E31582B3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45AC33EB18;
	Mon,  5 Jan 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxtrCMRR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJcg0+Mp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68C3002AB;
	Mon,  5 Jan 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628462; cv=none; b=q2KpjNlIELmxrrSRb0PXHPyaOxEBEkaUNbn3PDX7VnBerfHOhERcYbFXF80+11OJQ+lcdZEJYdVLgJFIFHsjVWhGMr3ntwic/EZGtku7WJPFTKTrwcjpUDDH4pU7kWSTPVo1WYsGFcecp0UmTELbZ+DJW8/YV09+W3LY7X8vXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628462; c=relaxed/simple;
	bh=Hs76y3MO8ZYdBfrOaJAaBecsBkakp0XF3JHcUG1+Gv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oCtHYGFMiq+Kzax/9SAdlDZnLw3EscrOPvEgi9EJwrDO5U1JVi9Pkmb1+Tu30xkmGc+MbqMGruiWKrMvvN1Q9rwuGnUq5AoIbUCIFVTQ0F0b/K+yE1SXNWMaJrbI0dmR+KjfTxtWeDCnZ7vo6x+TQnL/JtnJwvkzqv1zvDKIjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxtrCMRR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJcg0+Mp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVQFMcszhEJTFH/c+TaT7YUjFeuOUKR2hGE2WeHLYSg=;
	b=lxtrCMRRU/4PLM3oZhMt9c3Lsb0nKA1hWClQHKNerrlHmPLv98lHmlWkmGmlXfSGkbQJPk
	pjKMFJo3E3FUd97Ru893Q/WMnFZCAGxUk/sKf/Hh807ro6QgmdXDhf4Vcc64ddHhKyNf7a
	pb0JPic2/DwmkTZ0mZ4ZRYgduhK2XJpP94YdlQiG+VTJPXfNcQhEtd8D7fDkmYV06qn1aX
	C0Mzf3Q16jb7GuWPgEbd25ztsYwZ8adF76CgeMaiy46JWDhLiye0fUk5sgs8NJixP+Pbjh
	zhwSqJGLG9vns5ErGvHZLRefVB7ECMxT5jO7ldiFpSq6JbKz4Paxw4WKOZIOIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVQFMcszhEJTFH/c+TaT7YUjFeuOUKR2hGE2WeHLYSg=;
	b=vJcg0+MpyMebJTuLbjCTzIp/RKGFaLM6gqdH5eU3eJD6uinTe/c4F6FH1hV9aoa0ABBFyt
	slcGVWEs7buO4WAw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] stackdepot: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-32-elver@google.com>
References: <20251219154418.3592607-32-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845530.510.12382375981998234833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c3d3023f1cf3de10f2d2f83b0d011fa7cab16cf0
Gitweb:        https://git.kernel.org/tip/c3d3023f1cf3de10f2d2f83b0d011fa7cab=
16cf0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:35 +01:00

stackdepot: Enable context analysis

Enable context analysis for stackdepot.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-32-elver@google.com
---
 lib/Makefile     |  1 +
 lib/stackdepot.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 89defef..e755eee 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_POLYNOMIAL) +=3D polynomial.o
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from th=
is
 # file.
 CFLAGS_stackdepot.o +=3D -fno-builtin
+CONTEXT_ANALYSIS_stackdepot.o :=3D y
 obj-$(CONFIG_STACKDEPOT) +=3D stackdepot.o
 KASAN_SANITIZE_stackdepot.o :=3D n
 # In particular, instrumenting stackdepot.c with KMSAN will result in infini=
te
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index de0b002..166f50a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -61,18 +61,18 @@ static unsigned int stack_bucket_number_order;
 /* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
=20
+/* The lock must be held when performing pool or freelist modifications. */
+static DEFINE_RAW_SPINLOCK(pool_lock);
 /* Array of memory regions that store stack records. */
-static void **stack_pools;
+static void **stack_pools __pt_guarded_by(&pool_lock);
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
 /* Offset to the unused space in the currently used pool. */
-static size_t pool_offset =3D DEPOT_POOL_SIZE;
+static size_t pool_offset __guarded_by(&pool_lock) =3D DEPOT_POOL_SIZE;
 /* Freelist of stack records within stack_pools. */
-static LIST_HEAD(free_stacks);
-/* The lock must be held when performing pool or freelist modifications. */
-static DEFINE_RAW_SPINLOCK(pool_lock);
+static __guarded_by(&pool_lock) LIST_HEAD(free_stacks);
=20
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
@@ -291,6 +291,7 @@ EXPORT_SYMBOL_GPL(stack_depot_init);
  * Initializes new stack pool, and updates the list of pools.
  */
 static bool depot_init_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
=20
@@ -338,6 +339,7 @@ static bool depot_init_pool(void **prealloc)
=20
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
=20
@@ -357,6 +359,7 @@ static void depot_keep_new_pool(void **prealloc)
  * the current pre-allocation.
  */
 static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
 	void *current_pool;
@@ -391,6 +394,7 @@ static struct stack_record *depot_pop_free_pool(void **pr=
ealloc, size_t size)
=20
 /* Try to find next free usable entry from the freelist. */
 static struct stack_record *depot_pop_free(void)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
=20
@@ -428,6 +432,7 @@ static inline size_t depot_stack_record_size(struct stack=
_record *s, unsigned in
 /* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
 depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash,=
 depot_flags_t flags, void **prealloc)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack =3D NULL;
 	size_t record_size;
@@ -486,6 +491,7 @@ depot_alloc_stack(unsigned long *entries, unsigned int nr=
_entries, u32 hash, dep
 }
=20
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
+	__must_not_hold(&pool_lock)
 {
 	const int pools_num_cached =3D READ_ONCE(pools_num);
 	union handle_parts parts =3D { .handle =3D handle };
@@ -502,7 +508,8 @@ static struct stack_record *depot_fetch_stack(depot_stack=
_handle_t handle)
 		return NULL;
 	}
=20
-	pool =3D stack_pools[pool_index];
+	/* @pool_index either valid, or user passed in corrupted value. */
+	pool =3D context_unsafe(stack_pools[pool_index]);
 	if (WARN_ON(!pool))
 		return NULL;
=20
@@ -515,6 +522,7 @@ static struct stack_record *depot_fetch_stack(depot_stack=
_handle_t handle)
=20
 /* Links stack into the freelist. */
 static void depot_free_stack(struct stack_record *stack)
+	__must_not_hold(&pool_lock)
 {
 	unsigned long flags;
=20

