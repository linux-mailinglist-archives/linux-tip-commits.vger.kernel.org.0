Return-Path: <linux-tip-commits+bounces-6231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA5B18FE0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9541F3AF64D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFF1EDA3C;
	Sat,  2 Aug 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ty70C0q9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/xqubiA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701D2AD11;
	Sat,  2 Aug 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754165339; cv=none; b=i8C+BMrG5qj6LiBPfiKf7IgWE4KgEc6NHgSN+ulcWG5upTRhaGZaAV2CSPk0nzTryBVjfS0c48Nn0Ib1lBDneUylvUwE6mg6jJ6uh/FgjfJYnNUPMqYiPpYKv31CMynNnbAPb3/vdN4+twAfyANltLq6LfPISrKJ2rBXiHxysnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754165339; c=relaxed/simple;
	bh=6vS51PCfgbmzP1UTqjLpQ6KW9OVizJL54e8eUStnV3o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kiI8yElkaUa32TtxQ+6pYZQ3RTRxakWxd3MDqwzD6JDJgSasKiGWnG8fOkoWs9hGsXROtHA7saFMt8NxW8MFNkSkXGL22xslXsw0SnSo5MOVYkrKB7ruRI3CRC27kqG/ztxyzYKDDda1k0dDLC6KNhgoYDuL0EUjweDzQqMXGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ty70C0q9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/xqubiA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Aug 2025 20:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754165335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjDCYU43xkWZRM0jTG9QW/sOVarVHPFGlSm9G3Pq0q0=;
	b=Ty70C0q9pn+xbpN0UkY64kMp6TwdjmUcRUx+cm2ZVdBqYXN46i0wbGBCXgMfTBKkg/d9ap
	sJrkzFFOmWBUOxBHQTFVVHoOVMh/Yu9BAogrqix3af/5WgcLlSI8HqGHmDLy4iIX2wvCF0
	rm+Z/Wk6BGFTP8LWo+T0K3Vh7uvLMKonbi5VI2MV+Ax67ZaGKXEfzSeM7kME1h/3gJvOtC
	etF9JLfz2y1Km6LmpQ0mgG/S9hEfguft4vDswpQ2/+H9CTfZCdCE3iFN5/rEwFtmPVwkzw
	plu5yJHwDArYzN9/o38HpBr/bhpYVtT51bccncdilWJFHTOdqG/2aswG7gs9kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754165335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjDCYU43xkWZRM0jTG9QW/sOVarVHPFGlSm9G3Pq0q0=;
	b=T/xqubiALIkR7ApHhUa45kTI0Oy3rXRgkIC3YthWWSmvB1PidAZtzVYUgwfXk+jcoFn8En
	2Dd2gCQepTMXv6AQ==
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
Message-ID: <175416533376.1420.15851948598684111858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e3079ac6cf4213dd46a7a292150b2ba7e6e85bac
Gitweb:        https://git.kernel.org/tip/e3079ac6cf4213dd46a7a292150b2ba7e6e=
85bac
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Jul 2025 12:49:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Aug 2025 21:56:35 +02:00

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

To avoid ifdeffery or IS_ENABLED() nonsense, repair the broken config
dependency in hw_irq.h, which covers [un]lock_vector_lock().

It has to depend on CONFIG_X86_LOCAL_APIC as that's what makes the
functions available or stubbed out. The current CONFIG_IRQ_DOMAIN_HIERARCHY
guard is selected by CONFIG_X86_LOCAL_APIC, but can also be selected by
other parts of the Kconfig system, which makes 32-bit UP builds with
CONFIG_X86_LOCAL_APIC=3Dn fail.

Can we just get rid of this !APIC nonsense once and forever?

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug=
 retriggered irqs")
Reported-by: Hogan Wang <hogan.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hogan Wang <hogan.wang@huawei.com>
Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
---
 arch/x86/include/asm/hw_irq.h |  6 +--
 arch/x86/kernel/irq.c         | 63 +++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 162ebd7..99f7bf9 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -26,7 +26,7 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
=20
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+#ifdef CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
 struct msi_desc;
@@ -103,10 +103,10 @@ static inline void irq_complete_move(struct irq_cfg *c)=
 { }
 #endif
=20
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
+#else	/* CONFIG_X86_LOCAL_APIC */
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif	/* !CONFIG_X86_LOCAL_APIC */
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

