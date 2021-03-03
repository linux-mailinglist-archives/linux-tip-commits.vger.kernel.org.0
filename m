Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A132C79B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355658AbhCDAcV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842969AbhCCKXL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB8C08EC2C;
        Wed,  3 Mar 2021 01:49:38 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/A0o3BrWwxHFCgmVIMQGpakIiLM/ChkfyWO3Ef/TA8=;
        b=nqz3m0130PIKihgFX/e4X9Nvj1Aba2heHbnz6Yj4tyvHa1FAj7Ij+8e5jeV0j4qx4M3Dci
        eoIFu+KFR5lUFpFwj/bAzK5yOOdnEZecryXJR/jDpTUACrKf/MhlZLxSu/u6IB+yzpzJVS
        fqWIjp5YKmze7Sq/P61LHc0r7j7JaSQexc01Rh9vsOAjDi/mOf1rF02GFuU48GIMhjtYtf
        zFyuW64h1TQcEG+qeCOkpwGV7qUbZGuxcA9+dPlode15eWZ/NYHHJF/bDq10Dwc8B0vlvh
        Q99XSvthFju8vHLFVPQlELPVt37edlSrF4JKbCKd7r34qxBZe7M/Oh7qcrPUfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/A0o3BrWwxHFCgmVIMQGpakIiLM/ChkfyWO3Ef/TA8=;
        b=WBVmzePQukWpTUtnQEEaCdDS0170LYm1KXO2797vii1XRk0JVTbUhegabK2WtHNu4PbWA6
        9XIN17AR1j98RjBg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: use lsub_positive in cpu_util_next()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225083612.1113823-3-vincent.donnefort@arm.com>
References: <20210225083612.1113823-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497604.20312.18168364785560763796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b641a8b52c6162172ca31590510569eaadcd5e49
Gitweb:        https://git.kernel.org/tip/b641a8b52c6162172ca31590510569eaadcd5e49
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 08:36:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

sched/fair: use lsub_positive in cpu_util_next()

The sub_positive local version is saving an explicit load-store and is
enough for the cpu_util_next() usage.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20210225083612.1113823-3-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b994db9..7b2fac0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6471,7 +6471,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	 * util_avg should already be correct.
 	 */
 	if (task_cpu(p) == cpu && dst_cpu != cpu)
-		sub_positive(&util, task_util(p));
+		lsub_positive(&util, task_util(p));
 	else if (task_cpu(p) != cpu && dst_cpu == cpu)
 		util += task_util(p);
 
