Return-Path: <linux-tip-commits+bounces-5316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0692AAC75F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E350E7B2878
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95B28151D;
	Tue,  6 May 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAt444ps";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rdz7dn2u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CA280CF1;
	Tue,  6 May 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540270; cv=none; b=WR0c8xl4glX6Y7ma4KiZkC9cTvqRIi7TMyGrnKJELC1n+EmwIEx89Fe3ChMv2mj/ZvnvYJ0zqsUrnQHICEDTP1M54WDsxACX7ObyfTeZNM+L3Mvl9AO8R/EoR501Seug8hqcjSHgDuxePHmBGrQrlazThUZOcwj4dOcne6t1FV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540270; c=relaxed/simple;
	bh=zzsKrLB50JITY+PhJDIMbTNVC+4FU4hne2owNLlgSqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JMbIu7VzXDwH3rHY2zOIGcQJP8zF5qTdK2CWAzejWbbZ0fbMPhwhaTWrXEts6h7ooS9GaFdvGdlKUlhoxNUyvpDgyKD8H9vGa07MfTPCVUXyGH33PVfyyAHC8dPr5a5WQXiNlY3R57RXdiVF2YTDZXpC8pAQMit/S3CRxvbMqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAt444ps; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rdz7dn2u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 14:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746540267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8N2M9hxwFffSn0r4NuqAkr1YMl+4+4WrqqycY5xGdI=;
	b=YAt444pskRNj0dZ1bzZ5OLZ49veoyQ4E/Ez/DsNw81a6sadTulQ7HWEePPdwd2EimubZe5
	4lwNoreCtmhV9IWtNK2lXdYQKEHormsfRfmCPR0aRkwcXqNFI2FmDFBJRUOT3S8pJ0f/oI
	cWQ14Vj4tNZfMeI2sZwx5q6cpb91X+SyyVnc1mJY21njw13n3oqMTfevxsZO0sbNlKBH5O
	H0VkgMIki8+T0DmQ7oqnNHyv75q/HrCV5BbB2VG0XlGkmAVKZz0G9UczBl+aWUdgx/aM0A
	4eSqYt/adKT4BMrb5isqs5hwz8mW+rD0DxwD8fPzSb9lwZ/axcOEKGAKDvAggA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746540267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8N2M9hxwFffSn0r4NuqAkr1YMl+4+4WrqqycY5xGdI=;
	b=Rdz7dn2uw17wwb7rRVsvMxpg+cienSjNMes9eMqeko2BLZ3Vb3yZmyUUNc2RTvcaLEQ7Zq
	ugvF6JdMX6K9MAAQ==
From: "tip-bot2 for Alexey Charkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-vt8500: Don't require 8 interrupts
 from a chained controller
Cc: Alexey Charkov <alchark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506-vt8500-intc-updates-v2-3-a3a0606cf92d@gmail.com>
References: <20250506-vt8500-intc-updates-v2-3-a3a0606cf92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654026620.406.13872526110036599222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     54a1f3eb89ded8114b0bffc3696757cd95665ef9
Gitweb:        https://git.kernel.org/tip/54a1f3eb89ded8114b0bffc3696757cd95665ef9
Author:        Alexey Charkov <alchark@gmail.com>
AuthorDate:    Tue, 06 May 2025 16:46:16 +04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 15:58:26 +02:00

irqchip/irq-vt8500: Don't require 8 interrupts from a chained controller

VT8500 chained controller can route its interrupts to either or all
of its 8 interrupt outputs. Current code actually routes all of them
to the first output, so there is no need to create mappings for all
eight.

Drop redundant checks, and only map as many chained controller
interrupts as are defined in the device tree.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250506-vt8500-intc-updates-v2-3-a3a0606cf92d@gmail.com

---
 drivers/irqchip/irq-vt8500.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index c88aa64..debca89 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -220,16 +220,9 @@ static int __init vt8500_irq_init(struct device_node *node,
 
 	active_cnt++;
 
-	/* check if this is a slaved controller */
+	/* check if this is a chained controller */
 	if (of_irq_count(node) != 0) {
-		/* check that we have the correct number of interrupts */
-		if (of_irq_count(node) != 8) {
-			pr_err("%s: Incorrect IRQ map for slaved controller\n",
-					__func__);
-			return -EINVAL;
-		}
-
-		for (i = 0; i < 8; i++) {
+		for (i = 0; i < of_irq_count(node); i++) {
 			irq = irq_of_parse_and_map(node, i);
 			enable_irq(irq);
 		}

