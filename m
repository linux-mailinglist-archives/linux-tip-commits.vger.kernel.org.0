Return-Path: <linux-tip-commits+bounces-6447-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6289B43738
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610813B97B4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB52FABEE;
	Thu,  4 Sep 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGd2zgo8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjMqBbNV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9A2F998E;
	Thu,  4 Sep 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978344; cv=none; b=eFkez5X07mZXYRBWlQgT3g5zOemyma7lys+TS1diSyr+qtJjUrZnGfyIJPq4GbEfr6tHjPlL9qswUU5EgzbAwDkydVD1tLKF78Y8bsjatQSbwv5QTi/5NDVskbNTVytZnPZyxgrHeb40WP5ithyW0kXuTAu3fy/oSuDoWI6ivZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978344; c=relaxed/simple;
	bh=TUuDyhGy3Kl2Wh1IxttCHnuFZldViP/+Fw4ffBhhXsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XXJ+Uc/wURUoTHrFnOaUWv9bGb0voNKwNvv5cIYU/CkpWQu0ZU39oFHH9PDbtWfHx2rVnnTpWQQhBrU4L50Foycqs85pxciYKMDombNePLsHOtlz59O1+cAKb8J5V0dKZnCWc4hv7QnfOvAbYUd8TlVIBlPDprefcYN62u+d8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGd2zgo8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjMqBbNV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuJBkhlpMlwfWLwBD3cUQUZ1gs4FQU+cTpxlI6ZmCVM=;
	b=aGd2zgo84RSrpwk5DqT2P8/lFkB0//XzUmnOhJHSkelkc86o6U7tDHoFPVN8Dabb1NrEF8
	tBh10U6KlwoRwh82UZJM6bCnwxVm9+414Zm974DISpCL9VE+UDq3Lomi9YzioOk6o3+D6j
	0q8VnRmioAfc/sBbugXSDDwkox6d1nszPBY2lMP1fKOPVuQo3dWNatqyRnJRGmRYl2NgXn
	2owRbNl54SunY2E09OP+xfCtM9NSR1xzhb+t7g04Eol9QLMdOgKeWHcPptky31o1xdPX0x
	cMqWGRBJmOBrbDkIdX/phV/80oioYftXqmgxh/k2X15ASlFQV8FyFZURncUBIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuJBkhlpMlwfWLwBD3cUQUZ1gs4FQU+cTpxlI6ZmCVM=;
	b=TjMqBbNViFCAAMTrFlKpKlirGBjOAlMDrRDaC8EobkBhTCg7ckg1XHxqXlYrYOdhc/YXtS
	4U0CbMHKIxE0iZCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] riscv: vdso: Untangle Kconfig logic
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-6-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-6-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833954.1920.13150098391719966722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     eb3b66aab72c10632865afaf8e46f4667c21ef7d
Gitweb:        https://git.kernel.org/tip/eb3b66aab72c10632865afaf8e46f4667c2=
1ef7d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

riscv: vdso: Untangle Kconfig logic

On riscv32 the generic vDSO infrastructure is used but without its
time-related functionality. The Kconfig logic to implement this
treats HAVE_GENERIC_VDSO as a synonym for GENERIC_GETTIMEOFDAY.
This works today due to some underlying issues in how the generic vDSO
library works. Some future cleanups will break this logic.

Restructure the Kconfig logic, so HAVE_GENERIC_VDSO refers to the generic
library in general and GENERIC_GETTIMEOFDAY refers to its time-related
functionality.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-6-d9b65750e49f@li=
nutronix.de

---
 arch/riscv/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a..e4ac0e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
+	select ARCH_HAS_VDSO_ARCH_DATA if HAVE_GENERIC_VDSO
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -107,7 +107,7 @@ config RISCV
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
-	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
+	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO && 64BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
 	select GENERIC_IRQ_IPI if SMP
@@ -120,9 +120,9 @@ config RISCV
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-	select GENERIC_VDSO_DATA_STORE if MMU
-	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
+	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE if HAVE_GENERIC_VDSO
+	select GENERIC_VDSO_TIME_NS if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
@@ -165,7 +165,7 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_GENERIC_VDSO if MMU
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
@@ -221,7 +221,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO && 64BIT
 	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32 if 64BIT
=20

