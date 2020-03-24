Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFA190932
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCXJQz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:16:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCXJQz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg4-00086X-5m; Tue, 24 Mar 2020 10:16:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 78EA61C04D6;
        Tue, 24 Mar 2020 10:16:43 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:43 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Forgive apparent unfairness if CPU hotplug
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140312.28353.101971154365863922.tip-bot2@tip-bot2>
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

Commit-ID:     28e09a2e48486ce8ff0a72e21570d59b1243b308
Gitweb:        https://git.kernel.org/tip/28e09a2e48486ce8ff0a72e21570d59b1243b308
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 30 Jan 2020 20:37:04 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:59:59 -08:00

locktorture: Forgive apparent unfairness if CPU hotplug

If CPU hotplug testing is enabled, a lock might appear to be maximally
unfair just because one of the CPUs was offline almost all the time.
This commit therefore forgives unfairness if CPU hotplug testing was
enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5baf904..5efbfc6 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -704,7 +704,8 @@ static void __torture_print_stats(char *page,
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",
 			write ? "Writes" : "Reads ",
-			sum, max, min, max / 2 > min ? "???" : "",
+			sum, max, min,
+			!onoff_interval && max / 2 > min ? "???" : "",
 			fail, fail ? "!!!" : "");
 	if (fail)
 		atomic_inc(&cxt.n_lock_torture_errors);
