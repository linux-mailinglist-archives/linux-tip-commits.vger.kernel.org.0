Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC34E105771
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Nov 2019 17:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKUQsf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Nov 2019 11:48:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKUQsf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcl-0000Ys-N9; Thu, 21 Nov 2019 17:48:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 474531C1A3B;
        Thu, 21 Nov 2019 17:48:07 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:07 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Make the mlock accounting simple again
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191120170640.54123-1-alexander.shishkin@linux.intel.com>
References: <20191120170640.54123-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157435488706.21853.9491431504510528730.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c4b75479741c9c3a4f0abff5baa5013d27640ac1
Gitweb:        https://git.kernel.org/tip/c4b75479741c9c3a4f0abff5baa5013d27640ac1
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 19:06:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:37:50 +01:00

perf/core: Make the mlock accounting simple again

Commit:

  d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

does a lot of things to the mlock accounting arithmetics, while the only
thing that actually needed to happen is subtracting the part that is
charged to the mm from the part that is charged to the user, so that the
former isn't charged twice.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: songliubraving@fb.com
Link: https://lkml.kernel.org/r/20191120170640.54123-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f66a48..7e8980d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5825,13 +5825,7 @@ accounting:
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked <= user_lock_limit) {
-		/* charge all to locked_vm */
-	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
-		/* charge all to pinned_vm */
-		extra = user_extra;
-		user_extra = 0;
-	} else {
+	if (user_locked > user_lock_limit) {
 		/*
 		 * charge locked_vm until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
