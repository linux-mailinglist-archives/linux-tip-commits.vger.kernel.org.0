Return-Path: <linux-tip-commits+bounces-3138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D859FC17E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7717188543E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED0213248;
	Tue, 24 Dec 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6ss+IUK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ucgca5nU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAD212FA4;
	Tue, 24 Dec 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066482; cv=none; b=ZZbB9Zo+1ojhkaGeVRGFm2JMzmaYDzX3VuUzaDfFA0DDMArFFfLpUTLh6NbdKhC1uAfEKOz5ovskOJgSGY6rPR7WZZh7sX+IUvaRKHNS0wCJeDT6RS1WkKBswWq5KxuYlkHmvwpTFFR3agWOn41BHLArTGla10PxK9bQsjrXmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066482; c=relaxed/simple;
	bh=CoYEGgXkXlErlILt9E8G1VRyl3jWbj6UzDrXG6wtQ+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MjjyMw07a5/9uIHXk2nFy6otUVeuxQ7ckLB/zEoahJi1skuty88z9SSq/hy9LdJJ/UPuj2X9j4Hx2GcmJvMtFNF2PNEwM9s7nNpP+NVeFgyR6V9TFiUghUZzBgheGVkUzhWHzjP+gXCRwyYyyaM5UJ/V/Fy7c6wuZg5fsFI0nuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6ss+IUK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ucgca5nU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgLmuofAOPP/x2sHTMwAqUq43O0oDO3UrH76A1gVl44=;
	b=o6ss+IUKRm4F/IJ+tmqaebd/OToDsIzRSX5zwuRfOHd/mYWhaiRIffMQcp21CsujNMdTG1
	xR6A7lRX8eII+zqPjGI8QZbvbkyvIAYs/hCmmN5nR6VjSB2RhK276ewKqNyDFKyprPosGV
	A6Aio6AGzi6Ad+068rXfBZkwOZru5dKjBXTb5qxcam/CUZw5aCarUXoZE/C9E2KA9Fd8on
	e19F5h8BIFb4WFS/ZzmF4NTdn3Osudxlp+zPRqu7J7BZ9KVFe8qfS5Fg5QqS5MTaeoSv1+
	y7MH7NmbIQrLW8m+sO4e6ZgXpQ/DqNAvy+z/8UKQ6YBNBvkRVgRJX9gwQuYklA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgLmuofAOPP/x2sHTMwAqUq43O0oDO3UrH76A1gVl44=;
	b=Ucgca5nURjbgp80ib2yjbCj7hussZ9JdE0ahZ0LjCvyQzXZ7BPcFjSM9B8ZIt6x/yGLvDk
	SdD54pzfW6ISwbDg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/stats: Print domain name in /proc/schedstat
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-6-swapnil.sapkal@amd.com>
References: <20241220063224.17767-6-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506647928.399.3055132885672261082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     011b3a14dc66c40066d08d60a768e14ede7ef351
Gitweb:        https://git.kernel.org/tip/011b3a14dc66c40066d08d60a768e14ede7ef351
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Fri, 20 Dec 2024 06:32:23 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:18 +01:00

sched/stats: Print domain name in /proc/schedstat

Currently, there does not exist a straightforward way to extract the
names of the sched domains and match them to the per-cpu domain entry in
/proc/schedstat other than looking at the debugfs files which are only
visible after enabling "verbose" debug after commit 34320745dfc9
("sched/debug: Put sched/domains files under the verbose flag")

Since tools like `perf sched stats`[1] require displaying per-domain
information in user friendly manner, display the names of sched domain,
alongside their level in /proc/schedstat.

Domain names also makes the /proc/schedstat data unambiguous when some
of the cpus are offline. For example, on a 128 cpus AMD Zen3 machine
where CPU0 and CPU64 are SMT siblings and CPU64 is offline:

Before:
    cpu0 ...
    domain0 ...
    domain1 ...
    cpu1 ...
    domain0 ...
    domain1 ...
    domain2 ...

After:
    cpu0 ...
    domain0 MC ...
    domain1 PKG ...
    cpu1 ...
    domain0 SMT ...
    domain1 MC ...
    domain2 PKG ...

[1] https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20241220063224.17767-6-swapnil.sapkal@amd.com
---
 kernel/sched/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 802bd93..5f56396 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -138,7 +138,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		for_each_domain(cpu, sd) {
 			enum cpu_idle_type itype;
 
-			seq_printf(seq, "domain%d %*pb", dcount++,
+			seq_printf(seq, "domain%d %s %*pb", dcount++, sd->name,
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
 				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",

