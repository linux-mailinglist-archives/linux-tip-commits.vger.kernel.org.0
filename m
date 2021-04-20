Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C136568F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhDTKrT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhDTKrR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:17 -0400
Date:   Tue, 20 Apr 2021 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86ocYL+cFiq2XEAwR2VApdH1KWaxEoRJ6aYjoKjFXog=;
        b=gBcUhqmCti5/5S6QYaNEzT2fQ7luR692EJkX6qwHngRY5NITBKk9UG7xb+AHdfINWnRejl
        4yZnKmgRRatODK+jCLrRIx6xI7EkVjN7RUp127Wj1AEgDZPGzoL3MbJimcTlSBLkiKrlTY
        Dq0lG96oeh9SQ4z3QszyQfzsZ6bIVVnOMeoKuT3J2q9vRXMKMcMutJVKLNcNj5dYleseQ0
        LJ2Gi9lg0wr1Jo2khjdrnlDefM8Cbnxp2pCy7GQi2TG4t3IB8+SwZzik562hyJlbhpk+ll
        f8XsAcXDUBn/TjnMFyP9RQeKA/Nt2Dy5c1IuFSpmBOsFpO4OM0B0xrVbg+/NcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86ocYL+cFiq2XEAwR2VApdH1KWaxEoRJ6aYjoKjFXog=;
        b=qduRoQGtYRwa3Dooh9S3qEaA8mHkxcYUpD0YzkcSMvKGkkwFuydMS/MHLVzSAETKNRFd2D
        t/LgquX8XdjSy3Bg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove temporary pmu assignment in event_init
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-15-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-15-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560505.29796.6034093386968004555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b98567298bad891774054113690b30bd90d5738d
Gitweb:        https://git.kernel.org/tip/b98567298bad891774054113690b30bd90d5738d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:54 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:27 +02:00

perf/x86: Remove temporary pmu assignment in event_init

The temporary pmu assignment in event_init is unnecessary.

The assignment was introduced by commit 8113070d6639 ("perf_events:
Add fast-path to the rescheduling code"). At that time, event->pmu is
not assigned yet when initializing an event. The assignment is required.
However, from commit 7e5b2a01d2ca ("perf: provide PMU when initing
events"), the event->pmu is provided before event_init is invoked.
The temporary pmu assignment in event_init should be removed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-15-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 57d3fe1..ed8dcfb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2291,7 +2291,6 @@ out:
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct pmu *tmp;
 	int err;
 
 	switch (event->attr.type) {
@@ -2306,20 +2305,10 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 	err = __x86_pmu_event_init(event);
 	if (!err) {
-		/*
-		 * we temporarily connect event to its pmu
-		 * such that validate_group() can classify
-		 * it as an x86 event using is_x86_event()
-		 */
-		tmp = event->pmu;
-		event->pmu = &pmu;
-
 		if (event->group_leader != event)
 			err = validate_group(event);
 		else
 			err = validate_event(event);
-
-		event->pmu = tmp;
 	}
 	if (err) {
 		if (event->destroy)
