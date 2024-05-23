Return-Path: <linux-tip-commits+bounces-1286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681818CD99A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 May 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E775F1F2147A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 May 2024 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382D4F8BB;
	Thu, 23 May 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="riaDfviC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gn6t8o2I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA9F9F5;
	Thu, 23 May 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487422; cv=none; b=TvpX60ck/omgg1KdZ6QS0FQC9b4l/mKXOnU9gseG7T03Pou1IkbgvS3PN+tVND5K9Y84//XlXsCqJJ9xxjeEZFvBZAnkKXrl+N4RiOedGioMhjpRJYLNZWriddBlGrlGRac8RNC38CBYC+/jOYd8bLLusxDUG2ECMuSLmj3Bqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487422; c=relaxed/simple;
	bh=fgFCQKkzi3o7jrRI+z4PJ+96C/8tsH8Tyrk26hCeeXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IBvZuvBF1OK9B/ACKs3ZbazTUENlgooTUIGvffUDdRuJ6+GInmrN+L7NoqxYvVfO7xYWGuj0lbuccUXU3teZmLfr5Vk4NHw9cHDZmVhKCSLTBrqdRUAkhLJ77HRgHf3+78J8JH52/Sb4fSelqSADAOQG2gwOJLVA50lXjAs+CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=riaDfviC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gn6t8o2I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 May 2024 18:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716487418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUBVaf+IpEpYSyjsJQQw9ZgRULIxr3jpN5m8hkJ3YTo=;
	b=riaDfviCQq1fdIDjSzjjQhy14vQeEhvJRYpXMjymkK1cIQLjoGJjlkCwJKxwoboZqkN9Dw
	dOfjaFLxwTglkbpRv07CbfHmVHRpJ1v1MWVTHrIg59PdUosL8gu60NmTgR24DMM9J4h9/S
	jy4N4NDsw6NYMLqdW9rwugUjvXIbiGBtV90r/89LCZkILByTqwI0T5fnRWyAhbb0hiVdXJ
	OXzl/qQJivkk0oU+7XLc7LKEuwGxi6YKLBUpmKCYQXrfu/iKDXuFKfJUAv33tfKQ2JTaex
	Yv+/ogbUfgRDbLn1P2CDpR0YxMJKzIBLdJc2UG7FkXe41cLXWJ72HjBvrGwU1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716487418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUBVaf+IpEpYSyjsJQQw9ZgRULIxr3jpN5m8hkJ3YTo=;
	b=gn6t8o2I+vP7OYBhthT1K07Xw8R7xzN3tyvHn8ubdxTMwKO5oVHbKxKpZj6Y4HqAdAXAYR
	jlsFH6UB46ORdRCw==
From: "tip-bot2 for Palmer Dabbelt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-imsic: Fixup
 riscv_ipi_set_virq_range() conflict
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240522184953.28531-3-palmer@rivosinc.com>
References: <20240522184953.28531-3-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171648741822.10875.7508999228304750442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     88d68bbd07328aea6f6488b6803839970880492a
Gitweb:        https://git.kernel.org/tip/88d68bbd07328aea6f6488b6803839970880492a
Author:        Palmer Dabbelt <palmer@rivosinc.com>
AuthorDate:    Wed, 22 May 2024 11:49:55 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 May 2024 19:57:12 +02:00

irqchip/riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict

There was a semantic conflict between 21a8f8a0eb35 ("irqchip: Add RISC-V
incoming MSI controller early driver") and dc892fb44322 ("riscv: Use
IPIs for remote cache/TLB flushes by default") due to an API change.
This manifests as a build failure post-merge.

Fixes: 0bfbc914d943 ("Merge tag 'riscv-for-linus-6.10-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")
Reported-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240522184953.28531-3-palmer@rivosinc.com
Link: https://lore.kernel.org/all/mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9/

---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 886418e..4fbb370 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
 		return virq < 0 ? virq : -ENOMEM;
 
 	/* Set vIRQ range */
-	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
 
 	/* Announce that IMSIC is providing IPIs */
 	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);

