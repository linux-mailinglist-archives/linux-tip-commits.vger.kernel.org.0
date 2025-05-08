Return-Path: <linux-tip-commits+bounces-5481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14FAAF806
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C321985919
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973F22DA10;
	Thu,  8 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOcVR3Y+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0N55zLl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299E22CBD3;
	Thu,  8 May 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700442; cv=none; b=BzvcwuS6zFB6pMWbpmfmC2kfcNraXDCPQ9N00Fm5dUywY21S8fCTumfqUh5zsUwM51BqFsEfysckhnk95WwpzCgRNRNuztwUFoLMwH3+D1aH0m8AcRI5WdpFr3z6MwuLa9pQtSlaHcb0wxlQrFti+jC1z5frzuuY6gow1d6XGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700442; c=relaxed/simple;
	bh=Jt9s7NFS4qCC7hGm3z4BHUvKUfRU8OOidLMIJ3+sY8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tp4hXuQBe9q44viXXQJPDFZDLheJ/RmRz1IwQc7oBzfxtKZtru1fPnP/J5/PE9QPY58wXU0VwguUDSkmUV3L3fotCtg9nBsYVKX91gYG3bH5sGJo9RoF9dsNTk+80VIYOM9MpuYzcbNyJZYS0TiAJklAENkRrgJfZG/T0vMqWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOcVR3Y+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0N55zLl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICCVPVB4omGqOJBlrcx7+SmSauqHMSJPY1UGvkZJvRM=;
	b=sOcVR3Y+hIMihKRGt5TZ+k1UBPXizNVgMFIOT87RzRUdcLIwHXCQWRytNUFtp4JdwtgrW+
	hFvkm6BlxI3EaIvXVdI4OLRwWvzcszDPHIxUEOIY3DpiGFeNiXMmje87YmzXIhUXkjoOfu
	te8Ej1mfvG7d3mnUsWfwbRkQfV6Wd2SRmwnYBiOnkKAhrGTgS4Z90UX7U7NP6zGrufaGq2
	7MrOrOX5AnMyUdXMwWSlYic0RPmKqIlmzaWzIbNgdvzSbsbGYZc0uIFgQZShcdOqFIQlcP
	KyiW8NWMh7nt/Errf3gVRspdOO+XDNIHcSnh+NHsGagx3ODPRVXMCaRHpk3uCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICCVPVB4omGqOJBlrcx7+SmSauqHMSJPY1UGvkZJvRM=;
	b=j0N55zLlpud6SzA5bfXzNWdYsvnnDS5mECqellpDvDO+Wha3JzlyV/A0/anxOoVlQfhwNf
	ow3NtzlWAwqW93Dg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Pull futex_hash() out of futex_q_lock()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-5-bigeasy@linutronix.de>
References: <20250416162921.513656-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043847.406.10022879751966204246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2fb292096d950a67a1941949a08a60ddd3193da3
Gitweb:        https://git.kernel.org/tip/2fb292096d950a67a1941949a08a60ddd3193da3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:05 +02:00

futex: Pull futex_hash() out of futex_q_lock()

Getting the hash bucket and queuing it are two distinct actions. In
light of wanting to add a put hash bucket function later, untangle
them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-5-bigeasy@linutronix.de
---
 kernel/futex/core.c     | 7 +------
 kernel/futex/futex.h    | 2 +-
 kernel/futex/pi.c       | 3 ++-
 kernel/futex/waitwake.c | 6 ++++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cca1585..7adc914 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -502,13 +502,9 @@ void __futex_unqueue(struct futex_q *q)
 }
 
 /* The key must be already stored in q->key. */
-struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
+void futex_q_lock(struct futex_q *q, struct futex_hash_bucket *hb)
 	__acquires(&hb->lock)
 {
-	struct futex_hash_bucket *hb;
-
-	hb = futex_hash(&q->key);
-
 	/*
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
@@ -522,7 +518,6 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	q->lock_ptr = &hb->lock;
 
 	spin_lock(&hb->lock);
-	return hb;
 }
 
 void futex_q_unlock(struct futex_hash_bucket *hb)
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 16aafd0..a219903 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -354,7 +354,7 @@ static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
 #endif
 }
 
-extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
+extern void futex_q_lock(struct futex_q *q, struct futex_hash_bucket *hb);
 extern void futex_q_unlock(struct futex_hash_bucket *hb);
 
 
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 7a94184..3bf942e 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -939,7 +939,8 @@ retry:
 		goto out;
 
 retry_private:
-	hb = futex_q_lock(&q);
+	hb = futex_hash(&q.key);
+	futex_q_lock(&q, hb);
 
 	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
 				   &exiting, 0);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 6cf1070..1108f37 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -441,7 +441,8 @@ retry:
 		struct futex_q *q = &vs[i].q;
 		u32 val = vs[i].w.val;
 
-		hb = futex_q_lock(q);
+		hb = futex_hash(&q->key);
+		futex_q_lock(q, hb);
 		ret = futex_get_value_locked(&uval, uaddr);
 
 		if (!ret && uval == val) {
@@ -611,7 +612,8 @@ retry:
 		return ret;
 
 retry_private:
-	hb = futex_q_lock(q);
+	hb = futex_hash(&q->key);
+	futex_q_lock(q, hb);
 
 	ret = futex_get_value_locked(&uval, uaddr);
 

