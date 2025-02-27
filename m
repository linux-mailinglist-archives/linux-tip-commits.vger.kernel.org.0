Return-Path: <linux-tip-commits+bounces-3707-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08BBA47A90
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE37B3B41D6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8222A4E4;
	Thu, 27 Feb 2025 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phvUj2tN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3H/MaFea"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EE22A4D1;
	Thu, 27 Feb 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652947; cv=none; b=H5IrQn+HQkprdiiafbJP5oAEFMI8cYNwCPcr0LpDuUtI159FSJP8CLrSajDT2birtb3YmESb/MuAwtFqfz1x3+Nc3DGqGqab0lNQNYSpcF0FPumbNCIRK/mc7OUHiYS1q+8DxPAhMG+Xqt4KofQSGZvDUFtdJyfd3EHoG/JVgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652947; c=relaxed/simple;
	bh=dalhrAXHBnIlqalGFUHzwivZCLS9GXzQfwLertdPcZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UWsCHwjU2Agz2V5o8ejY1oIjmux4Sws+de3CHGgSaiiS9nhheee3+Lzwig6a4cOqUh6PwbZ22septi0AWoGy6nsLxde1HKj/j6WDo0fQ2DoJ1tuyjLHEERXeWa7Ge9fpMKvU18dvzu66C7JJCAGvcfavc+bpnE/Gd5cdAjINzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=phvUj2tN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3H/MaFea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqS78blCopCtsWIZ8oaPaYcSBfzrcjYCmXJuwngzpW0=;
	b=phvUj2tNlNO8tF3IKYz2nct0CweJpRZA04HSbqpmNJf6h6Uu3e5Bi0OpqtiK+IVARk1keg
	SEmeuTvOYlXfd839/GFLCMoYJpNsno+XFMDamP1MdskARshs+98g8E6urp0ZcqSYMZjUeX
	pkdCY49hF33U2r94u+6vXsVIiiOnQhNxkF3l8mC1rMnMxUeVvqwsW1+iGMhTBpMv20u1Ig
	PvoWqTjy+aNpWAgVEFW/90C7b5lyfNfFve2z0LHr1uVTOHYKicO/DhL7w859ju1A3aamje
	vsDK2JBSMoLVwjuylkMgisHzksLK1jN/FiO539+tWMYT/Ht5Ut5sg9vqtRZ2Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqS78blCopCtsWIZ8oaPaYcSBfzrcjYCmXJuwngzpW0=;
	b=3H/MaFeaBrqzXt4kYFdIOhKjrE+SWf6A/pH+wwZFEqbOX9qRfTuMItG4E/3tBCdtHjJVs7
	3lk1S3aV0jOi2/BA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/build: Rework CONFIG_GENERIC_CPU compiler flags
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-4-arnd@kernel.org>
References: <20250226213714.4040853-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065294286.10177.16333107826969113374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fc2d5cbe541032e74a66599ba843803cebbfed0e
Gitweb:        https://git.kernel.org/tip/fc2d5cbe541032e74a66599ba843803cebbfed0e
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:19:05 +01:00

x86/build: Rework CONFIG_GENERIC_CPU compiler flags

Building an x86-64 kernel with CONFIG_GENERIC_CPU is documented to
run on all CPUs, but the Makefile does not actually pass an -march=
argument, instead relying on the default that was used to configure
the toolchain.

In many cases, gcc will be configured to -march=x86-64 or -march=k8
for maximum compatibility, but in other cases a distribution default
may be either raised to a more recent ISA, or set to -march=native
to build for the CPU used for compilation. This still works in the
case of building a custom kernel for the local machine.

The point where it breaks down is building a kernel for another
machine that is older the the default target. Changing the default
to -march=x86-64 would make it work reliable, but possibly produce
worse code on distros that intentionally default to a newer ISA.

To allow reliably building a kernel for either the oldest x86-64
CPUs, pass the -march=x86-64 flag to the compiler. This was not
possible in early versions of x86-64 gcc, but works on all currently
supported versions down to at least gcc-5.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-4-arnd@kernel.org
---
 arch/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b3..5af3172 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -183,14 +183,14 @@ else
         cflags-$(CONFIG_MPSC)		+= -march=nocona
         cflags-$(CONFIG_MCORE2)		+= -march=core2
         cflags-$(CONFIG_MATOM)		+= -march=atom
-        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
+        cflags-$(CONFIG_GENERIC_CPU)	+= -march=x86-64 -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
         rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
         rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
         rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
         rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
-        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
+        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ctarget-cpu=x86-64 -Ztune-cpu=generic
         KBUILD_RUSTFLAGS += $(rustflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone

