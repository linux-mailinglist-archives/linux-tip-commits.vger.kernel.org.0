Return-Path: <linux-tip-commits+bounces-8064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E853AD3955C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0507300A3C0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A343328F8;
	Sun, 18 Jan 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6OhBmiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/DM+6CQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A6331A63;
	Sun, 18 Jan 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743723; cv=none; b=C5W6mHXPlbCMymq+cHFPpZjeTD1MUc/LHYWGSHQuQiM4KjlKg20krKfDPzEsGgAPPeJ7ojxvDdzvvgiQlj2+/hD3HJ33x1WSu2zEoQ+A06lbO6YHN9KDtSOyVhZGA9Kh+lRnqjDV5X7bd92DBRZZQNK4GLhKOdf9Av1efOstzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743723; c=relaxed/simple;
	bh=YNh7rPMxW30RxwQo+wQk3ewJNJIJ8AZGdy2qqPcBbvQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFac20+A1TPkUPjkg0V6IoqZyOFtgyLNDDr0ak4kwbC8NR6p3hrUjCEr6oeU0/FmJCsAuiz8nRKI5ejmpY4TKChfAwvwA8TSHOxgcMZef8l2LHFJRnJW/+b1vTwDTkTASylQCBKFWEtb9kDpaErpL6k4AldZqEDV8LRR5ehU+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6OhBmiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/DM+6CQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xyqQLkkwqg+wMVr0eLLLQfZWdaBZmfa0nYtokz7TKQ=;
	b=G6OhBmiViz8u0GRPcLfAbpyY14hTmNfol5MiYrNcXWGu/ymszA1AZgW9ZcYaD4Bt+HYCPT
	reBfNeVHdUWmesfH7hrTSvmS6u56FY243qUr9Go6wRfDT2AzLpD7VvqOv4pRt4OKL6U/vi
	VoWt1tXc0Jw0QQTpIRE3QHCMnOTA+YhX3Cxq8tmHuIBDn1ULgbrWcughHFs3FS00WMY5m2
	X0P8ZzVhBy4yiELOQhQvxiDQCq3mjizMlTLhG/1GdOPdhkULhWDh6b6jPkhbNLyLufo0o2
	s5j7M7YQyYwz2dU7YnNjbjPL0ww82fS2RxutPX9Fk1dUrdK+w3sBr/z5Z+RRhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xyqQLkkwqg+wMVr0eLLLQfZWdaBZmfa0nYtokz7TKQ=;
	b=y/DM+6CQwim4CT5nq2hqN650cYq6jr5mtAdVSaqffgJUnfpROlkd7TO6H2Rb8Q7yTYXU0T
	s7V/RwlQEgvmziAw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongarch-avec: Adjust irqchip driver for
 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-2-chenhuacai@loongson.cn>
References: <20260113085940.3344837-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176874371848.510.1874357246454080379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     d9e7035a51b89ef6041ce7c00b629e7877134a51
Gitweb:        https://git.kernel.org/tip/d9e7035a51b89ef6041ce7c00b629e78771=
34a51
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:34 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:16 +01:00

irqchip/loongarch-avec: Adjust irqchip driver for 32BIT/64BIT

csr_read64() is only available on 64BIT LoongArch platform, so use the
recently added adaptive csr_read() instead to make the driver work on both
32BIT and 64BIT platforms.

This makes avecintc_enable() a no-op for 32-bit as it is only required on
64-bit systems.

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-2-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongarch-avec.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loong=
arch-avec.c
index ba556c0..fb8efde 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -58,11 +58,13 @@ struct avecintc_data {
=20
 static inline void avecintc_enable(void)
 {
+#ifdef CONFIG_MACH_LOONGSON64
 	u64 value;
=20
 	value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
 	value |=3D IOCSR_MISC_FUNC_AVEC_EN;
 	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+#endif
 }
=20
 static inline void avecintc_ack_irq(struct irq_data *d)
@@ -167,7 +169,7 @@ void complete_irq_moving(void)
 	struct pending_list *plist =3D this_cpu_ptr(&pending_list);
 	struct avecintc_data *adata, *tdata;
 	int cpu, vector, bias;
-	uint64_t isr;
+	unsigned long isr;
=20
 	guard(raw_spinlock)(&loongarch_avec.lock);
=20
@@ -177,16 +179,16 @@ void complete_irq_moving(void)
 		bias =3D vector / VECTORS_PER_REG;
 		switch (bias) {
 		case 0:
-			isr =3D csr_read64(LOONGARCH_CSR_ISR0);
+			isr =3D csr_read(LOONGARCH_CSR_ISR0);
 			break;
 		case 1:
-			isr =3D csr_read64(LOONGARCH_CSR_ISR1);
+			isr =3D csr_read(LOONGARCH_CSR_ISR1);
 			break;
 		case 2:
-			isr =3D csr_read64(LOONGARCH_CSR_ISR2);
+			isr =3D csr_read(LOONGARCH_CSR_ISR2);
 			break;
 		case 3:
-			isr =3D csr_read64(LOONGARCH_CSR_ISR3);
+			isr =3D csr_read(LOONGARCH_CSR_ISR3);
 			break;
 		}
=20
@@ -234,7 +236,7 @@ static void avecintc_irq_dispatch(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
=20
 	while (true) {
-		unsigned long vector =3D csr_read64(LOONGARCH_CSR_IRR);
+		unsigned long vector =3D csr_read(LOONGARCH_CSR_IRR);
 		if (vector & IRR_INVALID_MASK)
 			break;
=20

