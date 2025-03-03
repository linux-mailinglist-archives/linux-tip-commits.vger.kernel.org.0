Return-Path: <linux-tip-commits+bounces-3813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3667A4CB54
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65CC175ADA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA72356B7;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c38D8tc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGEh339Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1903232367;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=Du1bFH9ONrqbAyMb9RGvR/0yhGTwAx5AQHbBiy7ENE+vAIwJ8dEWriFn+LC62ddA9l+warURq6upHa0rlnEtfZzO2B3GvZ64qq2aZEjb3AGvMQH6YncpjGc25zhVULqsV57dHFXORjP3eQEcRtWXspDHgDRO1VeJtyyBmaKYxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=RJnDkNx4c5FdIS0oDNbmRF2a9OqyXsWjyIw5NHbS6Vk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f9fJEH/43VXvXszoFNglUXLeiYN8Fejhd7n3oZVz/1NYxNE8+ISrH09t6AEPtCDbvp8Vk02ekdM3cvr3jJgIHyjeQwHAPoJZzRtvOy8FMDWvRxHtF08Qhk0sFGTyTQt7bru/hfYY+doisJlRY7cDpl55bKJORMYnrdzEQ1UvLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c38D8tc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OGEh339Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0VS2v/9GtzeVDpXXK0j1JY9O81e2NIxoW+Rq2POy40=;
	b=c38D8tc1cAw63rBx8Lt8y6mlvyFfKHl0fGwJfbP+IgJdGwn1mb1zcpTLUdtv8ao0axUj3k
	nhjNKtP6oHThqL5n4tridsm5AUw3EqLlhjFvhLbz9QE69SfJOfI1b9nUhebK0rZiACc2AY
	bKjtWiiCPHjpdpeidZ1ptleIKxUtn570tipbiDKidGYl7Oov6/132LlM+eiQGvEQKiEUxS
	3E+6jj8R5pO1nUO3tGd1iSQcxLqREN+R63ixRLY8GkAQ1lvDiG7/InPKoCf6kgAZfLFBHL
	j+U/J3pPfBqlmXmjGX5gfUMW299bPbxlMFReyInck4YTtIJyWhadcxkBAe8JDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0VS2v/9GtzeVDpXXK0j1JY9O81e2NIxoW+Rq2POy40=;
	b=OGEh339ZHxudjmX+1Pai86q3kng+DmOIT/CX/nL8sPBjKNZ2k1Q3dfPqh9tJEOFMg+duDm
	oi9rrR+CyrxyIRCA==
From: "tip-bot2 for Ryo Takakura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Fix wait context check on softirq for PREEMPT_RT
Cc: Ryo Takakura <ryotkkr98@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250118054900.18639-1-ryotkkr98@gmail.com>
References: <20250118054900.18639-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791921.14745.9525905092448169732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8a9d677a395703ef9075c91dd04066be8a553405
Gitweb:        https://git.kernel.org/tip/8a9d677a395703ef9075c91dd04066be8a553405
Author:        Ryo Takakura <ryotkkr98@gmail.com>
AuthorDate:    Sat, 18 Jan 2025 14:49:00 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

lockdep: Fix wait context check on softirq for PREEMPT_RT

Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT."), the wait context test for mutex usage within
"in softirq context" fails as it references @softirq_context.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
---
 include/linux/bottom_half.h |  8 ++++++++
 kernel/softirq.c            | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0a..0640a14 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,7 @@
 
 #include <linux/instruction_pointer.h>
 #include <linux/preempt.h>
+#include <linux/lockdep.h>
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
@@ -15,8 +16,13 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 }
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern struct lockdep_map bh_lock_map;
+#endif
+
 static inline void local_bh_disable(void)
 {
+	lock_map_acquire_read(&bh_lock_map);
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
@@ -25,11 +31,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
 
 static inline void local_bh_enable(void)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac..e864f9c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1073,3 +1073,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif

