Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C919F13D91D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2020 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAPLfT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Jan 2020 06:35:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPLfT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Jan 2020 06:35:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1is3Qg-0005Pk-4r; Thu, 16 Jan 2020 12:35:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91B831C0334;
        Thu, 16 Jan 2020 12:35:13 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:35:13 -0000
From:   "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] watchdog: Remove soft_lockup_hrtimer_cnt and related code
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191218131720.4146aea2@xhacker.debian>
References: <20191218131720.4146aea2@xhacker.debian>
MIME-Version: 1.0
Message-ID: <157917451326.396.13435521512432492165.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/core branch of tip:

Commit-ID:     d129479f1fff5c88adbf8dff7649664916d28f81
Gitweb:        https://git.kernel.org/tip/d129479f1fff5c88adbf8dff7649664916d28f81
Author:        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
AuthorDate:    Wed, 18 Dec 2019 05:31:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2020 12:25:51 +01:00

watchdog: Remove soft_lockup_hrtimer_cnt and related code

After commit 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u"
threads with cpu_stop_work"), the percpu soft_lockup_hrtimer_cnt is
not used any more, so remove it and related code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191218131720.4146aea2@xhacker.debian

---
 kernel/watchdog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334e..0621301 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -173,7 +173,6 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
@@ -350,8 +349,6 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
-	__this_cpu_write(soft_lockup_hrtimer_cnt,
-			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
 
