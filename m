Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D03BB86B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhGEH4m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59258 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGEH4g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:36 -0400
Date:   Mon, 05 Jul 2021 07:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wadRKsbsMPIWc59pF+sqvsbDZoGN+1JgIDBKdNQCkVI=;
        b=EP5UDEktB9f2ObixeQdp7LYhY0g51n3W9+gk8hz7Nm9KnAwZLmbNNYVtowIhY0xB6GZte8
        eppM7xugW5uzJVWv1WQnhlvKjUp4B4NKCEopwWLWYhWoPXXIiBgj33NeguA5ZVys1qHrfY
        SMnFtpd1ZbJpKgIE7rwKFlgruUM1HnAHi7qDTlDqAWi3lqmlyxi8Bo8vwrpV2L/rf0gmjl
        zGFWttbCMZUIc/HvzjNGSrWemI7z8We+iZbulSkvVYOuSm1d1KYBeYW2mJcqUhmottIysq
        0GijjCFiCYQBbUAd9nuquqI8dc7KtNdfUDexBhaizzDLy3O1VVq7CEzxUdWQOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wadRKsbsMPIWc59pF+sqvsbDZoGN+1JgIDBKdNQCkVI=;
        b=8rj6ytXpqver4WvPSxXJmOjwjJQQvgUz4zueQ0FGrms/eiSaPY0FoK6ux4SGBl/8iE3L7m
        xLYRMcifi28tfdAw==
From:   "tip-bot2 for Odin Ugedal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix CFS bandwidth hrtimer expiry type
Cc:     Odin Ugedal <odin@uged.al>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210629121452.18429-1-odin@uged.al>
References: <20210629121452.18429-1-odin@uged.al>
MIME-Version: 1.0
Message-ID: <162547163801.395.3977019363833751380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     72d0ad7cb5bad265adb2014dbe46c4ccb11afaba
Gitweb:        https://git.kernel.org/tip/72d0ad7cb5bad265adb2014dbe46c4ccb11afaba
Author:        Odin Ugedal <odin@uged.al>
AuthorDate:    Tue, 29 Jun 2021 14:14:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:24 +02:00

sched/fair: Fix CFS bandwidth hrtimer expiry type

The time remaining until expiry of the refresh_timer can be negative.
Casting the type to an unsigned 64-bit value will cause integer
underflow, making the runtime_refresh_within return false instead of
true. These situations are rare, but they do happen.

This does not cause user-facing issues or errors; other than
possibly unthrottling cfs_rq's using runtime from the previous period(s),
making the CFS bandwidth enforcement less strict in those (special)
situations.

Signed-off-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Link: https://lore.kernel.org/r/20210629121452.18429-1-odin@uged.al
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e263c9..1b15a19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5054,7 +5054,7 @@ static const u64 cfs_bandwidth_slack_period = 5 * NSEC_PER_MSEC;
 static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 {
 	struct hrtimer *refresh_timer = &cfs_b->period_timer;
-	u64 remaining;
+	s64 remaining;
 
 	/* if the call-back is running a quota refresh is already occurring */
 	if (hrtimer_callback_running(refresh_timer))
@@ -5062,7 +5062,7 @@ static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 
 	/* is a quota refresh about to occur? */
 	remaining = ktime_to_ns(hrtimer_expires_remaining(refresh_timer));
-	if (remaining < min_expire)
+	if (remaining < (s64)min_expire)
 		return 1;
 
 	return 0;
