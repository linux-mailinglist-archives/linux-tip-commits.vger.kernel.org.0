Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E628829B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgJIGiX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbgJIGf0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA256C0613DA;
        Thu,  8 Oct 2020 23:35:24 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rMSyzAggB8PUPO28CH//vdzdNPZkhD2V+MV/eR4j05c=;
        b=x5lq5ze8D6IppSKJz0BXOljcUDJ2TnVqTsuRch3a9P+cvVCUjHvJSalXCrb6IrHiRsx2GQ
        SQa8kbHKJXi/4+1JcpLKqU+K+01rvh+h456WuZkqsSHbCkMXX83D7b65uMj5sL4/xyMLG7
        k6VG6e1/sSwdtC+eSO3xxIDYBrsyjQmLZNdu8oPlYT67itz/P+s95U0LU5VugfbecpbdLK
        GUFsxt2XOnQpgtPruIHw7yga1I6OPA6Vxu/h0LaTdagxSbkV/JbXIY+VMGIbbVdE8DGMrb
        Tf40JWmS2hdCmlzF6FyAD3aNo9ZX1eYmRtRhjb8e34fuyhn+XvBiIy1XYM39Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rMSyzAggB8PUPO28CH//vdzdNPZkhD2V+MV/eR4j05c=;
        b=r+uoN7cxaWAJBQOLq9iuKFvXBZPKScAtcK9v/FG2SDrVAhvfG5tFgVTkRAIBNzSruLw4Sr
        jIVRbwNcrIofohBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Restrict default jiffies_till_first_fqs for
 strict RCU GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532275.7002.17536598861342010090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     aecd34b9765de3b58c98a1d75b982fc64becd1e9
Gitweb:        https://git.kernel.org/tip/aecd34b9765de3b58c98a1d75b982fc64becd1e9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Aug 2020 17:25:23 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:24 -07:00

rcu: Restrict default jiffies_till_first_fqs for strict RCU GPs

If there are idle CPUs, RCU's grace-period kthread will wait several
jiffies before even thinking about polling them.  This promotes
efficiency, which is normally a good thing, but when the kernel
has been built with CONFIG_RCU_STRICT_GRACE_PERIOD=y, we care more
about short grace periods.  This commit therefore restricts the
default jiffies_till_first_fqs value to zero in kernels built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, which causes RCU's grace-period kthread
to poll for idle CPUs immediately after starting a grace period.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..8551159 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -485,7 +485,7 @@ module_param(qhimark, long, 0444);
 module_param(qlowmark, long, 0444);
 module_param(qovld, long, 0444);
 
-static ulong jiffies_till_first_fqs = ULONG_MAX;
+static ulong jiffies_till_first_fqs = IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 0 : ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
 static int rcu_divisor = 7;
