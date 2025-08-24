Return-Path: <linux-tip-commits+bounces-6331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F350B32EF3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAAC1B28498
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254D265630;
	Sun, 24 Aug 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKvVlc/V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3pqPsYw0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D01FE474;
	Sun, 24 Aug 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756030951; cv=none; b=QqEsrbQHaCVBqJjTxLL0/fEyiOn+GdCXuVw/nlFBGYJxWzbLUBQkJlUcPDOSQF0u5HqMiW+0fkyskIpHNGVwyFRbOKlNLyfJ67byZjr11Zf1j7bV6V1RBw/lDg5+hOfYW9EJ0Uag4mNW04AkaMWGs9GqY1JTZWDCLVcWaz22/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756030951; c=relaxed/simple;
	bh=4bjGXTOa+YxPHqvgC1wvnL3997iBtY6RmjEyrIBV/d8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CyWFNtL65SeFzBByQzGg97Sa+p+YC+zZprcP2eH1PrDP8eFiY6wWsafAf77Z7F9dCpxEPsmKPjPIBmQnZENWjkF2qS+Ou7DfOk9MCgyfZYqx7uLHPv5tokFLmN1Is+4j9mCUjwreJan0Q8Ud1qb233npQ7Z8/S+gaA2EFm/t0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKvVlc/V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3pqPsYw0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756030948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2t+71IMdUZ4X9pCsSi9o7/f8WAjPX8JhoSoEFB0f/4=;
	b=CKvVlc/VawuYNtbcSb/dLwWOa3t0GGdf5ggt5LhlMIEXsNsluI2WVC+/pQ8Ndrkl1JSHgi
	rdHdpeBRSsPwiqsetxQOhl+D/oCs+KlLJGwbE6j8zAN2I5/vTlvi/ZhPznQS780qcF1muD
	fP6UenBpu11QXJ6GlMnKkp5jaZF6j5XTeyek8MY8mrgEyhcCgWCr1nY8JGETNy6XG0FiTr
	m9ZaBvHq/D7KDsxHWTUaAYwW4Oh6OmDpTYIqcGYk4B4HFlIy+ipu3zSyZ7XY7Kh6KbXgmh
	YlXw0btqGLLG27ipYsYEcmJgTk+G6ObmCbPuOWOaxtTCQwUR3eiDNRecTmoyJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756030948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2t+71IMdUZ4X9pCsSi9o7/f8WAjPX8JhoSoEFB0f/4=;
	b=3pqPsYw0Mk6/lmYnx3u3IJlaQckxVAv718ZKj6V2XAvorHTxKvyi3Mw3xPhU9F2ezIRL2v
	2Zk3jNOctO1bumDA==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Fix kmemleak L2 IST table entries
 false positives
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811135001.1333684-1-lpieralisi@kernel.org>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603094697.1420.8212077236889894044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1a2cce5b91eeeac24104cbccd8cd3a4dfbdbaa7a
Gitweb:        https://git.kernel.org/tip/1a2cce5b91eeeac24104cbccd8cd3a4dfbd=
baa7a
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Mon, 11 Aug 2025 15:50:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:12:53 +02:00

irqchip/gic-v5: Fix kmemleak L2 IST table entries false positives

L2 IST table entries are allocated with the kmalloc interface and their
physical addresses are programmed in the GIC (either IST base address
register or L1 IST table entries) but their virtual addresses are not
stored in any kernel data structure because they are not needed at runtime
- the L2 IST table entries are managed through system instructions but
never dereferenced directly by the driver.

This triggers kmemleak false positive reports:

unreferenced object 0xffff00080039a000 (size 4096):
  comm "swapper/0", pid 0, jiffies 4294892296
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc+0x34/0x40
    __kmalloc_noprof+0x320/0x464
    gicv5_irs_iste_alloc+0x1a4/0x484
    gicv5_irq_lpi_domain_alloc+0xe4/0x194
    irq_domain_alloc_irqs_parent+0x78/0xd8
    gicv5_irq_ipi_domain_alloc+0x180/0x238
    irq_domain_alloc_irqs_locked+0x238/0x7d4
    __irq_domain_alloc_irqs+0x88/0x114
    gicv5_of_init+0x284/0x37c
    of_irq_init+0x3b8/0xb18
    irqchip_init+0x18/0x40
    init_IRQ+0x104/0x164
    start_kernel+0x1a4/0x3d4
    __primary_switched+0x8c/0x94

Instruct kmemleak to ignore L2 IST table memory allocation virtual
addresses to prevent these false positive reports.

Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250811135001.1333684-1-lpieralisi@kernel.=
org
Closes: https://lore.kernel.org/lkml/cc611dda-d1e4-4793-9bb2-0eaa47277584@hua=
wei.com/
---
 drivers/irqchip/irq-gic-v5-irs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index f845415..ffc9773 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -5,6 +5,7 @@
=20
 #define pr_fmt(fmt)	"GICv5 IRS: " fmt
=20
+#include <linux/kmemleak.h>
 #include <linux/log2.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_=
irs_chip_data *irs_data
 		kfree(ist);
 		return ret;
 	}
+	kmemleak_ignore(ist);
=20
 	return 0;
 }
@@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
 		kfree(l2ist);
 		return ret;
 	}
+	kmemleak_ignore(l2ist);
=20
 	/*
 	 * Make sure we invalidate the cache line pulled before the IRS

