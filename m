Return-Path: <linux-tip-commits+bounces-1332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75E8D7F7C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB691F256F1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624684A3B;
	Mon,  3 Jun 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPJJ1ZsL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JSEWZVyJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F723BBE0;
	Mon,  3 Jun 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408468; cv=none; b=SiKNgDtrcxeaWw+4V3H0aBYaPgSRzdLnPELAqshtiax2e0FsAhdiwdWQnfPuvR7FEPS4IFTy9Z6d9fbHIo06PSxs6M93ztIlKAoqh/71r1dDIfMMH8kvAZnxFjseN7Ypv+LpGlqw62/HZ6KzIS/utV7rUGCAZjr2nTtxJV+4YE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408468; c=relaxed/simple;
	bh=In4lom+hG/oJFTmkvxRNExZc1lPNnnRUofZrzHVTmKM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jjYKMd5sQCrpeyJlzHNrIEY/bcbbtGUYDDfhAhqaPJ6CXd5R7t7BCUJS1qi2OZyQpYN0mW2J8eWBTnflTbO6PzbNJ7ZJ5965iwkyybSLAN6oiIMXoTzS6/vv9+X6Dw0GR0ydZ/nCRxK1A72d5Z9G65LpHkF8OZq1UuMaIkrbXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPJJ1ZsL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JSEWZVyJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717408465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7hulflvLTgJgmFgkRqAnHWG0dfGWjMefusBg5L/RII=;
	b=nPJJ1ZsLWKbNtE6FCgfa9Ou2J4OaD6R89xHdL7Ky2FRS+l6fGClbcxfvgXnK5NBlegIg4A
	nh3qinlTDIVQlDsl4x3aeJ59MOYinKscdpl57lp1XpJYndwCfyHjOPIZCpynU5sxPb6umj
	bmmvkz2yoSg/zuRtfJ+e0kIMm1AiSp0z9CCP9rQuD0VMCccBNUghGg7gjIb6z10U3Mw/4I
	U6958w+jhmnv7Q+ish1UfN1O0I9NApg3VyZjpT03r4Ox4BRtnA2Qcxqn+T082RgNa2YwCC
	8pvav06AmesI17128jcYYY4R5hwN6tAl0xeWAzWB4QzZil1tGg1NHvQ2m066iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717408465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7hulflvLTgJgmFgkRqAnHWG0dfGWjMefusBg5L/RII=;
	b=JSEWZVyJAIDLlaqKZJbyTGVvYmId6xRrv2tLEQ7c7MrhWUj0fEHoP5iNg8gikCGUp6RuPP
	wpgV67UDsbnUtZCA==
From: "tip-bot2 for Adrian Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/proc: Simplify irqdesc::kstat_irqs handling further
Cc: Thomas Gleixner <tglx@linutronix.de>, Adrian Huang <ahuang12@lenovo.com>,
 Jiwei Sun <sunjw10@lenovo.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240515100632.1419-1-ahuang12@lenovo.com>
References: <20240515100632.1419-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740846466.10875.8507564060524290466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     540588772ed0b191969c7902bf90d561ab0035be
Gitweb:        https://git.kernel.org/tip/540588772ed0b191969c7902bf90d561ab0035be
Author:        Adrian Huang <ahuang12@lenovo.com>
AuthorDate:    Wed, 15 May 2024 18:06:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:48:29 +02:00

genirq/proc: Simplify irqdesc::kstat_irqs handling further

Interrupts which have no action and chained interrupts can be
ignored due to the following reasons (as per tglx's comment):

  1) Interrupts which have no action are completely uninteresting as
     there is no real information attached.

  2) Chained interrupts do not have a count at all.

So there is no point to evaluate the number of accounted interrupts before
checking for non-requested or chained interrupts.

Remove the any_count logic and simply check whether the interrupt
descriptor has the kstat_irqs member populated.

[ tglx: Adapted to upstream changes ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Link: https://lore.kernel.org/r/20240515100632.1419-1-ahuang12@lenovo.com
Link: https://lore.kernel.org/lkml/87h6f0knau.ffs@tglx/
---
 kernel/irq/proc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 5c320c3..8cccdf4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -461,10 +461,10 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
 
-	unsigned long flags, any_count = 0;
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	unsigned long flags;
 
 	if (i > ACTUAL_NR_IRQS)
 		return 0;
@@ -488,10 +488,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs)
-		any_count = kstat_irqs_desc(desc, cpu_online_mask);
-
-	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);

