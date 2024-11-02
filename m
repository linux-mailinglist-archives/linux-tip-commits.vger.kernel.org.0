Return-Path: <linux-tip-commits+bounces-2692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E059B9E25
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848AC1C21814
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44615B99E;
	Sat,  2 Nov 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuG4/JyJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzr6QA4d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590113BACC;
	Sat,  2 Nov 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539479; cv=none; b=UlYYXBYjOJ8hKczwRN1ReGjp01PXRFa7QFjn8FN33rY+Ci4jxNSO4v6SazhDUl1R9i+4sPWEW/UOOKjO3bkKmCKZ+4YaVdnQm4XDyVhSQ7KMHcpAAHM9HWdKEZ+uojjgo+tSU0V5UVlCbl4iQ/QHQTxu8URBi/Sc9I6/ek7eEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539479; c=relaxed/simple;
	bh=i9+CMHUkMww78j1eGiwagnjFRk6uvaAFmv+8ijbFMkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PAZuqhO+O6d9naP2KBRV85CyyNR91DMGq9xdJVrdIUKvvz4X1d81AkPSn4L/rwzAZ+yedQSZ2vugNxxl1yBEQd3C6/bHLhUa+5tvn/Wb1E9FaXCRV7hxMt8TM5PDlUZWXjiTIoT8ACB5PF3o430PVW2i8qJpOzQ9WwpZhRYT3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuG4/JyJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzr6QA4d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 09:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730539475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtEiwYCbm8mH9lMf4np5azLZVfrBBJvcfjuP3wWqLM=;
	b=vuG4/JyJSeAFWiAfY1kHnh7H3MHkIQYWbvje9Ioth0/kooPa/JXjUAHxgVAaQ+u5+ybglj
	WVtn0AvIhPn9HDhk6pZspuwRhc3JYsAEgxfU47YmrFGYSBms785sf+dJPaarySYndjb+LU
	IO5+AeQcggTX3jB+RpiEM7PNtg/0dIsI2rMif6nOL5js+m4ZflNHWRqV+ZTg9nNqBSI+xm
	ww6KAPooM1HCCpAECWQxcFZEEoXhPRIPSgQuAcLeGcR2bF2Xb98CPa1LEUtN7AbI3Z8JXK
	EZBW6tSw1Oi2HbsHAhVPWrqxclf9sZknFezytto2rb8zMNc/mcpIhPkavrBq/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730539475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVtEiwYCbm8mH9lMf4np5azLZVfrBBJvcfjuP3wWqLM=;
	b=pzr6QA4dnkrE7cwrps/EcRmiXM5rwOzofyInPZj7SS1lskaJo5iKTGL29SOF9JHzt2iSuS
	+QUE80AtKZfL15Bw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Always check for negative motion
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241031120328.599430157@linutronix.de>
References: <20241031120328.599430157@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173053947434.3137.8990439381902202381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c163e40af9b2331b2c629fd4ec8b703ed4d4ae39
Gitweb:        https://git.kernel.org/tip/c163e40af9b2331b2c629fd4ec8b703ed4d4ae39
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 13:04:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 10:14:31 +01:00

timekeeping: Always check for negative motion

clocksource_delta() has two variants. One with a check for negative motion,
which is only selected by x86. This is a historic leftover as this function
was previously used in the time getter hot paths.

Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
against this as a by-product of the protection against 64bit math overflow.

clocksource_delta() is only used in the clocksource watchdog and in
timekeeping_advance(). The extra conditional there is not hurting anyone.

Remove the config option and unconditionally prevent negative motion of the
readout.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241031120328.599430157@linutronix.de

---
 arch/x86/Kconfig                   | 1 -
 kernel/time/Kconfig                | 5 -----
 kernel/time/timekeeping_internal.h | 7 -------
 3 files changed, 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd..53a5eda 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -145,7 +145,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	# Word-size accesses may read uninitialized data past the trailing \0
 	# in strings and cause false KMSAN reports.
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 8ebb6d5..b0b97a6 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -17,11 +17,6 @@ config ARCH_CLOCKSOURCE_DATA
 config ARCH_CLOCKSOURCE_INIT
 	bool
 
-# Clocksources require validation of the clocksource against the last
-# cycle update - x86/TSC misfeature
-config CLOCKSOURCE_VALIDATE_LAST_CYCLE
-	bool
-
 # Timekeeping vsyscall support
 config GENERIC_TIME_VSYSCALL
 	bool
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index b3dca83..63e600e 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -30,7 +30,6 @@ static inline void timekeeping_inc_mg_floor_swaps(void)
 
 #endif
 
-#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret = (now - last) & mask;
@@ -41,12 +40,6 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 	 */
 	return ret & ~(mask >> 1) ? 0 : ret;
 }
-#else
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-{
-	return (now - last) & mask;
-}
-#endif
 
 /* Semi public for serialization of non timekeeper VDSO updates. */
 unsigned long timekeeper_lock_irqsave(void);

