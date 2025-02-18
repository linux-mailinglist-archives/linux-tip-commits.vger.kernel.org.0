Return-Path: <linux-tip-commits+bounces-3409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB2A39763
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAEE1892552
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3572343C0;
	Tue, 18 Feb 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3iouzkG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNqnjVnS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F16232368;
	Tue, 18 Feb 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871992; cv=none; b=srKKZTxLp/twrO5Svfbvpso4y8iVUg/B1ocfFuca06d3ujcSQCW1X2AOUE78Ef9xEmRHD/5vvk+FPPvSrjQBs+sHkdDORQz88PCvkRNFWRQMaSO7rfRgW/5xuV3VfJ1NtqBlvscMSpgPRH2WfkYnqSy65j/JPeAfWLJUC7MQ/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871992; c=relaxed/simple;
	bh=J/MCQ7B5IF7N+vLWjsRDcB9yekFhR9PrX72YQgAng9Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WLidEeg+S1cW5EpctMVOXJu3v9Q9z7ODEl+z47BOOHjnlDOm4K3BYSaqFOUYqBqYlezknxJoLB1femqKALQRVZxwq3eGeLkK7tJ/SE57+IfIssfF7ZLiqCJz8KQEnv/LOrx8HhgkNb7gdtGlfMB8uDADna0fRXDZux9ORxWRXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3iouzkG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNqnjVnS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWXGHLlpn46RvlUzwGDyueyT3cr7MEgwQl0C2+YnCCI=;
	b=r3iouzkGPY/D5hjEcBFonNsmd7Q7JDLPxdvg3Td94cmrdKgsQ4l9j2kP/vsPgAhCBYX+Ns
	fbkkvQhh0vTABv1nre7amNZ3VnWErLh/6U9qviyZqiSphy/fEQsp0zs06ZVl2vXO/pf9i1
	a/ihd8m1cLgmFsTjdw8PHaGxlaZBNhQLqMQISp1SNsWSiRMmXCQn7FCYwB4BAwrVoAYJLe
	arzrmoVWry4xvXbHDU1rSqIBEH/CxYbA0tcpQM1b5DyQtpLUhoMb122TOWmd9bY1XVyTW9
	vNmSwpXSuq1wzZi+TMDIIMxWIN2A9vT0bx9ZBb2OoWpuZQD8MqS9LvX7V9HjkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWXGHLlpn46RvlUzwGDyueyT3cr7MEgwQl0C2+YnCCI=;
	b=MNqnjVnSRd3KG0UrGeLnq4Z5HS62GQUluyBUaKT1mNjoRU4eTWwg7Il2xJ+aOrpZn+FJIq
	6O4Wu4VB/RCO4OAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] blk_iocost: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C196d487c925411923a2d59d4bf5e366b9dac2747=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C196d487c925411923a2d59d4bf5e366b9dac2747=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198865.10177.11503443095930372931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     cab0e0a05627f7e661aa644a3a5f0eb88881872f
Gitweb:        https://git.kernel.org/tip/cab0e0a05627f7e661aa644a3a5f0eb88881872f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

blk_iocost: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/196d487c925411923a2d59d4bf5e366b9dac2747.1738746821.git.namcao@linutronix.de

---
 block/blk-iocost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 65a1d44..ed11438 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3004,8 +3004,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	iocg->hweight_inuse = WEIGHT_ONE;
 
 	init_waitqueue_head(&iocg->waitq);
-	hrtimer_init(&iocg->waitq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	iocg->waitq_timer.function = iocg_waitq_timer_fn;
+	hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	iocg->level = blkg->blkcg->css.cgroup->level;
 

