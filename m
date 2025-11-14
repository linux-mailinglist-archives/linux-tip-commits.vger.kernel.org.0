Return-Path: <linux-tip-commits+bounces-7356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81468C5E294
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 17:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3C42501C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612432ED3F;
	Fri, 14 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vT5cvxuU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5rCg0kNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2832ED44;
	Fri, 14 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135789; cv=none; b=mKhvqH1Q15Z9U7oAiE98B6Oi+2/7HGQnyFo3rrFpkJbT/CY/aZnYsgElsVOQmZ1Rp3h4SZlxAHoPxAcAg90u+ARLy0gJsRokXtrDsHQH1C70mDfPvyQ4QbhHNP5zdJxvn0ylnQatFTNkX0LudoAL1RojRAC6ad8W8cnQIi/b+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135789; c=relaxed/simple;
	bh=tNFRTsYAK7S98uddNyJ3zOSmRLXPWWmQm3V77snrI3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JEJRfPA1REZlP6Oq1KtyybSHRh2aU63ffMmMVP21U1fnjE9ESKeu4Fq6NSJa7gsn2XQID2HBVp2wauojfOrUP1yLNSLjvHFUeKpZ+ecYnxjeLHtO6SaqV7tEv/1aOrUbNHk/plqU6bt/qDiXVA8YnW3k+XjN9saXBKS6bNuWKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vT5cvxuU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5rCg0kNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763135786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIYXih3f1rUKjNCwdWKMScBVeD/1/Y7k58FpFOBA2gw=;
	b=vT5cvxuUBsIkj7Qw59uAbN4KgqU6eraXG9fX4LXlNG3s4pCRssVId32j0d1YNEgemXgnLv
	tBOZ+bbQ3cnFfXJS2GKsoPzyUXky27bOG0FSUDXmSKN+ym9hONyfAfkLzW7m829qdtB3ws
	y6m+7YFTkZSQ93lmJlMLtSUMMRLGqpKRvaS7j2+gE2XBgyBK37Af+Ylz8o+uN1YFJO/ASS
	FLnnqFIxu1drvdkURQZQVJS0uTllOkzspUAIrNurrU6FEv/DRaj6D1qs7Yh6My/43fF7/O
	vJrjX70RWbgg6xI+gY9MZClTsXUwSUmLZ2YMSjzPpxyrfUjXfTKb9HatqQHysQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763135786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIYXih3f1rUKjNCwdWKMScBVeD/1/Y7k58FpFOBA2gw=;
	b=5rCg0kNoJ+DzYoQljLLJqXdb1yfUqC2DodVDV0uFqFUl/0Plaqsg0Wb5rd3NtzwwU0uG1y
	yEF2iBqTMB5NidCA==
From: "tip-bot2 for Nick Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-intc: Add missing free() callback in
 riscv_intc_domain_ops
Cc: Nick Hu <nick.hu@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251114-rv-intc-fix-v1-1-a3edd1c1a868@sifive.com>
References: <20251114-rv-intc-fix-v1-1-a3edd1c1a868@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313578481.498.5356445807062679112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     14473a1f88596fd729e892782efc267c0097dd1d
Gitweb:        https://git.kernel.org/tip/14473a1f88596fd729e892782efc267c009=
7dd1d
Author:        Nick Hu <nick.hu@sifive.com>
AuthorDate:    Fri, 14 Nov 2025 15:28:44 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 16:52:34 +01:00

irqchip/riscv-intc: Add missing free() callback in riscv_intc_domain_ops

The irq_domain_free_irqs() helper requires that the irq_domain_ops->free
callback is implemented. Otherwise, the kernel reports the warning message
"NULL pointer, cannot free irq" when irq_dispose_mapping() is invoked to
release the per-HART local interrupts.

Set irq_domain_ops->free to irq_domain_free_irqs_top() to cure that.

Fixes: 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251114-rv-intc-fix-v1-1-a3edd1c1a868@sifive.=
com
---
 drivers/irqchip/irq-riscv-intc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index e580588..70290b3 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -166,7 +166,8 @@ static int riscv_intc_domain_alloc(struct irq_domain *dom=
ain,
 static const struct irq_domain_ops riscv_intc_domain_ops =3D {
 	.map	=3D riscv_intc_domain_map,
 	.xlate	=3D irq_domain_xlate_onecell,
-	.alloc	=3D riscv_intc_domain_alloc
+	.alloc	=3D riscv_intc_domain_alloc,
+	.free	=3D irq_domain_free_irqs_top,
 };
=20
 static struct fwnode_handle *riscv_intc_hwnode(void)

