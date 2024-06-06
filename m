Return-Path: <linux-tip-commits+bounces-1355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251298FF3FD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 19:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8916D1F20C80
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Jun 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810F1991DA;
	Thu,  6 Jun 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b5lqieGR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6D2VV++4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515819750B;
	Thu,  6 Jun 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695913; cv=none; b=CMmC0pEBT/i2SO7boxOSUEyx2i7oQS+IcjJd7k8z2NCrg9l+LljeYh+LQufcDWQcFO8Qu0dNdqJB2hYM5yV/FVb9ihV26MOZps+NNoitW9Lw4iBaB4mhwTTQVO+1N0gO7k7Yb3P6M/nqOUKeBgV1GUoUbs+e/Lha5G0UlxcPGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695913; c=relaxed/simple;
	bh=9VG1O8uxCPJ1Jf/O4qs13X01kXRuOf8uVD25gt7nWAU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fr/bIKzaBGfm8aFXnW4gyO8qjq+3qOj8m6JPSnpDYkh2LtSkVmLKEJKYtU74kyH2qwe1/Lcdf/DEnD4mHdZJrr8JluSdts4OJByeoOnuYBiZInD3jg/VHH6C5lBz98VmNOJMj1kGhN7tfXjbI1ySQu8JaEN2/H9m+/ViwIVt6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b5lqieGR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6D2VV++4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Jun 2024 17:45:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717695909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQ5zpTlWcyKkB5mrQoE/fWYdzgnwip0aaynKd3iEJgU=;
	b=b5lqieGR1TloLC7vr3xmOZTHVj8qZhrHM+XiDwS1dxoNprGn66h8QeUdYNsTkDdDU6LpnQ
	OOKOTuFnodsVdwexsbQjwgrvun+Uyojcky0MbhUfcu+9orsSy6KfgwjjuNZtv3m6A52vuM
	j/iRtDILwyIioIYKZdxZZLcETyit7qOwdyCi3PUSZO/YrikqVipwz0ciAkWYfXq/Q3zpOT
	sabjNu1XjKGpMyMqU1bstgcaJWH9abLYbvKw5y5QSgjCBdhwHrtSq7PFqDUh54SwTARSTr
	KNFGvqeQI214UyE2eoDI89wpb6ABWo+Pz0jNT19hgrhk+B4JX8Y66D3pUjM1/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717695909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQ5zpTlWcyKkB5mrQoE/fWYdzgnwip0aaynKd3iEJgU=;
	b=6D2VV++4SBaeCW+Q9rvaqvFvu2sGOUFko0y+fK3OMftTxnOPI3cAZbguZId+T4H9d/aaGC
	qwrAZgz1MlGavsDg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Move preempt_model_*() helpers from
 sched.h to preempt.h
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ankur Arora <ankur.a.arora@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240528003521.979836-2-ankur.a.arora@oracle.com>
References: <20240528003521.979836-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171769590946.10875.6251572206329384176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f0dc887f21d18791037c0166f652c67da761f16f
Gitweb:        https://git.kernel.org/tip/f0dc887f21d18791037c0166f652c67da761f16f
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Mon, 27 May 2024 17:34:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 16:52:36 +02:00

sched/core: Move preempt_model_*() helpers from sched.h to preempt.h

Move the declarations and inlined implementations of the preempt_model_*()
helpers to preempt.h so that they can be referenced in spinlock.h without
creating a potential circular dependency between spinlock.h and sched.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Link: https://lkml.kernel.org/r/20240528003521.979836-2-ankur.a.arora@oracle.com
---
 include/linux/preempt.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/sched.h   | 41 +----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9c..ce76f1a 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -481,4 +481,45 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_model_none(void);
+extern bool preempt_model_voluntary(void);
+extern bool preempt_model_full(void);
+
+#else
+
+static inline bool preempt_model_none(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_NONE);
+}
+static inline bool preempt_model_voluntary(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
+}
+static inline bool preempt_model_full(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT);
+}
+
+#endif
+
+static inline bool preempt_model_rt(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+/*
+ * Does the preemption model allow non-cooperative preemption?
+ *
+ * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
+ * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
+ * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
+ * PREEMPT_NONE model.
+ */
+static inline bool preempt_model_preemptible(void)
+{
+	return preempt_model_full() || preempt_model_rt();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac..90691d9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2064,47 +2064,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
-static inline bool preempt_model_none(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_NONE);
-}
-static inline bool preempt_model_voluntary(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
-}
-static inline bool preempt_model_full(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT);
-}
-
-#endif
-
-static inline bool preempt_model_rt(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
-/*
- * Does the preemption model allow non-cooperative preemption?
- *
- * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
- * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
- * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
- * PREEMPT_NONE model.
- */
-static inline bool preempt_model_preemptible(void)
-{
-	return preempt_model_full() || preempt_model_rt();
-}
-
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());

