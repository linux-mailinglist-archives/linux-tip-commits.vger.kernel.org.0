Return-Path: <linux-tip-commits+bounces-1429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFB90B57F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFB2855A8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A51474C1;
	Mon, 17 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDGkjjsy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLWhpXB2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759C146D77;
	Mon, 17 Jun 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639244; cv=none; b=Gft/LXIKWFYLXfbBu17r10y6QU6CrcV7zQSH7Qd8fli3TxljT5pEgMVNn2ZZzCsSDnlXyb4aHL4e7cq6vsG80gVHT2kdVlzoKldgN8qNSVTwb7Kzl9qFkg5CU9u0JSJhH6HFYEdfFEgXmT2sa9Fa1CsPBsHnWUXvtkCiZMIPnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639244; c=relaxed/simple;
	bh=h+oIY9z+hklgImUQF6E5P5MllMYIWwbKExLM6kJof2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y41nPceicUoNxqGnSYAk+HihRaDYRe3zPTdq7c4swpUI7iyffY2SooljYbOwCGtpBq4vrPWSdsuIZRRGBUEXmE855CDblTqk4UAhM6w8wBzmuaQvgVSQW34RqvY42nPFGKsG4SglEVdtNblaCSwLXssxg2SblUKiE3f7idNP5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDGkjjsy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLWhpXB2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 15:47:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+Cxg5aV3DrYfqRTWSUD6hzF+KYAGnJX+Bw6r4uVbfM=;
	b=eDGkjjsyMoMX50HGfYsUbbhNsDzs7l6EuyKM9efk1vLrqn3GyH0L+IsCLKXa1s2W2kXMWh
	YR5ILLKbQHBxNYBBJxEgq8bPoqtcuIbdJ1kD2X4NQonAHitTtWyo5FmqC9rtOGob9lFStZ
	7tKMxIdZGzaVxJVo/0/tGMjZEDlkA2NzUbDJkbocwR/JEKCsVXZK4JZk2rPjbw2lvY5nZ3
	4F+pySFvDkuhS/NPZtlo7hGxgkIFbqHGnfZTO0VXanCniajQv/J/P59XJ7oIXzzH1loNPD
	EjLeaSvdYvIVtFv9zED8nPoIEFGGVmCERxEsha1CBx3S19bktsZHW6rVP/Jfpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+Cxg5aV3DrYfqRTWSUD6hzF+KYAGnJX+Bw6r4uVbfM=;
	b=WLWhpXB2ZofI0LIM7QreI5c+z+CtJe0QKwcgoUwrXR7rVJb7gTqalVqDiXL/TBrTlj3q1v
	gGoHHWTB7qR+TEAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Fix concurrency issues in
 static_key_slow_dec()
Cc: Yue Sun <samsun1006219@gmail.com>, Xingwei Lee <xrivendell7@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610124406.422897838@linutronix.de>
References: <20240610124406.422897838@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863923908.10875.16051115443404235815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     83ab38ef0a0b2407d43af9575bb32333fdd74fb2
Gitweb:        https://git.kernel.org/tip/83ab38ef0a0b2407d43af9575bb32333fdd74fb2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 14:46:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Jun 2024 11:25:23 +02:00

jump_label: Fix concurrency issues in static_key_slow_dec()

The commit which tried to fix the concurrency issues of concurrent
static_key_slow_inc() failed to fix the equivalent issues
vs. static_key_slow_dec():

CPU0                     CPU1

static_key_slow_dec()
  static_key_slow_try_dec()

	key->enabled == 1
	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
	if (val == 1)
	     return false;

  jump_label_lock();
  if (atomic_dec_and_test(&key->enabled)) {
     --> key->enabled == 0
   __jump_label_update()

			 static_key_slow_dec()
			   static_key_slow_try_dec()

			     key->enabled == 0
			     val = atomic_fetch_add_unless(&key->enabled, -1, 1);

			      --> key->enabled == -1 <- FAIL

There is another bug in that code, when there is a concurrent
static_key_slow_inc() which enables the key as that sets key->enabled to -1
so on the other CPU

	val = atomic_fetch_add_unless(&key->enabled, -1, 1);

will succeed and decrement to -2, which is invalid.

Cure all of this by replacing the atomic_fetch_add_unless() with a
atomic_try_cmpxchg() loop similar to static_key_fast_inc_not_disabled().

[peterz: add WARN_ON_ONCE for the -1 race]
Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.422897838@linutronix.de
---
 kernel/jump_label.c | 45 ++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 3218fa5..1f05a19 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -131,7 +131,7 @@ bool static_key_fast_inc_not_disabled(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	/*
 	 * Negative key->enabled has a special meaning: it sends
-	 * static_key_slow_inc() down the slow path, and it is non-zero
+	 * static_key_slow_inc/dec() down the slow path, and it is non-zero
 	 * so it counts as "enabled" in jump_label_update().  Note that
 	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
 	 */
@@ -150,7 +150,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	lockdep_assert_cpus_held();
 
 	/*
-	 * Careful if we get concurrent static_key_slow_inc() calls;
+	 * Careful if we get concurrent static_key_slow_inc/dec() calls;
 	 * later calls must wait for the first one to _finish_ the
 	 * jump_label_update() process.  At the same time, however,
 	 * the jump_label_update() call below wants to see
@@ -247,20 +247,32 @@ EXPORT_SYMBOL_GPL(static_key_disable);
 
 static bool static_key_slow_try_dec(struct static_key *key)
 {
-	int val;
-
-	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
-	if (val == 1)
-		return false;
+	int v;
 
 	/*
-	 * The negative count check is valid even when a negative
-	 * key->enabled is in use by static_key_slow_inc(); a
-	 * __static_key_slow_dec() before the first static_key_slow_inc()
-	 * returns is unbalanced, because all other static_key_slow_inc()
-	 * instances block while the update is in progress.
+	 * Go into the slow path if key::enabled is less than or equal than
+	 * one. One is valid to shut down the key, anything less than one
+	 * is an imbalance, which is handled at the call site.
+	 *
+	 * That includes the special case of '-1' which is set in
+	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
+	 * fully serialized in the slow path below. By the time this task
+	 * acquires the jump label lock the value is back to one and the
+	 * retry under the lock must succeed.
 	 */
-	WARN(val < 0, "jump label: negative count!\n");
+	v = atomic_read(&key->enabled);
+	do {
+		/*
+		 * Warn about the '-1' case though; since that means a
+		 * decrement is concurrent with a first (0->1) increment. IOW
+		 * people are trying to disable something that wasn't yet fully
+		 * enabled. This suggests an ordering problem on the user side.
+		 */
+		WARN_ON_ONCE(v < 0);
+		if (v <= 1)
+			return false;
+	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
+
 	return true;
 }
 
@@ -271,10 +283,11 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 	if (static_key_slow_try_dec(key))
 		return;
 
-	jump_label_lock();
-	if (atomic_dec_and_test(&key->enabled))
+	guard(mutex)(&jump_label_mutex);
+	if (atomic_cmpxchg(&key->enabled, 1, 0))
 		jump_label_update(key);
-	jump_label_unlock();
+	else
+		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)

