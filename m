Return-Path: <linux-tip-commits+bounces-6073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A259B01C33
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6438A763228
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525092BE7B6;
	Fri, 11 Jul 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Qkafy2K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GtlZsni/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE2BE65A;
	Fri, 11 Jul 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237681; cv=none; b=lD7mpJ9T5iLeHJam+w3sGZRuuSGRAbl5Z20nCDBpJwBDRHxifj7Kxfogc7JM1NsukYQ67oBqh1TRHqxsd4vO8s/hFWjGchAKXua+XQL7Nouv9zrRQE02Ta62u5xa56cjLDGBrp1m2C9k3lUar16tXjm8kQ2DYiga9VslTt9k7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237681; c=relaxed/simple;
	bh=1MPf0tIAjrwf4MYN+ck33b9nkdqqmz0Afr1jBEeTlZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YuC4DCDXkLLR6Y+U7enaZWGl/oRPatGCxgD1zbKmaaW3OJUh4+yjDiOmhXCFrzTfc0v0eo4b3SzVOI45wMuY22n496kJjCU8ICivSRlcZeoGTUhoHnmGJihl9fdBYKs1fmGNSXE1VHmfJQeABqV0K/xYi3+IpSLQntvbF1CAlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Qkafy2K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GtlZsni/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 12:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752237675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmnMsCkwXU/b6I89BUyZs/ppqQUIFkHBte+emBNmWyA=;
	b=1Qkafy2KsuxX9zLTSgDVoEXEQfZXowQ01KI/IQ9sfE47fYAqNNKpFJ1q7QsgNs/+50Bpfk
	XAhtOjLglRyr60eyYrYgZBYW4ICdQzYkZdkTFylCxqU5PSb5guZTquBT6lhsm3+P3Sd6cl
	apCyBxWwspDFiOTVoX8YwkRjiUznOq7OJllI5RPJQzRX6lRqijxw9GiEFomKfZCTGnkyTn
	VzvvmoA2K9DBconuOCrXajlRRENRua0nuseV/+z81+teT1vxiGft1lfia8f1LUlCTMD9HA
	7EqsO4T6rO7POHfIZtlc1zAi7TsdTzuM+G2jPewzywM86FXCW36iaPXacXfvwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752237675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmnMsCkwXU/b6I89BUyZs/ppqQUIFkHBte+emBNmWyA=;
	b=GtlZsni/V1hCZo66QtJXowvu/BSkJA9rNA4SWsAKW3h1sncQtG+3YDyO1GGJDSepSCgjq0
	zcfRTrvHovuYkTCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] lib/smp_processor_id: Make migration check
 unconditional of SMP
Cc: kernel test robot <oliver.sang@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710082748.-DPO1rjO@linutronix.de>
References: <20250710082748.-DPO1rjO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175223767448.406.12939120121143461982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2885daf47081dd1aaf1a588e9d001eb343df1f90
Gitweb:        https://git.kernel.org/tip/2885daf47081dd1aaf1a588e9d001eb343df1f90
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 10:27:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Jul 2025 17:52:13 +02:00

lib/smp_processor_id: Make migration check unconditional of SMP

Commit cac5cefbade90 ("sched/smp: Make SMP unconditional")
migrate_disable() even on UP builds.
Commit 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and
scheduler_ipi()") made is_percpu_thread() check the affinity mask
instead replying always true for UP mask.

As a consequence smp_processor_id() now complains if invoked within a
migrate_disable() section because is_percpu_thread() checks its mask and
the migration check is left out.

Make migration check unconditional of SMP.

Fixes: cac5cefbade90 ("sched/smp: Make SMP unconditional")
Closes: https://lore.kernel.org/oe-lkp/202507100448.6b88d6f1-lkp@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Link: https://lore.kernel.org/r/20250710082748.-DPO1rjO@linutronix.de
---
 lib/smp_processor_id.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index a2bb773..94b3f6b 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -22,10 +22,8 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (is_percpu_thread())
 		goto out;
 
-#ifdef CONFIG_SMP
 	if (current->migration_disabled)
 		goto out;
-#endif
 
 	/*
 	 * It is valid to assume CPU-locality during early bootup:

