Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4CAAD56
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2019 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbfIEUuC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Sep 2019 16:50:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44590 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391712AbfIEUuB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i5yha-0001kc-Dx; Thu, 05 Sep 2019 22:49:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16CE71C0DEC;
        Thu,  5 Sep 2019 22:49:58 +0200 (CEST)
Date:   Thu, 05 Sep 2019 20:49:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: refs/heads/timers/core] posix-cpu-timers: Always clear head
 pointer on dequeue
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156771659804.12994.17024357039924554686.tip-bot2@tip-bot2>
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

The following commit has been merged into the refs/heads/timers/core branch of tip:

Commit-ID:     00d9e47f8ec2a293db9ebed86aab0583d9a49533
Gitweb:        https://git.kernel.org/tip/00d9e47f8ec2a293db9ebed86aab0583d9a49533
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 05 Sep 2019 14:03:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 05 Sep 2019 21:16:22 +02:00

posix-cpu-timers: Always clear head pointer on dequeue

The head pointer in struct cpu_timer is checked to be NULL in
posix_cpu_timer_del() when the delete raced with the exit cleanup. The
works correctly as long as the timer is actually dequeued via
posix_cpu_timers_exit*().

But if the timer was dequeued due to expiry the head pointer is still set
and triggers the warning.

In fact keeping the head pointer around after any dequeue is pointless as
is has no meaning at all after that.

Clear the head pointer always on dequeue and remove the unused requeue
function while at it.

Fixes: 60bda037f1dd ("posix-cpu-timers: Utilize timerqueue for storage")
Reported-by: syzbot+55acd54b57bb4b3840a4@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190905120539.707986830@linutronix.de

---
 include/linux/posix-timers.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index e685916..3d10c84 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -74,11 +74,6 @@ struct cpu_timer {
 	int			firing;
 };
 
-static inline bool cpu_timer_requeue(struct cpu_timer *ctmr)
-{
-	return timerqueue_add(ctmr->head, &ctmr->node);
-}
-
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 				     struct cpu_timer *ctmr)
 {
@@ -88,8 +83,10 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 
 static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
-	if (!RB_EMPTY_NODE(&ctmr->node.node))
+	if (ctmr->head) {
 		timerqueue_del(ctmr->head, &ctmr->node);
+		ctmr->head = NULL;
+	}
 }
 
 static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
