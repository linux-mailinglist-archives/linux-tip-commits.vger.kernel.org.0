Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4683829E994
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgJ2KwH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgJ2Kvz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F4C0613CF;
        Thu, 29 Oct 2020 03:51:55 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1h3/ossinN4rTail/ONAYutor/02AhD9mk6zMnBAxTE=;
        b=MT0vftZMIM5b0TK2nMWLRZARLcsxOLnfNEA+TEEfu723N1eA0dpxQMzoBH7bQ3MdVu9n2+
        MPqMzWRVl4JYJnTDEZG7k/wttbn1huYJxN4n8IpGB01HPsFyGS6VGj4Gskb1TiS8C/1Ej8
        Wt67saNMXxtC++3Ss/RMMCWe+37s2oI9CdS5GMWEeg2Iyzo89056j1jtdh2Exbe5t5jYsT
        pYYLPPyYIbjUVP5bSnicoQUvAZDaPNqv2K2gqBXt5IbrFCOzItB8lXKGps8piIgKJNM7AW
        EUl9go1GYhEigmqMPiIMNtNei3l608kkUNoKWUKJ2EpfF89QWI84OPzbRQpepw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1h3/ossinN4rTail/ONAYutor/02AhD9mk6zMnBAxTE=;
        b=MJ8f+y/qK2y+bfb1kmkI00r1f06ookae1KSO4WUPmzYLfoyIpXRdQZIoiWPdsTVMuypXYQ
        WpDzVAWMdHVKclCg==
From:   "tip-bot2 for jun qian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Improve the accuracy of sched_stat_wait
 statistics
Cc:     jun qian <qianjun.kernel@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yafang Shao <laoar.shao@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201015064846.19809-1-qianjun.kernel@gmail.com>
References: <20201015064846.19809-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Message-ID: <160396871261.397.9603442969201125395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b9c88f752268383beff0d56e50d52b8ae62a02f8
Gitweb:        https://git.kernel.org/tip/b9c88f752268383beff0d56e50d52b8ae62a02f8
Author:        jun qian <qianjun.kernel@gmail.com>
AuthorDate:    Thu, 15 Oct 2020 14:48:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:28 +01:00

sched/fair: Improve the accuracy of sched_stat_wait statistics

When the sched_schedstat changes from 0 to 1, some sched se maybe
already in the runqueue, the se->statistics.wait_start will be 0.
So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
wrong. We need to avoid this scenario.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lkml.kernel.org/r/20201015064846.19809-1-qianjun.kernel@gmail.com
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e3..b9368d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -906,6 +906,15 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (!schedstat_enabled())
 		return;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se
+	 * maybe already in the runqueue, the se->statistics.wait_start
+	 * will be 0.So it will let the delta wrong. We need to avoid this
+	 * scenario.
+	 */
+	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+		return;
+
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
