Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5025D8BC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Sep 2020 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIDMjB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Sep 2020 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgIDMi5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Sep 2020 08:38:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28374C061244;
        Fri,  4 Sep 2020 05:38:57 -0700 (PDT)
Date:   Fri, 04 Sep 2020 12:38:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599223134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BtwCFAPeIXzjXcS32i88wEyUjEx2NjSefEqQEE7hVQ=;
        b=B6NcvCBR/B0Harbi8qrbNhSbAa5U6ajDgeLVBhqaxY+83QDXsWX+3qK5MTJNqd9wRrBEwu
        Uqev3FDBAj+TBmW+L4N8oVXhWUambGbDJJ1WtsQ2MYCDa9cGhHQSU3EMGUBIwcxQneYpHG
        s4vZRj3hUjCv/QxVhuNGGTdemEpwEAH0A5hGjRa/Klyqwim3MIN84bk04UgpT+dW+qXR6l
        dpxV+LMi9VdB6izpE/Oqd6S84Ba6E6vfyDGZHwxwwl6akEXmniWrgHkb9+ayesleIQcvGd
        fhR1VYID2fMwFjfmb7CgxRhpe53C5DLM4JOd0jB/jQCBiucal6PrsU6sOyliLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599223134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BtwCFAPeIXzjXcS32i88wEyUjEx2NjSefEqQEE7hVQ=;
        b=fweQi5FWg3TQrkSMAwm8PBYdB/YUfjtBNRoLNOcG31wyuad/soV7sHgyQDIrSSq2xI/gDR
        ljnIa8UmmD/nlsCg==
From:   "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
MIME-Version: 1.0
Message-ID: <159922313318.20229.15806981631955100999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     153908ebc8b5721658c4aba92779fc6e3e2d5a61
Gitweb:        https://git.kernel.org/tip/153908ebc8b5721658c4aba92779fc6e3e2d5a61
Author:        Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 11:26:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 04 Sep 2020 14:35:40 +02:00

MAINTAINERS: Add myself as SCHED_DEADLINE reviewer

As discussed with Juri and Peter.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb6..713f82b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15355,6 +15355,7 @@ R:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
 R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
 R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
+R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
