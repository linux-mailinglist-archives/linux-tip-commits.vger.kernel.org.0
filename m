Return-Path: <linux-tip-commits+bounces-6785-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0035EBD59CF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92ECC4E1124
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346002BE041;
	Mon, 13 Oct 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lagWQaI3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEg1ODKb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542CA2989B7;
	Mon, 13 Oct 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378184; cv=none; b=LlFNlvyIVsLszd7ZLftlKsUCvOAJamIwcyJdWcCqBNxYYKm0ePKPr2KdJBi5cl4iXD4r1jIveZGgrUFbXJT9JDjaROBucptnJi7e0ElzViK/lMs2zy9XAaPwE6BS+NjPVETESgeNk/148XuVCwPgG8Ezhred6W44sWtNGZf3lvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378184; c=relaxed/simple;
	bh=+RyweEbu366Yl+PW5klppAukJrKQmFVKInMeADdtRy4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=knskidJuz9ffwCM9V9qOZXkwYrkJq1Oq36xIwM5KTcwEqoTnrMoFdUTWm2RywsIyyBLQ6QTOoztuYnCIvgIapebzRAqnM+i82SpPJPyf3r+69y8s3Uj8YYjhq6huNhPvIJ/40AM2Ht0tXcB5NcEIYjw+cl6FMHn2Yt69dTzhgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lagWQaI3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEg1ODKb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 17:56:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760378180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCYn106dWklNW2u1UQRqpok5lYa89dY1DqdwRQbCV0o=;
	b=lagWQaI3o65aRwF6+4jR8ey/JDJ/p2bjV4NV6FwzBSgFSnILrWZZruMCyJq5XGTY8ELAz/
	7xwZxFV2W/pnivkEp38FpT2QCKrx8kXOKhOmntlVZNwBzCGQCAiT0ILeNze8hbA8wU/aw0
	re9ZA4rRdJzZ7mh9umQdDqhd/SUH0PvW9u8NCO5uZAEqmr+S2KC0erxvNae0Fgjj68LVsc
	/xRRAYWA/PZCPg2aSl+LpxyT4FmHV4LRSO8mA3ZiJ/rbZ0roBe9PF+Xlw7xPXrP0Uel6hB
	zS1jQzNXOx6DYkyWMz0ttJtFGqIqS4bNYjptaNgCswRD/rssfdrB6xEWCU2Zrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760378180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCYn106dWklNW2u1UQRqpok5lYa89dY1DqdwRQbCV0o=;
	b=hEg1ODKbCQdoSCgbAuJts3yyU/8di3SZzW4iizb8paGCuecoIlJhP5xTAWxO/X8vFO2dXk
	tTAhEvJshedkpPCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Make X86_FEATURE leaf 17 Linux-specific
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924125935.15070-1-bp@kernel.org>
References: <20250924125935.15070-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176037817477.709179.14851049218444304175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ddde4abaa0ecc8395e0fcfa3e92f65d481890cc8
Gitweb:        https://git.kernel.org/tip/ddde4abaa0ecc8395e0fcfa3e92f65d4818=
90cc8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 24 Sep 2025 14:59:35 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Oct 2025 16:21:25 +02:00

x86/cpufeatures: Make X86_FEATURE leaf 17 Linux-specific

That cpuinfo_x86.x86_capability[] element was supposed to mirror CPUID flags
from CPUID_0x80000007_EBX but that leaf has still to this day only three bits
defined in it. So move those bits to scattered.c and free the capability
element for synthetic flags.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeature.h        | 2 +-
 arch/x86/include/asm/cpufeatures.h       | 5 ++++-
 arch/x86/kernel/cpu/common.c             | 8 ++------
 arch/x86/kernel/cpu/scattered.c          | 3 +++
 arch/x86/kvm/reverse_cpuid.h             | 1 -
 tools/arch/x86/include/asm/cpufeatures.h | 5 ++++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeat=
ure.h
index 893cbca..96acb66 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -30,7 +30,7 @@ enum cpuid_leafs
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
 	CPUID_7_ECX,
-	CPUID_8000_0007_EBX,
+	CPUID_LNX_6,
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 4091a77..80b68f4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instru=
ctions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions=
 Launch Control */
=20
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overfl=
ow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error conta=
inment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512..3ff9682 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1021,12 +1021,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_0001_EDX] =3D edx;
 	}
=20
-	if (c->extended_cpuid_level >=3D 0x80000007) {
-		cpuid(0x80000007, &eax, &ebx, &ecx, &edx);
-
-		c->x86_capability[CPUID_8000_0007_EBX] =3D ebx;
-		c->x86_power =3D edx;
-	}
+	if (c->extended_cpuid_level >=3D 0x80000007)
+		c->x86_power =3D cpuid_edx(0x80000007);
=20
 	if (c->extended_cpuid_level >=3D 0x80000008) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index caa4dc8..271f548 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -44,6 +44,9 @@ static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
 	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
+	{ X86_FEATURE_OVERFLOW_RECOV,		CPUID_EBX,  0, 0x80000007, 0 },
+	{ X86_FEATURE_SUCCOR,			CPUID_EBX,  1, 0x80000007, 0 },
+	{ X86_FEATURE_SMCA,			CPUID_EBX,  3, 0x80000007, 0 },
 	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 743ab25..81b4a7a 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -78,7 +78,6 @@ static const struct cpuid_reg reverse_cpuid[] =3D {
 	[CPUID_6_EAX]         =3D {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] =3D {0x8000000a, 0, CPUID_EDX},
 	[CPUID_7_ECX]         =3D {         7, 0, CPUID_ECX},
-	[CPUID_8000_0007_EBX] =3D {0x80000007, 0, CPUID_EBX},
 	[CPUID_7_EDX]         =3D {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       =3D {         7, 1, CPUID_EAX},
 	[CPUID_12_EAX]        =3D {0x00000012, 0, CPUID_EAX},
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/includ=
e/asm/cpufeatures.h
index 06fc047..bd655e1 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instru=
ctions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions=
 Launch Control */
=20
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overfl=
ow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error conta=
inment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */

