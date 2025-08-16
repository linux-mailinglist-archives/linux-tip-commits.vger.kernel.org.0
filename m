Return-Path: <linux-tip-commits+bounces-6257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18166B290B4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Aug 2025 23:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2E43B0363
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Aug 2025 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A91A2367D3;
	Sat, 16 Aug 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eoTBWzfV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zsikptlg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67557139D0A;
	Sat, 16 Aug 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755381563; cv=none; b=rRnLO6Yp2vYioMKeXXja6PR2otJXF4wQF0IP9CykeZEl9jAsSXYlmLsQlM0rqclCspy1cGTf4UR3+mPYDXca/lbWutMZjPSPgdwTxD7gqasoXZxzcdPeWwy/UUzFZ4Y1Arl9jtu7XyYv8SvT4pDLm5DwiSZd5KYZ0J8fvBvux+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755381563; c=relaxed/simple;
	bh=sp6qsAYWHkqbUXfuAEBq5k2O3MvUaYhOqpx5FqgDbto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eKND4yKg8jiUBf3kHqz2gq+6EbwRVt3uic6DJ1KSWVXxtuxPnJmMYF2r+T7E9XJfJ9qmK3DODjhuQ0R/Yrfpu4X7nWg/sgDFno024+EoPmm2MPe1lJt7c1rIE4xDnptbN69cGKPGu3Y8gUa9zcBxMJdwN/Ul+pvouTyMPMtYMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eoTBWzfV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zsikptlg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Aug 2025 21:59:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755381556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeIjZUEKVTBu3WrbFuYewoj+oBNuMUE4Bi0I0+/FyYg=;
	b=eoTBWzfVhjbOhFg2EI2lZNpVBV29C0sHF05ZuX7se8nXMwwvw+DW5dR3Inpyzng335kARA
	xw70hsu4pkGShWTmD/u7Btt41gasTgozQeaeiCAoP9OUf6SO8W/YYBn9BYOMSs3JRzIDbQ
	KoIVRs2lmsrzi7ZVjh3WoJlBwlWPzfwdlVIH5rDqdYGwxxntXwl4GXSDP58Lr5RUGCnchj
	20TsmqiWG3T16iBOg4F/IjT8jgA41zKzqEkK7qzqIKXco/8Hi/y6tWpMgfdBw2Jro3QxeN
	Bj6aR2zswoYxi3oP1eRZ2or4xyV86RKG66VDQbxZnEmkUfUO2Wz5m5gcbD158g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755381556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeIjZUEKVTBu3WrbFuYewoj+oBNuMUE4Bi0I0+/FyYg=;
	b=Zsikptlgj2EaSykb2DbsV5cmLJUhzdMuxRe80r2UhCQm3b/YlxI55iNd8DfO4l8/T4q8HY
	NaY7VY2pWJsfQgCw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/build: Remove cc-option from stack alignment flags
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-2-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-2-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175538155305.1420.8670527495780945494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     d87208128a3330c0eab18301ab39bdb419647730
Gitweb:        https://git.kernel.org/tip/d87208128a3330c0eab18301ab39bdb4196=
47730
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:38 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 22:59:19 +02:00

x86/build: Remove cc-option from stack alignment flags

'-mpreferred-stack-boundary' (the GCC option) and '-mstack-alignment'
(the clang option) have been supported in their respective compilers for
some time, so it is unnecessary to check for support for them via
cc-option. '-mpreferred-stack-boundary=3D3' had a restriction on
'-mno-sse' until GCC 7.1 but that is irrelevant for most of the kernel,
which includes '-mno-sse'.

Move to simple Kconfig checks to avoid querying the compiler for the
flags that it supports.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-2-ff7f19457523=
@kernel.org
---
 arch/x86/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index ed56573..f0aa58d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -37,10 +37,11 @@ export RETPOLINE_VDSO_CFLAGS
=20
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
-ifneq ($(call cc-option, -mpreferred-stack-boundary=3D4),)
+ifdef CONFIG_CC_IS_GCC
       cc_stack_align4 :=3D -mpreferred-stack-boundary=3D2
       cc_stack_align8 :=3D -mpreferred-stack-boundary=3D3
-else ifneq ($(call cc-option, -mstack-alignment=3D16),)
+endif
+ifdef CONFIG_CC_IS_CLANG
       cc_stack_align4 :=3D -mstack-alignment=3D4
       cc_stack_align8 :=3D -mstack-alignment=3D8
 endif

