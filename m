Return-Path: <linux-tip-commits+bounces-2918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C449E0009
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D2016217D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F41FDE31;
	Mon,  2 Dec 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiF67OUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60/aA8HW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1581FDE22;
	Mon,  2 Dec 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138084; cv=none; b=V9KaKQfbrACDTdirexj5JWWVxo3Czuxy+kC3v20KCxqG3AR03sOkp2GQUxFREUMTpH1wmOMy0Gbln6azAKgIDQhEQ+qsMHT3z/nMiCCSMFIoj7lWrAKhQ15nZdPQBNyHM1F287fZ19WpOkfu3o9oizsDRMLqGzuHxFo/p3OtYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138084; c=relaxed/simple;
	bh=rFgEIpXLxdP7KDmOO1SpSmiUECbv0DN/B6uVHdgD1tM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eZ+FhATEppPJWQ16raAbNHb8hFHmZ4pMq9cNaHZYbl2QACIBkGarV1/A6JX0gwiIkDLjr91dpv7k4alNiTUw9uRQzYol7np25dWZ5NGIjdxnBryiMsVzxk56yTMUlauUvcHIbGAHIoq0E4yrFtbHcIJJmD+eH+hzewdeuWWU6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiF67OUA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60/aA8HW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x2JAGwYi8nvNYDYc5ZpojMWufJj9KKDHjMAjr4H16s=;
	b=SiF67OUAdKYlgtBXLp/s8wwnZXiivvMTtRSUET99fYMYr3IfYPD/FknRRLrTZAlQe76vzf
	ih3xC7y5sFKsq6KHN4bvXw5kkQbiejkxo2u4osu3NCiwt1gIBx4DfXbcWcU78qPD85KHxQ
	T5PR35Jr+qDzyy8UmMZbR8qn+rX8WGrlBtG10YIpbLK8B6+CS4cEpWbNr6ucHu4FDlbyy9
	qkHG5dFd1x6+OhM9G+d7uI3zm5X+zRW5nNglPQquU5ouERzECClO3Ip3NtQvqonob7GBRr
	NZ/yil4fyhS2KHv+/phKxkNVmzFAAK38V+U8v+MaXwYZcYCfkSHR+laH0xfVFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x2JAGwYi8nvNYDYc5ZpojMWufJj9KKDHjMAjr4H16s=;
	b=60/aA8HWbzdARz0Y0yRu6X/RoRI5nrrTbZwwFFVPIwIrYIBJv/3absQax6OX4tG+qDgXft
	7buy5jLW0JwrNECQ==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove CONFIG_CFS_BANDWIDTH=n
 definition of cfs_bandwidth_used()
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Valentin Schneider <vschneid@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241127165501.160004-1-vschneid@redhat.com>
References: <20241127165501.160004-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808101.412.9205390634963152207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a76328d44c7ab7d1001a97cb2e84506dde7822d4
Gitweb:        https://git.kernel.org/tip/a76328d44c7ab7d1001a97cb2e84506dde7822d4
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 27 Nov 2024 17:55:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:31 +01:00

sched/fair: Remove CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used()

Andy reported that clang gets upset with CONFIG_CFS_BANDWIDTH=n:

  kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
   6580 | static inline bool cfs_bandwidth_used(void)
	|                    ^~~~~~~~~~~~~~~~~~

Indeed, cfs_bandwidth_used() is only used within functions defined under
CONFIG_CFS_BANDWIDTH=y. Remove its CONFIG_CFS_BANDWIDTH=n declaration &
definition.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20241127165501.160004-1-vschneid@redhat.com
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 05b8f1e..4283c81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5373,8 +5373,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
-static inline bool cfs_bandwidth_used(void);
-
 static void
 requeue_delayed_entity(struct sched_entity *se);
 
@@ -6748,11 +6746,6 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 #else /* CONFIG_CFS_BANDWIDTH */
 
-static inline bool cfs_bandwidth_used(void)
-{
-	return false;
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}

