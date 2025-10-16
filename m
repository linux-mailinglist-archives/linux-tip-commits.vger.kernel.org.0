Return-Path: <linux-tip-commits+bounces-6960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B280ABE59CD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 23:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04194F1FD1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43582E6CC6;
	Thu, 16 Oct 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qne9M73N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMLM1yYI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E22E6127;
	Thu, 16 Oct 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651603; cv=none; b=pKBhPa3CvDArD3ZSJi87j9BX4aBGCFS9dTNlo61TKVbdNdIS72mdgrbpCFKGvZPlsqRWu+x+RO17EOm2tY9HuYIVt5oc7eUsVLx5sQBuDua05lkNvYnSrlrh0eRRjOKqz+S15p/DNBSS7/winHh/CIUNuVHpGOjcx1i6WuxqJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651603; c=relaxed/simple;
	bh=+KZkhtsms5DdSVkIh9v4b89eFv6V857Q+JeL2DpOREs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d6kfQentp25ylyxINBwOUcA8+p/fLmBZ6LsWW6Nvn6EDWC1hly1Nrae6ZXAeVB/00ajVYWiTb3QiE2+09JIRJ/vtlPutT1AP0jerYV6UAgc/H131BEjY+xOZW/RbwG98f6PFJ+K249kjkGSTSiJ1Y4jLSFdIiepE9O/9kw+9n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qne9M73N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMLM1yYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:53:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760651600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Niz/F+ul7GJR+2jrpKP3RVUqznqiB5dL0zTu+xbPai4=;
	b=qne9M73NUIEzlRAvFobY62YKzk0zXZMIVt8Uq2nWCNfGr4O1Jj1N7pdaLUpR6TzAnpDvPZ
	i1Sp5e5SMxwaOqUlvblK9nBMVzf0BDL4UvpzUxOF2MjmHFm1UR6ADfUPukhOIqkPSDtAFz
	luVPOai7aNKZi8fO3L0IUM4a01e75zeMHvnHvvOer88TOxO3rQDQAtP9G3YQuD/itVZxVl
	5giky9EzAJPOrU1J9T56uSm3RkCFzpZCZC2hduxXVZg6sMzRiFcKJeA2JfoaH/cMJM1lCx
	PM+jRKFwVGXoC7M5JBjOqrNUkTwkXM2PukrBEkc6L9GjIA2zR9Jdyv94Z4KAiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760651600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Niz/F+ul7GJR+2jrpKP3RVUqznqiB5dL0zTu+xbPai4=;
	b=VMLM1yYISOx4uMG7HrjK93hidCMaSWIgo7ncHwX9eJPUKXjyANeX4KdOmiVuVi7hF7L8Aa
	iFUbexu9djzAEFCg==
From: "tip-bot2 for Elena Reshetova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sgx] x86/cpufeatures: Add X86_FEATURE_SGX_EUPDATESVN feature flag
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 Nataliia Bondarevska <bondarn@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016131314.17153-3-elena.reshetova@intel.com>
References: <20251016131314.17153-3-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176065159861.709179.13171067458385458125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     6ffdb49101f023136a9a1fb0deb59eba73c306a3
Gitweb:        https://git.kernel.org/tip/6ffdb49101f023136a9a1fb0deb59eba73c=
306a3
Author:        Elena Reshetova <elena.reshetova@intel.com>
AuthorDate:    Thu, 16 Oct 2025 16:11:05 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Oct 2025 14:42:08 -07:00

x86/cpufeatures: Add X86_FEATURE_SGX_EUPDATESVN feature flag

Add a flag indicating whenever ENCLS[EUPDATESVN] SGX instruction is
supported. This will be used by SGX driver to perform CPU SVN updates.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Nataliia Bondarevska <bondarn@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 4091a77..76364b6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -499,6 +499,7 @@
 #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-user=
space, see VMSCAPE bug */
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Coun=
ters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
+#define X86_FEATURE_SGX_EUPDATESVN	(21*32+17) /* Support for ENCLS[EUPDATESV=
N] instruction */
=20
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index 46efcbd..3d9f49a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -79,6 +79,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_SGX_EUPDATESVN,		X86_FEATURE_SGX1      },
 	{ X86_FEATURE_SGX_EDECCSSA,		X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index caa4dc8..3785035 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -43,6 +43,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_PER_THREAD_MBA,		CPUID_ECX,  0, 0x00000010, 3 },
 	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
+	{ X86_FEATURE_SGX_EUPDATESVN,		CPUID_EAX, 10, 0x00000012, 0 },
 	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
 	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },

