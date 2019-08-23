Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365749A548
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfHWCMT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:12:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389315AbfHWCMT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3o-0000x0-FX; Fri, 23 Aug 2019 04:12:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 31F0C1C07E4;
        Fri, 23 Aug 2019 04:12:16 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:16 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Fixup stale comment
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190819143801.747233612@linutronix.de>
References: <20190819143801.747233612@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633614.11655.4443334597910652856.tip-bot2@tip-bot2>
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

Commit-ID:     7cb9a94c158b956f46cf093ed966d0c1e996dddb
Gitweb:        https://git.kernel.org/tip/7cb9a94c158b956f46cf093ed966d0c1e996dddb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 Aug 2019 16:31:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2019 22:09:53 +02:00

posix-cpu-timers: Fixup stale comment

The comment above cleanup_timers() is outdated. The timers are only removed
from the task/process list heads but not modified in any other way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.747233612@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a426f4..742d4a4 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -412,9 +412,10 @@ static void cleanup_timers_list(struct list_head *head)
 }
 
 /*
- * Clean out CPU timers still ticking when a thread exited.  The task
- * pointer is cleared, and the expiry time is replaced with the residual
- * time for later timer_gettime calls to return.
+ * Clean out CPU timers which are still armed when a thread exits. The
+ * timers are only removed from the list. No other updates are done. The
+ * corresponding posix timers are still accessible, but cannot be rearmed.
+ *
  * This must be called with the siglock held.
  */
 static void cleanup_timers(struct list_head *head)
