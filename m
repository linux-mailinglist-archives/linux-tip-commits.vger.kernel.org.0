Return-Path: <linux-tip-commits+bounces-4766-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC2A81590
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E2B3AC1E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19F2561B6;
	Tue,  8 Apr 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYgTvZnP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ucoFIVH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C04248887;
	Tue,  8 Apr 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139138; cv=none; b=YlubtwYjL6quYKhtHYafEkuabOwrtoyaR8raQzBryoKKCdPbpvNjWBfYlKezwCQk+JpyHSGNHJ2D3Jnlz77/PPpQvRHVC4yklyLrDhuHkTru7oIc4CgNbguoMW9HY/QnnMjI8+CLgdWjh0N7Nm35KLAqXRrBXqjBNfTA3ZCD4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139138; c=relaxed/simple;
	bh=XaGnCAQx+m7q1ew4UbekEz3p+ODel/i2gtrDe1K+BwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lkG3m7teuFzUBFICw+hoeX64CB8R89uvzcPHmxbRsKYdM3j02oZ1IHYwXOevuTs2XWGywgwqLsMCpcHA1i/DIIxeT/bQWWkCL/kEzppbDF/pmA3//JmPgN6FKQNsN2HuUaPOPuydRP6c0lqm5C8x0Xdth6i9QWs0uBWKDFOxu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYgTvZnP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ucoFIVH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMw6FSyL1fr8rYsC6iS8S3ONc4cljsZydt++Zt1keYE=;
	b=bYgTvZnPv2m2xNexlLjZ1hktWLj7a+Lui8lVi+TFLo+UwS0Sarn+jAGIfXLas7ASr++Y8T
	B+WHR/UVEuLW5GZdsBNImgIWiDwd7H2WAUsZW2paC6jRYdsAp4armh3yuF4LlYgXxZhRo5
	cXdF1NYYlGeq/pd/EZKrShhp0ddAZYQzZvQB2rhJ3zLtiYL6s4u9vA17RPgym5h3E6HWIY
	ENYfk+0uIQqsTmrkQWrOUPkLk5S2hmAlCT+MLgMYl2T0UHSUZkW2cPsagzw0u4k+wPpCaD
	qBihkSxcp8U1kdaDbZWjjV4KfdKIX/Oup8/wuc+Jt0HvBdPGdRQO7DP3ZmzQ1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMw6FSyL1fr8rYsC6iS8S3ONc4cljsZydt++Zt1keYE=;
	b=4ucoFIVHHc9PioP6xvmEgJ8Gjot59wXTQlnX1mjVNRgArlc9dQ+4YKm5X+zgQ+f2yQjwo4
	oVdbwa9blOg0meBA==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Bypass bandwitdh checks with runtime
 disabled RT_GROUP_SCHED
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-7-mkoutny@suse.com>
References: <20250310170442.504716-7-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913403.31282.877012853655382108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     277e0909754e9f3c82def97150d2f3ea700098f1
Gitweb:        https://git.kernel.org/tip/277e0909754e9f3c82def97150d2f3ea700=
098f1
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:54 +02:00

sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED

When RT_GROUPs are compiled but not exposed, their bandwidth cannot
be configured (and it is not initialized for non-root task_groups neither).
Therefore bypass any checks of task vs task_group bandwidth.

This will achieve behavior very similar to setups that have
!CONFIG_RT_GROUP_SCHED and attach cpu controller to cgroup v2 hierarchy.
(On a related note, this may allow having RT tasks with
CONFIG_RT_GROUP_SCHED and cgroup v2 hierarchy.)

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-7-mkoutny@suse.com
---
 kernel/sched/core.c     | 6 +++++-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/syscalls.c | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 32fb4c1..6900ce5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9206,11 +9206,15 @@ static int cpu_cgroup_can_attach(struct cgroup_taskse=
t *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
=20
+	if (!rt_group_sched_enabled())
+		goto scx_check;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-#endif
+scx_check:
+#endif /* CONFIG_RT_GROUP_SCHED */
 	return scx_cgroup_can_attach(tset);
 }
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index efa22ba..5e82bfe 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2864,7 +2864,7 @@ static int sched_rt_global_constraints(void)
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_task(tsk) && tg->rt_bandwidth.rt_runtime =3D=3D 0)
+	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime=
 =3D=3D 0)
 		return 0;
=20
 	return 1;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 2bf5281..547c1f0 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -634,7 +634,8 @@ change:
 		 * Do not allow real-time tasks into groups that have no runtime
 		 * assigned.
 		 */
-		if (rt_bandwidth_enabled() && rt_policy(policy) &&
+		if (rt_group_sched_enabled() &&
+				rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime =3D=3D 0 &&
 				!task_group_is_autogroup(task_group(p))) {
 			retval =3D -EPERM;

