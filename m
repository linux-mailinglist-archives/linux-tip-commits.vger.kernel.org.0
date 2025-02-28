Return-Path: <linux-tip-commits+bounces-3731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4BA49703
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E762A1883969
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D9225D909;
	Fri, 28 Feb 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TYz3CHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XU2PVu7j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03E25DB0A;
	Fri, 28 Feb 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737936; cv=none; b=J0EvXWf+ahAb4+b8avU2gi6rBx5LwikvR1wwwKQd7GWWEHDlLVJe6PVmSlT47OnETIZZNYU2vKcl3Skd4qacHOVp8XWmpooI7nnGrFWSeTjP4zTpVLNolyzVSl81osnDlrwMEXCqhGldjZ4SJJPxLTKdjFCSKHms5kQWlvJdFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737936; c=relaxed/simple;
	bh=h5oR+UK+IF9s7jct0xLfzPSaVXMUfp4JhlUkjTrZgng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NNX2savK/EYUcIxn6zHfJzMNj+nPD257DGEwe3CJEGEL4vbD75Tuub6E2IpRQQFp49bZo/QQGe3usfyiLXdXvK0DLmJFpcBGUFazF9Syzr+gXkPbIPai+DWxDqC2Xsf/fkgy9sHwAtUCMybQE99Bgd6B3/g46o6sIKB58cdraEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TYz3CHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XU2PVu7j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:18:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740737933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Td20xOtlGWt2GXh9rt3aM23ulWnm3sPZmLCuqautPU=;
	b=1TYz3CHnSzsEOkquzilQOW2yceLv1SgAQcH/ItK23OFPcEv9qXShjFrnqirT8yE/yJpfNS
	fPj80ImbRMtIlDuZy8Rq1PKiQO5tfMBpYDITlhLqPC8yazs+c11+aZwcerz/k5YcH16Upj
	zJHXrh831gZ/6mJLwNhHKWQ17d0wpgPdNkomh4ut8A6AVDuO24iB61W9bJiYHrZ0rQ5d2E
	j14+DOsJ6QTb7pR1q9Oscu79/DE5UmgxcWMnEk4kARHA8EBJXkZ4AX2fLotXwn2/ALU52R
	nLQCw5xoR2y8VtnG1CvJzq8yaarS0rfLUs7BrVY/H/zCew8DBYSZyGc581oENQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740737933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Td20xOtlGWt2GXh9rt3aM23ulWnm3sPZmLCuqautPU=;
	b=XU2PVu7jw3NxpLQrietN30W25wZWrMvdWWTPKxBAlNmQ7r2XTWoFMNIiQEQ4qAYS5QiMwQ
	keFQDSbXA1CAt6Ag==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Enable modifying CPU bug flags with
 '{clear,set}puid='
Cc: Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220-force-cpu-bug-v2-3-7dc71bce742a@google.com>
References: <20241220-force-cpu-bug-v2-3-7dc71bce742a@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073793204.10177.9171183498085789285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ab68d2e36532806b8f86ff2f60861dbb8443f0be
Gitweb:        https://git.kernel.org/tip/ab68d2e36532806b8f86ff2f60861dbb8443f0be
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Fri, 20 Dec 2024 15:18:33 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 10:57:50 +01:00

x86/cpu: Enable modifying CPU bug flags with '{clear,set}puid='

Sometimes it can be very useful to run CPU vulnerability mitigations on
systems where they aren't known to mitigate any real-world
vulnerabilities. This can be handy for mundane reasons like debugging
HW-agnostic logic on whatever machine is to hand, but also for research
reasons: while some mitigations are focused on individual vulns and
uarches, others are fairly general, and it's strategically useful to
have an idea how they'd perform on systems where they aren't currently
needed.

As evidence for this being useful, a flag specifically for Retbleed was
added in:

  5c9a92dec323 ("x86/bugs: Add retbleed=force").

Since CPU bugs are tracked using the same basic mechanism as features,
and there are already parameters for manipulating them by hand, extend
that mechanism to support bug as well as capabilities.

With this patch and setcpuid=srso, a QEMU guest running on an Intel host
will boot with Safe-RET enabled.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241220-force-cpu-bug-v2-3-7dc71bce742a@google.com
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de1ad09..e5fc003 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -50,6 +50,7 @@ extern const char * const x86_power_flags[32];
  * X86_BUG_<name> - NCAPINTS*32.
  */
 extern const char * const x86_bug_flags[NBUGINTS*32];
+#define x86_bug_flag(flag) x86_bug_flags[flag]
 
 #define test_cpu_cap(c, bit)						\
 	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ff483c9..0f32b6f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1494,7 +1494,8 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 
 		/*
 		 * Handle naked numbers first for feature flags which don't
-		 * have names.
+		 * have names. It doesn't make sense for a bug not to have a
+		 * name so don't handle bug flags here.
 		 */
 		if (!kstrtouint(opt, 10, &bit)) {
 			if (bit < NCAPINTS * 32) {
@@ -1518,11 +1519,18 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			continue;
 		}
 
-		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
-			if (!x86_cap_flag(bit))
+		for (bit = 0; bit < 32 * (NCAPINTS + NBUGINTS); bit++) {
+			const char *flag;
+
+			if (bit < 32 * NCAPINTS)
+				flag = x86_cap_flag(bit);
+			else
+				flag = x86_bug_flag(bit - (32 * NCAPINTS));
+
+			if (!flag)
 				continue;
 
-			if (strcmp(x86_cap_flag(bit), opt))
+			if (strcmp(flag, opt))
 				continue;
 
 			pr_cont(" %s", opt);

