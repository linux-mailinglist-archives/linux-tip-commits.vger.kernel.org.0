Return-Path: <linux-tip-commits+bounces-2298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAC974E9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 11:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D62C1C20E55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C7186604;
	Wed, 11 Sep 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gxH47pZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/kkOeru"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD41865E2;
	Wed, 11 Sep 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047181; cv=none; b=lm8uEjgKd9tfNq4Gbhp6g32U18oP9r8t6yXAEui1mJh7NqdTUQtvbeTDZw7cNvCwtN8lMLES2RxAPYZ/1M2d8pVeG5tEsnQ5DYDZF/nwqyPPs4OOtrXgkI3nFKsK30k784CtubNFaDtvtYiXnU8qkJYNtamWOAIr0YRCe1Hq3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047181; c=relaxed/simple;
	bh=d710xrpYXGFcQs8e7w58sDzH3mVHD3GQ9XzcX51NJtc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hL6gnQ7JedhKbjvKdhbPKxJQvrU0ZJvuKHjHhhOP6Y486rwQjyy8Bh4H/S9yos8lt5+5YXypfksUMf3e/mN5EaU4ZdqfCtfwsuUkbSrKn4Aw23lhqnygS8gkCkaROTzkw0a6wIxgVzY6dkLJkbF9wWOETNAOGde92bH3CGVEfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gxH47pZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/kkOeru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 09:32:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726047178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ps+n+0C0S8lJAMj1MGqlEQHcRuS8e7i2TDD2iBx0378=;
	b=0gxH47pZvgUevH/2+ZwYlL+yla+3UhoFcqHEze752uQyLKkzlciW1Ncu1UsDQI8kgueKmU
	cRTPCME+qJDdNBWw31opWH8VZFVKsnHssG5igIrKEFnekVlZhL2eQ6A8HE7/AV79iPChUf
	/JYZZZPOSFWvujpG3NpZte/9wCoNb6sy6F4+l17gaI55l9FXhPYf6SRRwCTEQdIJmLX+KX
	O0YxdgvyMAEBBPSFNEuaafpgG+lDfK9xGkw8386ucD7hvpDzRqX8+eYCqBPIMh59O6eL6k
	27bskpwxRqPlj+rlKFiDIsQbi8vgeTqZDzfR7RcCMWRrAZJcaY6w+kyin0BNLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726047178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ps+n+0C0S8lJAMj1MGqlEQHcRuS8e7i2TDD2iBx0378=;
	b=i/kkOeruI8sI/FmPWkbFxNv/amlh1wfzHnRzHnbc32s74TpNIC2y1JSnOwk8V9Lf50YyDm
	TrJIwNvggzbawNBA==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Clarify nanoseconds in uapi
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-3-christian.loehle@arm.com>
References: <20240813144348.1180344-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604717764.2215.931251201259015873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6ebf2d021a13a77b495b4de15c6834e26b80d08e
Gitweb:        https://git.kernel.org/tip/6ebf2d021a13a77b495b4de15c6834e26b80d08e
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Sep 2024 11:23:56 +02:00

sched/deadline: Clarify nanoseconds in uapi

Specify the time values of the deadline parameters of deadline,
runtime, and period as being in nanoseconds explicitly as they always
have been.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-3-christian.loehle@arm.com
---
 include/uapi/linux/sched/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 9066238..bf6e9ae 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -58,9 +58,9 @@
  *
  * This is reflected by the following fields of the sched_attr structure:
  *
- *  @sched_deadline	representative of the task's deadline
- *  @sched_runtime	representative of the task's runtime
- *  @sched_period	representative of the task's period
+ *  @sched_deadline	representative of the task's deadline in nanoseconds
+ *  @sched_runtime	representative of the task's runtime in nanoseconds
+ *  @sched_period	representative of the task's period in nanoseconds
  *
  * Given this task model, there are a multiplicity of scheduling algorithms
  * and policies, that can be used to ensure all the tasks will make their

