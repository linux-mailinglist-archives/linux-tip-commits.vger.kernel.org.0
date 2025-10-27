Return-Path: <linux-tip-commits+bounces-7005-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D4C0F52A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F26F188C1A0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FC314B9D;
	Mon, 27 Oct 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4xXZLmZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjCGQuo+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C1314A7A;
	Mon, 27 Oct 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582660; cv=none; b=cXw95xEBPtQvgEV38FHwrUgiR8Wt8G5k/oxzFNZC/8lJ110PY/N/XhLB1U5mdJSQvDehooIma8F/bYOzflExyZDUCMk24JozwwHG/dfxnlC8OpaS7nA5rjn02GV0CUEUETHEYhSy6KY1k7YAEOPwVcumEB7dl/zEDv6Lbn6Ls5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582660; c=relaxed/simple;
	bh=CGRrE6Ko4gufpEGG0XVhktb7vRn9iTKCgdf9sMSJV+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oHfOb7Tsh1HUP7tKgJketZaku54/O3DdwXtKntqG5D10B2Yb71RIDwN5qOYGejWqNR+KCu8Mw/2sQ6XJjdWvUCL8EaTriecEFUx4bgOB8zTRdyQNTw+xMid5Mk1p9cjBCg3vLC4VoFgRrc+kYezE/aStYvPcDJQ8f4NFHkq3GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4xXZLmZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjCGQuo+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsh6/wiR7eXKqaaZg5eR6Dut9pplUp58akMDkpeiTwk=;
	b=I4xXZLmZjW717i27qTxgG3BvLZyYphpLZX8zcWTU5qO13VzqcNzyJgof9HxDQmHyqKfi26
	+x4naokBwvwzylnpT5KMXbst4+//8zFUWCSKVdlNPAAAeCghUbbe8X3jalV2j8Ci1AHvTx
	gAuvwDvCl7T2rNnCJmhwtnxpBnggOWiuZL61pbTPLQ9waqVehq4VAyhk/kK6/v8JZIDuLX
	4t4HkZ59/ZSUu+Nw8Gpzpr6wYPCjIbu4VQpUG4pDQTg2e38WKGZe47NJChYDyBcb8Szbzc
	WH+k/AFon14+FHdP903RLx0kYV4jKbTcmFcFbXPchd07XRTOsWUC6N2OFPJFqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsh6/wiR7eXKqaaZg5eR6Dut9pplUp58akMDkpeiTwk=;
	b=TjCGQuo+fZWR2eJfZEbZTFpJH2dJZ+Vl3Zwkh+fnugBg3uRUTeIRyAJTZRKKJL2OGUhPq0
	I8sHpd3f1ysDagCA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/apple-aic: Drop support for custom PMU irq partitions
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-23-maz@kernel.org>
References: <20251020122944.3074811-23-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265626.2601451.3060165708053134400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7443813f107a344139b3c7d04161bd7bddea7eda
Gitweb:        https://git.kernel.org/tip/7443813f107a344139b3c7d04161bd7bdde=
a7eda
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:36 +01:00

irqchip/apple-aic: Drop support for custom PMU irq partitions

Similarly to what has been done for GICv3, drop the irq partitioning
support from the AIC driver, effectively merging the two per-cpu interrupts
for the PMU.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-23-maz@kernel.org
---
 drivers/irqchip/irq-apple-aic.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 0b72451..795b3db 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -578,16 +578,9 @@ static void __exception_irq_entry aic_handle_fiq(struct =
pt_regs *regs)
 	}
=20
 	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) =3D=
=3D
-			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
-		int irq;
-		if (cpumask_test_cpu(smp_processor_id(),
-				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
-			irq =3D AIC_CPU_PMU_P;
-		else
-			irq =3D AIC_CPU_PMU_E;
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  AIC_FIQ_HWIRQ(irq));
-	}
+					  AIC_FIQ_HWIRQ(AIC_CPU_PMU_P));
=20
 	if (static_branch_likely(&use_fast_ipi) &&
 	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) =3D=3D =
UPMCR0_IMODE_FIQ) &&
@@ -632,18 +625,7 @@ static int aic_irq_domain_map(struct irq_domain *id, uns=
igned int irq,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
-		int fiq =3D FIELD_GET(AIC_EVENT_NUM, hw);
-
-		switch (fiq) {
-		case AIC_CPU_PMU_P:
-		case AIC_CPU_PMU_E:
-			irq_set_percpu_devid_partition(irq, &ic->fiq_aff[fiq]->aff);
-			break;
-		default:
-			irq_set_percpu_devid(irq);
-			break;
-		}
-
+		irq_set_percpu_devid(irq);
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
@@ -732,6 +714,10 @@ static int aic_irq_domain_translate(struct irq_domain *i=
d,
 				break;
 			}
 		}
+
+		/* Merge the two PMUs on a single interrupt */
+		if (*hwirq =3D=3D AIC_CPU_PMU_E)
+			*hwirq =3D AIC_CPU_PMU_P;
 		break;
 	default:
 		return -EINVAL;

