Return-Path: <linux-tip-commits+bounces-2299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83073974E9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E811F22272
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Sep 2024 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7106186E38;
	Wed, 11 Sep 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6RGJa9b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUvC9pUf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1B1865EB;
	Wed, 11 Sep 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047181; cv=none; b=cLsbDRpB20Yrd4PnVW5W3QqgvWasTM7p9oaK7qV7YU39Q119HHwTB3lrmNUcdfLtorfuByYf1Iav0qncx3B5bG2bstbcxm1VBiemkiW15oMtI1y/yh3sXQ+ffUVAqmlyhLIih2YGgzOYvBRYzxP4jonhsN7vTxFxb8y1fcnxX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047181; c=relaxed/simple;
	bh=yfL9Su9ePmN2TR4BbMZn7nLCvGogLY7bLULyL5dI0Nc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uCPUwjN9pD6SJ7CZz1O22+/Zo+0M6+yFPEymhut6A7xDl0dpYfqbYvRS/Io6Rin/5xZtZxqo9LQUHv5tijT130KRPi0jE4vAbRfufOe1G6Iiup0HI1BsROUCQP9NP6S5grlvzAK975ktQdsgrpUlU1HtznQfRfr/E65v2CNPzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6RGJa9b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qUvC9pUf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 09:32:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726047178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbmPymg1xvdbYEGsm2tjWBLWVp4FVQVRc5/N7n8yvjY=;
	b=D6RGJa9bIbtsdi5ewqJf0LURfF7vkW8hC6FsUguLO6UUEPKcPk9LtqQw3BDxnk2sjjFv9A
	DV5dTeFj4EohaCg2j7JnPwAH2XcIcrNHvRORvgz/y331yLo2cUOjyAw5ti8Y5QgOeQETF0
	f4T26vFKSnGgG9sFQMeqEUbarbl/IcEFnfK+1pkDs0WSNlDKuDHegTr55A7LRxXEUEz8iX
	GHiwdFgb65byrrd4XO9JnanIdHXeIk3nFeQjCm6lIO1Xd5+C6GH4vNippCtlqnL1fLd9Qp
	eXpNYJRY6+B2cBKkbupAMCFOOnbewUKINY1XMdPcPI3fBvdiUHRAXxYUi3/few==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726047178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbmPymg1xvdbYEGsm2tjWBLWVp4FVQVRc5/N7n8yvjY=;
	b=qUvC9pUf2vIAYAuZMW2zZnAI3e5h1QkfFW/0Q3ve9/2bh0ttVziHaD4MfTjdNtD395UP6t
	6rPTlnIzgqY4FuBQ==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Convert schedtool example to chrt
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-2-christian.loehle@arm.com>
References: <20240813144348.1180344-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604717824.2215.3356816703237140247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8bee4ca5bd64afa6a08c40db621d3c6336685bcf
Gitweb:        https://git.kernel.org/tip/8bee4ca5bd64afa6a08c40db621d3c6336685bcf
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Sep 2024 11:23:56 +02:00

sched/deadline: Convert schedtool example to chrt

chrt has SCHED_DEADLINE support so convert the example instead of
relying on a schedtool fork. While at it fix the wrong mentioning
of microseconds, it was nanoseconds for both schedtool and chrt.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-2-christian.loehle@arm.com
---
 Documentation/scheduler/sched-deadline.rst | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9fe4846..22838ed 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -749,21 +749,19 @@ Appendix A. Test suite
  of the command line options. Please refer to rt-app documentation for more
  details (`<rt-app-sources>/doc/*.json`).
 
- The second testing application is a modification of schedtool, called
- schedtool-dl, which can be used to setup SCHED_DEADLINE parameters for a
- certain pid/application. schedtool-dl is available at:
- https://github.com/scheduler-tools/schedtool-dl.git.
+ The second testing application is done using chrt which has support
+ for SCHED_DEADLINE.
 
  The usage is straightforward::
 
-  # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
+  # chrt -d -T 10000000 -D 100000000 0 ./my_cpuhog_app
 
  With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
- of 10ms every 100ms (note that parameters are expressed in microseconds).
- You can also use schedtool to create a reservation for an already running
+ of 10ms every 100ms (note that parameters are expressed in nanoseconds).
+ You can also use chrt to create a reservation for an already running
  application, given that you know its pid::
 
-  # schedtool -E -t 10000000:100000000 my_app_pid
+  # chrt -d -T 10000000 -D 100000000 -p 0 my_app_pid
 
 Appendix B. Minimal main()
 ==========================

