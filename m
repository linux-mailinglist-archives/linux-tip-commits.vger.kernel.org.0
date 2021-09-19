Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07922410D6C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 19 Sep 2021 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhISVFN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 19 Sep 2021 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVFM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 19 Sep 2021 17:05:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B1C061574;
        Sun, 19 Sep 2021 14:03:46 -0700 (PDT)
Date:   Sun, 19 Sep 2021 21:03:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632085424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHtSddGS6RwHOmqihnVgS6lv8ws8YpoUrVO1T/DKJdI=;
        b=QeyFI9iLNdk6iOZ4IXWZQyIVTUpBDs2gKrngT9NUHkuQ0fdwJT7MMHDYH7A7q843DUVeeF
        FGoI5gDeLEfSvpo4oSh4x06LRDRM+5JLmlciRHFkiMNNaQlutH6/FM4VAJ6fA4WGgZm45V
        03C7FBc7ifdwsUT1nm81Cl186LQlEgtTEbqH/y5Zc871ImuugNPPxtKpzdlETK9pmCePrs
        2UI7KyusY2AkKlRYa09UTxRuPnpbFGIBJg2gDDzUKtv3IDr60w3ZFrh1wwwELU9EuwMSAd
        RnYXg5DD99iaI7iVB5agE8iqyh5eDSrMQdJ1YwHFojtnjuZJxjS6AVxV9ug95g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632085424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHtSddGS6RwHOmqihnVgS6lv8ws8YpoUrVO1T/DKJdI=;
        b=IVIlFSOLNffHq0HUUVseCrLQHL3ZAleyAoqxQ+gGGPdXF3R0XQKDSYn1pLxM8rd0UlZf2u
        frNLj1uR5w9TyrBw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Disable irqfixup/poll on PREEMPT_RT.
Cc:     Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210917223841.c6j6jcaffojrnot3@linutronix.de>
References: <20210917223841.c6j6jcaffojrnot3@linutronix.de>
MIME-Version: 1.0
Message-ID: <163208542290.25758.2684703909187888712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b70e13885cf63b6f99cbd9a1dbb6beaa2622bf68
Gitweb:        https://git.kernel.org/tip/b70e13885cf63b6f99cbd9a1dbb6beaa2622bf68
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 03 Jul 2009 08:29:57 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 19 Sep 2021 23:01:15 +02:00

genirq: Disable irqfixup/poll on PREEMPT_RT.

The support for misrouted IRQs is used on old / legacy systems and is
not feasible on PREEMPT_RT.

Polling for interrupts reduces the overall system performance.
Additionally the interrupt latency depends on the polling frequency and
delays are not desired for real time workloads.

Disable IRQ polling on PREEMPT_RT and let the user know that it is not
enabled. The compiler will optimize the real fixup/poll code out.

[ bigeasy: Update changelog and switch to IS_ENABLED() ]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210917223841.c6j6jcaffojrnot3@linutronix.de
---
 kernel/irq/spurious.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index c481d84..02b2daf 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -447,6 +447,10 @@ MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detection when true");
 
 static int __init irqfixup_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqfixup boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
@@ -459,6 +463,10 @@ module_param(irqfixup, int, 0644);
 
 static int __init irqpoll_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqpoll boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 2;
 	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
 				"enabled\n");
