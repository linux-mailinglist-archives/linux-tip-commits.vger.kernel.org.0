Return-Path: <linux-tip-commits+bounces-3039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8749E913C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25D7280D0C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB321A442;
	Mon,  9 Dec 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XadVifA9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rc1W1039"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053E218E84;
	Mon,  9 Dec 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742023; cv=none; b=HooRKPpk9XnXjgRzPgbMUqukvtDiWe5iapuDvnPG3yyamtHrs6FkzBmQ0jinLiJaoEWgoEQWTJxOS/FY+Vo0zdgpniauL/pAlKDQz9oI9sAse1QjDJOGv4ARxRvZE56E8m1SQc4lu8g07hwhqRAMWWswRxW3vhw1fFcIEADAzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742023; c=relaxed/simple;
	bh=TCzRyXHXAmXS614Pfg79neAtbuS2QGsOQ4d/1vtXwTI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PQDh17qrQhDXkvwPbkdbfdBmFfPj1AMiax1xNlVXcLAfAzncNYCKWP5l8GwepSjGcrUXHFOjsGl9igd4ZH7cc20v8aCCH8MZjuVMRMZdroaJSdvM1RVivKfl3A+wDolMOYcvuaI4LsdQ0rbnY/3hZnE2RFDYn1QPBCK6vq3hNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XadVifA9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rc1W1039; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wKD30L4FC75+0xUyiX8YaWQ4rMa11sP6QxvbpgskJs=;
	b=XadVifA9YTRfRXggkeoaUXPjej1EIJBfGJXmBw/BrQTG9pp1EUKFzfrtzsqXw6A7MpEjWB
	TlYpN/mDBkRyXoB4e9yyVyw1mZP7YoBBbdH35nG0SapatkNS5Kmd8TGRh/4zM84ycKqQSM
	MGPf8mG7O4gKP+Vqu+89Xjj6clDmcGzu0IZ6jW1ANNAcLZXiHZeWwNC7vCUrubRTniEeC3
	2qgAEq+Y8/XPe1cRgQUU1nZ/jG+BvMN09NnRbMyNwhKApT8Jf3XaabFrGxgpak4J2223ve
	KQ4uAvlWSGM8+a4cAS8QTdaElyHPRIYufh8/28Hgt9DBFMgUwo1DXHZ0gFxaog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wKD30L4FC75+0xUyiX8YaWQ4rMa11sP6QxvbpgskJs=;
	b=rc1W1039eR83DkU5a1PaS5UW5P+Rdi2QksgxXKJVNxqk9q+a12iLGYe+CfGfLuPBHDFSkL
	/exsQuL//yf271BA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix NEXT_BUDDY
Cc: Adam Li <adamli@os.amperecomputing.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
References: <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374201490.412.1341317032853639946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     493afbd187c4c9cc1642792c0d9ba400c3d6d90d
Gitweb:        https://git.kernel.org/tip/493afbd187c4c9cc1642792c0d9ba400c3d6d90d
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Thu, 28 Nov 2024 12:59:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:09 +01:00

sched/fair: Fix NEXT_BUDDY

Adam reports that enabling NEXT_BUDDY insta triggers a WARN in
pick_next_entity().

Moving clear_buddies() up before the delayed dequeue bits ensures
no ->next buddy becomes delayed. Further ensure no new ->next buddy
ever starts as delayed.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Adam Li <adamli@os.amperecomputing.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Adam Li <adamli@os.amperecomputing.com>
Link: https://lkml.kernel.org/r/670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 05b8f1e..9d7a2dd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5478,6 +5478,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	bool sleep = flags & DEQUEUE_SLEEP;
 
 	update_curr(cfs_rq);
+	clear_buddies(cfs_rq, se);
 
 	if (flags & DEQUEUE_DELAYED) {
 		SCHED_WARN_ON(!se->sched_delayed);
@@ -5494,8 +5495,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
-			if (cfs_rq->next == se)
-				cfs_rq->next = NULL;
 			update_load_avg(cfs_rq, se, 0);
 			se->sched_delayed = 1;
 			return false;
@@ -5520,8 +5519,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
 
-	clear_buddies(cfs_rq, se);
-
 	update_entity_lag(cfs_rq, se);
 	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
 		se->deadline -= se->vruntime;
@@ -8774,7 +8771,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
 		return;
 
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
+	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
 		set_next_buddy(pse);
 	}
 

