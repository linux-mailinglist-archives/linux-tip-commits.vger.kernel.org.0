Return-Path: <linux-tip-commits+bounces-7538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8EC88132
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11E1D340422
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A7313E0B;
	Wed, 26 Nov 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8tCDvww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAlc6rdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7A3128A9;
	Wed, 26 Nov 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131781; cv=none; b=MTdqAQxHs7fgWv0lHHxe78Y7lpFrSAhf/Vqi12HnBXm0V4trhdVLE5jpxHXCoPXQBgCl5IzOxGw4n7zwk3vvUR284Zas+zOsPyul1BY6FMO0kiLh0a+pO+YSKxJlXAqlfY8kFKJ1jAK8zhkPIX2ATATNDuAdrCT7fEV35fBlEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131781; c=relaxed/simple;
	bh=fnoDJXaDSOCeI7NPsxgouHx7Hs97To+mxSZHlmgHiDs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m5gGiPXxTWcOuM7GTB6pub0Olt1zyFzLx6egyI6V6XhEUj1o2SZ9ttfPh4DAeQH0SUdP3R3Flh7ZyAeuSs/JsVHQXa6KrTmMsQ7zgCeVN5k79pBmkBozt4BLZ+m+5OS1c/nyCyu5nbpuS8+IkBvLOjH2N48sojaera1XE2H05wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K8tCDvww; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAlc6rdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnz0md2X20d3tzGa0poevVtw1UzAg8qevBsY2fhfHew=;
	b=K8tCDvwwbmxX/dOb6vYAF18n4cqzdb7mLi2PyMKF9lcUgKjrvlNmooyXm5N9RoljMP4a3M
	F8hWdPSVFIDFjejC0oA49IOKLK2mACeUq8S1sIShQRFlF2t45WWinpWKKcvkT91cAqwwLn
	vimyXVQOy+LHIDFtJSCG/2VW1A6ctnZPDzckS4I2kLnpjBh1lK3+oPDqXC6po8CZz2AuGO
	F1E9A3g/IE91j0GyWPzPHK/2Mk8i1FJCbdNB0UWqzrxkmdCvsU6VqrElR7xQzn9yGpNPID
	DvdUG2KBWyuaS+KvGs1dXLgFfC60OzV2Q9eokfLBblAfqt8Ij2xUPSLy+EW9Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tnz0md2X20d3tzGa0poevVtw1UzAg8qevBsY2fhfHew=;
	b=LAlc6rdAF/Y6yNRFAhuP+Q9DjGVKGTHcV1trPB+FkyZisbMq/cQwjmkpr7Hhu+qXkh53+c
	NxepjWuCSb85JJAw==
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
Message-ID: <176413177658.498.8348323122345597622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     35a5c37cb9f1f947dff18e7cfc75a8cfcfd557ca
Gitweb:        https://git.kernel.org/tip/35a5c37cb9f1f947dff18e7cfc75a8cfcfd=
557ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:40 +01:00

cpumask: Cache num_possible_cpus()

Reevaluating num_possible_cpus() over and over does not make sense. That
becomes a constant after init as cpu_possible_mask is marked ro_after_init.

Cache the value during initialization and provide that for consumption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
index db9f6c5..b674fdf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3085,10 +3085,13 @@ EXPORT_SYMBOL(cpu_all_bits);
 #ifdef CONFIG_INIT_ALL_POSSIBLE
 struct cpumask __cpu_possible_mask __ro_after_init
 	=3D {CPU_BITS_ALL};
+unsigned int __num_possible_cpus __ro_after_init =3D NR_CPUS;
 #else
 struct cpumask __cpu_possible_mask __ro_after_init;
+unsigned int __num_possible_cpus __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+EXPORT_SYMBOL(__num_possible_cpus);
=20
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
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

