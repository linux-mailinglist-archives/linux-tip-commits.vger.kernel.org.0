Return-Path: <linux-tip-commits+bounces-2346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057AD9900AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 12:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF4B28505B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DAE137903;
	Fri,  4 Oct 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xu/xf7s5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSG/IuKi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF146A83;
	Fri,  4 Oct 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036967; cv=none; b=m6FYpd0HaKcQXBqeTg5FHADIjuwBhF0/+6tf3lyEXLpA+53trnojWnfMOHqBuIGvbLUN4iB/OuDAIEs/rk3T3Bja2VbZdiLMZCV190vg1Xb5pHEDHbJx7C+mm+a7bOElMLKkT+rMOeTfIEves73B+opIVeK33o/trcmdQG1omuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036967; c=relaxed/simple;
	bh=29dpBzHhJFPqNyXXSfD0qN5hjV3jayvSMmLx+3ntZ+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kXfxu4lSPXAxd05vSLFswe8MY+2gmAE1lvzaPyws9FA7tXLNVSzjTh0YCa6m3048ks2H0JpfVVOa50QnY3Q63mAe+5UZNsFOC2AYGE5b0UzzzwKH0TD7cDl/kDdb6d0Kvai3IAGUdueXoMDuKl4ICtGkeFjgkx9SEmd508bYX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xu/xf7s5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSG/IuKi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Oct 2024 10:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728036964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/p7Z2//N9We1apYoX0ev1Q1oSXXCEq/zLSX/rd6yPlU=;
	b=Xu/xf7s5mS4vSSQo2PMgxjjfpjQQ0G0L3kMErLbYQvrtFilNM8n30U3+2JTXMwqAOi63G4
	Sx43cm2V6NASh55aERb/8+nq+uTFsij1DjBKUdnpPsnWDsPsFfCsN8uIM10EGeSJjRABk1
	/g1Q8/m0Sw27TyeKJbme5ZdvBtF6Rzc5tcx/VSWc/0uX73BHh/5gKKNYBFA30NYRtC504W
	sTl2JjSYCbdGwsNrGvZYbDf4ifr6LCEHfNzy4d8g/7JJl1wH4AAtZSrJWCWRt8em7IqB9Q
	561YuL7AP0vO+eVexrgS4rnGYMZ0RllVlEVKui6dJKYRvW/jbogwXqmGXb3m/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728036964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/p7Z2//N9We1apYoX0ev1Q1oSXXCEq/zLSX/rd6yPlU=;
	b=iSG/IuKidhEjsvgUGe1lSomcD/kt+4tJRKbcAWz7AuBeat4ItYtA7mUso+vZbYACK2hKbH
	1VMFfLZbrss8ZmAw==
From: "tip-bot2 for Mike Galbraith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix sched_delayed vs cfs_bandwidth
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 Mike Galbraith <efault@gmx.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <7515d2e64c989b9e3b828a9e21bcd959b99df06a.camel@gmx.de>
References: <7515d2e64c989b9e3b828a9e21bcd959b99df06a.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172803696357.1442.2246637734523151243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9b5ce1a37e904fac32d560668134965f4e937f6c
Gitweb:        https://git.kernel.org/tip/9b5ce1a37e904fac32d560668134965f4e937f6c
Author:        Mike Galbraith <efault@gmx.de>
AuthorDate:    Tue, 01 Oct 2024 03:34:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Oct 2024 11:27:54 +02:00

sched: Fix sched_delayed vs cfs_bandwidth

Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
can proceed as it would have sans DELAY_DEQUEUE treatment.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Link: https://lore.kernel.org/r/7515d2e64c989b9e3b828a9e21bcd959b99df06a.camel@gmx.de
---
 kernel/sched/fair.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31a..b63a7ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6058,10 +6058,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		if (se->on_rq) {
-			SCHED_WARN_ON(se->sched_delayed);
+		/* Handle any unfinished DELAY_DEQUEUE business first. */
+		if (se->sched_delayed) {
+			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
+
+			dequeue_entity(qcfs_rq, se, flags);
+		} else if (se->on_rq)
 			break;
-		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))

