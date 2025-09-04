Return-Path: <linux-tip-commits+bounces-6446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C297EB43734
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1937A5B73
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21632F9980;
	Thu,  4 Sep 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QJNMaOR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uV+YOuwR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F82F8BE6;
	Thu,  4 Sep 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978342; cv=none; b=peyfQTsxc+tTSL1ViFwXR2HbZJFtIK12GTLxTU36uGL7Q6hm+g+5XyVO8ETEAoKpuDI+0hE4BbiSnASoOlaGa1B11cg305ZNowYQQzDr6ueAJbP4tEUKunleXwzJ2PNPsJmXq7dfIDOPh2buPHXBm1+H+ZnV1OCLw7kF5YEFFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978342; c=relaxed/simple;
	bh=KO6RD8O4tIvaapVNnCSfvDYKymhkVkcuyabj7XH3WPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fz9QGBr3uB8smSF2z9Esq6uFbQwXg/ux4toFN6R4uALp5JYQlAonVItD5p3uTllIebncmwzxrKJYxRoLdaV0TNPyO/9DDvbFPpHahzuWvIE4R43IZM1K22M05XDtzx/+Gg4XlVG2eKwBcSVm00cHUT5rAI6/NcFb5BV353a8kkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QJNMaOR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uV+YOuwR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEKY99U93/aaPtH4MN6hU+qJtfRA4Ilvm024UoY6pOk=;
	b=3QJNMaOR64rEfnfKdn1Owqd47JKBOv49tfOb8Oz5GWOX7hsR2L7ltDhhZFCbm3VWhrIskW
	pDOJSi5D25TVmLTrXuUjWk77PX7T/aocvrdAfPMByLTLD5T9LKYyIJChLaDSgNWBpGcsN0
	naWYxP3Zead5Ba8zwL+z4sBQQkJqQY9E034agAQzqsI+Sl+50jr2U/jNEg0ebUAytVuD/l
	lXaAE1KhBN4Tl5WkmwHLE5U3UZ41kUsZdiMUjCzkYJl4HDHgwhkZENVNZU/Kpcq1VD5SDN
	dsXXffZ3jw025tNafW/s7AhlD/wMdlzof6b0H2DvaNZgkF2dvAxdoo91qWzSFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEKY99U93/aaPtH4MN6hU+qJtfRA4Ilvm024UoY6pOk=;
	b=uV+YOuwRraK7U3qWfOhM8bxBK25Qs1LQiWA9DJuSV575GKoQI3UCOpfzuJ6xoevKoYTOjp
	STNpKFadAI3aFdAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Drop kconfig GENERIC_VDSO_32
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-7-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-7-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833825.1920.16764377452967894020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     278f1c933c3fab6f249b995a1a13608246b76181
Gitweb:        https://git.kernel.org/tip/278f1c933c3fab6f249b995a1a13608246b=
76181
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

vdso: Drop kconfig GENERIC_VDSO_32

This configuration is never used.

Remove it.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-7-d9b65750e49f@li=
nutronix.de

---
 arch/arm/mm/Kconfig | 1 -
 arch/x86/Kconfig    | 1 -
 lib/vdso/Kconfig    | 7 -------
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5c1023a..2347988 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -926,7 +926,6 @@ config VDSO
 	default y if ARM_ARCH_TIMER
 	select HAVE_GENERIC_VDSO
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_DATA_STORE
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..4f12007 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,7 +14,6 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
-	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
 	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 45df764..76157c2 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,13 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
=20
-config GENERIC_VDSO_32
-	bool
-	depends on GENERIC_GETTIMEOFDAY && !64BIT
-	help
-	  This config option helps to avoid possible performance issues
-	  in 32 bit only architectures.
-
 config GENERIC_COMPAT_VDSO
 	bool
 	help

