Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1992D8694
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405296AbgLLNDn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438957AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BAC0611CB;
        Sat, 12 Dec 2020 04:58:46 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxoNqSYapiGtMGFOuQGAr0QDBJi2mQgLankMvhDu6mg=;
        b=qgCGWXWMmgd5PYO0V/6S5dHEeJ9i2tuYQvVR1bxNRIhvPVzHRdqjRBdsPauXGT18sBM5tF
        X94GjrYbk+yrgZAtAQT0W6ZFA5ViSa/sgs8qjh2FhMWWPVMUTzrI/4TjG+w4A2yNtNXUTU
        2+gJc6pfXmb1WfrdcCywb7gV8WzZzGtyd3TdvX+Rv+xRCVCR8wqCZPdkjPQsg0Kb3PvL9z
        T3KOqq+DYaniwoCe2DmaxPwEFz2df1CiyX6ivQMfZw0q4MAj7tstrFZyOhQJ26f8fMNxb1
        /JEsXwe6k2wJY5XdZDgCs4E3QhR5XneHsJISlQCzgYqNkJdcdGp0XrIUZwbSpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxoNqSYapiGtMGFOuQGAr0QDBJi2mQgLankMvhDu6mg=;
        b=MbJtfl6joklMWG3SRZBm0NXgzupIeNu8C/4+7SO8v34JGvBtpQ4DVTZ4vgSbcEXchy4Dl/
        gzld1jUjI86hkXBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide irq_get_effective_affinity()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194042.967177918@linutronix.de>
References: <20201210194042.967177918@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792133.3364.14572344639030307980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     276b1e6e6fecc2f138c72519705dabc8bd01ffa9
Gitweb:        https://git.kernel.org/tip/276b1e6e6fecc2f138c72519705dabc8bd01ffa9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Provide irq_get_effective_affinity()

Provide an accessor to the effective interrupt affinity mask. Going to be
used to replace open coded fiddling with the irq descriptor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.967177918@linutronix.de

---
 include/linux/irq.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 79ce314..2385b81 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -907,6 +907,13 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
 }
 #endif
 
+static inline struct cpumask *irq_get_effective_affinity_mask(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	return d ? irq_data_get_effective_affinity_mask(d) : NULL;
+}
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
