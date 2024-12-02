Return-Path: <linux-tip-commits+bounces-2932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D09E00AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70928B2D518
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C220A5E0;
	Mon,  2 Dec 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHUSZgAB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+W6uHsjz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E7209F4C;
	Mon,  2 Dec 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138095; cv=none; b=WmcgGFPsFFm082zFhfor2IGp1A/bErxesFJt3M6BcehoZCSOxIrbz4TVNP2sRaeGwxF86zWlIHl7Wd4R3flmdCffBf2GxxnmiNm3mx0YbpmwrUPH+ZTjEvzN4F3zmsizcRIDSzBXQ7fP0FgDCzYjUEbsZ5VhepQqBnbbIlJXU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138095; c=relaxed/simple;
	bh=7uhu8AgyjCqNJieLW58RwsLsRUYo+5UaAKxnt5Tr1lc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YyS3dzF7At3oKjC8LsPKhCmsSQn5JeuIj1GpGKd5u9wQyIe1QE4/cadw4jW6kwKyV9M7oSsJHMjUO5QlwVVKzcnJygW384wd+cbAThpSZIuYNt0Y3fND+iXPYs6MKsps0HhUIOfB8ksT6IKUI7jQgj4e1kqFxuIiUhZmG7OPQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gHUSZgAB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+W6uHsjz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN1MJbTxGq4mndlGROJemxUlMYnLy/f+MkE2aehMbEs=;
	b=gHUSZgABuFucNCMRgxj5OJ7m3PEjo7i37xE/Y2PP2yrw6Y+bI1eDl4mcQFigfR2n7Ju/35
	6jza9u8pMiO65jbJ6VhDI1trtGijSOvolfwhfCYNNJtpM6ANjRKYqxmqeRSAqstnynODL+
	9WNh/xDzjGo3HOnEy3C487fpsoMW8epZS6YqZsLoup7e/m1rn0uEYwl0LVQOSSgiBSKFBG
	w/lXzKtsNjrEsMKAcsn7eThjhBFRd8cCceYZQ/IZhi06pRIz+4sgZjrX8oOyRf3Jaowwzd
	yGaM4EEEu0Fhlr8Byq8uK4shjSgPrp85cdN0UxsiG+ZItPeHBfLSumbmNZemyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN1MJbTxGq4mndlGROJemxUlMYnLy/f+MkE2aehMbEs=;
	b=+W6uHsjzsFwM0HjKi9NVA+ZGiT/bp1iRJlQfZcpzvQeumqAkfofho5u6S8tooW7wo0IfjM
	z/d+jQgvqR9tTpBg==
From: "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: fix warning in sched_setaffinity
Cc: Josh Don <joshdon@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241111182738.1832953-1-joshdon@google.com>
References: <20241111182738.1832953-1-joshdon@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313809112.412.7405751950608912833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     70ee7947a29029736a1a06c73a48ff37674a851b
Gitweb:        https://git.kernel.org/tip/70ee7947a29029736a1a06c73a48ff37674a851b
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Mon, 11 Nov 2024 10:27:38 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:27 +01:00

sched: fix warning in sched_setaffinity

Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
a WARN when a per-task affinity assignment races with a cpuset update.

Specifically, we can have a race where a cpuset update results in the
task affinity no longer being a subset of the cpuset. That's fine; we
have a fallback to instead use the cpuset mask. However, we have a WARN
set up that will trigger if the cpuset mask has no overlap at all with
the requested task affinity. This shouldn't be a warning condition; its
trivial to create this condition.

Reproduced the warning by the following setup:

- $PID inside a cpuset cgroup
- another thread repeatedly switching the cpuset cpus from 1-2 to just 1
- another thread repeatedly setting the $PID affinity (via taskset) to 2

Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
Signed-off-by: Josh Don <joshdon@google.com>
Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://lkml.kernel.org/r/20241111182738.1832953-1-joshdon@google.com
---
 kernel/sched/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0d71fcb..ff0e5ab 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1200,7 +1200,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 			bool empty = !cpumask_and(new_mask, new_mask,
 						  ctx->user_mask);
 
-			if (WARN_ON_ONCE(empty))
+			if (empty)
 				cpumask_copy(new_mask, cpus_allowed);
 		}
 		__set_cpus_allowed_ptr(p, ctx);

