Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A42BAA40
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgKTMeS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgKTMeL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:11 -0500
Date:   Fri, 20 Nov 2020 12:34:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/R3Nv8geTEWe7XJre62KWCxkOkvWaUKucxnms62BpTg=;
        b=AOfdJV4Szz0UyZvg7fpIkFAUkO9eF1Aa11QWfsJtqQ4AoOIZI9ZfZ3v8rBWLa8r7DUBD4M
        FCwXknNN9wFtQSjumMsWNyBccT8jKCqYJC4c6dG40PwyMQU24pJODlxLvV/LY4cDZ5IZQX
        Yblt1p810j4m821FLlU1Pxrjo6y5YTPIvb8X45MHuY33gzpwuqQeqieJfhV0doil2M6ifb
        1955v+JT1yZg73uYudzwe5g/cKspXvpFeeAzvrOen7W5bWK0iLpvk9Ti+irQeWiLuQwHT5
        ldZshwXpxlujrlLub32MY9frkVU5Y7Z0m4fR2UqIrhtl0cTj8atC9oaxxHhnkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/R3Nv8geTEWe7XJre62KWCxkOkvWaUKucxnms62BpTg=;
        b=lzIv/I7E5IJQJ/7JiQBqJbWEK3WDmA1OllJHunXkHntX9umdasJtsg8AWvZmkmZPTocYo3
        fTSa0VzWCYF7/MDg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Warn when NUMA diameter > 2
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <jhjtux5edo2.mognet@arm.com>
References: <jhjtux5edo2.mognet@arm.com>
MIME-Version: 1.0
Message-ID: <160587564803.11244.428473772437307273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b5b217346de85ed1b03fdecd5c5076b34fbb2f0b
Gitweb:        https://git.kernel.org/tip/b5b217346de85ed1b03fdecd5c5076b34fbb2f0b
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 10 Nov 2020 18:43:00 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:46 +01:00

sched/topology: Warn when NUMA diameter > 2

NUMA topologies where the shortest path between some two nodes requires
three or more hops (i.e. diameter > 2) end up being misrepresented in the
scheduler topology structures.

This is currently detected when booting a kernel with CONFIG_SCHED_DEBUG=y
+ sched_debug on the cmdline, although this will only yield a warning about
sched_group spans not matching sched_domain spans:

  ERROR: groups don't span domain->span

Add an explicit warning for that case, triggered regardless of
CONFIG_SCHED_DEBUG, and decorate it with an appropriate comment.

The topology described in the comment can be booted up on QEMU by appending
the following to your usual QEMU incantation:

    -smp cores=4 \
    -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
    -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
    -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
    -numa dist,src=0,dst=3,val=40, -numa dist,src=1,dst=2,val=20, \
    -numa dist,src=1,dst=3,val=30, -numa dist,src=2,dst=3,val=20

A somewhat more realistic topology (6-node mesh) with the same affliction
can be conjured with:

    -smp cores=6 \
    -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
    -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
    -numa node,cpus=4,nodeid=4, -numa node,cpus=5,nodeid=5, \
    -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
    -numa dist,src=0,dst=3,val=40, -numa dist,src=0,dst=4,val=30, \
    -numa dist,src=0,dst=5,val=20, \
    -numa dist,src=1,dst=2,val=20, -numa dist,src=1,dst=3,val=30, \
    -numa dist,src=1,dst=4,val=20, -numa dist,src=1,dst=5,val=30, \
    -numa dist,src=2,dst=3,val=20, -numa dist,src=2,dst=4,val=30, \
    -numa dist,src=2,dst=5,val=40, \
    -numa dist,src=3,dst=4,val=20, -numa dist,src=3,dst=5,val=30, \
    -numa dist,src=4,dst=5,val=20

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com
---
 kernel/sched/topology.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 90f3e55..b296c1c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,6 +675,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
+	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -706,6 +707,38 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			sd->child = NULL;
 	}
 
+	for (tmp = sd; tmp; tmp = tmp->parent)
+		numa_distance += !!(tmp->flags & SD_NUMA);
+
+	/*
+	 * FIXME: Diameter >=3 is misrepresented.
+	 *
+	 * Smallest diameter=3 topology is:
+	 *
+	 *   node   0   1   2   3
+	 *     0:  10  20  30  40
+	 *     1:  20  10  20  30
+	 *     2:  30  20  10  20
+	 *     3:  40  30  20  10
+	 *
+	 *   0 --- 1 --- 2 --- 3
+	 *
+	 * NUMA-3	0-3		N/A		N/A		0-3
+	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
+	 *
+	 * NUMA-2	0-2		0-3		0-3		1-3
+	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
+	 *
+	 * NUMA-1	0-1		0-2		1-3		2-3
+	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
+	 *
+	 * NUMA-0	0		1		2		3
+	 *
+	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
+	 * group span isn't a subset of the domain span.
+	 */
+	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
+
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
