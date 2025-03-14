Return-Path: <linux-tip-commits+bounces-4204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5AA60D65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABC73BB405
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D71E9B37;
	Fri, 14 Mar 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNiyGATv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVhdEdBT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA31DF757;
	Fri, 14 Mar 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944955; cv=none; b=iz+EpzR8VIveu7kGTYk/6OIqE0Z8Z0sWiNaFZxKPGJ9qKZVRcqG12uogYC6G6eEOaj0+Wws8pJq4yU8ZVSs7th4G58S7ZPLm113ejAYJZRC5Rp7+Ng3qo8dcFNeb+tdIxhsaSmXoScTnikPDVrzDUGNv11RutDsqp5i4dDugjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944955; c=relaxed/simple;
	bh=naBbdIrmrJbN2ufogs5meOjGLn+KcQCWvoXhIuC5RRk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uBDXGGkH+7FSFZgXrczRlZkZgA/VsFXD2PXa4OVgmZB0IXXObaeT9UsQWBmJNtJ+CO8Ds81vcaRGZJhZBfq2kx7dixJg4O2VmBWW0oT78jjMkFy2HzLnhh1ahTogKGYTp3Zw7ZP/LtGsdbUkHBW5RYJOQ6rjCkfqPiX4Bs13IOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNiyGATv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVhdEdBT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 09:35:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741944951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4o9jYahamIh4OtIDF+HZ2TgBxKOqjTD978dHaGWqxU=;
	b=GNiyGATvOV2WaEGxbUxk39MrMFvlf37/ylLRc5OZ8qPLFSfcI6V16XDA7dEgMSiNkjyoPV
	VPrP0WuJhJE6FzNUMFW+m5w1/6kMc1QZTfaUDRRxFGN0kWZ0yZPRSYn38kWg1NhO5DfpFX
	2M+/ddOWrtVeMPy/3c4oMJW4Bh9erIiLzH8a25QGkN2Az+r//nu3JTcv7R30/RaROo2zU3
	uK1FZZtD1aYg0L3tTxGPtNHQnIH9K66J88CZ8l/1OQqMi0w8jrQrJ70dLho1IxC9gp50uB
	gNachFP3oCx64tBp1PMb/yf4Jom9hYbwlNlLQVt4k9ssYKczUJDs1HJVuIyJ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741944951;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4o9jYahamIh4OtIDF+HZ2TgBxKOqjTD978dHaGWqxU=;
	b=uVhdEdBTUfoeWMKXJJx3UKM1t9Ia1bHeIq1pJB0VmCqvZWB8Prwyjw8htsXpdUBseXi24b
	0Yi0olSewuvBcHBQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Warn about unmet CPU feature dependencies
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313201608.3304135-1-sohil.mehta@intel.com>
References: <20250313201608.3304135-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194494332.14745.961297784048418864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     96effb260ce507ed884a145d304ea1295a67844c
Gitweb:        https://git.kernel.org/tip/96effb260ce507ed884a145d304ea1295a67844c
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 13 Mar 2025 20:16:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 10:19:44 +01:00

x86/cpufeatures: Warn about unmet CPU feature dependencies

Currently, the cpuid_deps[] table is only exercised when a particular
feature is explicitly disabled and clear_cpu_cap() is called. However,
some of these listed dependencies might already be missing during boot.

These types of errors shouldn't generally happen in production
environments, but they could sometimes sneak through, especially when
VMs and Kconfigs are in the mix. Also, the kernel might introduce
artificial dependencies between unrelated features, such as making LAM
depend on LASS.

Unexpected failures can occur when the kernel tries to use such
features. Add a simple boot-time scan of the cpuid_deps[] table to
detect the missing dependencies. One option is to disable all of such
features during boot, but that may cause regressions in existing
systems. For now, just warn about the missing dependencies to create
awareness.

As a trade-off between spamming the kernel log and keeping track of all
the features that have been warned about, only warn about the first
missing dependency. Any subsequent unmet dependency will only be logged
after the first one has been resolved.

Features are typically represented through unsigned integers within the
kernel, though some of them have user-friendly names if they are exposed
via /proc/cpuinfo.

Show the friendlier name if available, otherwise display the
X86_FEATURE_* numerals to make it easier to identify the feature.

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250313201608.3304135-1-sohil.mehta@intel.com
---
 arch/x86/include/asm/cpufeature.h |  1 +-
 arch/x86/kernel/cpu/common.c      |  4 +++-
 arch/x86/kernel/cpu/cpuid-deps.c  | 35 ++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 910601c..fe6994f 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -77,6 +77,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+void check_cpufeature_deps(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 92fe56c..411378d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1648,6 +1648,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		check_cpufeature_deps(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1908,6 +1909,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Check for unmet dependencies based on the CPUID dependency table */
+	check_cpufeature_deps(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index df838e3..a2fbea0 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -147,3 +147,38 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+/*
+ * Return the feature "name" if available, otherwise return
+ * the X86_FEATURE_* numerals to make it easier to identify
+ * the feature.
+ */
+static const char *x86_feature_name(unsigned int feature, char *buf)
+{
+	if (x86_cap_flags[feature])
+		return x86_cap_flags[feature];
+
+	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
+
+	return buf;
+}
+
+void check_cpufeature_deps(struct cpuinfo_x86 *c)
+{
+	char feature_buf[16], depends_buf[16];
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
+			/*
+			 * Only warn about the first unmet dependency on the
+			 * first CPU where it is encountered to avoid spamming
+			 * the kernel log.
+			 */
+			pr_warn_once("x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.\n",
+				     smp_processor_id(),
+				     x86_feature_name(d->feature, feature_buf),
+				     x86_feature_name(d->depends, depends_buf));
+		}
+	}
+}

