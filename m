Return-Path: <linux-tip-commits+bounces-1264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140A8C8259
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6F21C21BB6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29225778;
	Fri, 17 May 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4uZV24Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10BZvS/g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E11B809;
	Fri, 17 May 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933174; cv=none; b=kL5U7pBXLqFvTvz7k2SSrCnzgBGSjQ2sGNBvTmxQl6bq33/0aLbhhNHwmLuLuf7YjIZV9L04FnWRCOLyMKP9IgzIPTakFLqN1psyQtg3d1WJnpqAHjLOwZYYTxzk+8w+iw5IyPUxpuZgP8/YlsVL9IRDXWBu6lV72mgW3310sgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933174; c=relaxed/simple;
	bh=Uo8TMkjO8z0SvFNJAC2gDMe+jJlidtzciWeLP9KZ0V0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aiX1APxsV1JwoBRw43J47b5JSzJFsKuXWFAVEC//Ee6hLnezc3OwB4tArXv9w/gb1DhssFjdXr8DnCnD9TF9IGGe7xhaXlJFQLUrZeO8Pm+qwoqCkD15jlduiPwV0x/I+KBwihbDRmCaSDWGPCERnYOENn4pVcqjHrdvSCRo3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4uZV24Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10BZvS/g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsOCnPWzCftUdW+oxDedyB6AsEoCsWSOjupa4hs7j9o=;
	b=p4uZV24YzjC3etKFg7D/RGYCl62S3Bhk0UHCsB6v2EGkLxI7RWl6AQQ4KOX9hRjpbsVIzb
	19ufFjTkX7TkDGDGi/x0/n3HeV2JYjrs0+E8upSjtVqiK8TAgNaHoF5SmsB2lTLFIdDhBE
	mEGkFRGxiNM7TwAbAzUD8fhB+n5YG7HzYyVDJT5HWyLBX3xA4Z9rrj4it2f5tp9SIgCXSO
	8bBJbqYsucC2o2fszLozXYvxYwt5OR0wkz1VUHy38mGiJZ9i+Rc7oXN7b6BxY7vQVSS7a5
	6nrlYXNn4dqlGksKrqAUmrnJzvkDn5Puw/reJ8dia96bq/CVBLYCafNwYwTKMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsOCnPWzCftUdW+oxDedyB6AsEoCsWSOjupa4hs7j9o=;
	b=10BZvS/gxpnSymZ9bU+e1JDrgcgr57JVVqHz4kRfguJCpM/Vx8QyoaMhGUyUjxStpgpeR1
	F3P98hAfNS3wOtCA==
From: "tip-bot2 for Vitalii Bursov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Dump domains' level
Cc: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com>
References:
 <9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317119.10875.3544825660193230541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     287372fa39f579a61e17b000aa74c8418d230528
Gitweb:        https://git.kernel.org/tip/287372fa39f579a61e17b000aa74c8418d230528
Author:        Vitalii Bursov <vitaly@bursov.com>
AuthorDate:    Tue, 30 Apr 2024 18:05:24 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:48:25 +02:00

sched/debug: Dump domains' level

Knowing domain's level exactly can be useful when setting
relax_domain_level or cpuset.sched_relax_domain_level

Usage:

  cat /debug/sched/domains/cpu0/domain1/level

to dump cpu0 domain1's level.

SDM macro is not used because sd->level is 'int' and
it would hide the type mismatch between 'int' and 'u32'.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a..c1eb9a1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
+	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
 }
 
 void update_sched_domain_debugfs(void)

