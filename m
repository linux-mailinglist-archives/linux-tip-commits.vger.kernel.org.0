Return-Path: <linux-tip-commits+bounces-4372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD5A68AE3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DD0172661
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650725DB14;
	Wed, 19 Mar 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxkgQi5I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XczE4qKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1B25D542;
	Wed, 19 Mar 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382239; cv=none; b=jwauidmJZmxGCH4/7hINq6i2uKKuEdXvsFYIiYqUgfD4QXugKXcHb5Xte1giWwrEKKQkuJuaLU+YtkVFWiyB3dE86VpRQDTvCGJSv69Ke7NaO4E0n4Uf2E8Gt8Kz+v9YZftQYYxGvnpH4fNuQiHG4Hodu6t8yfWXcj7zwVc0bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382239; c=relaxed/simple;
	bh=8zM9JZ3MwM8RJ4J26JsZR+nYwHU6HsuOsM+O6qF0Cpg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XGOoIDEYd2TKXJD95k5ybJW2Ql66wtgYvNhl5UN2+xgxcLYO3W7Xenb/kgjEmENaFs2n1hlqf4T51RLnKiwHG5AvOfU/xyDoF8QnQsTQvjRphR5HR17Kftt/DpISaD8IZvfC0QOzkKLK0VewUCzYtj/dMBe38KXyXMDNWViiXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxkgQi5I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XczE4qKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB3Vp6Y14SqqJ2M/oIj+C2Uy7TMrCLolabFm+Ng0+Q0=;
	b=YxkgQi5I+OXon/5BHDY5AN80AhGKj5lVlIsDQUDXtigWF803NfaKPLWNUcacpN4mi6HaSh
	2zsaYBn4gogcYKdb6q1F5sm1NddMVKNaDjLQ1UKDfpLQ9N4Iay2+C5/btxHr8t1/5/iHsG
	oeOi0X8zyBuEsTVR8apTjxWsM7Resxwp3HUBikU3hLcPuq7ZBdNiWDlCLwTseRoSQUqJct
	d4330CKMlNsAjs9IqVc9FSwg3BtG81SincQDbPic3g06+562LivScEQTLLEnf03kx5pog8
	07tBI0nKTTGojgqTpS9Cvgm5qPl6GzCV4WGiL8yW+j1JliRfz+evVPQQcJlrwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB3Vp6Y14SqqJ2M/oIj+C2Uy7TMrCLolabFm+Ng0+Q0=;
	b=XczE4qKzTqGq14MJBftJTpGoVNYuWqs/S6TrLbnxwVfsYNA48d97I+nUVO2c0n563qRrhP
	l/LhsdK3CF8tihCw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cpufeatures: Warn about unmet CPU feature dependencies
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
Message-ID: <174238223498.14745.2305576761857200877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     07e4a6eec269912aa84817449f7a3a126b09671f
Gitweb:        https://git.kernel.org/tip/07e4a6eec269912aa84817449f7a3a126b09671f
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 13 Mar 2025 20:16:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:17:31 +01:00

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
index a2b9a79..7356516 100644
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

