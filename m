Return-Path: <linux-tip-commits+bounces-2823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A929C08F7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1CA1F24387
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A6212636;
	Thu,  7 Nov 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdZYx/sO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flJjDiqq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC2DDBE;
	Thu,  7 Nov 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989997; cv=none; b=NsFd+7XAo2ul5thTnMU+sV/JHT2aREUD2YIR9CzYLGmJTePW7sOM82jaDHffdWWcJmndgexPQMihNi2tAmt3dWHo21JJXxYuPkakDiGCZRWrjlVhVuKrUZsFUjRZC41s+Y+RqSd9qQDJNOa47786I2MYIYoFFRPqD0mwi58RlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989997; c=relaxed/simple;
	bh=T6JAQLWAu30J1pPe9xHQ/jQRAjDtzjyrN6wBKTeqVl4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jxQh9YIlxcB8EuEWphRO7gCK6eA2GxD1dd3yzc0xrG08+/tcBy60KCEbOx99vbJn7RupSPCjIKwOJdmvj1CqdAw6c9m0CYlDKYdm4kEoiM8uAI26u5gQFnvgDpC4GtqgkWqkb255tj1cuY0TcOEtLhuh8mVVGDj3SUEe5rPhzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdZYx/sO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flJjDiqq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 14:33:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730989986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qhlCqOIeJg1V8GCtkeCwwDWxlFZtoh0P3xbDu2WT33Q=;
	b=IdZYx/sOJscWaVXIeRp4dUSooZ0Y6FQpwCDG0OfgEeJPBCtmwphgL3E64GVQ3BTzi5RM+T
	1wAjvKxcQa43yQiWYogmLd1u2PxUW3BOEdh3wHBsuLGs7YRlyKpN2plYJi5tWq7nLcbJal
	pc5Ehw+HftiJkH9hsrqhs7LvnsuLuW1oCpn3YqenLWlbFrkrYf6GhmUIh4CUTzoZYVB134
	HcnnyV7V1qDiQv6Tm01hTRIRA2Nsfy9f5Uc8XxVhYmTzbqopOU66rS7hVS+rga+Q4uTYKl
	W1H19jYOloLO3LPMqAeN5yWAKBD+sMRxhzrAfXYnzhlaIL/J8v0lRs4bLLA2kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730989986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qhlCqOIeJg1V8GCtkeCwwDWxlFZtoh0P3xbDu2WT33Q=;
	b=flJjDiqqmxSpBHx5zi2u5OZH+FB/kXVmPLrNaHIqfSEqAsC+tzRmFZgTIxxgHdf1SVZY/8
	2okTbQcN0K/8PpAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: No PREEMPT_RT=y for all{yes,mod}config
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173098998528.32228.2093818743217685683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fe9beaaa802d44d881b165430b3239a9d7bebf30
Gitweb:        https://git.kernel.org/tip/fe9beaaa802d44d881b165430b3239a9d7bebf30
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 07 Nov 2024 15:21:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Nov 2024 15:25:05 +01:00

sched: No PREEMPT_RT=y for all{yes,mod}config

While PREEMPT_RT is undoubtedly totally awesome, it does not, at this
time, make sense to have all{yes,mod}config select it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 35772d627b55 ("sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 7c1b29a..54ea59f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -88,7 +88,7 @@ endchoice
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing

