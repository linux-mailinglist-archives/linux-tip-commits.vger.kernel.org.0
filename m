Return-Path: <linux-tip-commits+bounces-2960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EE9E1BD1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A97B4236F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADF1E284F;
	Tue,  3 Dec 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y0JaVcLs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFWiW+Iv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0B1E25F7;
	Tue,  3 Dec 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222683; cv=none; b=GF/QK5uHveXKrCjq4XPdTFKbrtG12KNbv/9LWgWE6t87S/Xh38iXmTC4cjdozieuNw/Jb6b7oFhyJk1g+H5xxgtQa/z1KAmMa3J0YtdwYC4Ip9Okg/yZn8EGfxmCAB0W9m/iTV5xqMjQ05/+ktcgLt2n+QElFokAMoD30qVEUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222683; c=relaxed/simple;
	bh=FhC0QMvWednTfi024xXfypxuEw/KWioLX2xSjo+EHTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PL2URLZyZlH7DDzQVfctgoP1N9VWcO5LLd3mVyayUFcz8WvN2PJbD4Vh9oZi6NDV9nC+05MXEF9zIPuY5b2S34YRZMDnm83avzkKXdomDBJO5PmyjhiJnTRFHb6ZBVC7GyUIVe9+bQ89cQTgiJcJAWCmocwDK9xwc8T6kMQVqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y0JaVcLs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFWiW+Iv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 10:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733222679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxYH//mQF62YwgLSFiaU0rXVxmQk/9AKtWQpXPuTHL0=;
	b=y0JaVcLsucKBkMKVmb2/ao31mx5hN+3Hdhq7L017v1Dj4HZeHnCKxhkFTGqxwrDzLKhWNo
	oOQ5LmBSHKxW1tCV0/RU5MQ9M1cQhenaF0kc2vcL/AHojRkBSChiQqoXpDQdU4eRt6rfg7
	1CWg2PypGTO2S/1eKeC73t/G6hy4/Qo2LXRszqf5Ai2sE5INciTiJlJVvxH17VuGj5Sg8b
	4r4eR2UHcRc7oU2SixR7+aQysVkVZRbfwz6XTOUTUgpXngpqfX15d8a+7v7pKG55CXuTqO
	/K8nmV1n2wjEBAqbhS2NHbAXK22P/iqY14FLTQe89uuuMckRtdwoo6kMeLtcig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733222679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxYH//mQF62YwgLSFiaU0rXVxmQk/9AKtWQpXPuTHL0=;
	b=NFWiW+Ivv/y/wC5JBURgVTpbk+BGdtbUEyzWaNW85xSHjxRNvX4gIhR3Pvbjze13fY1b+r
	lYcnNK6RefU1d7Dw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Make "isolcpus=nohz" equivalent to
 "nohz_full"
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241030175253.125248-3-longman@redhat.com>
References: <20241030175253.125248-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322267814.412.9340788040836130645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1174b9344bc7e7989439cad207fcd94eaab028db
Gitweb:        https://git.kernel.org/tip/1174b9344bc7e7989439cad207fcd94eaab028db
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 30 Oct 2024 13:52:51 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:24:28 +01:00

sched/isolation: Make "isolcpus=nohz" equivalent to "nohz_full"

The "isolcpus=nohz" boot parameter and flag were used to disable tick
when running a single task.  Nowsdays, this "nohz" flag is seldomly used
as it is included as part of the "nohz_full" parameter.  Extend this
flag to cover other kernel noises disabled by the "nohz_full" parameter
to make them equivalent. This also eliminates the need to use both the
"isolcpus" and the "nohz_full" parameters to fully isolated a given
set of CPUs.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20241030175253.125248-3-longman@redhat.com
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 kernel/sched/isolation.c                        | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6..3fa0b4e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2432,7 +2432,9 @@
 			specified in the flag list (default: domain):
 
 			nohz
-			  Disable the tick when a single task runs.
+			  Disable the tick when a single task runs as well as
+			  disabling other kernel noises like having RCU callbacks
+			  offloaded. This is equivalent to the nohz_full parameter.
 
 			  A residual 1Hz tick is offloaded to workqueues, which you
 			  need to affine to housekeeping through the global
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5345e11..6a68632 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -209,9 +209,13 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	int len;
 
 	while (isalpha(*str)) {
+		/*
+		 * isolcpus=nohz is equivalent to nohz_full.
+		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK;
+			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
+				 HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD;
 			continue;
 		}
 

