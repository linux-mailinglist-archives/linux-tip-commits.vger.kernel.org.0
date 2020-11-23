Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26212C18E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgKWWwh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbgKWWvu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79629C061A4D;
        Mon, 23 Nov 2020 14:51:50 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+gG496E2BgxvaVGCXJJEfT7jZ7ytarDwdinxOoXvgg=;
        b=Yrd38s0gOLohQHWIoA8bzAfbdSK6ZhchAQJKMKzemcNS/ijIepl3byqRTCJZQdQIe59B6I
        rS3V1xQtTi2Uyy1SaK//ggYgoPkRu6PbAcf3O0eH2MaqBQBfeCQwX4BtGxzkxAOlv8Z1CZ
        vkmqGJj78tgLkjWCs1ovcmmVp32fOPdJidUUGaPNjvJb2hPSma2IxVMglk0ZlFCVlo9bn/
        q4GAX3tkLs9f29OH2nQXnxm85P8OJgwrzKXQ5D1izuIKaTkCegTuNVUFpcCxVPVLhBZv0v
        j0kYzXJbELDZnNvEsTTuKWTPL0g8o5NI3by8VWky93tUAjLv3NQVgb5QGneLfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+gG496E2BgxvaVGCXJJEfT7jZ7ytarDwdinxOoXvgg=;
        b=oM/vqD9X4RzMrpHpuYnUxLo8RGdKmTr7xgD/WjhCrSc+tCfFjD2wMxLb34mjoziaydfWYi
        7wSsHDSRHhZlsWCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: irqstat: Get rid of duplicated declaration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201113141733.392015387@linutronix.de>
References: <20201113141733.392015387@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190678.11115.3868292191963465356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2cb0837e56e1b04b773ed05df72297de4e010063
Gitweb:        https://git.kernel.org/tip/2cb0837e56e1b04b773ed05df72297de4e010063
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

arm64: irqstat: Get rid of duplicated declaration

irq_cpustat_t is exactly the same as the asm-generic one. Define
ack_bad_irq so the generic header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.392015387@linutronix.de

---
 arch/arm64/include/asm/hardirq.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 5ffa4ba..cbfa7b6 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,11 +13,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define ack_bad_irq ack_bad_irq
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
