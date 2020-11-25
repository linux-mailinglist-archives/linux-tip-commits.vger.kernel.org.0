Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6E2C41A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgKYOC5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:02:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50316 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbgKYOC4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:56 -0500
Date:   Wed, 25 Nov 2020 14:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ie5zApLM8EwS7KKcWwGgPLlc7A+9+kWyTZ6OFo+cPA0=;
        b=eBZkGkx5aYDdRA9QTnLBoQoGbW+3TvJtb8SGPdF+tvCZxt5fUvvuyYNsJaU3yN9YS8i4kD
        CXwG5y/oVkxHcGmPB8MvtNr0Gj1Jh1QVkYtkf52nilQci+0xB40Il3sj4VI8PrDKhMGx5G
        +B53Ivxvfos37Xwzuy6iojjp5E8EbfRluKYxnXwv/jx4M0nXbkyiWXu+mgfkgmHxplgwG3
        xdvvuNx0WydkV7cmhn/HCbHkWmAJyf2bTH6VOejU6x39MOFV/0n2fTbM+U4kplB/jF7Dtu
        4U9L08VuZIKoM4ny299soAkv89G3iiW8GEQvwLVXw2SMYItRTSUl9+KVOISLqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ie5zApLM8EwS7KKcWwGgPLlc7A+9+kWyTZ6OFo+cPA0=;
        b=0y1KGAof8qfqraN5O//yYMmGtayMPFZ0vnZQtozGcRCMBIx6VGq+wPVJvlmHxHjaOMpj+u
        5FuM46bezV8AyjAA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Avoid unnecessary calculation of load
 imbalance at clone time
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201120090630.3286-3-mgorman@techsingularity.net>
References: <20201120090630.3286-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160631297354.3364.7316288267383540606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5c339005f854fa75aa46078ad640919425658b3e
Gitweb:        https://git.kernel.org/tip/5c339005f854fa75aa46078ad640919425658b3e
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 Nov 2020 09:06:28 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:47 +01:00

sched: Avoid unnecessary calculation of load imbalance at clone time

In find_idlest_group(), the load imbalance is only relevant when the group
is either overloaded or fully busy but it is calculated unconditionally.
This patch moves the imbalance calculation to the context it is required.
Technically, it is a micro-optimisation but really the benefit is avoiding
confusing one type of imbalance with another depending on the group_type
in the next patch.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201120090630.3286-3-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d10abe..2626c6b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8777,9 +8777,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			.group_type = group_overloaded,
 	};
 
-	imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
 	do {
 		int local_group;
 
@@ -8833,6 +8830,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
+
+		/* Calculate allowed imbalance based on load */
+		imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
 		/*
 		 * When comparing groups across NUMA domains, it's possible for
 		 * the local domain to be very lightly loaded relative to the
