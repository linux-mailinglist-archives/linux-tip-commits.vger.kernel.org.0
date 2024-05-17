Return-Path: <linux-tip-commits+bounces-1262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC28C8254
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCCFB224D1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636E182C5;
	Fri, 17 May 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEHFuNpP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7LjWV0U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E418EAF;
	Fri, 17 May 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933173; cv=none; b=pgFGPZKztCkeLaJqdL6QuYsFBsiNbTk3mIbKpqXZi2hqNP0LThi4lbKV65yc9ovBIFGMxRXCuv5LoKwLvjy6RwOvPuy1GT3Y4rWXtZu743cinmvIpZw+oTPYEHr3hWA7Crgy4mRW7r5+3cmmN3396rO6FBBKA2ZzMvrz9ur2by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933173; c=relaxed/simple;
	bh=Gy+MfnzKFUlnUmJu/uqoWrGcD3nzjxYvX/tGEREoz8M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WUCVjiCrAs1X1/QO6R3mMRjLqY0uxMNT1r6KSlXWUv1crVQ8pSKHfA6V4wsuG9Rf13iBQ/Eg0uKuh9ls2K+wXo3/5st244zQDRfQghkOPYE9x7LpnCrNEgF/71XA5xaAG5pK9jai4pUR287auk4cQLmkakinullAE5OEW4/gGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEHFuNpP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7LjWV0U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAqBsmfXaE9NB6/Y4Gt8q2H5wvUn70FgT1PsS5eYfoo=;
	b=JEHFuNpP/oanSBwHMfwbyKvOWb9U/X0J24oq/My8t8kda6QUoJ/C2sPTb6NGJlHMQj4YTW
	Qm2FYLFGs5tl2xOlOQmVjVdl/F3Xw3tCcGKOXzNwwffIP8/Y6jYtaG+rM06fV/T4JJ646A
	aS/mDulkTpZ1NhPMWcKsq3Pnz910wpkyNpmb22BgY3G/obDps0+8ZK/p8zqhXQZ4k2V7/Y
	zWEmDGHfd0DdziPYo1HDhi03NC9B6mt87Y9KU7yVETDQ5oe6PdgBMhJoFn3OxmfbhugGWT
	dphws+0SURGc+B4+Y0qEtDYggBGQ3kS4rDVGQMHlp3X0imM9exNQ77TaA/3jew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAqBsmfXaE9NB6/Y4Gt8q2H5wvUn70FgT1PsS5eYfoo=;
	b=N7LjWV0U5QrhbwXXoy/dVPy9IL3uIAHtTHJPctWQQPr1v3oiVBKM0IbnYPwd43SLtBPsGk
	1Zk5QNfss40fgTBA==
From: "tip-bot2 for Cheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix incorrect initialization of the
 'burst' parameter in cpu_max_write()
Cc: Qixin Liao <liaoqixin@huawei.com>, Cheng Yu <serein.chengyu@huawei.com>,
 Zhang Qiao <zhangqiao22@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240424132438.514720-1-serein.chengyu@huawei.com>
References: <20240424132438.514720-1-serein.chengyu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317007.10875.3075272533719435489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     49217ea147df7647cb89161b805c797487783fc0
Gitweb:        https://git.kernel.org/tip/49217ea147df7647cb89161b805c797487783fc0
Author:        Cheng Yu <serein.chengyu@huawei.com>
AuthorDate:    Wed, 24 Apr 2024 21:24:38 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:53:54 +02:00

sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

In the cgroup v2 CPU subsystem, assuming we have a
cgroup named 'test', and we set cpu.max and cpu.max.burst:

    # echo 1000000 > /sys/fs/cgroup/test/cpu.max
    # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst

then we check cpu.max and cpu.max.burst:

    # cat /sys/fs/cgroup/test/cpu.max
    1000000 100000
    # cat /sys/fs/cgroup/test/cpu.max.burst
    1000000

Next we set cpu.max again and check cpu.max and
cpu.max.burst:

    # echo 2000000 > /sys/fs/cgroup/test/cpu.max
    # cat /sys/fs/cgroup/test/cpu.max
    2000000 100000

    # cat /sys/fs/cgroup/test/cpu.max.burst
    1000

.. we find that the cpu.max.burst value changed unexpectedly.

In cpu_max_write(), the unit of the burst value returned
by tg_get_cfs_burst() is microseconds, while in cpu_max_write(),
the burst unit used for calculation should be nanoseconds,
which leads to the bug.

To fix it, get the burst value directly from tg->cfs_bandwidth.burst.

Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Reported-by: Qixin Liao <liaoqixin@huawei.com>
Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240424132438.514720-1-serein.chengyu@huawei.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a91438..f88f505 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11402,7 +11402,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = tg->cfs_bandwidth.burst;
 	u64 quota;
 	int ret;
 

