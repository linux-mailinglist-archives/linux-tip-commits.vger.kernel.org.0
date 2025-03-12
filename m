Return-Path: <linux-tip-commits+bounces-4128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5FA5D9FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BE81886661
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B523F37B;
	Wed, 12 Mar 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sN6D1HfI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZhjtTYys"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686823DE8F;
	Wed, 12 Mar 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773288; cv=none; b=kR3lUY3vO+3ljRxxQ2iUt3Iv1pWZp3iJk8U955y7UR9p2UYpkhSTZh6SipWL4aJpd9S/W5PjBmaEzcrdB0LVvmvvVa4i8plnGFLALPu4KBmFpXYqV0V14cbl592DSWFh+/VXDzeN6iCc7XBjThd5+O+UgeqXwjw/5Yj6fYQYb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773288; c=relaxed/simple;
	bh=IMoHA4TS15ryvP7hBNmYMJe+7c+DgtJJ+y/haPdc6UQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XzNrblVNxdaT3KCDRACjrFOBpsVX/jVDGBNEOvrPtKSGgYpIxYPhVFaBnaDp/4lcWzHHlspSUjxDRKVAKH3Z/wUdHydSzdTC6MeoB63E/DlWORJC1juW0VyG1SmZzMitn5VP44Mar/F5lBGaieGzi1AA/2BAqxRFPLvZwoiibrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sN6D1HfI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZhjtTYys; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 09:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741773284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxe9a2tzWaqzTUCrlLtA5Er4Vh+Zs27ix9zpSVf76Pc=;
	b=sN6D1HfIWk7XuLdai2as3mdcsrYYy3zRyg9tp3oJQdD1Yb4Vbt07GU1bjNY3s5nHBjbSGh
	BMAugvVGu/9vYNgC4aV8Qv4gKJgsrgDxtPtWXMqhDp9UL+5fncOsWhy9mRt97CJmvyvmd3
	JUokf+U9g8bfgEAFr7GnPF1mfNCh/K9PAZGfSiPN5QMRE3bUAK9Xvx4+fmAdnN2ToGsEPe
	qZUB5oa5aOJrJ8CeE6ad8XgknY/TA9MCWtC8xeKyrCoTtvbwSo6Frq4vK2vLudnQGcQjXj
	UFEQtSs0ara+D5iiF65aHOhVx9ljknIK9mVEHJRAP8pwcoz6aQll37pwCjQMFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741773284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxe9a2tzWaqzTUCrlLtA5Er4Vh+Zs27ix9zpSVf76Pc=;
	b=ZhjtTYysfqi706gOyavwufvYysXz+KvhIQDBhEsR9qQfDH01Kb7km0m85uJJHVs207+lKf
	O1DdwEIqwG5zJNDw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Update x86_match_cpu() to also use cpu-type
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-4-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-4-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174177328352.14745.7472981549949801956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3fc9260bff702ea9d12cabce04c6e3620f7e1335
Gitweb:        https://git.kernel.org/tip/3fc9260bff702ea9d12cabce04c6e3620f7e1335
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:52 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Mar 2025 20:53:30 +01:00

x86/cpu: Update x86_match_cpu() to also use cpu-type

Non-hybrid CPU variants that share the same Family/Model could be
differentiated by their cpu-type. x86_match_cpu() currently does not use
cpu-type for CPU matching.

Dave Hansen suggested to use below conditions to match CPU-type:

  1. If CPU_TYPE_ANY (the wildcard), then matched
  2. If hybrid, then matched
  3. If !hybrid, look at the boot CPU and compare the cpu-type to determine
     if it is a match.

  This special case for hybrid systems allows more compact vulnerability
  list.  Imagine that "Haswell" CPUs might or might not be hybrid and that
  only Atom cores are vulnerable to Meltdown.  That means there are three
  possibilities:

  	1. P-core only
  	2. Atom only
  	3. Atom + P-core (aka. hybrid)

  One might be tempted to code up the vulnerability list like this:

  	MATCH(     HASWELL, X86_FEATURE_HYBRID, MELTDOWN)
  	MATCH_TYPE(HASWELL, ATOM,               MELTDOWN)

  Logically, this matches #2 and #3. But that's a little silly. You would
  only ask for the "ATOM" match in cases where there *WERE* hybrid cores in
  play. You shouldn't have to _also_ ask for hybrid cores explicitly.

  In short, assume that processors that enumerate Hybrid==1 have a
  vulnerable core type.

Update x86_match_cpu() to also match cpu-type. Also treat hybrid systems as
special, and match them to any cpu-type.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-4-e8514dcaaff2@linux.intel.com
---
 arch/x86/kernel/cpu/match.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 4f3c654..6af1e8b 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -6,6 +6,34 @@
 #include <linux/slab.h>
 
 /**
+ * x86_match_vendor_cpu_type - helper function to match the hardware defined
+ *                             cpu-type for a single entry in the x86_cpu_id
+ *                             table. Note, this function does not match the
+ *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
+ *                             TOPO_CPU_TYPE_PERFORMANCE.
+ * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
+ * @m: Pointer to the x86_cpu_id entry to match against.
+ *
+ * Return: true if the cpu-type matches, false otherwise.
+ */
+static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
+{
+	if (m->type == X86_CPU_TYPE_ANY)
+		return true;
+
+	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return true;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return m->type == c->topo.intel_type;
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		return m->type == c->topo.amd_type;
+
+	return false;
+}
+
+/**
  * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
  *         {}.
@@ -50,6 +78,8 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
+		if (!x86_match_vendor_cpu_type(c, m))
+			continue;
 		return m;
 	}
 	return NULL;

