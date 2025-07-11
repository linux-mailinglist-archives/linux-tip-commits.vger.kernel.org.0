Return-Path: <linux-tip-commits+bounces-6094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F65B02169
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB55C5A73
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C452F3627;
	Fri, 11 Jul 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHskx6Rr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOHUZ3wP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD102F4318;
	Fri, 11 Jul 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250189; cv=none; b=MBXT9p+IcITwrOpig8wsKmmxqEp4Nm3x6jMg+AEOxh2IMjEe7J6EasWAt5trziUuEk3g5AdfXxXFcb8nJJiVUEd7m8c0TKZwKOUXJ80xAq588S5PP+whieDm+mDtRZa7y+g5irN17Vh4JPD/W70py4CsePMbNEcU4M8dgwoaxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250189; c=relaxed/simple;
	bh=rPOPR0yKXE9xbGPqiVduitj1FEaBbn6n3Hp2ZuQfJOg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f8xTKQpsSbcNJ2JcJxyP8aOW0O6AGuaG+HzbAvJYjNiOlgiurTAF9/RMLwv2yLf8r14oLAmPxBuoSXWth/LzGsk/l+QDlCmg+LMkI4Zpz92YMeaBk91FA5GtnrIiYdzRuGKGFaHGmNAsSLBBePqDm2PJFBOLyeu5R76lq4+0uMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHskx6Rr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WOHUZ3wP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpyGLVWKG00MgiHt6W/i1zLogZu4GaPoVy1jW2kOj+0=;
	b=kHskx6RryeSznPOtIscVk+Q9VyjalTONOJegwG8knxv2tJ/rHpqjo+LSe9Sedd4w5nxSUZ
	xAjL66w+WvB256Cc+3sp4b4bHgQoY0Rx9yv6wdhTEMB8X3/kjxL53wi8gGCfoWfobAeAxt
	tfnpeYGE0E/xS29OnPL43aUGSkCgalg/qxf99A7+BXMhQxaXEI0G41ALoAXUqnY8EGbG0h
	Iqv/eDkUkYK73vgvUSV36k3EtmM2qjeCZZCnLUpyjpR3mSlsVBjflXuiZSuarBkWSzS/fO
	ToNcNQRAJgu+vla4ZPAh1eTqucYfwLZRzKwsKt2lQYkv/zqq+gYAena8NUqXvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpyGLVWKG00MgiHt6W/i1zLogZu4GaPoVy1jW2kOj+0=;
	b=WOHUZ3wPoy5xby0fkhImYljGlkbcFqxxMDVcZUmDFo1DTKWFl5wX8a3WLlwGtxifqUTJcQ
	bNrZ48kSI+nns+CA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] cpu: Define attack vectors
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-3-david.kaplan@amd.com>
References: <20250707183316.1349127-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018556.406.8134883552273629280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     19c24f7ee39af503b9731067b91add627b70ecb6
Gitweb:        https://git.kernel.org/tip/19c24f7ee39af503b9731067b91add627b70ecb6
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:32:57 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:55:16 +02:00

cpu: Define attack vectors

Define 4 new attack vectors that are used for controlling CPU speculation
mitigations.  These may be individually disabled as part of the
mitigations= command line.  Attack vector controls are combined with global
options like 'auto' or 'auto,nosmt' like 'mitigations=auto,no_user_kernel'.
The global options come first in the mitigations= string.

Cross-thread mitigations can either remain enabled fully, including
potentially disabling SMT ('auto,nosmt'), remain enabled except for
disabling SMT ('auto'), or entirely disabled through the new
'no_cross_thread' attack vector option.

The default settings for these attack vectors are consistent with existing
kernel defaults, other than the automatic disabling of VM-based attack
vectors if KVM support is not present.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-3-david.kaplan@amd.com
---
 include/linux/cpu.h |  21 +++++++-
 kernel/cpu.c        | 130 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 140 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6378370..1fb143e 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -198,9 +198,25 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+enum cpu_attack_vectors {
+	CPU_MITIGATE_USER_KERNEL,
+	CPU_MITIGATE_USER_USER,
+	CPU_MITIGATE_GUEST_HOST,
+	CPU_MITIGATE_GUEST_GUEST,
+	NR_CPU_ATTACK_VECTORS,
+};
+
+enum smt_mitigations {
+	SMT_MITIGATIONS_OFF,
+	SMT_MITIGATIONS_AUTO,
+	SMT_MITIGATIONS_ON,
+};
+
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+extern bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v);
+extern enum smt_mitigations smt_mitigations;
 #else
 static inline bool cpu_mitigations_off(void)
 {
@@ -210,6 +226,11 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 {
 	return false;
 }
+static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
+{
+	return false;
+}
+#define smt_mitigations SMT_MITIGATIONS_OFF
 #endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59e009..faf0f23 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/cpuset.h>
 #include <linux/random.h>
 #include <linux/cc_platform.h>
+#include <linux/parser.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3174,8 +3175,38 @@ void __init boot_cpu_hotplug_init(void)
 
 #ifdef CONFIG_CPU_MITIGATIONS
 /*
- * These are used for a global "mitigations=" cmdline option for toggling
- * optional CPU mitigations.
+ * All except the cross-thread attack vector are mitigated by default.
+ * Cross-thread mitigation often requires disabling SMT which is expensive
+ * so cross-thread mitigations are only partially enabled by default.
+ *
+ * Guest-to-Host and Guest-to-Guest vectors are only needed if KVM support is
+ * present.
+ */
+static bool attack_vectors[NR_CPU_ATTACK_VECTORS] __ro_after_init = {
+	[CPU_MITIGATE_USER_KERNEL] = true,
+	[CPU_MITIGATE_USER_USER] = true,
+	[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM),
+	[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM),
+};
+
+bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
+{
+	if (v < NR_CPU_ATTACK_VECTORS)
+		return attack_vectors[v];
+
+	WARN_ONCE(1, "Invalid attack vector %d\n", v);
+	return false;
+}
+
+/*
+ * There are 3 global options, 'off', 'auto', 'auto,nosmt'. These may optionally
+ * be combined with attack-vector disables which follow them.
+ *
+ * Examples:
+ *   mitigations=auto,no_user_kernel,no_user_user,no_cross_thread
+ *   mitigations=auto,nosmt,no_guest_host,no_guest_guest
+ *
+ * mitigations=off is equivalent to disabling all attack vectors.
  */
 enum cpu_mitigations {
 	CPU_MITIGATIONS_OFF,
@@ -3183,19 +3214,96 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
+enum {
+	NO_USER_KERNEL,
+	NO_USER_USER,
+	NO_GUEST_HOST,
+	NO_GUEST_GUEST,
+	NO_CROSS_THREAD,
+	NR_VECTOR_PARAMS,
+};
+
+enum smt_mitigations smt_mitigations __ro_after_init = SMT_MITIGATIONS_AUTO;
 static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
+static const match_table_t global_mitigations = {
+	{ CPU_MITIGATIONS_AUTO_NOSMT,	"auto,nosmt"},
+	{ CPU_MITIGATIONS_AUTO,		"auto"},
+	{ CPU_MITIGATIONS_OFF,		"off"},
+};
+
+static const match_table_t vector_mitigations = {
+	{ NO_USER_KERNEL,	"no_user_kernel"},
+	{ NO_USER_USER,		"no_user_user"},
+	{ NO_GUEST_HOST,	"no_guest_host"},
+	{ NO_GUEST_GUEST,	"no_guest_guest"},
+	{ NO_CROSS_THREAD,	"no_cross_thread"},
+	{ NR_VECTOR_PARAMS,	NULL},
+};
+
+static int __init mitigations_parse_global_opt(char *arg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(global_mitigations); i++) {
+		const char *pattern = global_mitigations[i].pattern;
+
+		if (!strncmp(arg, pattern, strlen(pattern))) {
+			cpu_mitigations = global_mitigations[i].token;
+			return strlen(pattern);
+		}
+	}
+
+	return 0;
+}
+
 static int __init mitigations_parse_cmdline(char *arg)
 {
-	if (!strcmp(arg, "off"))
-		cpu_mitigations = CPU_MITIGATIONS_OFF;
-	else if (!strcmp(arg, "auto"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO;
-	else if (!strcmp(arg, "auto,nosmt"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
-	else
-		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
-			arg);
+	char *s, *p;
+	int len;
+
+	len = mitigations_parse_global_opt(arg);
+
+	if (cpu_mitigations_off()) {
+		memset(attack_vectors, 0, sizeof(attack_vectors));
+		smt_mitigations = SMT_MITIGATIONS_OFF;
+	} else if (cpu_mitigations_auto_nosmt()) {
+		smt_mitigations = SMT_MITIGATIONS_ON;
+	}
+
+	p = arg + len;
+
+	if (!*p)
+		return 0;
+
+	/* Attack vector controls may come after the ',' */
+	if (*p++ != ',' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",	arg);
+		return 0;
+	}
+
+	while ((s = strsep(&p, ",")) != NULL) {
+		switch (match_token(s, vector_mitigations, NULL)) {
+		case NO_USER_KERNEL:
+			attack_vectors[CPU_MITIGATE_USER_KERNEL] = false;
+			break;
+		case NO_USER_USER:
+			attack_vectors[CPU_MITIGATE_USER_USER] = false;
+			break;
+		case NO_GUEST_HOST:
+			attack_vectors[CPU_MITIGATE_GUEST_HOST] = false;
+			break;
+		case NO_GUEST_GUEST:
+			attack_vectors[CPU_MITIGATE_GUEST_GUEST] = false;
+			break;
+		case NO_CROSS_THREAD:
+			smt_mitigations = SMT_MITIGATIONS_OFF;
+			break;
+		default:
+			pr_crit("Unsupported mitigations options %s\n",	s);
+			return 0;
+		}
+	}
 
 	return 0;
 }

