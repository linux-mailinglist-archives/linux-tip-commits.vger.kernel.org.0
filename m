Return-Path: <linux-tip-commits+bounces-7954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3BD19277
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FF303010669
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C3392B65;
	Tue, 13 Jan 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KqrdQyCl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BFS5Jly"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E763921E1;
	Tue, 13 Jan 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312064; cv=none; b=c8LwQmChMpetgS4YOYLRDP5adqT8gMrC3hZqtMOS2EpAokPEG1BdGOxPbTuS8ZuB/56TOjiabVLHqCV0YZx2VNNSu1CV2tXN2UwXSlVXdgQNvKVkoH2jgdJKZb+Uz7P6iQsvEQdVXwCLlT5MjC0hptaOpgqTtY7rBzS8iLwY800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312064; c=relaxed/simple;
	bh=J9kJkg1J5upObWh6SfWW9ygegIkAxOrLK/snDgQWN0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GOjRTmi19uXhrwv+sfIFm+5hBTpEpbpovavMoS5fNO/l84NtzMyya+vVyuV/bbkwQ5HMH7B+dDuR1Ws3nNkOclfbtwTHSxqh1gAvKnbpb6UHjeBn3xCG+Ko7bjwz8xgvQH972NkwYyNhmtE9ZESQ/tJ/1wCSBMJL0bSsQdS6fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KqrdQyCl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BFS5Jly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1bu+0UneZFrqGE0AOrE8OWxAVB4wxs+QhYT48RCEJ4=;
	b=KqrdQyClwfxXUa2Slho39DUqPImevkoFXykIHsHw2oEXFeLeWDDDVa5YOs/tjW9SsVsvN+
	gq1AN6e9GhEvq0046DcSaARj8pWnbL158gwphEHER8ZdZWH5ge0EC5uNM3ITjb7/gjdIXL
	RH99UOpCHaJoNT1Jb4ThtjM5PepwoJlZi9DjpxyixbXYZ8SuButnPOZtavbgyyB+juzcrC
	M15BC2zHJY1groI1BSezCPHrHuH1dRrFMB9I+VYep0p2rmcHdtsHN0OYmIMWnoeTOJyLsv
	I4/HXUrMcuC+FJ35umhaSXsmC3LN985KvcLpW7wsKYvwawSpr5U8Mw9BkBw28Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1bu+0UneZFrqGE0AOrE8OWxAVB4wxs+QhYT48RCEJ4=;
	b=+BFS5JlyRGKxtfjcwsjcxaEiaUhmufHqHTIo/shezuCPtRj4Fj0KKFztrgr9AU9GWFpVnz
	damUayWM0XXaReAQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Provide clock_getres_time64() for x86-32
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-5-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-5-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205745.510.5947015150292818830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     21bbfd74044f77a98bbc27ea9e6cb04f4dfd8ee6
Gitweb:        https://git.kernel.org/tip/21bbfd74044f77a98bbc27ea9e6cb04f4df=
d8ee6
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:16 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

x86/vdso: Provide clock_getres_time64() for x86-32

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-5-97ea7a06a543@=
linutronix.de
---
 arch/x86/entry/vdso/vclock_gettime.c    | 8 ++++++++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vcloc=
k_gettime.c
index 0debc19..027b7e8 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -74,4 +74,12 @@ int __vdso_clock_getres(clockid_t clock, struct old_timesp=
ec32 *res)
=20
 int clock_getres(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_getres")));
+
+int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_getres(clock, ts);
+}
+
+int clock_getres_time64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres_time64")));
 #endif
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vd=
so32/vdso32.lds.S
index 8a3be07..6f977c1 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -28,6 +28,7 @@ VERSION
 		__vdso_time;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 		__vdso_getcpu;
 	};
=20

