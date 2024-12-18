Return-Path: <linux-tip-commits+bounces-3082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF679F5C01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 02:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3BC1698B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A016126F1E;
	Wed, 18 Dec 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLQqg8Zd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZUamBfD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367131F61C;
	Wed, 18 Dec 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483620; cv=none; b=BG5WUpId43Cf+O8QuMry+Q079pjwWitIer0oyuxLkli9EKx4WxtBvXYqZ3t2dzhWho32DKBhHd6GHIYpxKgQN+hLZCvlSiR1vstviAoouclwSXFbtlqWvPbX79YxGBbWVmHruCaoqiORj+lWoQXzhddnKL0p/NyyH+eHQLiJsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483620; c=relaxed/simple;
	bh=GNlZGUVyamCmZfNMnMZG2IjiQk+kG3Xf5rojB3KRUAQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aoJ80FJiXAkTss0fHnAK4Qw3E3eWtZUIkD7HCu57RdOiyi49TAw0h2HvzCIxF62FF7tFxHxpHWoK52ExGG7718bT3/tP+TosYJMDLUbR2dJMXzsqrxJ9w7kt1XwKe8Z/m0AV3fRFmvLpbHXrKUPtvQgEzPi843BsVyK4k9z3OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLQqg8Zd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZUamBfD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 01:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734483616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LAzdoTLsk6QLrrHDAEc0aEHTNJm6vfJJTigrgs18b8E=;
	b=vLQqg8ZdokhIrvyfTrUZ5YJlHCAw/8jHpBme+boz7cuMcSE8GMKrp0Hlh4nU7V8L9jDFKK
	C59NRyTu/yk9GlbevTHy8ZLiN3TbE4XjLxbUqI9C69vp6csUrmSqOA0zaMz0yYFRG/pCy4
	x1vvc6bpm3Bfxf3MZvhwbYJ+QXSAyLLlQ62Qhsqj0qlcyxweAQeIRg9XzA44NC0yW+3mKB
	cppoMdv4LuPZWs3uZdNTpn7HbMtON/kavIoBnxVKRGRNRy4MNG5N643V3BemMGjjK3ZwDW
	PPM2XrcHi2mZUifJhST2i4JIGbMCvMCJQypEfwxQbLN9ZM06pQM8HrZGjjQmkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734483616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LAzdoTLsk6QLrrHDAEc0aEHTNJm6vfJJTigrgs18b8E=;
	b=FZUamBfDloedJUCe8pQk+BwxWTSy/hmnMiBYaBPNUV4vLQR+esKuKZ2jKpJJsdZD4MGiFe
	f1yYHSJmKZf6vrCQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Expose only stepping min/max interface
Cc: Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173448361546.7135.12929211316404977661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     85b08180df07b9a5984b15ae31d76b904d42a115
Gitweb:        https://git.kernel.org/tip/85b08180df07b9a5984b15ae31d76b904d42a115
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 10:51:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Dec 2024 16:14:49 -08:00

x86/cpu: Expose only stepping min/max interface

The x86_match_cpu() infrastructure can match CPU steppings. Since
there are only 16 possible steppings, the matching infrastructure goes
all out and stores the stepping match as a bitmap. That means it can
match any possible steppings in a single list entry. Fun.

But it exposes this bitmap to each of the X86_MATCH_*() helpers when
none of them really need a bitmap. It makes up for this by exporting a
helper (X86_STEPPINGS()) which converts a contiguous stepping range
into the bitmap which every single user leverages.

Instead of a bitmap, have the main helper for this sort of thing
(X86_MATCH_VFM_STEPS()) just take a stepping range. This ends up
actually being even more compact than before.

Leave the helper in place (renamed to __X86_STEPPINGS()) to make it
more clear what is going on instead of just having a random GENMASK()
in the middle of an already complicated macro.

One oddity that I hit was this macro:

       X86_MATCH_VFM_STEPS(vfm, X86_STEPPING_MIN, max_stepping, issues)

It *could* have been converted over to take a min/max stepping value
for each entry. But that would have been a bit too verbose and would
prevent the one oddball in the list (INTEL_COMETLAKE_L stepping 0)
from sticking out.

Instead, just have it take a *maximum* stepping and imply that the match
is from 0=>max_stepping. This is functional for all the cases now and
also retains the nice property of having INTEL_COMETLAKE_L stepping 0
stick out like a sore thumb.

skx_cpuids[] is goofy. It uses the stepping match but encodes all
possible steppings. Just use a normal, non-stepping match helper.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213185129.65527B2A%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 15 ++---
 arch/x86/kernel/apic/apic.c          | 18 +++---
 arch/x86/kernel/cpu/common.c         | 78 +++++++++++++--------------
 drivers/edac/i10nm_base.c            | 21 +++----
 drivers/edac/skx_base.c              |  2 +-
 include/linux/mod_devicetable.h      |  2 +-
 6 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 9c77dbe..88564bb 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -56,7 +56,6 @@
 /* x86_cpu_id::flags */
 #define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
 
-#define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
@@ -208,6 +207,7 @@
 		VFM_MODEL(vfm),				\
 		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
+#define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
  * @vfm:	Encoded 8-bits each for vendor, family, model
@@ -218,12 +218,13 @@
  *
  * feature is set to wildcard
  */
-#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		steppings, X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(		\
+		VFM_VENDOR(vfm),				\
+		VFM_FAMILY(vfm),				\
+		VFM_MODEL(vfm),					\
+		__X86_STEPPINGS(min_step, max_step),		\
+		X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c5fb28e..b16bda1 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -509,19 +509,19 @@ static struct clock_event_device lapic_clockevent = {
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,   0x2, 0x2, 0x3a), /* EP */
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,   0x4, 0x4, 0x0f), /* EX */
 
 	X86_MATCH_VFM(INTEL_BROADWELL_X,	0x0b000020),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x2, 0x2, 0x00000011),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x3, 0x3, 0x0700000e),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x4, 0x4, 0x0f00000c),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x5, 0x5, 0x0e000003),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x3, 0x3, 0x01000136),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x4, 0x4, 0x02000014),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x5, 0xf, 0),
 
 	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
 	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5c2897..d21b352 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1201,8 +1201,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL(vendor, family, model, blacklist)	\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, blacklist)
 
-#define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)		   \
-	X86_MATCH_VFM_STEPPINGS(vfm, steppings, issues)
+#define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)		   \
+	X86_MATCH_VFM_STEPS(vfm, X86_STEP_MIN, max_stepping, issues)
 
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
@@ -1227,43 +1227,43 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_L,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_G,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_X,		X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GRACEMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_L,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_G,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_X,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_D,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_G,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_X,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS),
+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS),
+	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_D,     X86_STEP_MAX,	MMIO | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_L,     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT,      X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_D,    X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEP_MAX,	RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 51556c7..09bf5a3 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -938,16 +938,17 @@ static struct res_config gnr_cfg = {
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D, X86_STEP_MIN,		 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D,	   0x4,	X86_STEP_MAX, &i10nm_cfg1),
+	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,	  X86_STEP_MIN,		 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,		   0x4, X86_STEP_MAX, &i10nm_cfg1),
+	X86_MATCH_VFM(	    INTEL_ICELAKE_D,				      &i10nm_cfg1),
+
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, &spr_cfg),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,  &spr_cfg),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,  &gnr_cfg),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, &gnr_cfg),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,   &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 14cfd39..fed5ecb 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X, &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4338b1b..d67614f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -700,6 +700,8 @@ struct x86_cpu_id {
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
 #define X86_STEPPING_ANY 0
+#define X86_STEP_MIN 0
+#define X86_STEP_MAX 0xf
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 
 /*

