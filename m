Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6252D8FEA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgLMTS5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390899AbgLMTCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6BC0619D7;
        Sun, 13 Dec 2020 11:01:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bMGiSKYV+6e3N2o4vbsZYfzOtkbUx6tCOEltPbA/NxY=;
        b=Yr6W8k/VrWhu/nsULVQj8xW1BLY7g2wEURr52tmaSBbDtkJzgHBBv/sU4xCohtzasBNSTC
        goW5OdKOhOkfXtNnbXhEIrSOrW6ryoPyJhlmLiwzS8RtvSM2vCcF8F57lkmwG5/m+Fe/1v
        lZrlmXNdOkILbNN8DuaFTam3F4LjX96yZfei9XRYGynRoryvR4HjPJv5sDENKoP1Iv9+AA
        w/QSHL41+/lzaxirDOsGdGgKKAbNk69r3i+veQUQqM8FH3ZDyFnhErFK9zQ8c+dmBdN5R7
        iDepoLDvKDeimM6HnIbVwC1KgxM0BGqlgayIFF4o7BpcFSxiua18dMT/wcV8Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bMGiSKYV+6e3N2o4vbsZYfzOtkbUx6tCOEltPbA/NxY=;
        b=rzlrxm1LCiU23JIuiztQCUljWXkFQ6RtBPR5lXEj0TXVo7cfjnjQPJXw9i3vHSfqn0QDgT
        K3DoVmYt+YUp35CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Prevent hangs for invalid arguments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606971.3364.8908973636375392973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bc80d353b3f565138cda7e95ed4020e6e69360b2
Gitweb:        https://git.kernel.org/tip/bc80d353b3f565138cda7e95ed4020e6e69360b2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 17 Sep 2020 10:37:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:51 -08:00

refscale: Prevent hangs for invalid arguments

If an refscale torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a ref_scale_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index fb5f20d..23ff36a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -658,7 +658,6 @@ ref_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -718,6 +717,10 @@ ref_scale_init(void)
 unwind:
 	torture_init_end();
 	ref_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
