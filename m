Return-Path: <linux-tip-commits+bounces-4768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A78A81593
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C503B1937
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5052566DE;
	Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2emj2WOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ny7G0DoC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DC255E46;
	Tue,  8 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139139; cv=none; b=LNvDTw88+nK7RvqvndSC1btQqm4jR3UwxlcvcuNpIbVveVrlgnT22KvgR3j0/cAfX4mRqFvFpJaBMrnjk1u/EK0T2i2CVCN8sLjBXBkHhsgtjZEEhOGDR5JlRLInH0qM6wU3rtGwYpjYIMSDZIdseFD7Bhy0EO+Mlq9uY5kIchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139139; c=relaxed/simple;
	bh=4V/FJXlz9m+TRArp4odRVVw/03mugJsmMS1kWvqwLlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CE9N5a6GEoU4H3khmSI2w5hYN4w2fktBjieFQd8MklK5s8lcD5WzZhviy139rD45UBmha9iq9slYZmiywwuCkBI2Vi1MaFWMNoyRsTbC2vLLZ+/OflrqpO8LS1rfnfNHOmRlGRXNJUSIyd7Po2Sb9n0qGhHwgCNN3wn6R6guc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2emj2WOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ny7G0DoC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W0bkE13i0Pph0UQo0Fdl307S9NvKfmuvqFM6RYXgJA=;
	b=2emj2WOIjKaQfyzGIZi4n+2VZCbfjbWe1oGsr5bdn/2+UEtmjx6PjZPjFzhI54y3U/ww0G
	CQiA/HxKxhWBEmBnS+3Kfl4uP6mtg7AxBlnwwUgfGZbJP2+KXQNwDukgaVoSzi7TuZ5sWZ
	hc8RbjEOCSAw8maYjChVOAczj6beLC81KNv33pvmmnaXC/AqHMomjVOsYx1CFew5RUs5qx
	f6FUypYPBy/1TL3ljN9iY4DhbVUqcrsu+/D9SMs5BCo83GCqk8i5JCr3ML2ev2Y+dumCSR
	uTcb/d89wiKcbpE+P/Xp/yJLlKOnf54m235/0zNjZhCAYyxKumjc6ZzVc51JeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W0bkE13i0Pph0UQo0Fdl307S9NvKfmuvqFM6RYXgJA=;
	b=Ny7G0DoCgy/LxsKx+81zqM8gTwxaWQDkK9YTotPmXNBxZEazg7wx2Hv607vQYIOhAEskQx
	iabXiBLNPKGcWyDA==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Add commadline option for RT_GROUP_SCHED toggling
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-5-mkoutny@suse.com>
References: <20250310170442.504716-5-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913549.31282.14487045368820805817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e34e0131fea1b0f63c2105a1958c94af2ee90f4d
Gitweb:        https://git.kernel.org/tip/e34e0131fea1b0f63c2105a1958c94af2ee=
90f4d
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:53 +02:00

sched: Add commadline option for RT_GROUP_SCHED toggling

Only simple implementation with a static key wrapper, it will be wired
in later.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-5-mkoutny@suse.com
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++-
 init/Kconfig                                    | 11 +++++++-
 kernel/sched/core.c                             | 25 ++++++++++++++++-
 kernel/sched/sched.h                            | 17 +++++++++++-
 4 files changed, 58 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 3f35d5b..1682023 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6280,6 +6280,11 @@
 			Memory area to be used by remote processor image,
 			managed by CMA.
=20
+	rt_group_sched=3D	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
+			when CONFIG_RT_GROUP_SCHED=3Dy. Defaults to
+			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
+			Format: <bool>
+
 	rw		[KNL] Mount root device read-write on boot
=20
 	S		[KNL] Run init in single mode
diff --git a/init/Kconfig b/init/Kconfig
index 681f38e..b2c045c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1082,6 +1082,17 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
=20
+config RT_GROUP_SCHED_DEFAULT_DISABLED
+	bool "Require boot parameter to enable group scheduling for SCHED_RR/FIFO"
+	depends on RT_GROUP_SCHED
+	default n
+	help
+	  When set, the RT group scheduling is disabled by default. The option
+	  is in inverted form so that mere RT_GROUP_SCHED enables the group
+	  scheduling.
+
+	  Say N if unsure.
+
 config EXT_GROUP_SCHED
 	bool
 	depends on SCHED_CLASS_EXT && CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 042c978..58d093a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9892,6 +9892,31 @@ static struct cftype cpu_legacy_files[] =3D {
 	{ }	/* Terminate */
 };
=20
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
+DEFINE_STATIC_KEY_FALSE(rt_group_sched);
+# else
+DEFINE_STATIC_KEY_TRUE(rt_group_sched);
+# endif
+
+static int __init setup_rt_group_sched(char *str)
+{
+	long val;
+
+	if (kstrtol(str, 0, &val) || val < 0 || val > 1) {
+		pr_warn("Unable to set rt_group_sched\n");
+		return 1;
+	}
+	if (val)
+		static_branch_enable(&rt_group_sched);
+	else
+		static_branch_disable(&rt_group_sched);
+
+	return 1;
+}
+__setup("rt_group_sched=3D", setup_rt_group_sched);
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 static int cpu_extra_stat_show(struct seq_file *sf,
 			       struct cgroup_subsys_state *css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c006348..d1e591f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1500,6 +1500,23 @@ static inline bool sched_group_cookie_match(struct rq =
*rq,
 }
=20
 #endif /* !CONFIG_SCHED_CORE */
+#ifdef CONFIG_RT_GROUP_SCHED
+# ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
+DECLARE_STATIC_KEY_FALSE(rt_group_sched);
+static inline bool rt_group_sched_enabled(void)
+{
+	return static_branch_unlikely(&rt_group_sched);
+}
+# else
+DECLARE_STATIC_KEY_TRUE(rt_group_sched);
+static inline bool rt_group_sched_enabled(void)
+{
+	return static_branch_likely(&rt_group_sched);
+}
+# endif /* CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED */
+#else
+# define rt_group_sched_enabled()	false
+#endif /* CONFIG_RT_GROUP_SCHED */
=20
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {

