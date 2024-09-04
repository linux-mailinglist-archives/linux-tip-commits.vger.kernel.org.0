Return-Path: <linux-tip-commits+bounces-2163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEF96C6AE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 20:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B993E1F26643
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E01E4108;
	Wed,  4 Sep 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWw+fnxb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5SrmIPF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD71E2002;
	Wed,  4 Sep 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475698; cv=none; b=DXklEvVNEzg+pG/R78V5meaN2jGW5a0OeSW2GzBcNe46qldtSHP5MXk7ZOuOFFIRvCAPTb/g6Ya8HwXLGJOquTpjveoLt3it31KHMFnINUI1d4QztY1+9xrm4z+RjhQsyt9vU5rChgs3Tpep4AyFgo7SGdOxxEbCmZ3PXKztvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475698; c=relaxed/simple;
	bh=EiRQGc+5EeL6UndbOKF1LdYzf+iwBv54ZLVgUGWC55c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dByt1LQDxaEU24VA9ujEbAZ1PcBXpKV2ZL9An0MT+fB697ge7xakrZ7rvYMLc5kSEpZT+wSlejy0YeVUKx54A1xCuz3LWel8Nbk4/QrQaEU/j4T4Yi7RBDmpPcJjffzkonIEFziC4LecmyGXAAZ5o2sMH3bR3WxOZrHnv1sUC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWw+fnxb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5SrmIPF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 18:48:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725475694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCpNmdEq3Pls2s3xIeuWjwwHGM5me1vwDaKc/meuBx0=;
	b=VWw+fnxbImRoLDoKFYA7oY4OhDMZPJrUvttAnG5bz2DMK70gymvEc5CjaSxbFGbjlwKpyU
	wztnXyw4Qyk9JTnNWCm4L2Xc6V4URKFEm3q0MjTR1pRNxha61oYpc7KgItvX81YPiEvJaL
	C45bQMZCaG6VkXfJM0R1z0WINyUTlu5Vq/mSdzjAEMj0YrVglO4aCeUF/+5iWOyvNRU3tU
	06m3YUcJhM4hZfYqYyysedB6DGcDkoo14yFxyTvhySDIfz2rDoEMbwDZV46e6asbXIeieG
	2N/nRcc5EDZhzu01k9gpeBOX9S0iUEdeNBDf4cI+XWLHjyHQTg5v7iuQcLxhnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725475694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCpNmdEq3Pls2s3xIeuWjwwHGM5me1vwDaKc/meuBx0=;
	b=J5SrmIPFdDOfj96Y9vyS0pwEI8jNFCGvVqyuFQkSnyVw8ZChCllspoMq6YpGSG5HeXyQft
	ZIXgaLqUGBRLQZDg==
From: "tip-bot2 for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/apple-aic: Only access system registers on
 SoCs which provide them
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Nick Chan <towinchenmi@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sven Peter <sven@svenpeter.dev>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240901034143.12731-5-towinchenmi@gmail.com>
References: <20240901034143.12731-5-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172547569346.2215.2676526728015449402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     59fc20ba70294d2c5f620ad6206aa661ce7718d6
Gitweb:        https://git.kernel.org/tip/59fc20ba70294d2c5f620ad6206aa661ce7718d6
Author:        Konrad Dybcio <konrad.dybcio@somainline.org>
AuthorDate:    Sun, 01 Sep 2024 11:40:07 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 20:43:30 +02:00

irqchip/apple-aic: Only access system registers on SoCs which provide them

Starting from the A11 (T8015) SoC, Apple introuced system registers for
fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
A7-A10 SoCs and trying to access them results in an instant crash.

Restrict sysreg access within the AIC driver to configurations where
use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.

Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Link: https://lore.kernel.org/all/20240901034143.12731-5-towinchenmi@gmail.com

---
 drivers/irqchip/irq-apple-aic.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 9012690..da5250f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -234,6 +234,7 @@ enum fiq_hwirq {
 	AIC_NR_FIQ
 };
 
+/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11+) */
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 /* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
 static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
@@ -550,14 +551,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
-		}
-	}
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING))
+		aic_handle_ipi(regs);
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
@@ -592,8 +588,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
 
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ) &&
+	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
 		/* Same story with uncore PMCs */
 		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
 		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
@@ -829,7 +826,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -850,8 +848,10 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&use_fast_ipi)) {
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	}
 
 	/* Commit all of the above */
 	isb();

