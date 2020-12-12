Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584672D8695
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405688AbgLLNDp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438962AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4CC0611CC;
        Sat, 12 Dec 2020 04:58:46 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1lBa/sKexG+SJIcc9xB/l2ZhQnK+L5HGjO6Gjgbu/Y=;
        b=kgWX9PlyRFrD9URdfePcfdlNfGOQJeKY9Lh/kU4a0phVsyFKOF+6LLu/qf2XmVk0m+uoGL
        JgF8INQLy2RmQZl2s1MTRoMLaHBKuGlObQmPXgG0l2l6JdM+l3ZtdfrF4g1QcAKOC4xBsA
        8+h+fl3nTi3jFsF1hovPG4rYRlrm8AaivsC1/Lu5jkv2rXjNOlSuHjpqRqYc+7xg4aGpJ0
        yudgfCxNEAHo4gwD0DBhkUivrJYMfzHgm2ltuBVl0w9UXQJCvrGBkaD+N0dAgQJTAtt2ib
        BFt84c6qD3054YMI0QwkjBT+WRm16Fp+P+RV+3t1vZbCULUMvRWIhH6dz9RbOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1lBa/sKexG+SJIcc9xB/l2ZhQnK+L5HGjO6Gjgbu/Y=;
        b=83HwTXf4c7basT0Asvm8byVBMIqddl1xjakznR+pQgkQMkDqky6ukZMwTMeupS4P/pZXws
        B7XgaJ4aKj8eFxBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Annotate irq stats data races
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.067097663@linutronix.de>
References: <20201210194043.067097663@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792105.3364.9820233761878732243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fb4f676fc901cb547226efb3e69ffeaeefa124be
Gitweb:        https://git.kernel.org/tip/fb4f676fc901cb547226efb3e69ffeaeefa124be
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

genirq: Annotate irq stats data races

Both the per cpu stats and the accumulated count are accessed lockless and
can be concurrently modified. That's intentional and the stats are a rough
estimate anyway. Annotate them with data_race().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194043.067097663@linutronix.de

---
 kernel/irq/irqdesc.c | 4 ++--
 kernel/irq/proc.c    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f309869..d28f69e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -943,10 +943,10 @@ unsigned int kstat_irqs(unsigned int irq)
 	if (!irq_settings_is_per_cpu_devid(desc) &&
 	    !irq_settings_is_per_cpu(desc) &&
 	    !irq_is_nmi(desc))
-	    return desc->tot_count;
+		return data_race(desc->tot_count);
 
 	for_each_possible_cpu(cpu)
-		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
+		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
 	return sum;
 }
 
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 72513ed..9813878 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,9 +488,10 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs)
+	if (desc->kstat_irqs) {
 		for_each_online_cpu(j)
-			any_count |= *per_cpu_ptr(desc->kstat_irqs, j);
+			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+	}
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;
