Return-Path: <linux-tip-commits+bounces-2098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25C95D56B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C811DB21BF9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728431922C5;
	Fri, 23 Aug 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HDFC0LDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UIyF7Vat"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601A8F6B;
	Fri, 23 Aug 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438709; cv=none; b=scyuHMlZHnDv72z3FNxEEbFhzA8mKl0IT0+MrZVpOKIjksWSokLEbkzUMQ/ARbRL+/+Naj5r5qrG5EEU+QBuQmRU1TxQqzeCSjMJs1iutF8HayY1e/81MlkGqphtc8972xDln7yDeOLLBKiFJ9JtHdoOlrBE6YBkgYdzWc6Gz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438709; c=relaxed/simple;
	bh=sDVZhszbQc3yyiz/Hoj635GHaH+B/4b0+zCcE6hW8oo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fzkKece+8K7BwFBVhfEMJ5pweKKK+V2jGLs3GLLjwZBb7yX2YohxFuwIeJKNLMKMLDBTeEpqdQV8/GWYzRNWPXWxsnQ6F6qu3abOjmz6yJtVi4o09pTvznhNnjxCb+DDfQ9DgCx9wicpEUG8C4EuUav06IxAZGpY+b6UKbfMfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HDFC0LDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UIyF7Vat; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfibfREUsUCKJKSy54O8OJc4X1+24HbKwoIQw+UF/m8=;
	b=HDFC0LDUTLBtZW1RvRy6OFqWV7ADRFt01y39Bw9TOTLezdWjpaXMOJev+4y8CJJ3YTDBls
	R0iPmfWINZMrYE/W6E0bAVTFzUG5msKr+T+ORDzC1RxzgRqt2iZElx8MsbUiUJUCQOT+KN
	omNqrVRQ3A+x9bq/M4eY+n9Xc/Rpv7z8Nhr8ZgaOZFc08IoYA+iLzh3M8nwdR62Y3Kf1RG
	aZ0UlH4/ERZBN8Lz+1xlUNyQElFi25H7ACchGLEgmZTMIBE8wlETP9YA2IGkzaMutyWo2f
	bxy2JB9b2NlMcHelVm0sKNbHf4uiivdkdANSzlKbbT/np42wSpPH1wKe8Xl0lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfibfREUsUCKJKSy54O8OJc4X1+24HbKwoIQw+UF/m8=;
	b=UIyF7Vat9FZCkPOYr5IOt2vCbUlasydqI4D3B8NkPXQ/XbGDK9QOmf/hLETBfSSIlAcV41
	k2u9VNdunylcWVDg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-eiointc: Rename
 CPUHP_AP_IRQ_LOONGARCH_STARTING
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240823103936.25092-3-zhangtianyang@loongson.cn>
References: <20240823103936.25092-3-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443870565.2215.9426012412699407062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9e83dd3ebb14fadccb936308b7b101c75da76324
Gitweb:        https://git.kernel.org/tip/9e83dd3ebb14fadccb936308b7b101c75da76324
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Fri, 23 Aug 2024 18:39:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:40:27 +02:00

irqchip/loongson-eiointc: Rename CPUHP_AP_IRQ_LOONGARCH_STARTING

Rename CPUHP_AP_IRQ_LOONGARCH_STARTING to CPUHP_AP_IRQ_EIOINTC_STARTING
because the upcoming AVECINTC irqchip driver will introduce a new state
and so both are clearly identifiable.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240823103936.25092-3-zhangtianyang@loongson.cn

---
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++--
 include/linux/cpuhotplug.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 34b5ca2..c756b7a 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -398,8 +398,8 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 
 	if (nr_pics == 1) {
 		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-					  "irqchip/loongarch/intc:starting",
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_EIOINTC_STARTING,
+					  "irqchip/loongarch/eiointc:starting",
 					  eiointc_router_init, NULL);
 	}
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 51ba681..e49807f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -145,7 +145,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-	CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,

