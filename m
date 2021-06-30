Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC403B841C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhF3NwU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhF3NvI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:08 -0400
Date:   Wed, 30 Jun 2021 13:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nTkAi4ajgO+sDtCwRZEbZHlDmkQP6dcU5cxJvu3E+U4=;
        b=UJ+jlX1ka9lEDBXF6iwR/Ua6+2klt+X3gpvEiGqDQqQJs8+iNg+p0cXGZQUAu5ruBDj6Sc
        hcSKGiG0syB2nVokQJs1sRaox5tdvyUJ8EZSwZucBsuWMCE7D3zTFVUWQTbyA/FnkANpuE
        FwOL9bDHcoIF2yp2oHdM8Oa9kqrf6158hwCee3CgOAzfhNP6h63vTzdIOjcJY2j1TafLDI
        3sAO2SZopQ89Ge83dGYITJDplN2WKLImSACIidByghDtc+C9qF7qy7vd10dFTDZSRXeheI
        SXZJG5STL2FYq09puw/Q0zHZgK4i95SHwTLbd59FF7irhhM63k8NIyTTEqAWyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nTkAi4ajgO+sDtCwRZEbZHlDmkQP6dcU5cxJvu3E+U4=;
        b=9Ce95So0jiez9r/2hxrgPq4/0ByxiHQyp4egB4u70YJKKPeeCaM2VBkFLU4yedNl5UPmHz
        J2h8I412D4UCzPDA==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree_plugin: Don't handle the case of 'all' CPU range
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088267.395.9014503789298882918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a6814a79f2ca09a5e15e69324213dad29a5844ad
Gitweb:        https://git.kernel.org/tip/a6814a79f2ca09a5e15e69324213dad29a5844ad
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:13:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:38:20 -07:00

rcu/tree_plugin: Don't handle the case of 'all' CPU range

The 'all' semantics is now supported by the bitmap_parselist() so we can
drop supporting it as a special case in RCU code.  Since 'all' is properly
supported in core bitmap code, also drop legacy comment in RCU for it.

This patch does not make any functional changes for existing users.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b..3f7a345 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1535,13 +1535,10 @@ static void rcu_cleanup_after_idle(void)
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
