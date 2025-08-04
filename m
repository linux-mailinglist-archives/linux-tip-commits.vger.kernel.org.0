Return-Path: <linux-tip-commits+bounces-6233-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DCB1AAFF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F0D189FAC5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Aug 2025 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1928B3FD;
	Mon,  4 Aug 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NrMvLysl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MCexnNW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A1917E3;
	Mon,  4 Aug 2025 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347326; cv=none; b=UTRHdbOM+b43+bPf4oGdvSEOt5tIx2/iAqoMBrOFla8DGx/IyUtk6JoPpfOBvhln1Smnzsxoxa5peoQAtQ7IRO9Kr9bRCBJqpje3nYCVNwWZLqslG+PEHdZJwlKbgWilQ6vxI974+DO/E/HTB5ne8QCwlnMVL5WdzkKFWeHqGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347326; c=relaxed/simple;
	bh=F3rT9VhiEn1cprxuycemIGbq7Kq3qEL31yLdVczjeKU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ror+cVc+bRLEw/lBd+KZuxB6o8OySVTdn1m/qrGQ/4AxqVGctv6G05BUi+DQ3Tc1A9p55Df/n9A0LH6vfJ5cZ5RoAXKon/R+jW0qiR6rDO4cwdg6oWkR9sJPvAgfbsAO6CfFErCPf6XOB/ghBxPAeISu4Je+ow2LW118JslCLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NrMvLysl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MCexnNW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Aug 2025 22:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754347323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dt9Td28EOzuc+bIXGqpUQkEOOmQqt80jnH8LgqzNK2g=;
	b=NrMvLyslYkuXqkCH9slSGbiaRVjESFRg2SI5lKCi6TAHV54s7BN965Nz3M/Z6uiUu45r9v
	AOATC1Fy6oPEWYxF0tar1XyR/blVPh5aOvqfh+boTwkQNhwgc9WEYkRP2irNtO4gU21188
	LOzaVs7c48kRv7HwdkaFIfcWgQdeBFHb4ZcXlWrqBawK4wvICTevJ3dCU8fuckWQdG8BEW
	qyUL7pqglkq2QHx3kr7dSQpBWBrir4W2AFjUSkYgagmZf17zDbjorNfvRsYY6uCxZWYvLG
	YtaS6AxaivYrbW+xqWQCejxyGpDkt9TxIOZeHk9KOSisLUz6zBdUGinc9/G2Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754347323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dt9Td28EOzuc+bIXGqpUQkEOOmQqt80jnH8LgqzNK2g=;
	b=3MCexnNWKgaj7f8uYvmWWXzarWCMb4pRvojly08JxqwTHWfQcRgri8aytnfDBtxPeBNJgt
	/AaIr/Ovr0U3H4Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/irq: Plug vector setup race
Cc: Hogan Wang <hogan.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <draft-87ikjhrhhh.ffs@tglx>
References: <draft-87ikjhrhhh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175434732073.1420.15265473606517387764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ce0b5eedcb753697d43f61dd2e27d68eb5d3150f
Gitweb:        https://git.kernel.org/tip/ce0b5eedcb753697d43f61dd2e27d68eb5d=
3150f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Jul 2025 12:49:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Aug 2025 23:34:03 +02:00

x86/irq: Plug vector setup race

Hogan reported a vector setup race, which overwrites the interrupt
descriptor in the per CPU vector array resulting in a disfunctional device.

CPU0				CPU1
				interrupt is raised in APIC IRR
				but not handled
  free_irq()
    per_cpu(vector_irq, CPU1)[vector] =3D VECTOR_SHUTDOWN;

  request_irq()			common_interrupt()
  				  d =3D this_cpu_read(vector_irq[vector]);

    per_cpu(vector_irq, CPU1)[vector] =3D desc;

    				  if (d =3D=3D VECTOR_SHUTDOWN)
				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);

free_irq() cannot observe the pending vector in the CPU1 APIC as there is
no way to query the remote CPUs APIC IRR.

This requires that request_irq() uses the same vector/CPU as the one which
was freed, but this also can be triggered by a spurious interrupt.

Interestingly enough this problem managed to be hidden for more than a
decade.

Prevent this by reevaluating vector_irq under the vector lock, which is
held by the interrupt activation code when vector_irq is updated.

To avoid ifdeffery or IS_ENABLED() nonsense, move the
[un]lock_vector_lock() declarations out under the
CONFIG_IRQ_DOMAIN_HIERARCHY guard as it's only provided when
CONFIG_X86_LOCAL_APIC=3Dy.

The current CONFIG_IRQ_DOMAIN_HIERARCHY guard is selected by
CONFIG_X86_LOCAL_APIC, but can also be selected by other parts of the
Kconfig system, which makes 32-bit UP builds with CONFIG_X86_LOCAL_APIC=3Dn
fail.

Can we just get rid of this !APIC nonsense once and forever?

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug=
 retriggered irqs")
Reported-by: Hogan Wang <hogan.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hogan Wang <hogan.wang@huawei.com>
Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
---
 arch/x86/include/asm/hw_irq.h | 12 +++---
 arch/x86/kernel/irq.c         | 63 +++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 162ebd7..cbe19e6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -92,8 +92,6 @@ struct irq_cfg {
=20
 extern struct irq_cfg *irq_cfg(unsigned int irq);
 extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
-extern void lock_vector_lock(void);
-extern void unlock_vector_lock(void);
 #ifdef CONFIG_SMP
 extern void vector_schedule_cleanup(struct irq_cfg *);
 extern void irq_complete_move(struct irq_cfg *cfg);
@@ -101,12 +99,16 @@ extern void irq_complete_move(struct irq_cfg *cfg);
 static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
 static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
-
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
+
+#ifdef CONFIG_X86_LOCAL_APIC
+extern void lock_vector_lock(void);
+extern void unlock_vector_lock(void);
+#else
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif
=20
 /* Statistics */
 extern atomic_t irq_err_count;
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9ed29ff..10721a1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -256,26 +256,59 @@ static __always_inline void handle_irq(struct irq_desc =
*desc,
 		__handle_irq(desc, regs);
 }
=20
-static __always_inline int call_irq_handler(int vector, struct pt_regs *regs)
+static struct irq_desc *reevaluate_vector(int vector)
 {
-	struct irq_desc *desc;
-	int ret =3D 0;
+	struct irq_desc *desc =3D __this_cpu_read(vector_irq[vector]);
+
+	if (!IS_ERR_OR_NULL(desc))
+		return desc;
+
+	if (desc =3D=3D VECTOR_UNUSED)
+		pr_emerg_ratelimited("No irq handler for %d.%u\n", smp_processor_id(), vec=
tor);
+	else
+		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	return NULL;
+}
+
+static __always_inline bool call_irq_handler(int vector, struct pt_regs *reg=
s)
+{
+	struct irq_desc *desc =3D __this_cpu_read(vector_irq[vector]);
=20
-	desc =3D __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
-	} else {
-		ret =3D -EINVAL;
-		if (desc =3D=3D VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
-					     __func__, smp_processor_id(),
-					     vector);
-		} else {
-			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
-		}
+		return true;
 	}
=20
-	return ret;
+	/*
+	 * Reevaluate with vector_lock held to prevent a race against
+	 * request_irq() setting up the vector:
+	 *
+	 * CPU0				CPU1
+	 *				interrupt is raised in APIC IRR
+	 *				but not handled
+	 * free_irq()
+	 *   per_cpu(vector_irq, CPU1)[vector] =3D VECTOR_SHUTDOWN;
+	 *
+	 * request_irq()		common_interrupt()
+	 *				  d =3D this_cpu_read(vector_irq[vector]);
+	 *
+	 * per_cpu(vector_irq, CPU1)[vector] =3D desc;
+	 *
+	 *				  if (d =3D=3D VECTOR_SHUTDOWN)
+	 *				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	 *
+	 * This requires that the same vector on the same target CPU is
+	 * handed out or that a spurious interrupt hits that CPU/vector.
+	 */
+	lock_vector_lock();
+	desc =3D reevaluate_vector(vector);
+	unlock_vector_lock();
+
+	if (!desc)
+		return false;
+
+	handle_irq(desc, regs);
+	return true;
 }
=20
 /*
@@ -289,7 +322,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
=20
-	if (unlikely(call_irq_handler(vector, regs)))
+	if (unlikely(!call_irq_handler(vector, regs)))
 		apic_eoi();
=20
 	set_irq_regs(old_regs);

