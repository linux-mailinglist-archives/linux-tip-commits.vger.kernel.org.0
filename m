Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8A42D7F7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhJNLS2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhJNLS0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9CC061570;
        Thu, 14 Oct 2021 04:16:22 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHkwUXE2BgMSejVifWgxMmIQj1wsrDnV15HFg6zFW80=;
        b=RNC688j8uTLDOE4GY9I+a9tkTzudP07d8Xxo1tkipkYUU6X91nR1IaNbzccRBOML5CccHL
        6HltOFhgyS5fW6u4rUAOt6U+jeHDjuf5yB4OJC9jomnttr3eJLN6iqpLdDygtHfXcQ7UPP
        7ow5l9x09dxtJhBZy63K7S197jgQTnOr+10UJSywML5pgnrLxvE/DKe/CUpkwqWWn4Thvw
        H7vyQZt2S7cjhCwtwr8cXf1swtBg0/b7FSs3+mEdDulcfOUcaxYNm9YR2b4sRgS0YXwOSv
        5q7/Q7U1O6sZaGQU5YXPyXzuNnLA0G6iLNp4aOwwx8KLeitDZx36kbTZHbV2oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHkwUXE2BgMSejVifWgxMmIQj1wsrDnV15HFg6zFW80=;
        b=wj5YfgMZ9eG74ipY/yxa40DzGnsoGWUvUz2+Y9EdccYB/QU+CXyeVzqIbjb8TEgw0pY3UA
        U4oTwPmwUXkpC2Dw==
From:   "tip-bot2 for Bharata B Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix a few comments
Cc:     Bharata B Rao <bharata@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211004105706.3669-4-bharata@amd.com>
References: <20211004105706.3669-4-bharata@amd.com>
MIME-Version: 1.0
Message-ID: <163421017992.25758.2626208384412078593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d380f24fe662033fd21a65f678057abd293f76e
Gitweb:        https://git.kernel.org/tip/7d380f24fe662033fd21a65f678057abd293f76e
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Mon, 04 Oct 2021 16:27:05 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

sched/numa: Fix a few comments

Fix a few comments to help understand them better.

Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20211004105706.3669-4-bharata@amd.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfbd5ef..87db481 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2074,7 +2074,7 @@ static void numa_migrate_preferred(struct task_struct *p)
 }
 
 /*
- * Find out how many nodes on the workload is actively running on. Do this by
+ * Find out how many nodes the workload is actively running on. Do this by
  * tracking the nodes from which NUMA hinting faults are triggered. This can
  * be different from the set of nodes where the workload's memory is currently
  * located.
@@ -2128,7 +2128,7 @@ static void update_task_scan_period(struct task_struct *p,
 
 	/*
 	 * If there were no record hinting faults then either the task is
-	 * completely idle or all activity is areas that are not of interest
+	 * completely idle or all activity is in areas that are not of interest
 	 * to automatic numa balancing. Related to that, if there were failed
 	 * migration then it implies we are migrating too quickly or the local
 	 * node is overloaded. In either case, scan slower
