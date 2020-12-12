Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB252D86BC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439062AbgLLNJQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:09:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438899AbgLLM7b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:31 -0500
Date:   Sat, 12 Dec 2020 12:58:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93YLj9aryUhPpc0BEjF7zC70GEdG7QvZQPuRoIVFALo=;
        b=qhEIMKXtsNA5bIQZnU7IhxUxIYyC/4o6e8xYGRBoqfXYlYuwQ6REKNXlobGLjlW04wXSXZ
        gscInUNPU5fTjwRSEoz8yWz3boaP7dbV5SRCKB7K64Avxu1yvxN8UzzFdE2oHJ8hXqsFZK
        QgXDdjDywIQF5P+Amj2+e0/obFQ4knW3iXiZwVm44V5Py43ZcVzsVn5pVJxqgUSm52Fxme
        ZTUMCF1LDFh66DtN+P+gSMhvWkmgqE8Lb+ANyVpDioho4saBgA+AdR4em0cjdmx3bmpwB4
        uQ8RyOTgKiKrXaBG9nKmY7xUL+fhJHzeJz3BDVdMhFWhLr3vZ/V8c97ttCanYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93YLj9aryUhPpc0BEjF7zC70GEdG7QvZQPuRoIVFALo=;
        b=bucHP8b5dHorut7MzBVAzM+Lei2n6Q5DvOgtkoQCJxAX7p8rKWlfBzRsY2LdsvC7G9gKah
        SVDhFWslioI+LVDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] parisc/irq: Simplify irq count output for /proc/interrupts
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-parisc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.172893840@linutronix.de>
References: <20201210194043.172893840@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792076.3364.15318766316290964513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     89c1ca3058ced5cc8176de7b668b9d0ff08f8f4b
Gitweb:        https://git.kernel.org/tip/89c1ca3058ced5cc8176de7b668b9d0ff08f8f4b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

parisc/irq: Simplify irq count output for /proc/interrupts

The SMP variant works perfectly fine on UP as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-parisc@vger.kernel.org
Link: https://lore.kernel.org/r/20201210194043.172893840@linutronix.de

---
 arch/parisc/kernel/irq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e76c866..15c6207 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -216,12 +216,9 @@ int show_interrupts(struct seq_file *p, void *v)
 		if (!action)
 			goto skip;
 		seq_printf(p, "%3d: ", i);
-#ifdef CONFIG_SMP
+
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#else
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#endif
 
 		seq_printf(p, " %14s", irq_desc_get_chip(desc)->name);
 #ifndef PARISC_IRQ_CR16_COUNTS
