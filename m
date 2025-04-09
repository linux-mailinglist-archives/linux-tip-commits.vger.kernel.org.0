Return-Path: <linux-tip-commits+bounces-4793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCB7A82437
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FE94C41AF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964525E838;
	Wed,  9 Apr 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYGxWCao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yxt+dh9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102525E825;
	Wed,  9 Apr 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200302; cv=none; b=rrOP6Hx8yqFeHS80bhVgkAM3uVpIp3UMwwZ6LHwE3tblvubFFhc10y2uLK12bBpRSXjw6gw2w4vVBcoA/lcTMkrTYBWnsxrs0zQhpXe+FwF0AMU7NMAHv7hULg4ji1X1PtYpKmflgkQ8PCf+ikRSxQQRLFBvWlCi8McXz/s8eH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200302; c=relaxed/simple;
	bh=GlZwCY4BAgacwhTavkIs9jTWFfuHo5KprQF5+BHZN7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F+5aKz90LWtzbbGINET+QH8b/2KPjOFDOmr/5/Jk/it2a2GgZ2vJUlfZug0rjm/P4+fh5Y6W+j9T3CtEkG1bIL/MsFt7/f+9qk4JBCjVd7LsYGoobPGh/JaLjZvnbXu91a/9XILtfsm9x3PNLZwMNvCgd9xMpCCVvvS9q+i/xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYGxWCao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yxt+dh9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 12:04:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744200297;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtR6S8RUveQuXCe3grfrCeco9UkmctVrebUu0e0Y/s=;
	b=iYGxWCaoyzyWXWSgqh5TpdrQjHjpwybBpTgbTwJuqgyK8cP2jukGZGOHwCYCm8oV6E/2DZ
	aHkGB/xDP8EId7j3aCq+HSH6SutUiTQPD7r8ASL/cVYHrDwLnNLLDmWYU1+1lFzckyn1yI
	VhP+/pgVyA5GXIv0tO8vIvPvvf7WrzmLDTwccoqthXc/x80s3sC5s4MBtthh3sLJ+ukFlW
	f+clpKw/R6hZxk84O3pf14R4OgrReft3JyXPCsRTl6LtERbtJYNN+g3ViMmBpJqAd7KnxU
	E21qZ52Z5KPTGDfbCOtsDqJQ4v7Nb02zzqhetxYaKCIUsuIbUmKjhmQXpCRusA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744200297;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBtR6S8RUveQuXCe3grfrCeco9UkmctVrebUu0e0Y/s=;
	b=Yxt+dh9wXqJ7V2bpMLdDpCJNc9pVBPTBzoVzr5nAdAN9y1y7AnkwECvDT+h4Wkeuy+FS0e
	7UiP/YXt7Jxx6vAA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/x86: Zap the subsection letters
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409111435.GEZ_ZWmz3_lkP8S9Lb@fat_crate.local>
References: <20250409111435.GEZ_ZWmz3_lkP8S9Lb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174420029649.31282.6766699753807343972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     254a6d14c9c952e8eae0fafd4fed3778721b948e
Gitweb:        https://git.kernel.org/tip/254a6d14c9c952e8eae0fafd4fed3778721b948e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 09 Apr 2025 13:14:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 13:56:52 +02:00

Documentation/x86: Zap the subsection letters

The subsections already have numbering - no need for the letters too.

Zap the latter.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250409111435.GEZ_ZWmz3_lkP8S9Lb@fat_crate.local
---
 Documentation/arch/x86/cpuinfo.rst | 51 ++++++++++++++++-------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 7114f34..f80e2a5 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -79,8 +79,9 @@ feature flags.
 How are feature flags created?
 ==============================
 
-a: Feature flags can be derived from the contents of CPUID leaves.
-------------------------------------------------------------------
+Feature flags can be derived from the contents of CPUID leaves
+--------------------------------------------------------------
+
 These feature definitions are organized mirroring the layout of CPUID
 leaves and grouped in words with offsets as mapped in enum cpuid_leafs
 in cpufeatures.h (see arch/x86/include/asm/cpufeatures.h for details).
@@ -89,8 +90,9 @@ cpufeatures.h, and if it is detected at run time, the flags will be
 displayed accordingly in /proc/cpuinfo. For example, the flag "avx2"
 comes from X86_FEATURE_AVX2 in cpufeatures.h.
 
-b: Flags can be from scattered CPUID-based features.
-----------------------------------------------------
+Flags can be from scattered CPUID-based features
+------------------------------------------------
+
 Hardware features enumerated in sparsely populated CPUID leaves get
 software-defined values. Still, CPUID needs to be queried to determine
 if a given feature is present. This is done in init_scattered_cpuid_features().
@@ -104,8 +106,9 @@ has only one feature and would waste 31 bits of space in the x86_capability[]
 array. Since there is a struct cpuinfo_x86 for each possible CPU, the wasted
 memory is not trivial.
 
-c: Flags can be created synthetically under certain conditions for hardware features.
--------------------------------------------------------------------------------------
+Flags can be created synthetically under certain conditions for hardware features
+---------------------------------------------------------------------------------
+
 Examples of conditions include whether certain features are present in
 MSR_IA32_CORE_CAPS or specific CPU models are identified. If the needed
 conditions are met, the features are enabled by the set_cpu_cap or
@@ -114,8 +117,8 @@ the feature X86_FEATURE_SPLIT_LOCK_DETECT will be enabled and
 "split_lock_detect" will be displayed. The flag "ring3mwait" will be
 displayed only when running on INTEL_XEON_PHI_[KNL|KNM] processors.
 
-d: Flags can represent purely software features.
-------------------------------------------------
+Flags can represent purely software features
+--------------------------------------------
 These flags do not represent hardware features. Instead, they represent a
 software feature implemented in the kernel. For example, Kernel Page Table
 Isolation is purely software feature and its feature flag X86_FEATURE_PTI is
@@ -130,8 +133,8 @@ x86_cap/bug_flags[] arrays in kernel/cpu/capflags.c. The names in the
 resulting x86_cap/bug_flags[] are used to populate /proc/cpuinfo. The naming
 of flags in the x86_cap/bug_flags[] are as follows:
 
-a: Flags do not appear by default in /proc/cpuinfo
---------------------------------------------------
+Flags do not appear by default in /proc/cpuinfo
+-----------------------------------------------
 
 Feature flags are omitted by default from /proc/cpuinfo as it does not make
 sense for the feature to be exposed to userspace in most cases. For example,
@@ -139,8 +142,8 @@ X86_FEATURE_ALWAYS is defined in cpufeatures.h but that flag is an internal
 kernel feature used in the alternative runtime patching functionality. So the
 flag does not appear in /proc/cpuinfo.
 
-b: Specify a flag name if absolutely needed
--------------------------------------------
+Specify a flag name if absolutely needed
+----------------------------------------
 
 If the comment on the line for the #define X86_FEATURE_* starts with a
 double-quote character (""), the string inside the double-quote characters
@@ -155,25 +158,28 @@ shall override the new naming with the name already used in /proc/cpuinfo.
 Flags are missing when one or more of these happen
 ==================================================
 
-a: The hardware does not enumerate support for it.
---------------------------------------------------
+The hardware does not enumerate support for it
+----------------------------------------------
+
 For example, when a new kernel is running on old hardware or the feature is
 not enabled by boot firmware. Even if the hardware is new, there might be a
 problem enabling the feature at run time, the flag will not be displayed.
 
-b: The kernel does not know about the flag.
--------------------------------------------
+The kernel does not know about the flag
+---------------------------------------
+
 For example, when an old kernel is running on new hardware.
 
-c: The kernel disabled support for it at compile-time.
-------------------------------------------------------
+The kernel disabled support for it at compile-time
+--------------------------------------------------
+
 For example, if 5-level-paging is not enabled when building (i.e.,
 CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
 Even though the feature will still be detected via CPUID, the kernel disables
 it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
 
-d: The feature is disabled at boot-time.
-----------------------------------------
+The feature is disabled at boot-time
+------------------------------------
 A feature can be disabled either using a command-line parameter or because
 it failed to be enabled. The command-line parameter clearcpuid= can be used
 to disable features using the feature number as defined in
@@ -186,8 +192,9 @@ disable specific features. The list of parameters includes, but is not limited
 to, nofsgsbase, nosgx, noxsave, etc. 5-level paging can also be disabled using
 "no5lvl".
 
-e: The feature was known to be non-functional.
-----------------------------------------------
+The feature was known to be non-functional
+------------------------------------------
+
 The feature was known to be non-functional because a dependency was
 missing at runtime. For example, AVX flags will not show up if XSAVE feature
 is disabled since they depend on XSAVE feature. Another example would be broken

