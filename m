Return-Path: <linux-tip-commits+bounces-1483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6B912D64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1441C239C8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB117A934;
	Fri, 21 Jun 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/An1dmj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qty+hXZ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826E169AE2;
	Fri, 21 Jun 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995323; cv=none; b=M1j2aG4dmTQpENBEMUhMiwYRl5KtiduuHkQdA8+vMbWLRYF79sOLXRug65DlObnupWQ+fRY9EaPe/juNf6x3xa7KyvjQW6vzSwlAL2zJRAvuvBtHPWI9/kvFYSPByZF2XKXiCtN++0340SeMh9RQ815pFRnmNSf8DrLvC699+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995323; c=relaxed/simple;
	bh=XYhg8CY9Pux0RNqDlKdarrBJ740NpQUMv82e3mKYDmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Va6Pa2hRTRjujY16b7QrDohmE5m+DPuBRwMYJdGp2zjWFtuQG/KcTWZf1FuN5t10nGBsNpuaczws4bTjRJUg5uWeh4Q9+hLzcFT9ZcKIsg1DlEC3OXAsxauC+gKXA3P7UDa0QWbg5flLwlV5osIoiZW2FLW3ujO1Kg6f377bZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/An1dmj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qty+hXZ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 18:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718995320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kUs/qy8M1sk5YMoq/qWjMBeThfoCeL4ewRDb0jPr4=;
	b=i/An1dmjbHC91FHZX08FXWjpp0hEa3Ngtph6dsPmh2ru2We/BvQ4XHP9GQszb+4CS5CwPL
	DBi6VHyJ3C8iGyPXtW3Sbjibfo5DHTBGUm9ucD7OCTpt30ZQnqCxa1BPPqXxOu0ypjKgK5
	vlX/yZo7lzfH/L+7Ixcs/9g8sZefhawLf5W4qFZlVjGNiUpl9y1xrrda53ShXS9PZYY+SE
	/AwmTluvPI5+fq2o4FnFcqQHTq3cF+a7pidXo0PnXbkVZ2vYqgCbuXjnvwb+/si0MGqPp8
	6OqhAgKUP8IYKB2A2rNctGXo7LX0lO8Toen31MTJuiHKXLM7Z+HMF7BqGcIvpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718995320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kUs/qy8M1sk5YMoq/qWjMBeThfoCeL4ewRDb0jPr4=;
	b=qty+hXZ8V8SnEdR2Cq+vkjP+I+9dK+ydlNDTAlpcIf0VlEUTAHpyzQkGr6b0URJsXJudvC
	mwqDER3Fj9AVYqBw==
From: "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-intc: Remove asmlinkage
Cc: Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614151955.1949-1-jszhang@kernel.org>
References: <20240614151955.1949-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171899531960.10875.12877295810458778149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     722c9389c7fa91d1b6c665252f655b352b3a32b8
Gitweb:        https://git.kernel.org/tip/722c9389c7fa91d1b6c665252f655b352b3a32b8
Author:        Jisheng Zhang <jszhang@kernel.org>
AuthorDate:    Fri, 14 Jun 2024 23:19:55 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Jun 2024 20:35:24 +02:00

irqchip/riscv-intc: Remove asmlinkage

The two functions riscv_intc_aia_irq() and riscv_intc_irq()
are only called by C functions.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20240614151955.1949-1-jszhang@kernel.org

---
 drivers/irqchip/irq-riscv-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9e71c44..983538a 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,7 +26,7 @@ static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
 static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
 static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
 
-static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
+static void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
@@ -34,7 +34,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
-static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+static void riscv_intc_aia_irq(struct pt_regs *regs)
 {
 	unsigned long topi;
 

