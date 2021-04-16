Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93536284B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDPTI0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbhDPTIZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 15:08:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFEC061574;
        Fri, 16 Apr 2021 12:08:00 -0700 (PDT)
Date:   Fri, 16 Apr 2021 19:07:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618600078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rs7H9++iukDUMdDgPrGBCMc4aazWQuUJdeFDnMN55Fw=;
        b=SoAxEH1tYb/dmHBoopiTFS8NKUG2P1PNkuIalYBAWeSO4eqfgOclwDOwKzQ2UWvjLiDls9
        2VjHd7XSSo1oLLk9Sjs3ZR8Lv0+j+RTsIf9T/7GuFEfQKO6bOGqTqblj+OrPL4JdD0h8uy
        kEHKim8+wVkkbYejurZGeG/UfRIq+N9EDhwAnb14+38rgOMnsBON4ZV3c7HodlJ1SgJe0C
        GpXE1UN2Ml1d3a5SFBgS9Es9R+Rx4t1LhZWkyRKXHf4eQ0k5tqWYov0cqEvltimFoK/xXk
        BMYvpI59MuEaUWlT6NB828mo50uz1Yp/LrGPkctVvVopwMYFFjuKLyVuA980HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618600078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rs7H9++iukDUMdDgPrGBCMc4aazWQuUJdeFDnMN55Fw=;
        b=kPyR+mfIuCSqxYMuxzQKSi9cM1nHCw7x1ELZiA0hBG/sfoywgjfagAfoglHcJ/QIjsjbcU
        MSCuSGbpSEoHc+DQ==
From:   "tip-bot2 for Wang Wensheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Use tick_check_replacement() instead of open
 coding it
Cc:     Wang Wensheng <wangwensheng4@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326022328.3266-1-wangwensheng4@huawei.com>
References: <20210326022328.3266-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Message-ID: <161860007631.29796.743363594563784489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d7840aaadd6e84915866a8f0dab586f6107dadf1
Gitweb:        https://git.kernel.org/tip/d7840aaadd6e84915866a8f0dab586f6107dadf1
Author:        Wang Wensheng <wangwensheng4@huawei.com>
AuthorDate:    Fri, 26 Mar 2021 02:23:28 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Apr 2021 21:03:50 +02:00

tick: Use tick_check_replacement() instead of open coding it

The function tick_check_replacement() is the combination of
tick_check_percpu() and tick_check_preferred(), but tick_check_new_device()
has the same logic open coded.

Use the helper to simplify the code.

[ tglx: Massage changelog ]

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210326022328.3266-1-wangwensheng4@huawei.com

---
 kernel/time/tick-common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9d3a225..e15bc0e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -348,12 +348,7 @@ void tick_check_new_device(struct clock_event_device *newdev)
 	td = &per_cpu(tick_cpu_device, cpu);
 	curdev = td->evtdev;
 
-	/* cpu local device ? */
-	if (!tick_check_percpu(curdev, newdev, cpu))
-		goto out_bc;
-
-	/* Preference decision */
-	if (!tick_check_preferred(curdev, newdev))
+	if (!tick_check_replacement(curdev, newdev))
 		goto out_bc;
 
 	if (!try_module_get(newdev->owner))
