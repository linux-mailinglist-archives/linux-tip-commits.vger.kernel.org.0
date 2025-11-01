Return-Path: <linux-tip-commits+bounces-7131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B824C286C8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 194F74E0314
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB372302CA5;
	Sat,  1 Nov 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jF1vUUQ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKYraF+Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AA3019B8;
	Sat,  1 Nov 2025 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026455; cv=none; b=godjG7q2VVvY0uX/7kS+MyER/3EOtMqS+hevrpX9P0OJs28GYB/rUaAciomFdZrdUUNB/gqDx2kZ7gbtNEW4qTDgRkWZs/3XB3y+Vs1h26jI5C1eCwpjEm3CrFW5/rtbE46LkZO7ItMcd+dhvkotfZvzAk1r7kdf0llg7N+jeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026455; c=relaxed/simple;
	bh=I99KdJmuOctKLuwvymerkINu/nlRPajmxtNSCtIIIOI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d+9Gjlzq5D8kvPV9CDMdBlRhEeCnau5n/UI99ZVWdW3IcRXw3x5JERe64gACm0zUay8IHAe3Ft8Wn19hmmkeEaIxACsXW9jdeHFj8YtRWPecf/eRcLkwslccDYDy2TYwUPIhx4Umnf6D7hkTLOyKr/wxjRT0/mZDbzNG1AfUg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jF1vUUQ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKYraF+Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjFCy3oIeZxEg07jRQaX7gYuOEcEErQGrddy4g0nFQw=;
	b=jF1vUUQ7mRTZANzH0i26opjv96gWo6dQ4ULTkn2V/LL+j8uUFCEk1Bv7WI2Vifqz9dl51/
	3wA3yMvsxuOLbR1J7y4uxlpeNMdxpAGYA46jyv5chomm9+3MJh+SYJEdrBE25CpFRIju92
	QnCKXWpJeWmGCFnxD9PkYe71AwUo/yYWxIl6X3vYs+ia1m54y0+46DocJC6U4nIDqUQHq9
	yLrO77r/sTKG9FR2fn/y3B5QtCeBotxVLIrG241ah4pY/65RFRXukN9cUgoPejff2es0qI
	LHmieHNw1NCsT7jo665NT9xz6NJxNdJE6V/CnckKDm6ygDF+YJgf8XZywFHZCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjFCy3oIeZxEg07jRQaX7gYuOEcEErQGrddy4g0nFQw=;
	b=yKYraF+YGYI57yHwfBhCJRZ2O+RU44L4bPUdPDbOtPOPmAfeQzzlC/tTaEBPN4J9ozdaxo
	tQpqfIJVRgIoKmDw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] clocksource: Remove ARCH_CLOCKSOURCE_DATA
Cc: Arnd Bergmann <arnd@arndb.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, Andreas Larsson <andreas@gaisler.com>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-35-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-35-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202644955.2601451.11045424848598772412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4c6736970fbf35aa65512ce7f82abd970f133c8e
Gitweb:        https://git.kernel.org/tip/4c6736970fbf35aa65512ce7f82abd970f1=
33c8e
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:08 +01:00

clocksource: Remove ARCH_CLOCKSOURCE_DATA

After sparc64, there are no remaining users of ARCH_CLOCKSOURCE_DATA
and it can just be removed.

[ Thomas W: Drop sparc64 bits ]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-35-e0607bf4=
9dea@linutronix.de
---
 include/linux/clocksource.h | 6 +-----
 kernel/time/Kconfig         | 4 ----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41..12d853b 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,8 +25,7 @@ struct clocksource_base;
 struct clocksource;
 struct module;
=20
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
=20
@@ -106,9 +105,6 @@ struct clocksource {
 	u64			max_idle_ns;
 	u32			maxadj;
 	u32			uncertainty_margin;
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
-	struct arch_clocksource_data archdata;
-#endif
 	u64			max_cycles;
 	u64			max_raw_delta;
 	const char		*name;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f..fe33118 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -9,10 +9,6 @@
 config CLOCKSOURCE_WATCHDOG
 	bool
=20
-# Architecture has extra clocksource data
-config ARCH_CLOCKSOURCE_DATA
-	bool
-
 # Architecture has extra clocksource init called from registration
 config ARCH_CLOCKSOURCE_INIT
 	bool

