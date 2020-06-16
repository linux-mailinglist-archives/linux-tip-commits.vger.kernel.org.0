Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76B1FB067
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgFPMWG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 08:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgFPMWF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB6C08C5C6;
        Tue, 16 Jun 2020 05:22:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbI-0004gu-OD; Tue, 16 Jun 2020 14:22:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC80B1C0837;
        Tue, 16 Jun 2020 14:21:52 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:52 -0000
From:   "tip-bot2 for Peng Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: correct SD_flags returned by tl->sd_flags()
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
References: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Message-ID: <159231011270.16989.15647375607443324340.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9b1b234bb86bcdcdb142e900d39b599185465dbb
Gitweb:        https://git.kernel.org/tip/9b1b234bb86bcdcdb142e900d39b599185465dbb
Author:        Peng Liu <iwtbavbm@gmail.com>
AuthorDate:    Tue, 09 Jun 2020 23:09:36 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:04 +02:00

sched: correct SD_flags returned by tl->sd_flags()

During sched domain init, we check whether non-topological SD_flags are
returned by tl->sd_flags(), if found, fire a waning and correct the
violation, but the code failed to correct the violation. Correct this.

Fixes: 143e1e28cb40 ("sched: Rework sched_domain topology definition")
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba81187..9079d86 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1328,7 +1328,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd_flags = (*tl->sd_flags)();
 	if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
 			"wrong sd_flags in topology description\n"))
-		sd_flags &= ~TOPOLOGY_SD_FLAGS;
+		sd_flags &= TOPOLOGY_SD_FLAGS;
 
 	/* Apply detected topology flags */
 	sd_flags |= dflags;
