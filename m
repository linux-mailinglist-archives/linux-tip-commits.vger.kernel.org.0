Return-Path: <linux-tip-commits+bounces-1354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530A8FF3FC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FC71F2112C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409A3BBCC;
	Thu,  6 Jun 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQbuG2hR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWbspxkS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A91991C7;
	Thu,  6 Jun 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695913; cv=none; b=KjAv72YyKPUWGd1AaswAKcSrwCnx3ACw38RgCahegQc5/cqv36gtdHkDfyShSjmu+cWfh8+IvGAcvjSUjhAnSHKL54Mx84/6LVEk7D3JohAHL+A3KCqj/NILcEWKlP8lmdlfAXJXeEeCGUtA73zwbaLJX80FWUoywuK4Kv0xv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695913; c=relaxed/simple;
	bh=uyGm6ZUIbxbRbpt405smIVUtq5i5bFuz83fng0Jpp+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DsDk97kMgABxc3Ksu3VIN+JTUUVXuFeWGMIn27Xez5P8ahEFfeBc6u1VtUOgdsBZwXJzaUl/HaUSrYog3rbXTVD+WKb+RZlafwbnSwjRnv+oLLpg5OFjFYyGiIioiiIJSogiJPx1DGiR4DrtnNbmWa8mA5qDBC+no9IlCvukROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQbuG2hR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWbspxkS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Jun 2024 17:45:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717695909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DRLsjhbepAMwN+9568MetcDQGBIgafcDOLWHnxhD78=;
	b=zQbuG2hRd/kn6X7JoB8dNT52KQrGPGX7fipxdEbkFyOVDFNJSWxUGxsduqoaZUMrHyyQD9
	dR8f6hm197ohdYkDUqZlBpGqwuRkqiy5zvtTPlyErTbGakQcsF+GBpDJUng57w0KD0yS9y
	QbGV8vPiYAe6L4YwybKgc7yN86ZYt1B7b1BVJ03NaJsf4ExRdoBsoPHT3mtW0jHqI2kwvW
	JsxDHZ6YhOuyx8KloDd6fUfLBPzL9R67qi/YrhwMQeMk8TyAc4K0jpBf4NkS80XcA+6yDk
	UeerZZl6eof80KYOpj+vMu35YKgYOFQZzBP1M7VDqp4OIpOjm5JErxjyRGNp3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717695909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DRLsjhbepAMwN+9568MetcDQGBIgafcDOLWHnxhD78=;
	b=WWbspxkSoGyH5YQzw23KCyXQLtHY1RuMyGGyc6Ie9lcNL0ptPUF5UBUEOP+WXfhzt47EOu
	AMI2CRdeWWu8q5CQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Drop spinlocks on contention iff kernel
 is preemptible
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ankur Arora <ankur.a.arora@oracle.com>, Chen Yu <yu.c.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com>
References: <ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171769590909.10875.6998954081392102122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c793a62823d1ce8f70d9cfc7803e3ea436277cda
Gitweb:        https://git.kernel.org/tip/c793a62823d1ce8f70d9cfc7803e3ea436277cda
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Mon, 27 May 2024 17:34:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 16:52:36 +02:00

sched/core: Drop spinlocks on contention iff kernel is preemptible

Use preempt_model_preemptible() to detect a preemptible kernel when
deciding whether or not to reschedule in order to drop a contended
spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
preemption model is "none" or "voluntary".  In short, make kernels with
dynamically selected models behave the same as kernels with statically
selected models.

Somewhat counter-intuitively, NOT yielding a lock can provide better
latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
rwlock, is often contended between an invalidation event (takes mmu_lock
for write) and a vCPU servicing a guest page fault (takes mmu_lock for
read).  For _some_ setups, letting the invalidation task complete even
if there is mmu_lock contention provides lower latency for *all* tasks,
i.e. the invalidation completes sooner *and* the vCPU services the guest
page fault sooner.

But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
can vary depending on the host VMM, the guest workload, the number of
vCPUs, the number of pCPUs in the host, why there is lock contention, etc.

In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
opposite and removing contention yielding entirely) needs to come with a
big pile of data proving that changing the status quo is a net positive.

Opportunistically document this side effect of preempt=full, as yielding
contended spinlocks can have significant, user-visible impact.

Fixes: c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic preempt mode")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Link: https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 include/linux/spinlock.h                        | 14 ++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa7..555e6b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4752,7 +4752,9 @@
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
-			       can be preempted anytime.
+			       can be preempted anytime.  Tasks will also yield
+			       contended spinlocks (if the critical section isn't
+			       explicitly preempt disabled beyond the lock itself).
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3fcd20d..63dd8cf 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
@@ -479,11 +478,10 @@ static inline int spin_needbreak(spinlock_t *lock)
  */
 static inline int rwlock_needbreak(rwlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*

