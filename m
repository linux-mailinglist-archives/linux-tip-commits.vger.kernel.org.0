Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390A1CE618
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbgEKU71 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731832AbgEKU7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 16:59:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064CC05BD09;
        Mon, 11 May 2020 13:59:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWF-0005iN-Jo; Mon, 11 May 2020 22:59:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 923581C06E5;
        Mon, 11 May 2020 22:59:20 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:20 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove self-stack-trace when all quiescent states seen
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076050.390.11074838018481966087.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     33b2b93bd831fc0e994654cef3d046c713e3b55e
Gitweb:        https://git.kernel.org/tip/33b2b93bd831fc0e994654cef3d046c713e3b55e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Apr 2020 14:12:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:04:37 -07:00

rcu: Remove self-stack-trace when all quiescent states seen

When all quiescent states have been seen, it is normally the grace-period
kthread that is in trouble.  Although the existing stack trace from
the current CPU might possibly provide useful information, experience
indicates that there is too much noise for this to be worthwhile.

This commit therefore removes this stack trace from the output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4da41a6..535762b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -440,8 +440,6 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 			       rcu_state.name, j - gpa, j, gpa,
 			       READ_ONCE(jiffies_till_next_fqs),
 			       rcu_get_root()->qsmask);
-			/* In this case, the current CPU might be at fault. */
-			sched_show_task(current);
 		}
 	}
 	/* Rewrite if needed in case of slow consoles. */
