Return-Path: <linux-tip-commits+bounces-2317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3997998DF87
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2B7B26018
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71181D0E1D;
	Wed,  2 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sE/goZOC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJ1enx+j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233ED1D0B8B;
	Wed,  2 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883823; cv=none; b=LF61g3/MKiXM1uwymzQsAxwOYsMZCGD3J9Bvb0yDVLYAImpzgG7x3j5yfHEEZGj6dOjQxN8dzfCxmuQc5boZSMFZ/9EHk1ygxA1Bxgw4Lbgo++D0FYCrS3bpSc87We9XeR0bb4Bo/PKnO2TH0KBPAwJPx12xtzZpOvYRVwFtdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883823; c=relaxed/simple;
	bh=TUqlKQtMjRz2yZNXXMPbIQcnUmXJpnEwP6GwgjcQ59I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qEH0gLnmjW0CdXC8Yh9ODGFAsuh3JC8SE+P9O1c/UJ5x6AkntbvpLftaj4Swhn/XtjrZjM6rwPzSu48gf69EQQc0aeuHkYWLlZrdSbTdhmUJ18rCNr+GS0ns9p3vGHmTlq63BEu2rC+mt434OXfRwS0BfQmOiH3rozhxObcQwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sE/goZOC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJ1enx+j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyoVWz05nB116XbM2YkVfOhXcq3XkgRVHFjLPPbtfg8=;
	b=sE/goZOC10aHXsKMEp+KOnMh8xEQp450HmfAiNx5oZ3nGXM35NYi0q3cwRZ5HHhEdE+Qex
	lMbqiULt7ElFlvqpr7zMsz6DA8wGCUKB2StcqIZH1OLPwgdcXTXG+cv6v1A/6QAb01dTjv
	ITq7cX1s9qArRN6a2/vYziYl5llIx0AnT6NN37GFGXw+qWOfLRMxda9p7EhQzoJMVApalt
	oYNQ66WjCKbgKHRqfJZnHA6npc/1xekcHt28jK/rA5JgwsuaOW3OtD7cJ1AZfijQtAJ1Z5
	y8ecrTjO1leyOoTem8kvhfDYhkso8Z4dvsFqpPekxBDIgW9X76V1i+oLxKHQ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyoVWz05nB116XbM2YkVfOhXcq3XkgRVHFjLPPbtfg8=;
	b=kJ1enx+jjSnoBN4L2BaqB3wrRCPwsoAjlFLx22uHabQ+Bp1H9GD29ZD7d2pYFLv6pzX4Mc
	wybQ0h+ifmmd0PBg==
From: "tip-bot2 for Andrew Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/riscv-imsic: Fix output text of base address
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240909085610.46625-2-ajones@ventanamicro.com>
References: <20240909085610.46625-2-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788381998.1442.11807110934577537569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4a1361e9a5c5dbb5c9f647762ae0cb1a605101fa
Gitweb:        https://git.kernel.org/tip/4a1361e9a5c5dbb5c9f647762ae0cb1a605101fa
Author:        Andrew Jones <ajones@ventanamicro.com>
AuthorDate:    Mon, 09 Sep 2024 10:56:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:12:18 +02:00

irqchip/riscv-imsic: Fix output text of base address

The "per-CPU IDs ... at base ..." info log is outputting a physical
address, not a PPN.

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/all/20240909085610.46625-2-ajones@ventanamicro.com

---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 64905e6..c708780 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -341,7 +341,7 @@ int imsic_irqdomain_init(void)
 		imsic->fwnode, global->hart_index_bits, global->guest_index_bits);
 	pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
 		imsic->fwnode, global->group_index_bits, global->group_index_shift);
-	pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n",
+	pr_info("%pfwP: per-CPU IDs %d at base address %pa\n",
 		imsic->fwnode, global->nr_ids, &global->base_addr);
 	pr_info("%pfwP: total %d interrupts available\n",
 		imsic->fwnode, num_possible_cpus() * (global->nr_ids - 1));

