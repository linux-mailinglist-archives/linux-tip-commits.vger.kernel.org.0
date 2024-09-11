Return-Path: <linux-tip-commits+bounces-2297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A5974E9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9471C220A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD48185B68;
	Wed, 11 Sep 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oeAFHpBd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ktIgxSCK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795D18629C;
	Wed, 11 Sep 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047180; cv=none; b=pRbrb2zhAsr0FvhAx9u22iGzj3HJp60EwqrmIJ83tcaOE6cFlsSRUq2NIPcAQEAcmpVflXfxn6MY6WiCuOalxHClilRzyirhip+SWEFqWUt58u8geMjOds4/2vmyaSJrNcfSAZ3xrKcpdQGgTW0O8eSheeRda/OJh4yIbbUh24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047180; c=relaxed/simple;
	bh=nDj8dkaqw3SO4n3jv8KAOvydzUjpJzllgnxzUfOpkTM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nOU4E5brnHZ/WvWh8k6UY07NFg4v0vARHx/IZytVrPP51bYEO/Y0lfeHXo9yd/gwYzIHuhUpXLWQFvsXwGewMsyMcRxBjuSLg7v+4xDuAnLv18cwks9Eih4V84/7dQ4DRNuZ6Lf0xI15UrVySk/w1K3blmblOdNCO2GHWGD7sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oeAFHpBd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ktIgxSCK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 09:32:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726047177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43zp0X/MhzxwJLg50k0cjmYvWsl7YshLXUj2dYU07GM=;
	b=oeAFHpBdwlCwF+ptZ8QyLFCVXnXdIQHQbw8WZCK4n3+hdtRhjsyj1Y1DOIXV/n6a6JdvER
	jdIdSrDQa/iKS3vTytmY9w8v4qvESaUf/8Zd2cLRoJ5yR4GFF/BVSOp2YpCC77O2R39z1e
	4XCtgz+84wtyfuml27JNbFft8NSfTxAhl4FhD/uP8JHv+F79D1HqKLbVzh0tTU1dsMqjvW
	gz78ux9nBXC6snUHnFroQAZQKCTSDz30n0lnuJKvgAzfhbxtQzh2ndgcxDoHhj0w18umBf
	PfG+zNvHLeQa+B38CqYGOVpREbThH+TLQMCSkAOP8wXDbTsGAV2KY/pXJoHPvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726047177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43zp0X/MhzxwJLg50k0cjmYvWsl7YshLXUj2dYU07GM=;
	b=ktIgxSCK6HjkzBzrbMpfa0ovEQdIUq5ay9CvNV9AJBNP+/DY/WdVDRX5coidTAJnOu22HJ
	W0Kj5wpVooUwn/DQ==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Use NSEC_PER_MSEC for deadline task
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-5-christian.loehle@arm.com>
References: <20240813144348.1180344-5-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604717639.2215.480349818909979737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bc9057da1a220ff2cb6c8885fd5352558aceba2c
Gitweb:        https://git.kernel.org/tip/bc9057da1a220ff2cb6c8885fd5352558aceba2c
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Sep 2024 11:25:22 +02:00

sched/cpufreq: Use NSEC_PER_MSEC for deadline task

Convert the sugov deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-5-christian.loehle@arm.com
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece624..43111a5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSEC_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC,
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;

