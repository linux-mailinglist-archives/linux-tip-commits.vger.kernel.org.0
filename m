Return-Path: <linux-tip-commits+bounces-7012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F0C0F51B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5ED4EA6C8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B81318157;
	Mon, 27 Oct 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCzOfscp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rboOnd8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EE316917;
	Mon, 27 Oct 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582670; cv=none; b=uU/kLw/GYfWH4NeNQA/AKUzKojy8W7Pb31lCTBk6Ag+Lju1DOhXcpw3lNTHzZ3b7olLb7WTTwFWd/H4rclqE1d8LAdHVpN3GjdZfsGb5XaINs/dzusXKNWCMVwoucanS5+uNcgPZB7ZjKjQUQ6o7CV4qXONWdMN2HiZNk5ikbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582670; c=relaxed/simple;
	bh=dvmOBl+agrlHorIqbzioOcMx88QQP9XCVb2oTyAzeTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TzHYyuSWWjGRtMX712OzSdj9nXkbtW6fIahly7kWJB67Ru84LfUODRhkg6yKBm4vLxn67gJOtReE8qg/ta9sdTB5zWvQBW6pJDw37pwEIgL4qejXWh30ibQw3FZMtknxwFKqE9/7YFWSRrozWEH8c0rqzOnbSTjtNi16go2/NLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCzOfscp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rboOnd8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/NWHgTRg75gQyW2tbe9MAIzhgcRshO3ZabwisNlDe4=;
	b=mCzOfscp9QE97H9wWfpWA3IXEsGRsqQKiG/v69n4u2Y7sBDxf1wrO4UZ57SyuDegH6SOAv
	nA4NvCz22jrkzlCq22X0LDW7e2mnu+Ii6tAlCuv8TNxyBnn6PGoIDESLXB3ePoY22BSGD9
	k1+akqNM0xhLaYWj/yuv21W9+VM4QvaH+rpi3yPMRKouSLQnwMWaLkpRG4i2h8vVApo7XC
	QVzuUiNdt9ayaZE4MC9TjaxPZAMxYRasdaSY1pZiPSjVSPpgC6ajvPEhwVHUj8/TrTce8B
	D9BolqYe88X32rE/rkVT3DZzdh99ylAGpXnoHWFHKq/4kIMyMXNXUvQGM+xN8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/NWHgTRg75gQyW2tbe9MAIzhgcRshO3ZabwisNlDe4=;
	b=+rboOnd8GECiC1l5y1LdLANjQoZCwao5ytMzEI7WrjeTKMZC4vW4Bq7Jo5jE1CnrJwV5OP
	POI5GVpJVYRWmjBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Update request_percpu_nmi() to take an affinity
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-16-maz@kernel.org>
References: <20251020122944.3074811-16-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266514.2601451.2966918817805660708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b9c6aa9efc71dae656f9f913d1250ea08cd6e10f
Gitweb:        https://git.kernel.org/tip/b9c6aa9efc71dae656f9f913d1250ea08cd=
6e10f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:35 +01:00

genirq: Update request_percpu_nmi() to take an affinity

Continue spreading the notion of affinity to the per CPU interrupt request
code by updating the call sites that use request_percpu_nmi() (all two of
them) to take an affinity pointer. This pointer is firmly NULL for now.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-16-maz@kernel.org
---
 arch/arm64/kernel/smp.c   |  2 +-
 drivers/perf/arm_pmu.c    |  2 +-
 include/linux/interrupt.h |  4 ++--
 kernel/irq/manage.c       | 12 +++++++-----
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 68cea3a..6fb838e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1094,7 +1094,7 @@ static void ipi_setup_sgi(int ipi)
 	irq =3D ipi_irq_base + ipi;
=20
 	if (ipi_should_be_nmi(ipi)) {
-		err =3D request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
+		err =3D request_percpu_nmi(irq, ipi_handler, "IPI", NULL, &irq_stat);
 		WARN(err, "Could not request IRQ %d as NMI, err=3D%d\n", irq, err);
 	} else {
 		err =3D request_percpu_irq(irq, ipi_handler, "IPI", &irq_stat);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5c310e8..22c601b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -659,7 +659,7 @@ int armpmu_request_irq(int irq, int cpu)
 			irq_ops =3D &pmunmi_ops;
 		}
 	} else if (armpmu_count_irq_users(irq) =3D=3D 0) {
-		err =3D request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
+		err =3D request_percpu_nmi(irq, handler, "arm-pmu", NULL, &cpu_armpmu);
=20
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 52147d5..81506ab 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -197,8 +197,8 @@ request_percpu_irq(unsigned int irq, irq_handler_t handle=
r,
 }
=20
 extern int __must_check
-request_percpu_nmi(unsigned int irq, irq_handler_t handler,
-		   const char *devname, void __percpu *dev);
+request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *name,
+		   const struct cpumask *affinity, void __percpu *dev_id);
=20
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5f4c651..b1a3140 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2527,6 +2527,7 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * @irq:	Interrupt line to allocate
  * @handler:	Function to be called when the IRQ occurs.
  * @name:	An ascii name for the claiming device
+ * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
  *
  * This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
@@ -2543,8 +2544,8 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * If the interrupt line cannot be used to deliver NMIs, function
  * will fail returning a negative value.
  */
-int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
-		       const char *name, void __percpu *dev_id)
+int request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *=
name,
+		       const struct cpumask *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2561,12 +2562,13 @@ int request_percpu_nmi(unsigned int irq, irq_handler_=
t handler,
 	    !irq_supports_nmi(desc))
 		return -EINVAL;
=20
-	/* The line cannot already be NMI */
-	if (irq_is_nmi(desc))
+	/* The line cannot be NMI already if the new request covers all CPUs */
+	if (irq_is_nmi(desc) &&
+	    (!affinity || cpumask_equal(affinity, cpu_possible_mask)))
 		return -EINVAL;
=20
 	action =3D create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCI=
NG,
-					 name, NULL, dev_id);
+					 name, affinity, dev_id);
 	if (!action)
 		return -ENOMEM;
=20

