Return-Path: <linux-tip-commits+bounces-6228-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AFCB18E61
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31A3AA25AF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0DE1FF1C9;
	Sat,  2 Aug 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLVncpV1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQbvVwAN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EC20298E;
	Sat,  2 Aug 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754137139; cv=none; b=krDgJojJCz/JJQa1/CdFGn7Y5z24UAIIzN7AJtzdXBcQ/WqOSKITXIhduhDcUYO9m7nV5YNmHZFJ3L9k4xMvtWiUWQRfEuazuYqvKWBRokxg4+dY8RwFmENqYqgyCH+suHgDLbmvVDrGMXONCORJYYVw7uvC4jZboOpifNQ4b04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754137139; c=relaxed/simple;
	bh=6DIUdeH3GipugXwPd9A8bUmRgY7x3wuy0vTMfsev7K4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GWjc6hU0bv9UdLBDd8pRqJKHyNsPAJDq/Geaj+hIwlHEgouNU+wbydFWSvyLmWEV3bJ4hhDLNlQCuLgicyMoMDZAo/7LcecPQdjvl+afi7W2S0G99agQd+5OoLHkeRY130eNpPI7iZofSnLgzR/ooFzwgHjPyP0i1QFDPhBWKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLVncpV1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQbvVwAN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Aug 2025 12:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754137135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSfzL0044dJYqJDgecNU2bg1SmEs9qIHmfQekYk0Luc=;
	b=xLVncpV1PUxgmBYtxsBfc74RJ9441xYCadL9J0TIsK3dR/b+hV7y3ylPKFRWCqjf9DBf7u
	DU05jxUJcLXDADUcWzo238MrrTkXp0/zfQuNftwOaw4k4+TXZAVD6x7hMX8QeWErTDMMEL
	grwXdd80rU6SlknebB+H05eaht19+csasY7Ic8gGVD1CgfEvUGZ2DVqu3zMundi/W6w0OC
	8JRjzvUIzppGcDo+y6OPDHDZTW5+tYsrrzzrvdDyr5XDF5Q/hO/hS08bwlb2C77wvFt7eT
	Zc1TAbSOdOKFQ8Pqlhs7CMhNUzLLabtyfk1cFnyyf//2Z2dCLixHyrpc0Xj5ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754137135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSfzL0044dJYqJDgecNU2bg1SmEs9qIHmfQekYk0Luc=;
	b=eQbvVwANQ2phu2PHMWQePkY4IphWF1WGEtBpb6RGDXl5PmSIBhDoajtUOxhjc/fNS9TcfG
	rJKHkQOaIe3HhbAQ==
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
Message-ID: <175413713418.1420.12184653889719341688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     69adc077da4c247dd39a8a0e3a898a25924e98d0
Gitweb:        https://git.kernel.org/tip/69adc077da4c247dd39a8a0e3a898a25924=
e98d0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Jul 2025 12:49:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Aug 2025 14:09:38 +02:00

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

Prevent this by reevaluating vector_irq under the vector lock, which is
held by the interrupt activation code when vector_irq is updated.

Interestingly enough this problem managed to be hidden for more than a
decade.

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug=
 retriggered irqs")
Reported-by: Hogan Wang <hogan.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hogan Wang <hogan.wang@huawei.com>
Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
---
 arch/x86/kernel/irq.c | 63 ++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 15 deletions(-)

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

