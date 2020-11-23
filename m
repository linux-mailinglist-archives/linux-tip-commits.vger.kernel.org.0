Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211812C18EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgKWWwi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbgKWWvv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50DC0613CF;
        Mon, 23 Nov 2020 14:51:50 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4ySV0KIM7oUBIiD0btyhFbnGjkQ5j3Wf0snRN+cCw8=;
        b=e6hEq/S0p/J++bJhdJ1Cf8FCVQQbtC+XDBSW4rP+khifdxpwFgL3EXCQMrSboULCjVNP8h
        ey3h2g9FN7QTz7dDIKbL77HP125mZ0lA+Y4pkquWny0OI7Z+BPvKBdekJ+CBG0DpR1HVkk
        o/1jlI7gTocAkd/ZvSf6dGWLvRBiqQIZOogR9LhFFX8jV5P4DnlItDl9/D+ug2E9Kxd2A3
        AgS1ijCQvbdOuFRCN1FINVwp0O+CoXsMRr1gYzRiVGBVsQQsFqbWpFxC0gk1cNFdF0QeER
        NcrsRfzjhCpDoN2blH7jTK9rTC0d1obumv8Vu7EDDrijo+8jXcIuTXmyx3tW9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4ySV0KIM7oUBIiD0btyhFbnGjkQ5j3Wf0snRN+cCw8=;
        b=vSVNEf6QUYYn3hDdI9Rh/fsoTjDGOQvz6eLHvA5wrDjy3FM4waujR/DQu+SYm/qHeSj6M4
        7k3EVFb6eBQhoSCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqstat: Get rid of nmi_count() and __IRQ_STAT()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.005212732@linutronix.de>
References: <20201113141733.005212732@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190856.11115.9272233845735009132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     769dda58d1f647a45270db2f02efe2e2de856709
Gitweb:        https://git.kernel.org/tip/769dda58d1f647a45270db2f02efe2e2de856709
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

irqstat: Get rid of nmi_count() and __IRQ_STAT()

Nothing uses this anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.005212732@linutronix.de

---
 include/linux/irq_cpustat.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
index 6e8895c..78fb2de 100644
--- a/include/linux/irq_cpustat.h
+++ b/include/linux/irq_cpustat.h
@@ -19,10 +19,6 @@
 
 #ifndef __ARCH_IRQ_STAT
 DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
 #endif
 
-/* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
-
 #endif	/* __irq_cpustat_h */
