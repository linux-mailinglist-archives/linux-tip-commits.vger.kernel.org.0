Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8639BA1F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFDNqj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFDNqi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 09:46:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626BC061766;
        Fri,  4 Jun 2021 06:44:52 -0700 (PDT)
Date:   Fri, 04 Jun 2021 13:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622814291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rknRye6Pj01X8lmCtsBcQxZ/N02a5RRN31jvg68Mp0w=;
        b=uS64hex4senYlnVHBMK44BnawputKuEiFRSSmeeqPaFE/M+BjhR+5HDlSuTL8RIVwSMwZC
        nK/gG063vriQb2Xd2Nq9C5HwwhaBoyrrs6STNGf6aSIQMjOIwzD4ZlhDq7onyvRW/r9Ria
        MMK/fiF8i59+xDiT+O82uvvsT2qc5jkIlZfudlfuBHiyuXi5ODilgMW+HLo6iRz0B4kHRU
        Au6DU66DxOwSIvJkrOFKWLFifB0HQEiHub2C7AFztV+IXnZL2Pz8kEQKAT+wZ2dOyShODW
        bfHTrE0PSmFpJTScjhjmPVGCraQHO7xh2DsvhYw1aohNzCTtuTzAMtOqjCLbMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622814291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rknRye6Pj01X8lmCtsBcQxZ/N02a5RRN31jvg68Mp0w=;
        b=463xohIMbAWLyOvXUruHZtc8UvsVVolMfbdBLeG6Cp48wmAG5xFI4+b4ZGrfi5IaLCB6Vn
        09iGEpBEbWsBD0AA==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Remove obsolete init_schedstats()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210602112108.1709635-1-eric.dumazet@gmail.com>
References: <20210602112108.1709635-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <162281429016.29796.14526882751261492265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1faa491a49d53f5d1c8c23bdf01763cfc00a2b19
Gitweb:        https://git.kernel.org/tip/1faa491a49d53f5d1c8c23bdf01763cfc00a2b19
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Wed, 02 Jun 2021 04:21:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 04 Jun 2021 15:38:42 +02:00

sched/debug: Remove obsolete init_schedstats()

Revert commit 4698f88c06b8 ("sched/debug: Fix 'schedstats=enable'
cmdline option").

After commit 6041186a3258 ("init: initialize jump labels before
command line option parsing") we can rely on jump label infra being
ready for use when setup_schedstats() is called.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20210602112108.1709635-1-eric.dumazet@gmail.com
---
 kernel/sched/core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e59466..9e9a5be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4009,7 +4009,6 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 #ifdef CONFIG_SCHEDSTATS
 
 DEFINE_STATIC_KEY_FALSE(sched_schedstats);
-static bool __initdata __sched_schedstats = false;
 
 static void set_schedstats(bool enabled)
 {
@@ -4033,16 +4032,11 @@ static int __init setup_schedstats(char *str)
 	if (!str)
 		goto out;
 
-	/*
-	 * This code is called before jump labels have been set up, so we can't
-	 * change the static branch directly just yet.  Instead set a temporary
-	 * variable so init_schedstats() can do it later.
-	 */
 	if (!strcmp(str, "enable")) {
-		__sched_schedstats = true;
+		set_schedstats(true);
 		ret = 1;
 	} else if (!strcmp(str, "disable")) {
-		__sched_schedstats = false;
+		set_schedstats(false);
 		ret = 1;
 	}
 out:
@@ -4053,11 +4047,6 @@ out:
 }
 __setup("schedstats=", setup_schedstats);
 
-static void __init init_schedstats(void)
-{
-	set_schedstats(__sched_schedstats);
-}
-
 #ifdef CONFIG_PROC_SYSCTL
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
@@ -4079,8 +4068,6 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 	return err;
 }
 #endif /* CONFIG_PROC_SYSCTL */
-#else  /* !CONFIG_SCHEDSTATS */
-static inline void init_schedstats(void) {}
 #endif /* CONFIG_SCHEDSTATS */
 
 /*
@@ -9089,8 +9076,6 @@ void __init sched_init(void)
 #endif
 	init_sched_fair_class();
 
-	init_schedstats();
-
 	psi_init();
 
 	init_uclamp();
