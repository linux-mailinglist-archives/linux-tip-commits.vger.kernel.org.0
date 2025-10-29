Return-Path: <linux-tip-commits+bounces-7040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0CC196AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09F7C50737D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B732C312;
	Wed, 29 Oct 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WRQ87TJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixDX1xFQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE96329C4D;
	Wed, 29 Oct 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730578; cv=none; b=h05zby1AAr06dnVDyUys6rOuHp6G1ItksGHoSnMFhqTD7VRPqnmaft5otOXpMAsHy64DZ8MU6PsokwT8mfbFeCYWuYAXq2NuoxZvQZ5gzES2N0uj/zZDMKlIEEjZ/5x65/kKLPVifhNkKJNBOL+5Hb+V6999xr3ErjmzRMJsstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730578; c=relaxed/simple;
	bh=f9WwFVOM+qzvYvZ2R9aupnRFR49jh1Nbtl3Hzb8fMUc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OoFwnJXo8nydfWmSeVhv3LgsBxTW/tfsSfpw+HJTujyFHv6drhhXeS1gnXQn8mKhiC5vxFpINq7x5cuGgP5j7D0hH/bpd7OrE5UGSNmJoQSkZyWndMWFJcXSBlcw+P6ksaGmKTV5B8ZPocm4FAX2tDKj5FiwXPpn6xQRd+RGcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WRQ87TJh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixDX1xFQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbEy2Tf9uV2/3KAv3K7rMjTZgXTK7tscD5ykdpw6jhE=;
	b=WRQ87TJhWVHBefvJtQDaHs+wpoOAgcNsKLhl8K18mNt5DH47mb13o0CQo1Dw+LoTGCvYV7
	RLzb7iymZxRE7WSmMzHhpnL2kufL44fX0nGPCMXHaUW8Yy+8znD9mVRxP0h3FsEFPp1bkX
	UOy8cy/pndo22nD8WvY3j6WgQF+psUJUmTen85vZy7RuO3mjOpAUpMEvP9rUetuV9bVfAI
	7ArP9PxTce25bFe7qILPRrKUOU7CUr70Rd0m/gUF6HRWQY3bRo2K0cS/Ft+0QqAxdtzjJn
	DiV5xXBD5j+FfKReyGobVd9D8Yhqwk11BdOqE8DGViJEjYMfw0gqaO4HjPQIbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbEy2Tf9uV2/3KAv3K7rMjTZgXTK7tscD5ykdpw6jhE=;
	b=ixDX1xFQ57CbGDrddVs6jts6lriw0vchvH8bWZvh81oRRkgPPrH7nIwPD/7+IWb0Ggposa
	+6qwTNA0KpPxPICQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] unwind: Make unwind_task_info::unwind_mask consistent
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.384384486@infradead.org>
References: <20250924080119.384384486@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057318.2601451.3711090924055288815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     639214f65b1db87c6992eadf93079ff0d8768c2d
Gitweb:        https://git.kernel.org/tip/639214f65b1db87c6992eadf93079ff0d87=
68c2d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 16:09:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:57 +01:00

unwind: Make unwind_task_info::unwind_mask consistent

The unwind_task_info::unwind_mask was manipulated using a mixture of:

  regular store
  WRITE_ONCE()
  try_cmpxchg()
  set_bit()
  atomic_long_*()

Clean up and make it consistently atomic_long_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250924080119.384384486@infradead.org
---
 include/linux/unwind_deferred.h       |  4 ++--
 include/linux/unwind_deferred_types.h |  3 ++-
 kernel/unwind/deferred.c              | 17 +++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 196e12c..f4743c8 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -46,7 +46,7 @@ void unwind_deferred_task_exit(struct task_struct *task);
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info =3D &current->unwind_info;
-	unsigned long bits =3D info->unwind_mask;
+	unsigned long bits =3D atomic_long_read(&info->unwind_mask);
=20
 	/* Was there any unwinding? */
 	if (likely(!bits))
@@ -56,7 +56,7 @@ static __always_inline void unwind_reset_info(void)
 		/* Is a task_work going to run again before going back */
 		if (bits & UNWIND_PENDING)
 			return;
-	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+	} while (!atomic_long_try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 	current->unwind_info.id.id =3D 0;
=20
 	if (unlikely(info->cache)) {
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_def=
erred_types.h
index 29452ff..0a4c8dd 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
=20
 #include <linux/types.h>
+#include <linux/atomic.h>
=20
 struct unwind_cache {
 	unsigned long		unwind_completed;
@@ -32,7 +33,7 @@ union unwind_task_id {
 };
=20
 struct unwind_task_info {
-	unsigned long		unwind_mask;
+	atomic_long_t		unwind_mask;
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	union unwind_task_id	id;
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 09617d8..a88fb48 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -53,7 +53,7 @@ DEFINE_STATIC_SRCU(unwind_srcu);
=20
 static inline bool unwind_pending(struct unwind_task_info *info)
 {
-	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
+	return atomic_long_read(&info->unwind_mask) & UNWIND_PENDING;
 }
=20
 /*
@@ -141,7 +141,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	cache->nr_entries =3D trace->nr;
=20
 	/* Clear nr_entries on way back to user space */
-	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+	atomic_long_or(UNWIND_USED, &info->unwind_mask);
=20
 	return 0;
 }
@@ -159,7 +159,7 @@ static void process_unwind_deferred(struct task_struct *t=
ask)
=20
 	/* Clear pending bit but make sure to have the current bits */
 	bits =3D atomic_long_fetch_andnot(UNWIND_PENDING,
-				  (atomic_long_t *)&info->unwind_mask);
+					&info->unwind_mask);
 	/*
 	 * From here on out, the callback must always be called, even if it's
 	 * just an empty trace.
@@ -264,7 +264,7 @@ int unwind_deferred_request(struct unwind_work *work, u64=
 *cookie)
=20
 	*cookie =3D get_cookie(info);
=20
-	old =3D READ_ONCE(info->unwind_mask);
+	old =3D atomic_long_read(&info->unwind_mask);
=20
 	/* Is this already queued or executed */
 	if (old & bit)
@@ -277,7 +277,7 @@ int unwind_deferred_request(struct unwind_work *work, u64=
 *cookie)
 	 * to have a callback.
 	 */
 	bits =3D UNWIND_PENDING | bit;
-	old =3D atomic_long_fetch_or(bits, (atomic_long_t *)&info->unwind_mask);
+	old =3D atomic_long_fetch_or(bits, &info->unwind_mask);
 	if (old & bits) {
 		/*
 		 * If the work's bit was set, whatever set it had better
@@ -291,7 +291,7 @@ int unwind_deferred_request(struct unwind_work *work, u64=
 *cookie)
 	ret =3D task_work_add(current, &info->work, twa_mode);
=20
 	if (WARN_ON_ONCE(ret))
-		WRITE_ONCE(info->unwind_mask, 0);
+		atomic_long_set(&info->unwind_mask, 0);
=20
 	return ret;
 }
@@ -323,7 +323,8 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(bit, &t->unwind_info.unwind_mask);
+		atomic_long_andnot(BIT(bit),
+				   &t->unwind_info.unwind_mask);
 		if (t->unwind_info.cache)
 			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
 	}
@@ -353,7 +354,7 @@ void unwind_task_init(struct task_struct *task)
=20
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
-	info->unwind_mask =3D 0;
+	atomic_long_set(&info->unwind_mask, 0);
 }
=20
 void unwind_task_free(struct task_struct *task)

