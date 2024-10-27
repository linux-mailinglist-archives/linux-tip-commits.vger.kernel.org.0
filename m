Return-Path: <linux-tip-commits+bounces-2612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DE9B1CE2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055B51F21941
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E8139D0A;
	Sun, 27 Oct 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXIjjBA+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKeO+BtH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978283F9D2;
	Sun, 27 Oct 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022227; cv=none; b=ZweeKRdloUn8xoWN8I7tD+GFmWJFICnwhcr9kWPJBd298DD7P6yvBf01vvEeCJYhfbXgABLmCEMV0Z/2XGZPfWijxk1P6ZHjxRhrf3ztTRbuu0dgmw82GKrQjKNLCqBZ2KUS6jRA9o50a0wKQubDeZu9jlDLKi5Sm8Bd969BILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022227; c=relaxed/simple;
	bh=g3mZnCdFMSghnHzeCYV5Ob8fm4Q6+E2Th/RFOUaCj+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dasat47lL+MPBEyOJBTDwCwIhXee72/azI4ZN9NXPCp2aTS51M1A4YBKrg1HNOyKRZe5B7UchZZ2bpRUhmWqY+ie6nhTybN7Vk6qNd4YoSUf4FTUunwHpyZgYBoL/x7G0bfiX96pMZnGEjWpl7LKGD+/YagefpfMa5PgSX2+eNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXIjjBA+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKeO+BtH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 27 Oct 2024 09:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730022223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8au+eaOtaD9EclbnrrUgOp0tFI3VkVR7CpXJe7pWGs=;
	b=yXIjjBA+jHNFlDWfdlEKNzUPrcW0vhQG9kVlthJPFikYyyKToERy+yy80fB3nFQ599l2Ql
	ZV2jBWzr7MxD/YLxJeQnpA+yTdj8l7kZmQCxvFLwp00IpsqH9ZPPfmGZFgRgdX/1j/BuAS
	tnPWQAppwaL8xIfMewdtK5WBtHhSOPm98b2zYqyReboVK13zh97IbDuQXfyNnPGq3ldk/E
	5ufcVi95UG4TaHTee3U0KrbUyLM4RXOzK/Hmb7/+FIlNx+NK6ivdpuCeQZ0+HodqMN10T6
	cIXaaExKLBGL4lvTFlMVWYkwmOotpYlU6dhdWOpmB6PZM9AmMN0KSW6sPLgKGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730022223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8au+eaOtaD9EclbnrrUgOp0tFI3VkVR7CpXJe7pWGs=;
	b=qKeO+BtHEIq3+wPVmZCiBHyadQf92p/ed7+y6a0CAW5IUkjQJv7uzQU9L4KiKisVngqHbv
	jwZRz3/RDNL2q0CA==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] genirq/msi: Fix off-by-one error in msi_domain_alloc()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241026063639.10711-1-ruanjinjie@huawei.com>
References: <20241026063639.10711-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173002222286.1442.9459023448412471573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5f994f534120f47432092fb36f5cb0c7a80ed2bf
Gitweb:        https://git.kernel.org/tip/5f994f534120f47432092fb36f5cb0c7a80ed2bf
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Sat, 26 Oct 2024 14:36:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Oct 2024 10:40:47 +01:00

genirq/msi: Fix off-by-one error in msi_domain_alloc()

The error path in msi_domain_alloc(), frees the already allocated MSI
interrupts in a loop, but the loop condition terminates when the index
reaches zero, which fails to free the first allocated MSI interrupt at
index zero.

Check for >= 0 so that msi[0] is freed as well.

Fixes: f3cf8bb0d6c3 ("genirq: Add generic msi irq domain support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241026063639.10711-1-ruanjinjie@huawei.com

---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3a24d6b..396a067 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -718,7 +718,7 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
 		if (ret < 0) {
 			if (ops->msi_free) {
-				for (i--; i > 0; i--)
+				for (i--; i >= 0; i--)
 					ops->msi_free(domain, info, virq + i);
 			}
 			irq_domain_free_irqs_top(domain, virq, nr_irqs);

