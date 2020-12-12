Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A82D8684
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438921AbgLLM7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 07:59:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438898AbgLLM7b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:31 -0500
Date:   Sat, 12 Dec 2020 12:58:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JQ2DGHT0t4i6gF/9qcMTahRzSm/eFv8wIZRlzZ/bDI=;
        b=N/94sXmPyx7eYuzDq84AipHfA3rGqr36FpMPctFWNdqPv2WHVXQriWeSDnedtjJnrZsuwW
        C+GRewCpIIT6Mj5vhk0w8PylKtVguC7hPgxZYBgRWibNdRrthjyGR9VDY35yt2ERYPfV6b
        xxODiJuhrsXmF9UGzfv78j/6wtsEN2kODdNGEWPonPjWH3VT09+RKdK4AdNhPtC0cicm/g
        DbV31AqhCLJfFrDdEUNbfdT9wLj0XWYKvT7HCwy6GGpXvJilLszUcVZlMIfjMIUoI31gIr
        1xqMsvUCOZ1hjoqMbvxNVycv66eV4Ja3w6FIl0KUzgqTg/IwG7kHwvs7sf4YnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JQ2DGHT0t4i6gF/9qcMTahRzSm/eFv8wIZRlzZ/bDI=;
        b=1vxdCaq/Z8ZNC4DznItO90Esh6/OlL4FlmpcmxN48p5yytPYpt2p+X4LLfHMqSQ7GsSHQE
        8NtRqPA4cZcKarBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide kstat_irqdesc_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.362094758@linutronix.de>
References: <20201210194043.362094758@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792016.3364.4118604074336451470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ea5f36556b8bde14234ec223ebc59968ade4735a
Gitweb:        https://git.kernel.org/tip/ea5f36556b8bde14234ec223ebc59968ade4735a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

genirq: Provide kstat_irqdesc_cpu()

Most users of kstat_irqs_cpu() have the irq descriptor already. No point in
calling into the core code and looking it up once more.

Use it in per_cpu_count_show() to start with.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194043.362094758@linutronix.de

---
 include/linux/irqdesc.h | 6 ++++++
 kernel/irq/irqdesc.c    | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 4a1d016..891b323 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -113,6 +113,12 @@ static inline void irq_unlock_sparse(void) { }
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
+static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
+					      unsigned int cpu)
+{
+	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+}
+
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
 {
 	return container_of(data->common, struct irq_desc, irq_common_data);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1f7325f..18dd779 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -147,12 +147,12 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	int cpu, irq = desc->irq_data.irq;
 	ssize_t ret = 0;
 	char *p = "";
+	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		unsigned int c = kstat_irqs_cpu(irq, cpu);
+		unsigned int c = irq_desc_kstat_cpu(desc, cpu);
 
 		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
 		p = ",";
