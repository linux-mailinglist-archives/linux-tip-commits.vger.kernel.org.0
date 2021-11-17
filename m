Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252B0454AD6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhKQQYA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 11:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhKQQX6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 11:23:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09539C061570;
        Wed, 17 Nov 2021 08:20:59 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637166057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNi2yELSNcNJEROgf4kONbWUVibndhRvKFguMLCZEE4=;
        b=RQ+ZBfaXD3w03lxQ4UoExO5Dwh6jRXmfjmnCt6SSxMcgdR+dJP8actu7r1Xi8oDiMgfb9W
        bdbZt7l/Dd1bgPLXGhc84iME2NH4bVw23UIc+aZeulNG+COXsF+ZIIuGtruB3kIcFgr+ee
        2KmbZ0EKPKpmVpi4j1wiw3nyDasnCOAmbCs2Q1ugU8uzi9ZMtUmY906+TKvmVFBtO6sYu0
        1iHLbFiem2N21Iz/z/pJENu9t9taVZJN7VBXqbUoVYqT0nBFJ6LIvU9//wo6wcKggI/cWJ
        PpfRuX8OqVTfu9Tn029+6W9StQh63oJsk13KShAt8ENKgi2rJ5HeVpMUJ5oUAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637166057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNi2yELSNcNJEROgf4kONbWUVibndhRvKFguMLCZEE4=;
        b=wvatB4nQzrFugWPIG0b3GnIJAR/rceHyJV2PQid38LdvBeIP6xBocNSubhcbLGZSPjVEpH
        a28mAQHy72lHUZCA==
From:   "tip-bot2 for Zhaolong Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of cpu_missing
Cc:     Borislav Petkov <bp@suse.de>, Zhaolong Zhang <zhangzl2013@126.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211109112345.2673403-1-zhangzl2013@126.com>
References: <20211109112345.2673403-1-zhangzl2013@126.com>
MIME-Version: 1.0
Message-ID: <163716605578.11128.8813948261185645198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     2322b532ad9043336f36ba2634ab3620d5d5b4f5
Gitweb:        https://git.kernel.org/tip/2322b532ad9043336f36ba2634ab3620d5d5b4f5
Author:        Zhaolong Zhang <zhangzl2013@126.com>
AuthorDate:    Tue, 09 Nov 2021 19:23:45 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Nov 2021 15:32:31 +01:00

x86/mce: Get rid of cpu_missing

Get rid of cpu_missing because

  7bb39313cd62 ("x86/mce: Make mce_timed_out() identify holdout CPUs")

provides a more detailed message about which CPUs are missing.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211109112345.2673403-1-zhangzl2013@126.com
---
 arch/x86/kernel/cpu/mce/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed3653..30de00f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -99,7 +99,6 @@ struct mca_config mca_cfg __read_mostly = {
 
 static DEFINE_PER_CPU(struct mce, mces_seen);
 static unsigned long mce_need_notify;
-static int cpu_missing;
 
 /*
  * MCA banks polled by the period polling timer for corrected events.
@@ -314,8 +313,6 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
-	if (cpu_missing)
-		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 	if (!fake_panic) {
@@ -891,7 +888,6 @@ static int mce_timed_out(u64 *t, const char *msg)
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		cpu_missing = 1;
 		return 1;
 	}
 	*t -= SPINUNIT;
@@ -2702,7 +2698,6 @@ struct dentry *mce_get_debugfs_dir(void)
 
 static void mce_reset(void)
 {
-	cpu_missing = 0;
 	atomic_set(&mce_fake_panicked, 0);
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
