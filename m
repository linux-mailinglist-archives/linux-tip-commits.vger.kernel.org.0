Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF07D1927C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Mar 2020 13:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCYMGY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Mar 2020 08:06:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgCYMGV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nU-0000lp-JV; Wed, 25 Mar 2020 13:06:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC3051C0489;
        Wed, 25 Mar 2020 13:06:06 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:06 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] ia64: Replace cpu_down() with smp_shutdown_nonboot_cpus()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-4-qais.yousef@arm.com>
References: <20200323135110.30522-4-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796636.28353.2605944745472235096.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     1e42176b4dac328b0be7075c2cebdf2006d31eb3
Gitweb:        https://git.kernel.org/tip/1e42176b4dac328b0be7075c2cebdf2006d31eb3
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:50:56 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:32 +01:00

ia64: Replace cpu_down() with smp_shutdown_nonboot_cpus()

Use the new smp_shutdown_nonboot_cpus() instead of using cpu_down()
directly.

Use reboot_cpu instead of hardcoding the boot CPU to 0.

This also prepares to make cpu_up/down() a private interface of the CPU
subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20200323135110.30522-4-qais.yousef@arm.com

---
 arch/ia64/kernel/process.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f3..bf4c0cd 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -646,14 +646,8 @@ cpu_halt (void)
 
 void machine_shutdown(void)
 {
-#ifdef CONFIG_HOTPLUG_CPU
-	int cpu;
+	smp_shutdown_nonboot_cpus(reboot_cpu);
 
-	for_each_online_cpu(cpu) {
-		if (cpu != smp_processor_id())
-			cpu_down(cpu);
-	}
-#endif
 #ifdef CONFIG_KEXEC
 	kexec_disable_iosapic();
 #endif
