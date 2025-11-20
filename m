Return-Path: <linux-tip-commits+bounces-7417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66257C73AFD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14A73357EE8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C42332EC5;
	Thu, 20 Nov 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDyoG0PD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Hvt79MC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036843321AD;
	Thu, 20 Nov 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637605; cv=none; b=n8e0kb28QaiY77w4VjBTVB8nr3beQ74sxZZGQtZqhCmKubMOssB4cvCNPL1OUPXbmUudUkFgrpRBQL1KpNOPT0Bq3tANt2r6mBvOPZsDOIgPORRqBtL6TuywSBUuAKO8Qwjxx1ulZKJmHMjJmBMSJGhvqauDl/UOce0zjSO7cnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637605; c=relaxed/simple;
	bh=6lBAjh7AuktGmUqksiJlbwEgUO4C1kZsvpqshVdhMuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=McV7xAD3QbFUJmwTAfxD5oCiBRQ3M9zxV5q4Wix9BT2YpaiI9N+7iRPGctzNXVT7GutWY7qtYQ1WCwQI9xt+3LnkOAXUkR2ycsySXPKaO1Yit43vZVkAv3qUdyjjgd/K89cmyobvjERH0kNeAA6mWVsoIlJhtUV83ydd1H/dKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDyoG0PD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Hvt79MC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AryOvb6O48eK7guWMR8eCqQeFBzYNXyaeLlyCGV+cHE=;
	b=LDyoG0PD/xeK+ncBrVokn6h8VxFAHvJG+3ylt/V4sXCXNlQ6zkTG7LSGVtl3wdzv7J/ktm
	4ye7w4dbbOl8h8htYsgSlJVdzjPJTdJc3CZ9UAGlDh1p+l5EbKCOv60QkMIe3zmr8sl3YE
	ZeEbDzQhlqCdoOy2fYxe2PTl0LlW8oFfiuPbxX7W+ZRLEzFivD8HFrCr8gUZ1F+vzTminB
	RjUot/bqTwE9f7GYDVk08XdH+dSUd+qRCpFhp+UvDZ+VXPTXghCGaIffet5Lfyhe+8a04I
	4EKp0a3IS6W7dVwHcoPggCy0PYCKEKhti10WkDuIAAWNKpU/9pgcn2qi0lY2xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AryOvb6O48eK7guWMR8eCqQeFBzYNXyaeLlyCGV+cHE=;
	b=+Hvt79MCAaTqizsnrOqGuzBEEEc7aOX5jCFCIOTpOQYyYBs4Yv+BvUVK0ShHpwxzvfsNzg
	1SzEvR/ibOyUbuAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] cpumask: Cache num_possible_cpus()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yury Norov <yury.norov@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.578653738@linutronix.de>
References: <20251119172549.578653738@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760025.498.8053574440000863451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     d0f23ccf6ba9e2cc202e9ad25a427b8e5ea3ca1e
Gitweb:        https://git.kernel.org/tip/d0f23ccf6ba9e2cc202e9ad25a427b8e5ea=
3ca1e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:54 +01:00

cpumask: Cache num_possible_cpus()

Reevaluating num_possible_cpus() over and over does not make sense. That
becomes a constant after init as cpu_possible_mask is marked ro_after_init.

Cache the value during initialization and provide that for consumption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/20251119172549.578653738@linutronix.de
---
 include/linux/cpumask.h | 10 ++++++++--
 kernel/cpu.c            | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index feba06e..66694ee 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -126,6 +126,7 @@ extern struct cpumask __cpu_dying_mask;
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
=20
 extern atomic_t __num_online_cpus;
+extern unsigned int __num_possible_cpus;
=20
 extern cpumask_t cpus_booted_once_mask;
=20
@@ -1152,13 +1153,13 @@ void init_cpu_possible(const struct cpumask *src);
 #define __assign_cpu(cpu, mask, val)	\
 	__assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
=20
-#define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_ma=
sk, (possible))
 #define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask,=
 (enabled))
 #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask,=
 (present))
 #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (a=
ctive))
 #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dyin=
g))
=20
 void set_cpu_online(unsigned int cpu, bool online);
+void set_cpu_possible(unsigned int cpu, bool possible);
=20
 /**
  * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
@@ -1211,7 +1212,12 @@ static __always_inline unsigned int num_online_cpus(vo=
id)
 {
 	return raw_atomic_read(&__num_online_cpus);
 }
-#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+
+static __always_inline unsigned int num_possible_cpus(void)
+{
+	return __num_possible_cpus;
+}
+
 #define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c5..18e530d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3108,6 +3108,9 @@ EXPORT_SYMBOL(__cpu_dying_mask);
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
=20
+unsigned int __num_possible_cpus __ro_after_init =3D NR_CPUS;
+EXPORT_SYMBOL(__num_possible_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -3116,6 +3119,7 @@ void init_cpu_present(const struct cpumask *src)
 void init_cpu_possible(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_possible_mask, src);
+	__num_possible_cpus =3D cpumask_weight(&__cpu_possible_mask);
 }
=20
 void set_cpu_online(unsigned int cpu, bool online)
@@ -3140,6 +3144,21 @@ void set_cpu_online(unsigned int cpu, bool online)
 }
=20
 /*
+ * This should be marked __init, but there is a boatload of call sites
+ * which need to be fixed up to do so. Sigh...
+ */
+void set_cpu_possible(unsigned int cpu, bool possible)
+{
+	if (possible) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_possible_mask))
+			__num_possible_cpus++;
+	} else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_possible_mask))
+			__num_possible_cpus--;
+	}
+}
+
+/*
  * Activate the first processor.
  */
 void __init boot_cpu_init(void)

