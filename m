Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58A81F5264
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jun 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgFJKeZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Jun 2020 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgFJKeY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Jun 2020 06:34:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408BC03E96F;
        Wed, 10 Jun 2020 03:34:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jiy3l-0001gw-HJ; Wed, 10 Jun 2020 12:34:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14FFA1C0105;
        Wed, 10 Jun 2020 12:34:17 +0200 (CEST)
Date:   Wed, 10 Jun 2020 10:34:16 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
Gitweb:        https://git.kernel.org/tip/bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Jun 2020 12:14:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Jun 2020 12:30:19 +02:00

sched: Fix RANDSTRUCT build fail

As a temporary build fix, the proper cleanup needs more work.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Eric Biggers <ebiggers@kernel.org>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Suggested-by: Kees Cook <keescook@chromium.org>
Fixes: a148866489fb ("sched: Replace rq::wake_list")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 57a5ce9..59caeb9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -653,8 +653,10 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
+	struct {
+		struct llist_node		wake_entry;
+		unsigned int			wake_entry_type;
+	};
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
