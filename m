Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC42C18E4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgKWWwh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbgKWWvt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:49 -0500
Date:   Mon, 23 Nov 2020 22:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/eujOdjUJrhufpjcpQASeW1wguCtS6o4ZIjhXYhfr0=;
        b=FT/36Izhp7EZjUE5Yu0UlTLrHP7JFhPZbg4MLIX9ay/AG1WNOlNZING4IJa94Run22mxaa
        n8cRVDgKy3VdtMJd4aB7gBq12vk0V5pPfzsYApvYYviB8dVu8Xlg5gyE+Z5e/WhjhDx7+s
        ChrO8lr3vmBgbMFRIM2myWPs8mmyl066tKMzNUEVss+JOqAL1AHl29tE6MXwCh7x9rH3Hp
        Rkjil1ocafYN87t++ot75W+WdeoNm48/D2JWGqAkEaarRHyaQaGoHZEgZN8Bt1ccsjoQul
        B73afi4LDvP4i1Ma1A+BdR0wcdIFLt0aYdViByQKc3Y/BnVCx6UI4vOyy3oJ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/eujOdjUJrhufpjcpQASeW1wguCtS6o4ZIjhXYhfr0=;
        b=b5fYlDrkLaN7Y/QqmeAm+lNJJqx1XdgUexSXBt9h3jVdmRP7UoakrBi/073ue7aZT+MrYw
        rnnia4GuSQTH4nBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] asm-generic/irqstat: Add optional __nmi_count member
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.501611990@linutronix.de>
References: <20201113141733.501611990@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190618.11115.4619942314562685698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1adb99eabce9deefb55985c19181d375ba6ff4aa
Gitweb:        https://git.kernel.org/tip/1adb99eabce9deefb55985c19181d375ba6ff4aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:06 +01:00

asm-generic/irqstat: Add optional __nmi_count member

Add an optional __nmi_count member to irq_cpustat_t so more architectures
can use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.501611990@linutronix.de

---
 include/asm-generic/hardirq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214d..f5dd997 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -7,6 +7,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef ARCH_WANTS_NMI_IRQSTAT
+	unsigned int __nmi_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
