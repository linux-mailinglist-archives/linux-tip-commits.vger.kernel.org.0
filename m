Return-Path: <linux-tip-commits+bounces-4411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547BAA6A221
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB27AE4DA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338C214A97;
	Thu, 20 Mar 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JNpfK1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYHYHo0n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDE1A238C;
	Thu, 20 Mar 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461878; cv=none; b=R3VeRt7ChweFJw/aeWh1/OpdoY51FjlTpBKoKlMFvRu3wECRfD9hR492RhNjuMOx2QpM6BOkIufmnCf+TSsXDyutP4neDdhntJkF90uuDDWX1HjjfEFKLnkCkNMsfc+Ui+UfjX8eqrAtlA1tpOF3RQVHECbDj3PsZR5HhuZcDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461878; c=relaxed/simple;
	bh=Dst/DGFL64COKD10SvoG59LF+Is/23kUkBCSAsjgk1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PPQFec5F/QHXxTggZVULevvE+YXA5imDbupDbZWXADrVG0CcaKVQFxKdsUl5fCtq6lnxXuvdLZId+tfcYWPWQsDkwhY+xPekfsA4pB/zZZq9/EEswqQoyuWju3N964qsc/4uTxPD7PeSW07tIW8jsbE2JvI1twfJCSbUhq5gX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JNpfK1c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYHYHo0n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:11:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+3/J2hd2qN9XRVW1GlgGpad6IVb1zQuDogijj12jbo=;
	b=4JNpfK1chBOplfttSxPTcKdiveTcTuqII9skq4fHATNa/tIYvyiOtLn1NIcgwkn1fi9oVJ
	XiJQG54WvYxLOkYYk05yd6eUsPgJOrzpGAUkikE22MYd27QjZbjOKZPPv+56Z5Z7SLWdaa
	65KQXhIxxRxijlufphjGy0WYK7R4nxo56xC/hXk8jfRZ3PBEFc4dWlYsTR97jq2baE+bt9
	NJxJNYtwelUpjwIJ+Qr4KEvK7ffXOHUwnv44PalXlDCPNn2I+jr8IGD3ZZOn86/gGKY+2o
	4kbtgY1FxbT0XZp2X41aAl5LG3Ddpnb+4z7qFc8O0NIdK1RHI7c0UEPIbpEokg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+3/J2hd2qN9XRVW1GlgGpad6IVb1zQuDogijj12jbo=;
	b=FYHYHo0nSXR76j0iD+vynrvCuiL85AnGlr3ZSCj7WusaYb17hkNdPF4P8tS1owkslVIltX
	JY5DtTLJCLmGFGCA==
From: "tip-bot2 for Yujun Dong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, sched: Use smp_mb__after_atomic() in
 current_clr_polling()
Cc: Yujun Dong <yujundong@pascal-lab.net>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241230141624.155356-1-yujundong@pascal-lab.net>
References: <20241230141624.155356-1-yujundong@pascal-lab.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246187166.14745.68835127537382463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3785c7dbae0f733f13f8857beaaada5d7dc63e02
Gitweb:        https://git.kernel.org/tip/3785c7dbae0f733f13f8857beaaada5d7dc63e02
Author:        Yujun Dong <yujundong@pascal-lab.net>
AuthorDate:    Mon, 30 Dec 2024 22:16:24 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 20 Mar 2025 10:03:52 +01:00

cpuidle, sched: Use smp_mb__after_atomic() in current_clr_polling()

In architectures that use the polling bit, current_clr_polling() employs
smp_mb() to ensure that the clearing of the polling bit is visible to
other cores before checking TIF_NEED_RESCHED.

However, smp_mb() can be costly. Given that clear_bit() is an atomic
operation, replacing smp_mb() with smp_mb__after_atomic() is appropriate.

Many architectures implement smp_mb__after_atomic() as a lighter-weight
barrier compared to smp_mb(), leading to performance improvements.
For instance, on x86, smp_mb__after_atomic() is a no-op. This change
eliminates a smp_mb() instruction in the cpuidle wake-up path, saving
several CPU cycles and thereby reducing wake-up latency.

Architectures that do not use the polling bit will retain the original
smp_mb() behavior to ensure that existing dependencies remain unaffected.

Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241230141624.155356-1-yujundong@pascal-lab.net
---
 include/linux/sched/idle.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index e670ac2..439f602 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -79,6 +79,21 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	return unlikely(tif_need_resched());
 }
 
+static __always_inline void current_clr_polling(void)
+{
+	__current_clr_polling();
+
+	/*
+	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
+	 * Once the bit is cleared, we'll get IPIs with every new
+	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
+	 * fold.
+	 */
+	smp_mb__after_atomic(); /* paired with resched_curr() */
+
+	preempt_fold_need_resched();
+}
+
 #else
 static inline void __current_set_polling(void) { }
 static inline void __current_clr_polling(void) { }
@@ -91,21 +106,15 @@ static inline bool __must_check current_clr_polling_and_test(void)
 {
 	return unlikely(tif_need_resched());
 }
-#endif
 
 static __always_inline void current_clr_polling(void)
 {
 	__current_clr_polling();
 
-	/*
-	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
-	 * Once the bit is cleared, we'll get IPIs with every new
-	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
-	 * fold.
-	 */
 	smp_mb(); /* paired with resched_curr() */
 
 	preempt_fold_need_resched();
 }
+#endif
 
 #endif /* _LINUX_SCHED_IDLE_H */

