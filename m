Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5B2C18E0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbgKWWwg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbgKWWvt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:49 -0500
Date:   Mon, 23 Nov 2020 22:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkBw7P73uLvcEZkfhady/16eN+F041E6rZq3AYnI4sQ=;
        b=WVr5V18MaXMcMevkHxF6aY4jtYXDueuoMRUh1miEVWHf4bNcBe5ad298EolU+Ihgv+sRan
        l6BTjyWffYCdSoR2kKcyg9wFZg8co9fxC+bMNRvshC18m8Jc4sTq8zHN/ofM18ptoh+0xs
        +LNyW1aIFudwv0ejTybzqepMXeZTYQh/3QC7FRqmlJh+JzqJiukbwl/QsBKOo9afx5Alnu
        DMOMD3sZwVfecAvVYaklVjn5wk3D0uHNsTyJAB/gv5vx1pD6CW0i6KtNEa4pkFYOyy7JSF
        N5fogO5GntuE3G1hvsrRrY/gvaJx03OVXiBWMpz6ep54Vwo/DMtudRu7TC8uBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkBw7P73uLvcEZkfhady/16eN+F041E6rZq3AYnI4sQ=;
        b=xkqXW7JBJf5EXVyWXggbNpsPauMj6V2ftrFKxRgXFJCYhmmrPn7suZkdZ00JfuorgvJ1E2
        +24LYokOZItR0mCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sh: irqstat: Use the generic irq_cpustat_t
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.625146223@linutronix.de>
References: <20201113141733.625146223@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190559.11115.1468849090363137294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fd15c1941f0ae0b46d48431d0020edfc843abd33
Gitweb:        https://git.kernel.org/tip/fd15c1941f0ae0b46d48431d0020edfc843abd33
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:06 +01:00

sh: irqstat: Use the generic irq_cpustat_t

SH can now use the generic irq_cpustat_t. Define ack_bad_irq so the generic
header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.625146223@linutronix.de

---
 arch/sh/include/asm/hardirq.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/sh/include/asm/hardirq.h b/arch/sh/include/asm/hardirq.h
index edaea35..9fe4495 100644
--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -2,16 +2,10 @@
 #ifndef __ASM_SH_HARDIRQ_H
 #define __ASM_SH_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/irq.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;		/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+#define ARCH_WANTS_NMI_IRQSTAT
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_SH_HARDIRQ_H */
