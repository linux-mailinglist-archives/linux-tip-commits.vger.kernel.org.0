Return-Path: <linux-tip-commits+bounces-5470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE9AAF7EF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304531C07E47
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F24224AE4;
	Thu,  8 May 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9zy64pm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zgZqloJD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821B221FD6;
	Thu,  8 May 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700435; cv=none; b=u1R2SU3jN22DeJWMCLnoiaPXQ97FtRRYJlA6GQkZTlW1erF3zJ9dWe8MdeARnsM+0uj3aqO2H3xl/nPUjIJltk+pSuvIXR6CutDdLnJempgblSHb8fX8NE0vypRJ8jF8ncjWjNPKbvURR/Y4Y3eB0q0oHG8sAgbJgUp7Wq6IhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700435; c=relaxed/simple;
	bh=YPogsCkcIuPyqCxKuHlgKGo+uzdRStsTQl3FN48LWTI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oumRkoEFfcOnD3hcXomVauKNtGNxB2Kko0rKXWuFjFrJ3GcYrAHUTqsu5faq77vGkxiGr48+BX7J/1aIgBxzhPhSQQOSyYOrU4s4Xty55Mr2CjP15qjI3ayCA8Sg67XobrD2p5TBWAK6j+8Hbu9bcLD4krrZMUV7tWbncHcQIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9zy64pm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zgZqloJD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXB2CK/zBFSL111eIxKOZuOZKjro+/ktrMd8CtRZ5WI=;
	b=F9zy64pmy7Iou30bGAuWtmE4mPt9vxvBKzWH3b5oiBMFEPKfHNtR4h+0uyJRPcK81hlYnH
	h9Sk5II6wM/e0k8A0ZdHDZQtDkn9slV9uBNfoMVnfl/XXooKH/gbr7tFsB6Z2Lr4YcM8j4
	AJ7jvgLIciCgzF965SCJk1AVG6k9yWNvOz51GN1ezFHDTx1izAuTH7H10mEw8V4X+0c13h
	oZXGTr5LTja5JVHsW/txVw6nM+kUAnaCEWfVffRIlFxgbkq20RI9o8EPk+HPMJeI8Ovaiq
	EL3BLMNrGRebkvbBc8flQiuYBou7KSJbk5PtuKJVY2sF2FIVYv16vZOshdoVYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXB2CK/zBFSL111eIxKOZuOZKjro+/ktrMd8CtRZ5WI=;
	b=zgZqloJDJtyUwguMBiRqLP5Aj8uI+HBs7/hdkdK86kDTlzsL1Rxsx6eohbkqvBay6JxCfj
	LXz/w3T6gLGZ1OCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Allow to make the private hash immutable
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-16-bigeasy@linutronix.de>
References: <20250416162921.513656-16-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043025.406.4077003074361442688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     63e8595c060a1fef421e3eecfc05ad882dafb8ac
Gitweb:        https://git.kernel.org/tip/63e8595c060a1fef421e3eecfc05ad882dafb8ac
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:08 +02:00

futex: Allow to make the private hash immutable

My initial testing showed that:

	perf bench futex hash

reported less operations/sec with private hash. After using the same
amount of buckets in the private hash as used by the global hash then
the operations/sec were about the same.

This changed once the private hash became resizable. This feature added
an RCU section and reference counting via atomic inc+dec operation into
the hot path.
The reference counting can be avoided if the private hash is made
immutable.
Extend PR_FUTEX_HASH_SET_SLOTS by a fourth argument which denotes if the
private should be made immutable. Once set (to true) the a further
resize is not allowed (same if set to global hash).
Add PR_FUTEX_HASH_GET_IMMUTABLE which returns true if the hash can not
be changed.
Update "perf bench" suite.

For comparison, results of "perf bench futex hash -s":
- Xeon CPU E5-2650, 2 NUMA nodes, total 32 CPUs:
  - Before the introducing task local hash
    shared  Averaged 1.487.148 operations/sec (+- 0,53%), total secs = 10
    private Averaged 2.192.405 operations/sec (+- 0,07%), total secs = 10

  - With the series
    shared  Averaged 1.326.342 operations/sec (+- 0,41%), total secs = 10
    -b128   Averaged   141.394 operations/sec (+- 1,15%), total secs = 10
    -Ib128  Averaged   851.490 operations/sec (+- 0,67%), total secs = 10
    -b8192  Averaged   131.321 operations/sec (+- 2,13%), total secs = 10
    -Ib8192 Averaged 1.923.077 operations/sec (+- 0,61%), total secs = 10
    128 is the default allocation of hash buckets.
    8192 was the previous amount of allocated hash buckets.

- Xeon(R) CPU E7-8890 v3, 4 NUMA nodes, total 144 CPUs:
  - Before the introducing task local hash
    shared   Averaged 1.810.936 operations/sec (+- 0,26%), total secs = 20
    private  Averaged 2.505.801 operations/sec (+- 0,05%), total secs = 20

  - With the series
    shared   Averaged 1.589.002 operations/sec (+- 0,25%), total secs = 20
    -b1024   Averaged    42.410 operations/sec (+- 0,20%), total secs = 20
    -Ib1024  Averaged   740.638 operations/sec (+- 1,51%), total secs = 20
    -b65536  Averaged    48.811 operations/sec (+- 1,35%), total secs = 20
    -Ib65536 Averaged 1.963.165 operations/sec (+- 0,18%), total secs = 20
    1024 is the default allocation of hash buckets.
    65536 was the previous amount of allocated hash buckets.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20250416162921.513656-16-bigeasy@linutronix.de
---
 include/uapi/linux/prctl.h |  2 ++-
 kernel/futex/core.c        | 49 ++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3b93fb9..43dec6e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -367,6 +367,8 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
+# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
+# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 9e7dad5..8054fda 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -63,6 +63,7 @@ struct futex_private_hash {
 	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
+	bool		immutable;
 	struct futex_hash_bucket queues[];
 };
 
@@ -132,12 +133,16 @@ static inline bool futex_key_is_private(union futex_key *key)
 
 bool futex_private_hash_get(struct futex_private_hash *fph)
 {
+	if (fph->immutable)
+		return true;
 	return rcuref_get(&fph->users);
 }
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
 	/* Ignore return value, last put is verified via rcuref_is_dead() */
+	if (fph->immutable)
+		return;
 	if (rcuref_put(&fph->users))
 		wake_up_var(fph->mm);
 }
@@ -277,6 +282,8 @@ again:
 		if (!fph)
 			return NULL;
 
+		if (fph->immutable)
+			return fph;
 		if (rcuref_get(&fph->users))
 			return fph;
 	}
@@ -1383,6 +1390,9 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 	spin_lock_init(&fhb->lock);
 }
 
+#define FH_CUSTOM	0x01
+#define FH_IMMUTABLE	0x02
+
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 void futex_hash_free(struct mm_struct *mm)
 {
@@ -1433,10 +1443,11 @@ static bool futex_hash_less(struct futex_private_hash *a,
 	return false; /* equal */
 }
 
-static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct futex_private_hash *fph;
+	bool custom = flags & FH_CUSTOM;
 	int i;
 
 	if (hash_slots && (hash_slots == 1 || !is_power_of_2(hash_slots)))
@@ -1447,7 +1458,7 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 	 */
 	scoped_guard(rcu) {
 		fph = rcu_dereference(mm->futex_phash);
-		if (fph && !fph->hash_mask) {
+		if (fph && (!fph->hash_mask || fph->immutable)) {
 			if (custom)
 				return -EBUSY;
 			return 0;
@@ -1461,6 +1472,7 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 	rcuref_init(&fph->users, 1);
 	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
 	fph->custom = custom;
+	fph->immutable = !!(flags & FH_IMMUTABLE);
 	fph->mm = mm;
 
 	for (i = 0; i < hash_slots; i++)
@@ -1553,7 +1565,7 @@ int futex_hash_allocate_default(void)
 	if (current_buckets >= buckets)
 		return 0;
 
-	return futex_hash_allocate(buckets, false);
+	return futex_hash_allocate(buckets, 0);
 }
 
 static int futex_hash_get_slots(void)
@@ -1567,9 +1579,22 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
 
+static int futex_hash_get_immutable(void)
+{
+	struct futex_private_hash *fph;
+
+	guard(rcu)();
+	fph = rcu_dereference(current->mm->futex_phash);
+	if (fph && fph->immutable)
+		return 1;
+	if (fph && !fph->hash_mask)
+		return 1;
+	return 0;
+}
+
 #else
 
-static int futex_hash_allocate(unsigned int hash_slots, bool custom)
+static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 {
 	return -EINVAL;
 }
@@ -1578,23 +1603,35 @@ static int futex_hash_get_slots(void)
 {
 	return 0;
 }
+
+static int futex_hash_get_immutable(void)
+{
+	return 0;
+}
 #endif
 
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 {
+	unsigned int flags = FH_CUSTOM;
 	int ret;
 
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		if (arg4 != 0)
+		if (arg4 & ~FH_FLAG_IMMUTABLE)
 			return -EINVAL;
-		ret = futex_hash_allocate(arg3, true);
+		if (arg4 & FH_FLAG_IMMUTABLE)
+			flags |= FH_IMMUTABLE;
+		ret = futex_hash_allocate(arg3, flags);
 		break;
 
 	case PR_FUTEX_HASH_GET_SLOTS:
 		ret = futex_hash_get_slots();
 		break;
 
+	case PR_FUTEX_HASH_GET_IMMUTABLE:
+		ret = futex_hash_get_immutable();
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;

