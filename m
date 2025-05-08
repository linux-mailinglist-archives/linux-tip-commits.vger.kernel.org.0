Return-Path: <linux-tip-commits+bounces-5478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA3AAF800
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B190C9E2565
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9422CBE9;
	Thu,  8 May 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0dRhPjP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6x8CPHQK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE72144CF;
	Thu,  8 May 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700440; cv=none; b=PK18ydUlIpXPWGFVb64MHCEGO9hU5QtkRyHDC9FoXDQcGeore94buShuCU95W6zYf46QJbQ3/CFwpBisaNG3lZq3CdSi7vtNHQ7akCQmmwlhXjgdcc8HnGO2ln0W3Uo4aevRg7NwgPB2yLAt3sAz+rtG8kVDh1Z5Qh2nS3FPgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700440; c=relaxed/simple;
	bh=IFo0+QmhA55lMOQfAv2U6YbY4Qgj/Lyhadk8wjCDTUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AlMKy+Og470VFs7cXwgHt3Ens//bZnNs8XDAM49evhQXtnrZsolnjcF548+d8M3TX2fpOK0/fe00drdkDpoggw5/+gxbnNzGbWBdQwKVe3PZi+moITKU6TFCu0PADLy/GY/JM2EDVoahp9Tpb5O5nQSjRvJpmLhXJmpeq6u6DKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0dRhPjP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6x8CPHQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGIomkOBDn9V35HGDXO6Dp0csgp4r28hRjdTk6LRBCo=;
	b=m0dRhPjP5LGPN2MOjSWI511wQtexwK0YDQnb35Z04S6YYy3Svy8SJcVkhkHGmlsQNXYXcL
	pBytDRs8gBoOo5tDH1ycvWTLJunAJrhlsiZmL0OZBdisReEAQFhlePihhRXnWYXdukWaso
	fGE4s6jaF6fJE7GArv1lB59W58LgyT83oFTVF/1y2FekqlDOaRb+AISdNgXByjUj7RWjhT
	z2Z+NueEa+0PFH7O33cQ2lcQVSUC9H8xh1M2qt6dFdZ1z547QcgGTJowZ+t3Rz0OG/2sfz
	WM8ay2KPojlenmAbAKjdwOyBCUZ9J6iNpNeuLJrCz16xcQfYq0d8Q4BH1pVHsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGIomkOBDn9V35HGDXO6Dp0csgp4r28hRjdTk6LRBCo=;
	b=6x8CPHQKE2XkZO5Dasjr8sVdJg8QFpx5JBs/0Q5htbGNMuYOl1T8w0GuTDUleDY01AAJao
	CRsUW3urJwH5UDAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Decrease the waiter count before the
 unlock operation
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-10-bigeasy@linutronix.de>
References: <20250416162921.513656-10-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043473.406.1014453652831723224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     fe00e88d217a7bf7a4d0268d08f51e624d40ee53
Gitweb:        https://git.kernel.org/tip/fe00e88d217a7bf7a4d0268d08f51e624d40ee53
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:06 +02:00

futex: Decrease the waiter count before the unlock operation

To support runtime resizing of the process private hash, it's required
to not use the obtained hash bucket once the reference count has been
dropped. The reference will be dropped after the unlock of the hash
bucket.
The amount of waiters is decremented after the unlock operation. There
is no requirement that this needs to happen after the unlock. The
increment happens before acquiring the lock to signal early that there
will be a waiter. The waiter can avoid blocking on the lock if it is
known that there will be no waiter.
There is no difference in terms of ordering if the decrement happens
before or after the unlock.

Decrease the waiter count before the unlock operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-10-bigeasy@linutronix.de
---
 kernel/futex/core.c    | 2 +-
 kernel/futex/requeue.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 6a1d6b1..5e70cb8 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -537,8 +537,8 @@ void futex_q_lock(struct futex_q *q, struct futex_hash_bucket *hb)
 void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
 	futex_hb_waiters_dec(hb);
+	spin_unlock(&hb->lock);
 }
 
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 992e3ce..023c028 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -456,8 +456,8 @@ retry_private:
 			ret = futex_get_value_locked(&curval, uaddr1);
 
 			if (unlikely(ret)) {
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 
 				ret = get_user(curval, uaddr1);
 				if (ret)
@@ -542,8 +542,8 @@ retry_private:
 				 * waiter::requeue_state is correct.
 				 */
 			case -EFAULT:
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				ret = fault_in_user_writeable(uaddr2);
 				if (!ret)
 					goto retry;
@@ -556,8 +556,8 @@ retry_private:
 				 *   exit to complete.
 				 * - EAGAIN: The user space value changed.
 				 */
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				/*
 				 * Handle the case where the owner is in the middle of
 				 * exiting. Wait for the exit to complete otherwise
@@ -674,8 +674,8 @@ retry_private:
 		put_pi_state(pi_state);
 
 out_unlock:
-		double_unlock_hb(hb1, hb2);
 		futex_hb_waiters_dec(hb2);
+		double_unlock_hb(hb1, hb2);
 	}
 	wake_up_q(&wake_q);
 	return ret ? ret : task_count;

