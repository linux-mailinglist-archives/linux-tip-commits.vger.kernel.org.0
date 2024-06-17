Return-Path: <linux-tip-commits+bounces-1431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F290BA1A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4301F20C89
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C6198833;
	Mon, 17 Jun 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1cMJTCuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zfw3z5CL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B51364BE;
	Mon, 17 Jun 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650174; cv=none; b=o06ULZ5rHJzeqx/aFSD+mj6j53AAW6qPuJEDwB+9u+lz7twZfzWcRBOBonbVravnjuUrmF/sBGX3MsqnZ9uURaGuq0mWKNhrCB7Nibd5MNoNBf1pa/jZ2iTJEpPn3sK4UvEJEuDEF/pCEYNNPLG33/0kOtJOGdnNb1m8XxW+amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650174; c=relaxed/simple;
	bh=q06gzOqeRWxO8BKxyT+dTszpm+khnSzcaW718ffYMoQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FBI+C8qib82LyWpLwzYUHBkZH44dDKOlWlk2i3grqhVSJYZDBC3PHJjVg1PWtJhas1EKb6Wu1UjS0GWyCTpLn2grq0r0I84qVURp5XepyAFN41Chz/9DNxjbzWH+2z8S7bAEaUEY+tfOuRdTjKkUjN2eqzmNhtatOqR3Vj0AJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1cMJTCuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zfw3z5CL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 18:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718650170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8k/eL6Ni5D3Fig2MwGzoFiFLIk1Ub6lNDC8Ey4Xq7/g=;
	b=1cMJTCuqyPUFGlOrOZ+WWqyxCisl6/VqWxB4Api0acKXiFfXU/Tuv7IiBj0u0QRwbccZl7
	oom/p4WRceO1FDGEQZB3LjElt/TRLFSIGr1G36LJk6enpaiyEXUUlMwaHL/Flpu9Lj90mt
	egu2Z2Uis7HUZ/qlSBAPYwnwg9BlvdOlVd0CIFjw4xhQfLR0XPZq+FNKjOQmvjbvUgUhyM
	gKsk0R2ZNZ7FXlPdg2oRLkZsIYck7kfTFFYfk4qTr9r0BLaHXRobUI3FebkDHV6M8Wa2we
	kF1z8Vqrrnp86fyohe+MUOZmiLbAgeTXH1+To8G3eCsvqLzU82IZNhq5QS9Kcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718650170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8k/eL6Ni5D3Fig2MwGzoFiFLIk1Ub6lNDC8Ey4Xq7/g=;
	b=Zfw3z5CLv9odUmBYA0rcoIchQUkanv/7RdpL1sJhU05eIyuhoR53zq/Q6TvCaz3261YmLC
	hH0JBop3aWPMsVDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=n
Cc: Borislav Betkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171865016969.10875.13044042895933336613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8cb2dbf94e44bcde4cff0223f2f900f8fb9083a4
Gitweb:        https://git.kernel.org/tip/8cb2dbf94e44bcde4cff0223f2f900f8fb9083a4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 17 Jun 2024 20:31:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 20:46:39 +02:00

irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=n

ld: kernel/irq/irqdomain.o: in function `irq_domain_instantiate':
kernel/irq/irqdomain.c:296:(.text+0x10dd): undefined reference to `irq_domain_alloc_generic_chips'
ld: kernel/irq/irqdomain.c:313:(.text+0x1218): undefined reference to `irq_domain_remove_generic_chips'
ld: kernel/irq/irqdomain.o: in function `irq_domain_remove':
kernel/irq/irqdomain.c:349:(.text+0x1ddf): undefined reference to `irq_domain_remove_generic_chips'

Provide the required stubs.

Fixes: e6f67ce32e8e ("irqdomain: Add support for generic irq chips creation before publishing a domain")
Reported-by: Borislav Betkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 712bcee..1f5dbf1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1182,9 +1182,19 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 
 struct irq_chip_generic *irq_get_domain_generic_chip(struct irq_domain *d, unsigned int hw_irq);
 
+#ifdef CONFIG_GENERIC_IRQ_CHIP
 int irq_domain_alloc_generic_chips(struct irq_domain *d,
 				   const struct irq_domain_chip_generic_info *info);
 void irq_domain_remove_generic_chips(struct irq_domain *d);
+#else
+static inline int
+irq_domain_alloc_generic_chips(struct irq_domain *d,
+			       const struct irq_domain_chip_generic_info *info)
+{
+	return -EINVAL;
+}
+static inline void irq_domain_remove_generic_chips(struct irq_domain *d) { }
+#endif /* CONFIG_GENERIC_IRQ_CHIP */
 
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,

