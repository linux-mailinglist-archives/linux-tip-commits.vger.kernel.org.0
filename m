Return-Path: <linux-tip-commits+bounces-6258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65856B290D8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 00:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54C3C4E05CC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Aug 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBBA155CBD;
	Sat, 16 Aug 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3XBB20o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDKP9Q9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769951EA7D2;
	Sat, 16 Aug 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755382239; cv=none; b=cau4csJobqVArlEe4ZC9yB7XkfsZtwZ9D+jxmCRDE90Dc3lvV2O8I1IGIG3gaVLPWufiYPKFlkP7txkBCM0Bhb2/VTWo5c8oiAEEIMplKeigFNGxR3d5yJvAWt1/cs90NYed2NWyEMRjCqElueWHyR/C+QzDD3mSPhkw/olD2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755382239; c=relaxed/simple;
	bh=D60tK3PSFAaROK8EB/iFgPklNEhy8qXrCKr3TDbz9vk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YEaw80egzwcAilxZ712WjrVQNhdpsMMCrEKlJ6OxfEsSdsY1DXaFGkb8vsBCMlZbV5Cl7lNZbqOEEviYEH3bhh9ctpLu7rgdFJxglNmKlfC6yEOoTAg9NOgQC0ZNFl4JaIJf+bTOETY1KqfJnRW4H3rgRfMAhqRyezz+rXF1Wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3XBB20o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDKP9Q9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Aug 2025 22:10:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbAx/TeFThcUNLQdxOEcqMB6acr8UQUPqc9/s5bRLQU=;
	b=N3XBB20oTaci3sNt4cF5yH/Eb7TfeSmkWUQLJ/8Mb3hlzzVN03iE7sqAguoKTmz39TnwD0
	XRhXv4hXXgdxqrWtBCGpN6I01p66uZhTxk3iEwqTRm7aB3qbyE/RbiK37UdoqhmeaD4C4E
	FYmM65lxDe32bM6djbPGuDPq87DWB+Ycuf67t02BhmMaT7fdT/SeIkXxdYIl2Is0czd9gS
	15W+PvqGBh19gf86zHbDQc3pfH52LkrSMC6U2LV1dhe5dr3nbfRRvJByaWqWPnfhDJBj7w
	Ji0h0fOOtgbzr9MXWUQjZNTQYKjBgGLU4uHEpkqlc2Tf4S6hAnl5epr5QmHuzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbAx/TeFThcUNLQdxOEcqMB6acr8UQUPqc9/s5bRLQU=;
	b=UDKP9Q9GfXzMrGZ5M4s0iQTK4mKVHr6N8M2rh224urjdcpnYVKeASAQrrA3pE5o+FcTRlK
	AriGRBgC1xL7uwCg==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/build: Clean up stack alignment flags in CC_FLAGS_FPU
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-3-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-3-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175538223259.1420.17881056973057324367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     487fe3a936b0b84ef09fa324b4c01d059886f951
Gitweb:        https://git.kernel.org/tip/487fe3a936b0b84ef09fa324b4c01d05988=
6f951
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:39 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 16 Aug 2025 23:50:16 +02:00

x86/build: Clean up stack alignment flags in CC_FLAGS_FPU

The minimum supported version of GCC to build the x86 kernel was bumped
to GCC 8.1 in

  a3e8fe814ad1 ("x86/build: Raise the minimum GCC version to 8.1").

Prior to GCC 7.1, '-mpreferred-stack-boundary=3D3' was not allowed with
'-msse', so areas of the kernel that needed floating point had a
different alignment. Now that GCC > 7.1 is mandatory, there is no need
to have a different value of '-mpreferred-stack-boundary' from the rest
of the kernel, so remove this handling from CC_FLAGS_FPU.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D34fac449e121be97dd0=
73c5428cc855367b2872c
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-3-ff7f19457523=
@kernel.org
---
 arch/x86/Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f0aa58d..0c82a61 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -84,19 +84,7 @@ KBUILD_RUSTFLAGS +=3D -Ctarget-feature=3D-sse,-sse2,-sse3,=
-ssse3,-sse4.1,-sse4.2,-av
 #
 CC_FLAGS_FPU :=3D -msse -msse2
 ifdef CONFIG_CC_IS_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundar=
y=3D3
-# (8B stack alignment).
-# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D53383
-#
-# The "-msse" in the first argument is there so that the
-# -mpreferred-stack-boundary=3D3 build error:
-#
-#  -mpreferred-stack-boundary=3D3 is not between 4 and 12
-#
-# can be triggered. Otherwise gcc doesn't complain.
 CC_FLAGS_FPU +=3D -mhard-float
-CC_FLAGS_FPU +=3D $(call cc-option,-msse -mpreferred-stack-boundary=3D3,-mpr=
eferred-stack-boundary=3D4)
 endif
=20
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)

