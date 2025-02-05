Return-Path: <linux-tip-commits+bounces-3338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABDFA299B6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 20:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E440B3A816C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822C1FF1DE;
	Wed,  5 Feb 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ev26W7p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtwKtvTw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085D944F;
	Wed,  5 Feb 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782456; cv=none; b=pI+a/Nubp0uTZGlVUiX4/BZjkifW/UezaGUd/xyS7tjdBE8EgW7TBGsvw+mCwJJKp0zkepBlU4Lj3+HGjXDRsfn2/92ko/CPC+rLh4OzN+nhcqDkDJTwM3b/IrYcVrsTCX88gablBHDO6XOMBjuuTsDOdMK57toRJHhCNrvFz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782456; c=relaxed/simple;
	bh=zKwhHoa80sT3I1TN7V5LVSiaPfH+Pw9Es/5isgm//DU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qIb8lAE+qyhpBxNLA6NF5dzcuVLKK8Oj56Kx8D8VgFa87E/y2wfu0Oj3qC9/ib0yWbmfb3FpwQFnGBxzUMvNQ9s7scGcOiAZkKtbkeAXksMgOLOjO7y9JPet/9p5xEeeoWU9FeDXLaLndOhmtMSPskQ7AvYyZPPa3aTTwD+3Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ev26W7p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtwKtvTw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 19:07:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g918dhRbuKVM8SXGK1T/gJkkX25CowjAZDc0xNidboc=;
	b=2Ev26W7pBzYEiVQwdStQ7gKLXFNT7+kmc5BmiIyAW+p/20o1AbDtAKhdvmKB4bQPu3RrXT
	fQozeWWIGq7NaMxmpRd4OSrSynatIzxWRE2uMrfNrLrVIkfKKHbDsslF2zC3dsM9HK1sWX
	4049D58jLG0pq7jJfPPpRZDsNkINflfxhTSOJXylEWHTe2KBj6+QE287lAViHp+Ljp+XJ3
	j8L1hmZTj5IpozuuXmuIKNI28ba66p3PGtDMSQXCi6V58Al2wxfxHe8AgAx69ooveHF+3Y
	y9QKeiDnKOSbv+4jmLrd+126m4VgpbzOlHMXEpFNhp2bwkY9xeCmqi8K+wbMjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g918dhRbuKVM8SXGK1T/gJkkX25CowjAZDc0xNidboc=;
	b=FtwKtvTwobZ18cWj7cQzYdIBfQm8u1QLeaL/dkXAYFpgvzDKfs7H1UHC850xF1oYIlM3Wi
	9VaYeRLYnSFJu2DA==
From: "tip-bot2 for Patryk Wlazlyn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/smp: Eliminate mwait_play_dead_cpuid_hint()
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173878244859.10177.11042481523316633025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     96040f7273e2bc0be1871ad9ed4da7b504da9410
Gitweb:        https://git.kernel.org/tip/96040f7273e2bc0be1871ad9ed4da7b504da9410
Author:        Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
AuthorDate:    Wed, 05 Feb 2025 17:52:11 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 05 Feb 2025 10:44:52 -08:00

x86/smp: Eliminate mwait_play_dead_cpuid_hint()

Currently, mwait_play_dead_cpuid_hint() looks up the MWAIT hint of the
deepest idle state by inspecting CPUID leaf 0x5 with the assumption
that, if the number of sub-states for a given major C-state is nonzero,
those sub-states are always represented by consecutive numbers starting
from 0. This assumption is not based on the documented platform behavior
and in fact it is not met on recent Intel platforms.

For example, Intel's Sierra Forest report two C-states with two
substates each in cpuid leaf 0x5:

  Name*   target cstate    target subcstate (mwait hint)
  ===========================================================
  C1      0x00             0x00
  C1E     0x00             0x01

  --      0x10             ----

  C6S     0x20             0x22
  C6P     0x20             0x23

  --      0x30             ----

  /* No more (sub)states all the way down to the end. */
  ===========================================================

   * Names of the cstates are not included in the CPUID leaf 0x5,
     they are taken from the product specific documentation.

Notice that hints 0x20 and 0x21 are not defined for C-state 0x20
(C6), so the existing MWAIT hint lookup in
mwait_play_dead_cpuid_hint() based on the CPUID leaf 0x5 contents does
not work in this case.

Instead of using MWAIT hint lookup that is not guaranteed to work,
make native_play_dead() rely on the idle driver for the given platform
to put CPUs going offline into appropriate idle state and, if that
fails, fall back to hlt_play_dead().

Accordingly, drop mwait_play_dead_cpuid_hint() altogether and make
native_play_dead() call cpuidle_play_dead() instead of it
unconditionally with the assumption that it will not return if it is
successful. Still, in case cpuidle_play_dead() fails, call
hlt_play_dead() at the end.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20250205155211.329780-5-artem.bityutskiy%40linux.intel.com
---
 arch/x86/kernel/smpboot.c | 54 ++++----------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8aad14e..5746084 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1258,6 +1258,10 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1304,50 +1308,6 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
 }
 
 /*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead_cpuid_hint(void)
-{
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
-	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
-	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
-
-	eax = CPUID_LEAF_MWAIT;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	/*
-	 * eax will be 0 if EDX enumeration is not valid.
-	 * Initialized below to cstate, sub_cstate value when EDX is valid.
-	 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
-		eax = 0;
-	} else {
-		edx >>= MWAIT_SUBSTATE_SIZE;
-		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-			if (edx & MWAIT_SUBSTATE_MASK) {
-				highest_cstate = i;
-				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-			}
-		}
-		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-			(highest_subcstate - 1);
-	}
-
-	mwait_play_dead(eax);
-}
-
-/*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
  */
@@ -1397,9 +1357,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead_cpuid_hint();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	/* Below returns only on error. */
+	cpuidle_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */

