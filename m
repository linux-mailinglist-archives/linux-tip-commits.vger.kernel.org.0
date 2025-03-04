Return-Path: <linux-tip-commits+bounces-3903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B2A4DA82
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C93B2B99
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29697203705;
	Tue,  4 Mar 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ss6T7YLo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="35Cmbrtx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFE202C4E;
	Tue,  4 Mar 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083988; cv=none; b=ZoQLfCFyV/BH0Hs+zd1n7dLxdEdLssxvYsweJ7G96AcAfpVNG8p38p55jO5kajCWzoUkNVYZZyAO+Gk3UZ7/trYKBjlq/AVsnnQL2XT9YS8wvadFVhIhh1JfCuGHkJuJNZT2u/tIZnvWB7AUwnHO7I+M0xPxWkhUG0QM36ua/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083988; c=relaxed/simple;
	bh=oaMXmza/S/e2NlSrRfqIpiHghrdHp0vwtpUDs01fRUc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z3sPu0KxVEv5+sFl2mjUhL2+IlMH+lt418BwRXnskWKibURdwvTC0AMQR02H6W9l4MN3Af2LILEbdibCyt8KaUbBIQO5VTjSAbpCiE2si6Vu933SzE3Nk1iNfpow+MnFmMWWnhwYVPSoQ3COEFtpV5mVbu3RqQl0tS7VRCmrT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ss6T7YLo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=35Cmbrtx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cUBYGAmH/C+oHdP7UTfMB63dVFM39Id/pOh7jiW2Nw=;
	b=Ss6T7YLoLwpfYbCQnJYJCJvRHFGQFwCyGp7mIA5UwB3hEidsQcPd8xO7akJSOZe+v85BaQ
	mXL2f61UdcTrsJ/y4XNIZJcFgdOCULMa0niRx2NMJ5KC+A3SViJhJQKRemDfC2i+EHKYcA
	kIIkCgWAN5y0bzGL/7eeTC7UFHLK/7XPIWgzBUy3q1FvAl9e2yrGZ6fhakeVLdnGVgxsc5
	O8hL7XWoTtVeKGmRjqcXgyGdnGYKc+Y2SKXiY5RLoNn7v+SWz2Vs5ZWj0RwMbFMRrh1A/4
	ZVTLqOl5JS8ZwJeZwd6iFFy7O+WHgdiR7iZBTN2Q946fvsnVY9mve+4TmVbUPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cUBYGAmH/C+oHdP7UTfMB63dVFM39Id/pOh7jiW2Nw=;
	b=35CmbrtxYcWNFZXJkm/1WVfehRyecqOMn6NsOiXHMXF4GE7LvUw12j+kBna6t8GtL4h7Jw
	bVtnso6pme8EUbBw==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove unnecessary macro indirection related
 to CPU feature names
Cc: Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com>
References: <20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398359.14745.15032929904688026341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     27c3b452c1a554483ac692702639c826602d1089
Gitweb:        https://git.kernel.org/tip/27c3b452c1a554483ac692702639c826602d1089
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Mon, 03 Mar 2025 15:45:37 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:14:53 +01:00

x86/cpu: Remove unnecessary macro indirection related to CPU feature names

These macros used to abstract over CONFIG_X86_FEATURE_NAMES, but that
was removed in:

  7583e8fbdc49 ("x86/cpu: Remove X86_FEATURE_NAMES")

Now they are just an unnecessary indirection, remove them.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com
---
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/common.c      | 12 ++++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index e5fc003..e955da3 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -37,13 +37,8 @@ enum cpuid_leafs
 	NR_CPUID_WORDS,
 };
 
-#define X86_CAP_FMT_NUM "%d:%d"
-#define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
-
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
-#define X86_CAP_FMT "%s"
-#define x86_cap_flag(flag) x86_cap_flags[flag]
 
 /*
  * In order to save room, we index into this array by doing
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f32b6f..b5fdaa6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -667,8 +667,8 @@ static void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
 		if (!warn)
 			continue;
 
-		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
-			x86_cap_flag(df->feature), df->level);
+		pr_warn("CPU: CPU feature %s disabled, no CPUID level 0x%x\n",
+			x86_cap_flags[df->feature], df->level);
 	}
 }
 
@@ -1502,9 +1502,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+					pr_cont(" %d:%d", bit >> 5, bit & 31);
 				else
-					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+					pr_cont(" %s", x86_cap_flags[bit]);
 
 				if (set)
 					setup_force_cpu_cap(bit);
@@ -1523,9 +1523,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			const char *flag;
 
 			if (bit < 32 * NCAPINTS)
-				flag = x86_cap_flag(bit);
+				flag = x86_cap_flags[bit];
 			else
-				flag = x86_bug_flag(bit - (32 * NCAPINTS));
+				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
 
 			if (!flag)
 				continue;

