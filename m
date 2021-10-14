Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB442D7F5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhJNLS0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhJNLSZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:25 -0400
Date:   Thu, 14 Oct 2021 11:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSfDRYjVAhYKBi2CxYttpEMHrSSVjZ08QilZrB6ZAs4=;
        b=ZxajTEY6bJTxFU7RZx/agj6AXQS90crKdolE6TYlPscQ6Z5AjR0NhpLnog70LlOOf9zS0z
        4piMncWn2tCj+09U/eia9thvPlyDesg7uJ+iCGvdTI2oWSlDkTeMAQdWt4ArwOR/qucemN
        f2BL/RWj/A1Fv3Kesyu3q9qcG7bWbZ/hvsmil+dAm7wf6oCCSUsoXkA0DEAJ6l28QiTYyz
        qw7gW2IGY0Aqgb6cXl3i/YsKdG4JQqOjopCUS/Hb8Hs/CX0EH7olN9XiBGZPMEAn+ylLmr
        UNCXOMBRrwnOCQLqhjuEwGfHS2Ut4W178ApCDQyvOqo4DbkbvVMOZ+RZaW+ubQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSfDRYjVAhYKBi2CxYttpEMHrSSVjZ08QilZrB6ZAs4=;
        b=e97ueWGi4TLOf3wzvKm8oyWhdlUkkQfyF5fBE9Arzhmz85UStr0EqcgrRb7rqH7G+0ztiH
        nKdiq5HcQrmoFMCw==
From:   "tip-bot2 for Yicong Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove unused numa_distance in
 cpu_attach_domain()
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Barry Song <baohua@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210915063158.80639-1-yangyicong@hisilicon.com>
References: <20210915063158.80639-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163421017898.25758.6737691887512703032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f9ec6fea201429b5a3f76319e943989f1a1e25ef
Gitweb:        https://git.kernel.org/tip/f9ec6fea201429b5a3f76319e943989f1a1e25ef
Author:        Yicong Yang <yangyicong@hisilicon.com>
AuthorDate:    Wed, 15 Sep 2021 14:31:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

sched/topology: Remove unused numa_distance in cpu_attach_domain()

numa_distance in cpu_attach_domain() is introduced in
commit b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")
to warn user when NUMA diameter > 2 as we'll misrepresent
the scheduler topology structures at that time. This is
fixed by Barry in commit 585b6d2723dc ("sched/topology: fix the issue
groups don't span domain->span for NUMA diameter > 2") and
numa_distance is unused now. So remove it.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20210915063158.80639-1-yangyicong@hisilicon.com
---
 kernel/sched/topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c56faae..5af3edd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
-	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -732,9 +731,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		}
 	}
 
-	for (tmp = sd; tmp; tmp = tmp->parent)
-		numa_distance += !!(tmp->flags & SD_NUMA);
-
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
