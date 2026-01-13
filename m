Return-Path: <linux-tip-commits+bounces-7958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFEED19286
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8D6F30213F4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2DA392C20;
	Tue, 13 Jan 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bm1Qia9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9oKTwCRq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC2392B83;
	Tue, 13 Jan 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312068; cv=none; b=VBEoh0e5djdFPqDD3MlCZ58NiIzdwmlycibV0Kn6T4EqirLp7qPaBDph2TEm+Ne7T8KxkP3rGSO1KAWA1ixxhLPIwgQzi5qzyY3chM2l9Fk87oU/FsJm8VfkY4hgBIxXWLFUsUphT/2UDXIg4qiBWsilBLF5CQllI1G6ZY/IBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312068; c=relaxed/simple;
	bh=N5KeteRshhRr4HOGNOVzgT2/lvVpHF31aPtYLMuAddA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t2mToEafdVFDUEaiOLozFJqBMWR/jowWOqPify4twp8gnrGWj1zmZAf086ZvjepZYtw7CfL9bnFNjWrL0TvwJ/OzzgMCIb0A4Vo8y+1c10J8SHTiHC0wjnR6QXfBRSeQUTco6UBO3jhg+nkmmBfjRITmZScCpXav1+KRBvZUykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bm1Qia9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9oKTwCRq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17E/YuZsh8LPRqPiyAfYWV/m32ze5148M+NXVmgWux4=;
	b=bm1Qia9jSvaC9jvq0URzD9UP7vxloJaayKSXak5dwA6Axh5kYWyAVAPjX288lK73hdkme3
	vpugoQYSxXRk8DGaJDakWAerWOZJP5msVFqCN6gerMcE5xxiahIpaZ1J+OdyUasSxOGzwX
	g3a7mn9PdhXl47Ag883OrqB4eNJW0R3bWh1JykX9xwjNQX88d6Ec+/pa62vF55pLQKhy5C
	D8HojHxfqt7oEsGIXT4v7b+KuafejlQ2GQwy7asLXjzcQU0sYXNM2EvE8j4LnDPe15Ngfc
	p7HHIgd8w2L6zlTqd3LcoqA/g5m/OXi+7wb0rnz2qAlDqIer0dIRqzskfNqDOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17E/YuZsh8LPRqPiyAfYWV/m32ze5148M+NXVmgWux4=;
	b=9oKTwCRqJtWlW1FAJz4YYabqs1ZPeGXc2P+ju7Upaagtact/q4sUmmVRSerl23cHmeAQRf
	ewq131nwf7KapvBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso: Add prototype for __vdso_clock_getres_time64()
Cc: Arnd Bergmann <arnd@arndb.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-1-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-1-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831206210.510.11960132519582082267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b205656daf932c06aff424de5d6d01faf60faa5b
Gitweb:        https://git.kernel.org/tip/b205656daf932c06aff424de5d6d01faf60=
faa5b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:12 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

vdso: Add prototype for __vdso_clock_getres_time64()

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI. The generic vDSO library already
provides nearly all necessary building blocks for architectures to
provide this function. Only a prototype is missing.

Add the prototype to the generic header so architectures can start
providing this function.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-1-97ea7a06a543@=
linutronix.de
---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index 9ac1618..16a0a05 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -20,5 +20,6 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_t=
imespec *ts);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz=
);
 int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts=
);
=20
 #endif

