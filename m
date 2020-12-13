Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5AA2D9025
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgLMTCE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgLMTBo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:44 -0500
Date:   Sun, 13 Dec 2020 19:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dIduRtDOCRucv9p/42YOvlyZDfetc6Stmqlh16TUkBg=;
        b=oOKApflVLEs3IviC37ClnUJ6R2VAZMhTXj7rEdDfrOwOU99s2tESE/Lrxfr0C8C65hcb2A
        JI6SKamWuA5MZxeVsE12bEs5qqDFG1eob8w9uHN6Hl3IVmsx+ju5UKmy9tLxPwj3GiQFRz
        OdsjvleFgHTugPmqzPaP2kjX2vu5/z1dy3XPpGYiGcmXapLCmO2iZjK7Gs/21VlsVuU1iu
        51xP3BMf/AI0sXdJOo3Icpp5s6GJOFUBWtMBUBbkqrGG3gnWUG4xyeOKVbmXqHWdiwaIao
        E1wQWUjm+Ag6pZiIuMRcM85TyaBpdDFgQip8/kyO+dQLmfpWY5gMG7amHmQ8Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dIduRtDOCRucv9p/42YOvlyZDfetc6Stmqlh16TUkBg=;
        b=TdAKrjHDLvHyR45aC3XJtR5DKyx9wdRfmNDNO2k2Is4QEqCjAFJMTOkX9nUSCrPjrGY3Bg
        AsYh1CC8Z8B4S0Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu,ftrace: Fix ftrace recursion
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606092.3364.8546598097323675015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d2098b4440981705e844c50254540ba7b5f82795
Gitweb:        https://git.kernel.org/tip/d2098b4440981705e844c50254540ba7b5f82795
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 29 Sep 2020 13:33:40 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu,ftrace: Fix ftrace recursion

Kim reported that perf-ftrace made his box unhappy. It turns out that
commit:

  ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")

removed one too many notrace qualifiers, probably due to there not being
a helpful comment.

This commit therefore reinstates the notrace and adds a comment to avoid
losing it again.

[ paulmck: Apply Steven Rostedt's feedback on the comment. ]
Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
Reported-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5f458e4..d6a015e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1093,8 +1093,11 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * CPU can safely enter RCU read-side critical sections.  In other words,
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
+ *
+ * Make notrace because it can be called by the internal functions of
+ * ftrace, and making this notrace removes unnecessary recursion calls.
  */
-bool rcu_is_watching(void)
+notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
