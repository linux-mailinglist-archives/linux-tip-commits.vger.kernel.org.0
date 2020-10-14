Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9F28E5CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgJNR7L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR7K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 13:59:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80C5C061755;
        Wed, 14 Oct 2020 10:59:10 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602698348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDtGP9VrBmXRHMeKz6o0yz6e2kELpK/M4NSGV5ySA8w=;
        b=sGG1RQFF2QRxknjZ0FUkU2Q2Aw5Io5cs+gxnFO4cdiVFLUvXQY8B551KCW16wvchPVsPbt
        2yxTMA5g7nJR2WdeLYHULfnA+REbYdFf0CEAqQgezaB0Tjw1DovQiLnjUdhAQswzWDu0HA
        tjaFBqWWBgaLGgORw1XQpBb9qMnrtja3SCe1JyTCo5bWPC3Oerhq6p2eqptDz9AtpahIdr
        YVOSMBG/E12DcraQ4L9/eH45JW53Be5ilFP0rU9YAcVrzMJGJExZbnrgTaR6m8AKYz4TP5
        U4aU7btr4/j0MiBLc3h3krvk6aywPlDOe/75aBZxCVv2K38Io6EcRZ/te4nOlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602698348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDtGP9VrBmXRHMeKz6o0yz6e2kELpK/M4NSGV5ySA8w=;
        b=ZHV1U2h3fePQjn26uQiex+YyVcvKmJtvzv+EGdltbOrRjvpPmF/y6taBZQiOs7YcBQ4Gut
        6A+0PBqhmNFyDsAg==
From:   "tip-bot2 for zhuguangqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Replace zero-length array with flexible-array
Cc:     zhuguangqing <zhuguangqing@xiaomi.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014140220.11384-1-zhuguangqing83@gmail.com>
References: <20201014140220.11384-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Message-ID: <160269833193.7002.1527298287571208111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     eba9f08293d76370049ec85581ab3d7f6d069e3e
Gitweb:        https://git.kernel.org/tip/eba9f08293d76370049ec85581ab3d7f6d069e3e
Author:        zhuguangqing <zhuguangqing@xiaomi.com>
AuthorDate:    Wed, 14 Oct 2020 22:02:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 19:55:19 +02:00

sched: Replace zero-length array with flexible-array

In the following commit:

  04f5c362ec6d: ("sched/fair: Replace zero-length array with flexible-array")

a zero-length array cpumask[0] has been replaced with cpumask[].
But there is still a cpumask[0] in 'struct sched_group_capacity'
which was missed.

The point of using [] instead of [0] is that with [] the compiler will
generate a build warning if it isn't the last member of a struct.

[ mingo: Rewrote the changelog. ]

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20201014140220.11384-1-zhuguangqing83@gmail.com
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6..648f023 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1471,7 +1471,7 @@ struct sched_group_capacity {
 	int			id;
 #endif
 
-	unsigned long		cpumask[0];		/* Balance mask */
+	unsigned long		cpumask[];		/* Balance mask */
 };
 
 struct sched_group {
