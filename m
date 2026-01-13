Return-Path: <linux-tip-commits+bounces-7949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CFD192CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F5730A83A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AB3921DA;
	Tue, 13 Jan 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLlBeI8B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVjwk7yf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E62255F5E;
	Tue, 13 Jan 2026 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312059; cv=none; b=ZBDKMG+dFfcHqIiWfav7DnJh8dZAygkRI1WPYHowu1cCzM0/RRHakFo7fa1VG+WSW3KKwq4N2t7jSOXUMMMCnDAHXBgUU2vVVDF4BVLHtbpODuyjA/VVcNA/lU2SdrwyhC/+ZzBr4/uTTQeBx7Z0vno/8mF0BwvuYkqS1Rfa4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312059; c=relaxed/simple;
	bh=blf7tmI37DFwuWttKvMDSmNnNqLn6M9dOcmD34tZGE8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U+VF15f+r1FD3SjCgA4EvtiUgceJhXVrwazo5bBE7qMSXH99i7kwI/hH4drDGT+hRMSehTsujJTUzq3k7mr+Bw4wyNAlvEmwmy5opMrPXlbVfwig1KpA5YIxISsM9ygGrQrsZpMBDIFNSVK3+DxPUYdbUMn2dROAlmv43JdmMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLlBeI8B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVjwk7yf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yn8f8OlhVvJEfjaT1Uf/kZvj9DsfdLXcaONH5MyEx4=;
	b=XLlBeI8BwTOXpHN2ZjW9BnKFSI7YujAas+qDjZj7s8jjAQtHZKVHIFWU96sLhPlPrS00Kr
	MKE8TBVf8xRa8E0UKbISQMM+5RS1Acaj2IC7e1+iRR3JLQsGtNuKbObI/YdiqwR5HifkRf
	93mxP+1qyZq6GSstWBFKBerVtcFqADIXbiCNjlM9LhmfNNAxVlaHIHnWBo6CkiJP6pxEos
	FqA1xiYh4XrP5zkaz0Ohr5DK6IT4pvXJBl6q+hNH3TSU0X/gKO9RA0KeRNppAQVw+IuyfZ
	W8kXRAJaoZGCwWFrly1gBgMnWfEJQ90NzEpNP6YT4Gb6cxNMTUel8X8scF5oWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yn8f8OlhVvJEfjaT1Uf/kZvj9DsfdLXcaONH5MyEx4=;
	b=KVjwk7yfLCAZS2XXh1lN9elZ+tnT28ZzYcj+eVziSO3C9ueYykb5RF714idLG/jkQV+idW
	vT6k4DoNPxuijjDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] MIPS: vdso: Provide getres_time64() for 32-bit ABIs
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-9-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-9-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205313.510.14287310860825824823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bec06cd6a140ceb62ee4634c9550212f5f05bcfd
Gitweb:        https://git.kernel.org/tip/bec06cd6a140ceb62ee4634c9550212f5f0=
5bcfd
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:20 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

MIPS: vdso: Provide getres_time64() for 32-bit ABIs

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-9-97ea7a06a543@=
linutronix.de
---
 arch/mips/vdso/vdso.lds.S      | 1 +
 arch/mips/vdso/vgettimeofday.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index c8bbe56..5d08be3 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -103,6 +103,7 @@ VERSION
 		__vdso_clock_getres;
 #if _MIPS_SIM !=3D _MIPS_SIM_ABI64
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 #endif
 #endif
 	local: *;
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 604afea..1d23621 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -46,6 +46,11 @@ int __vdso_clock_gettime64(clockid_t clock,
 	return __cvdso_clock_gettime(clock, ts);
 }
=20
+int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_getres(clock, ts);
+}
+
 #else
=20
 int __vdso_clock_gettime(clockid_t clock,

