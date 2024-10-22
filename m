Return-Path: <linux-tip-commits+bounces-2527-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E139AB913
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 23:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5AF284B43
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615861CCEF7;
	Tue, 22 Oct 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GT/Wd/fj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKiHmgmj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF515573B;
	Tue, 22 Oct 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634035; cv=none; b=gTLAX2eDnPGeP8ogYBldQnfD2vXLNzSJwlsrpCgfVKvqJDJN/leeXt7aSeC7mg5UUJH40LTf98v6n8zJZrzXM8ZRKdGaTVA9vQuUxGHRQblfPGG+jFN4zJp1x0/3aC0vNfYaA6RN4vEXnn+FFNtSfhvv18R5Xu9oNaKIRnZ4sCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634035; c=relaxed/simple;
	bh=1xspFbBNeFfPQZ0bdINnhp7gA77sMk56qJo3yLiyh/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QVUNUOWi03GGM/mhVjAkDocEdLrp9j91nvXYRN7MBJk8aZEFSnMf12DHZwuK9HvjUjcVZoBGMPsUCRGFgqJmM2f9gUS/ahsEfPeVGflq4hsv2VMmPopYm8PYrlkQnJWRdlq3PwMXgNQhLxCtryzY+1iyjnI7RbU9WLe2V7D4bYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GT/Wd/fj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKiHmgmj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NphCggOTd45C2oyVUTvFrGKCTzkpGm5Ad7+aiRNa3uc=;
	b=GT/Wd/fjrzHVXeqvJkHb3CrVM2AGIOjOpEfgMEmER0vEMeAc6l+2Nrc9ZwW/kpLv5DSoDW
	4AxhOP09WNt01urjBiWa+Y5d89MODBeUooYkQleBjtBiPmibtRaCGFiK7s0u83VkBJGotL
	St+lSRpaJGUfQSNH9hITkTcvMljYnDvWhJX2/X2l6AKWioxetZJX0MviwvwzEP0wbU0500
	46wdTYUMudd55XrQm672mvtNy9CHhT7VAIezvRhrZytMzu7SfgGvOtw9j0yne3E0iL6dqu
	8neMJfpyZpxAjQJkjLs2QiASVJtMFYFuxAGOd3meDCZzvboW9ZtlnQ0rtjoEwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NphCggOTd45C2oyVUTvFrGKCTzkpGm5Ad7+aiRNa3uc=;
	b=TKiHmgmjAcA3I2MR7Buto3hSJakZ9qw8w0RbzcWEH8AeCwri0phFwqPqXWWhW1VpvjTBqE
	JpxtwOCE7Je56HCw==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Cc: Waiman Long <longman@redhat.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240809014802.15320-1-qiuxu.zhuo@intel.com>
References: <20240809014802.15320-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963402982.1442.4924559467557584983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2628cbd03924b91a360f72117a9b9c78cfd050e7
Gitweb:        https://git.kernel.org/tip/2628cbd03924b91a360f72117a9b9c78cfd050e7
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Fri, 09 Aug 2024 09:48:02 +08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 21:21:16 -07:00

locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase

Convert the fields of 'enum vcpu_state' to uppercase for better
readability. No functional changes intended.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240809014802.15320-1-qiuxu.zhuo@intel.com
---
 kernel/locking/qspinlock_paravirt.h | 36 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index ac2e225..dc1cb90 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -38,13 +38,13 @@
 #define PV_PREV_CHECK_MASK	0xff
 
 /*
- * Queue node uses: vcpu_running & vcpu_halted.
- * Queue head uses: vcpu_running & vcpu_hashed.
+ * Queue node uses: VCPU_RUNNING & VCPU_HALTED.
+ * Queue head uses: VCPU_RUNNING & VCPU_HASHED.
  */
 enum vcpu_state {
-	vcpu_running = 0,
-	vcpu_halted,		/* Used only in pv_wait_node */
-	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
+	VCPU_RUNNING = 0,
+	VCPU_HALTED,		/* Used only in pv_wait_node */
+	VCPU_HASHED,		/* = pv_hash'ed + VCPU_HALTED */
 };
 
 struct pv_node {
@@ -266,7 +266,7 @@ pv_wait_early(struct pv_node *prev, int loop)
 	if ((loop & PV_PREV_CHECK_MASK) != 0)
 		return false;
 
-	return READ_ONCE(prev->state) != vcpu_running;
+	return READ_ONCE(prev->state) != VCPU_RUNNING;
 }
 
 /*
@@ -279,7 +279,7 @@ static void pv_init_node(struct mcs_spinlock *node)
 	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
 
 	pn->cpu = smp_processor_id();
-	pn->state = vcpu_running;
+	pn->state = VCPU_RUNNING;
 }
 
 /*
@@ -308,26 +308,26 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 		/*
 		 * Order pn->state vs pn->locked thusly:
 		 *
-		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
+		 * [S] pn->state = VCPU_HALTED	  [S] next->locked = 1
 		 *     MB			      MB
-		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
+		 * [L] pn->locked		[RmW] pn->state = VCPU_HASHED
 		 *
 		 * Matches the cmpxchg() from pv_kick_node().
 		 */
-		smp_store_mb(pn->state, vcpu_halted);
+		smp_store_mb(pn->state, VCPU_HALTED);
 
 		if (!READ_ONCE(node->locked)) {
 			lockevent_inc(pv_wait_node);
 			lockevent_cond_inc(pv_wait_early, wait_early);
-			pv_wait(&pn->state, vcpu_halted);
+			pv_wait(&pn->state, VCPU_HALTED);
 		}
 
 		/*
-		 * If pv_kick_node() changed us to vcpu_hashed, retain that
+		 * If pv_kick_node() changed us to VCPU_HASHED, retain that
 		 * value so that pv_wait_head_or_lock() knows to not also try
 		 * to hash this lock.
 		 */
-		cmpxchg(&pn->state, vcpu_halted, vcpu_running);
+		cmpxchg(&pn->state, VCPU_HALTED, VCPU_RUNNING);
 
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	u8 old = vcpu_halted;
+	u8 old = VCPU_HALTED;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -374,7 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
+	if (!try_cmpxchg_relaxed(&pn->state, &old, VCPU_HASHED))
 		return;
 
 	/*
@@ -407,7 +407,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * If pv_kick_node() already advanced our state, we don't need to
 	 * insert ourselves into the hash table anymore.
 	 */
-	if (READ_ONCE(pn->state) == vcpu_hashed)
+	if (READ_ONCE(pn->state) == VCPU_HASHED)
 		lp = (struct qspinlock **)1;
 
 	/*
@@ -420,7 +420,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 * Set correct vCPU state to be used by queue node wait-early
 		 * mechanism.
 		 */
-		WRITE_ONCE(pn->state, vcpu_running);
+		WRITE_ONCE(pn->state, VCPU_RUNNING);
 
 		/*
 		 * Set the pending bit in the active lock spinning loop to
@@ -460,7 +460,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 				goto gotlock;
 			}
 		}
-		WRITE_ONCE(pn->state, vcpu_hashed);
+		WRITE_ONCE(pn->state, VCPU_HASHED);
 		lockevent_inc(pv_wait_head);
 		lockevent_cond_inc(pv_wait_again, waitcnt);
 		pv_wait(&lock->locked, _Q_SLOW_VAL);

