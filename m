Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BC9A55A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfHWCMj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:12:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389328AbfHWCMU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3p-0000xf-BB; Fri, 23 Aug 2019 04:12:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0CF751C07E4;
        Fri, 23 Aug 2019 04:12:17 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:16 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Cleanup forward declarations and
 includes
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190819143801.472005793@linutronix.de>
References: <20190819143801.472005793@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633698.11661.15470255584101715791.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ce03f613461642669d6150c405dd28f4bfd54bbb
Gitweb:        https://git.kernel.org/tip/ce03f613461642669d6150c405dd28f4bfd54bbb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 Aug 2019 16:31:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2019 22:09:52 +02:00

posix-timers: Cleanup forward declarations and includes

 - Rename struct siginfo to kernel_siginfo as that is used and required
 - Add a forward declaration for task_struct and remove sched.h include
 - Remove timex.h include as it is not needed

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.472005793@linutronix.de

---
 include/linux/posix-timers.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 604cec0..26c636d 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,11 +4,10 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/sched.h>
-#include <linux/timex.h>
 #include <linux/alarmtimer.h>
 
-struct siginfo;
+struct kernel_siginfo;
+struct task_struct;
 
 struct cpu_timer_list {
 	struct list_head entry;
