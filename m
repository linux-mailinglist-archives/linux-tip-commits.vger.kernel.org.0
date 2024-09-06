Return-Path: <linux-tip-commits+bounces-2186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A496F718
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3152286283
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869021D172D;
	Fri,  6 Sep 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A14+mym2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLC4YA6I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE4156880;
	Fri,  6 Sep 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633679; cv=none; b=sPQG5+b7bdyne1Cwtiz81v4WMAflJ4vv4Ig3Pp7hIg8keEmoIKCVXX4adugH41wxJmHKCfNbQn/PrNbiPL5/NC5It9Ph8MEYBeb9e9hQsRGf5siJvEvcDQCKu1QJxnvQhV4/x7RKuZ7v19diugSf0PMiWSVULtdHSIxi8bLJdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633679; c=relaxed/simple;
	bh=VlO7EeZd3KPAQTxO05Pn/zw/Zimdne90HKTSzKmF8mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U9RNzTTwkGpa8Fq70XC+EkZu5djSMRsQQlb+ZDfRV1/jQO/n1+tyq00I9wxMUqw06hwT2PWVq0r/HpG3lDqYRYcemboOUKUhWImmmPIyVDeqCQXT4SbLl7zpITQYb1Re2OSV6ysWNojdKp3qiT8f+cKCiv0egD/c80yHz0Y1oTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A14+mym2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLC4YA6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 14:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725633675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVS+0uXrWpJOYDz8cFvZ81KUZyiMf56A8YI5YcIMhcM=;
	b=A14+mym2iaXEkh/HYK46sZ5l4evOxCZJ8nqOoBUCCo8xNfQLZYOIJO8DTEGmkCqRVCHdjr
	YS2DYRHrOJYjUF2x9EaX8k3doVAo6Mrgip1B6xvT0lqmkDt8wBlKwxO0h1Lt/r1VKTGZMQ
	UNzdHL7mh+ABO28s2p+pJ/EK41Mv5kRRhjqqzsTdujo1MLKSCz3WBpAf6u5egEqMaYaJC8
	8uIV5EBbNsFIWuhJQ+bSscRrItGzPsTqjlOypFx0kxv7CmZ4oVafEg5e62zfAcTi6J2HLU
	CaHgBwOF+qGi3V2jZztLpueW+rI7DRBj6oemEnSr1yCYuUeTKdq39BKY1I7j/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725633675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVS+0uXrWpJOYDz8cFvZ81KUZyiMf56A8YI5YcIMhcM=;
	b=oLC4YA6IDTjvPQiCYhB+E3Kr6xKHeN9N1ePUgzsp3cymr7Pk1bqAvMZJHiHvRVaUaVIW/A
	DeJmX7XOEaQlV/DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_label: Fix static_key_slow_dec() yet again
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <875xsc4ehr.ffs@tglx>
References: <875xsc4ehr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563367463.2215.5542972042769938731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     de752774f38bb766941ed1bf910ba5a9f6cc6bf7
Gitweb:        https://git.kernel.org/tip/de752774f38bb766941ed1bf910ba5a9f6cc6bf7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 16:03:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Sep 2024 16:29:22 +02:00

jump_label: Fix static_key_slow_dec() yet again

While commit 83ab38ef0a0b ("jump_label: Fix concurrency issues in
static_key_slow_dec()") fixed one problem, it created yet another,
notably the following is now possible:

  slow_dec
    if (try_dec) // dec_not_one-ish, false
    // enabled == 1
                                slow_inc
                                  if (inc_not_disabled) // inc_not_zero-ish
                                  // enabled == 2
                                    return

    guard((mutex)(&jump_label_mutex);
    if (atomic_cmpxchg(1,0)==1) // false, we're 2

                                slow_dec
                                  if (try-dec) // dec_not_one, true
                                  // enabled == 1
                                    return
    else
      try_dec() // dec_not_one, false
      WARN

Close this by creating two distinct operations, one dec_not_one()-like
for the fast path and one dec_and_test()-like for the slow path. Both
also taking the magic -1 value into account.

Thomas provided the more readable version with comments on.

Fixes: 83ab38ef0a0b ("jump_label: Fix concurrency issues in static_key_slow_dec()")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/875xsc4ehr.ffs@tglx
---
 kernel/jump_label.c | 83 ++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 6dc76b5..0881fd2 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -168,8 +168,8 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 		jump_label_update(key);
 		/*
 		 * Ensure that when static_key_fast_inc_not_disabled() or
-		 * static_key_slow_try_dec() observe the positive value,
-		 * they must also observe all the text changes.
+		 * static_key_dec() observe the positive value, they must also
+		 * observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
@@ -250,49 +250,74 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static bool static_key_slow_try_dec(struct static_key *key)
+static bool static_key_dec(struct static_key *key, bool dec_not_one)
 {
-	int v;
+	int v = atomic_read(&key->enabled);
 
-	/*
-	 * Go into the slow path if key::enabled is less than or equal than
-	 * one. One is valid to shut down the key, anything less than one
-	 * is an imbalance, which is handled at the call site.
-	 *
-	 * That includes the special case of '-1' which is set in
-	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
-	 * fully serialized in the slow path below. By the time this task
-	 * acquires the jump label lock the value is back to one and the
-	 * retry under the lock must succeed.
-	 */
-	v = atomic_read(&key->enabled);
 	do {
 		/*
-		 * Warn about the '-1' case though; since that means a
-		 * decrement is concurrent with a first (0->1) increment. IOW
-		 * people are trying to disable something that wasn't yet fully
-		 * enabled. This suggests an ordering problem on the user side.
+		 * Warn about the '-1' case; since that means a decrement is
+		 * concurrent with a first (0->1) increment. IOW people are
+		 * trying to disable something that wasn't yet fully enabled.
+		 * This suggests an ordering problem on the user side.
+		 *
+		 * Warn about the '0' case; simple underflow.
 		 */
-		WARN_ON_ONCE(v < 0);
-		if (v <= 1)
-			return false;
+		if (WARN_ON_ONCE(v <= 0))
+			return v;
+
+		if (dec_not_one && v == 1)
+			return v;
+
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
 
-	return true;
+	return v;
+}
+
+/*
+ * Fastpath: Decrement if the reference count is greater than one
+ *
+ * Returns false, if the reference count is 1 or -1 to force the caller
+ * into the slowpath.
+ *
+ * The -1 case is to handle a decrement during a concurrent first enable,
+ * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
+ * slow path is serialized the caller will observe 1 once it acquired the
+ * jump_label_mutex, so the slow path can succeed.
+ *
+ * Notably 0 (underflow) returns success such that it bails without doing
+ * anything.
+ */
+static bool static_key_dec_not_one(struct static_key *key)
+{
+	int v = static_key_dec(key, true);
+
+	return v != 1 && v != -1;
+}
+
+/*
+ * Slowpath: Decrement and test whether the refcount hit 0.
+ *
+ * Returns true if the refcount hit zero, i.e. the previous value was one.
+ */
+static bool static_key_dec_and_test(struct static_key *key)
+{
+	int v = static_key_dec(key, false);
+
+	lockdep_assert_held(&jump_label_mutex);
+	return v == 1;
 }
 
 static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+	if (static_key_dec_and_test(key))
 		jump_label_update(key);
-	else
-		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
@@ -329,7 +354,7 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 {
 	STATIC_KEY_CHECK_USE(key);
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	schedule_delayed_work(work, timeout);

