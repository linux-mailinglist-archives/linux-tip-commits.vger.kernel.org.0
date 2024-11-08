Return-Path: <linux-tip-commits+bounces-2830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738559C22E4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Nov 2024 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B11F21401
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Nov 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F81199E88;
	Fri,  8 Nov 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cI1seGLH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eprBAiul"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D165198A17;
	Fri,  8 Nov 2024 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086723; cv=none; b=cKBrihvXVZatfxezTgA0tD7kcxFbTDn9zR4kr6CJLkMN5AJS8W7TXleXWqD5WmLeI89Y1k5VrfGFJRlFYdzcu9Wns9XE8aka/awJ6Er+5RkFUyefY0QRXfeRRIRJPeCdlaCcPTu39HdWawcea0ermQTMVM9W4zXTU292upduc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086723; c=relaxed/simple;
	bh=yjkhTloaj5xBbPU720ourmFkp+SdQwSIuS5jc1v/IOM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Gr33dM3vWMwy1KTzYvtcPZ1M1pmiGjqBzHzoBhOjhjj/zd/WWIwGOK9bzJ0RyJ4mzF3SDsN8pjdrw75obwbJsjGaATGMdX0ndizm8dpmVkRkW5LgPDrhDk7NB4vpzhqfMUWnmXUY6eR8XsaNMxiNtJgkQme72adaiyI+r+AyPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cI1seGLH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eprBAiul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 08 Nov 2024 17:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731086719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mm//0lU9z4+PEHZ0bqZdYFhwhkp101ccMzBRZO6feJk=;
	b=cI1seGLHflxUcR7zH4DnIK4X4FNTjSqHa4z4DO8lMYndwsFX86tRs9+6e5EvZJmeQJQ1Ys
	UsS6pt4wJ2E9JA0W5VLocAsYAJCJODN9IdBiHhevWqWupFukkMKgltWU0K07nuWaJzikKF
	xG/l6XYaac8dZz7a05iYtJ5BfvAEUp8RpTBDv6n/BQ65L3S2Wa4eWY6jXsYYStsDCDiGH9
	lpRIjIUG2mtQ79EISukoUK0Z9dh4Y8m2yg55+NZmAV7HKiNh+n1vmJSmjfMRN+Ezr/yibN
	IY9oqmjTGckUyorVoRXqYuOKRlUZkzkdGOjrVhcDQYDDAe7k2fjEYnrhiKV8Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731086719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mm//0lU9z4+PEHZ0bqZdYFhwhkp101ccMzBRZO6feJk=;
	b=eprBAiulOoRvN292K2H23bPD7jGyL4fRBaFEUq8a1tso+vT08GPJT88mCLxzRcbzr/BznR
	j5qZYFVUSe7YZBAw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/cpu: Make sure flag_is_changeable_p() is always
 being used
Cc: Dave Hansen <dave.hansen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173108671848.32228.1588073946582041076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     62e724494db7954c47b4417769f1225cf98f4d77
Gitweb:        https://git.kernel.org/tip/62e724494db7954c47b4417769f1225cf98f4d77
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 08 Nov 2024 17:30:10 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Nov 2024 09:08:48 -08:00

x86/cpu: Make sure flag_is_changeable_p() is always being used

When flag_is_changeable_p() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
  351 | static inline int flag_is_changeable_p(u32 flag)
      |                   ^~~~~~~~~~~~~~~~~~~~

Fix this by moving core around to make sure flag_is_changeable_p() is
always being used.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

While at it, fix the argument type to be unsigned long along with
the local variables, although it currently only runs in 32-bit cases.
Besides that, makes it return boolean instead of int. This induces
the change of the returning type of have_cpuid_p() to be boolean
as well.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/all/20241108153105.1578186-1-andriy.shevchenko%40linux.intel.com
---
 arch/x86/include/asm/cpuid.h |  8 ++++---
 arch/x86/kernel/cpu/common.c | 39 ++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index ca42433..239b9ba 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <linux/types.h>
+
 #include <asm/string.h>
 
 struct cpuid_regs {
@@ -20,11 +22,11 @@ enum cpuid_regs_idx {
 };
 
 #ifdef CONFIG_X86_32
-extern int have_cpuid_p(void);
+bool have_cpuid_p(void);
 #else
-static inline int have_cpuid_p(void)
+static inline bool have_cpuid_p(void)
 {
-	return 1;
+	return true;
 }
 #endif
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 07a34d7..e09ffde 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -275,21 +275,13 @@ static int __init x86_noinvpcid_setup(char *s)
 }
 early_param("noinvpcid", x86_noinvpcid_setup);
 
-#ifdef CONFIG_X86_32
-static int cachesize_override = -1;
-static int disable_x86_serial_nr = 1;
-
-static int __init cachesize_setup(char *str)
-{
-	get_option(&str, &cachesize_override);
-	return 1;
-}
-__setup("cachesize=", cachesize_setup);
-
 /* Standard macro to see if a specific flag is changeable */
-static inline int flag_is_changeable_p(u32 flag)
+static inline bool flag_is_changeable_p(unsigned long flag)
 {
-	u32 f1, f2;
+	unsigned long f1, f2;
+
+	if (!IS_ENABLED(CONFIG_X86_32))
+		return true;
 
 	/*
 	 * Cyrix and IDT cpus allow disabling of CPUID
@@ -312,11 +304,22 @@ static inline int flag_is_changeable_p(u32 flag)
 		      : "=&r" (f1), "=&r" (f2)
 		      : "ir" (flag));
 
-	return ((f1^f2) & flag) != 0;
+	return (f1 ^ f2) & flag;
 }
 
+#ifdef CONFIG_X86_32
+static int cachesize_override = -1;
+static int disable_x86_serial_nr = 1;
+
+static int __init cachesize_setup(char *str)
+{
+	get_option(&str, &cachesize_override);
+	return 1;
+}
+__setup("cachesize=", cachesize_setup);
+
 /* Probe for the CPUID instruction */
-int have_cpuid_p(void)
+bool have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -348,10 +351,6 @@ static int __init x86_serial_nr_setup(char *s)
 }
 __setup("serialnumber", x86_serial_nr_setup);
 #else
-static inline int flag_is_changeable_p(u32 flag)
-{
-	return 1;
-}
 static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 }
@@ -1087,7 +1086,6 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_32
 	int i;
 
 	/*
@@ -1108,7 +1106,6 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 				break;
 			}
 		}
-#endif
 }
 
 #define NO_SPECULATION		BIT(0)

