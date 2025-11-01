Return-Path: <linux-tip-commits+bounces-7162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A7C2879A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657163AF514
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7EE313E13;
	Sat,  1 Nov 2025 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y7RGExUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yUGmfdRC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907631328D;
	Sat,  1 Nov 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026496; cv=none; b=OwMY5ZHQQ8PrSXkmtwdmSnQwbNnCg4ZjfIPmXe44cbbbcZoGVCP/06bJGfe37JPRGF4AUq/UDNWyg68hQ3G4k8K98NHnXw8UzJJJeWkaxOBd/RH4q6dJhxLIW1UX7qzcenB2TP8w3mkgaf7emskV28EczenV7V+KO/H7vCv3Rak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026496; c=relaxed/simple;
	bh=jAyMpzhB1VH7aSPzUkJONTrsKPoDml7qdeWozjsXZcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nN307Hb6TdyXhruCSLpzhGps0IkoFLoN31jBK/HHg+iJimG0fINcAHLuVyQq7gOae777ZoW76RwKHmpgwHDX2xZepb/XSfUUMY1YL7U8SPPAhYqJenidlCZZ2DZmCmUTDZvUyoulIfIC3ANM2BSMB68QDOGUQYg3dLzdhgfp4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y7RGExUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yUGmfdRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeq1kcsn+EIGi9CuspmKwhrtuck7bNCej0e6e6AA3D4=;
	b=y7RGExUYTcGqp/rwQo9rLM/lFXYoYaje9UDYZe+sZgKT9cRS4yYZR++PRE9umU0zqoolYX
	LjDJCSZGc3yPaxrBySf3EqSPA9G5JCC9fNxgPN0z0XfhBhLxyWNlouDx5lkGqf+RyGIZCI
	c9iokGuLBmaUEXjS4tPF6dKW49WZQTf5lF0Xj/N34npvYlWAUjbv5pHnhsjcLBix1a3C/u
	ucFXpfS/HG3O11iTHt8bDQnUQpLQDOlYj6AlJH6tLk38y4qyLWRNmsYhntx/JUPpWUGCht
	ORYb4I4Z4/4kE+Tlp2cG9d/rpoWCecZfygZ9u8/hYgeJMTasFxAQbodyKjKpcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeq1kcsn+EIGi9CuspmKwhrtuck7bNCej0e6e6AA3D4=;
	b=yUGmfdRCi0G6TMnOV1CkLXcuSgk6PPoTegecgdjO/Mc5jziMe6WVswg+ppsTR/f/0RYfBT
	L6co0rpoEc9WonDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] arm64: vDSO: compat_gettimeofday: Add explicit includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-4-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-4-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202649170.2601451.16662114257653154347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7aa7035e413d35e766d5c5339ac2fb825b54d36a
Gitweb:        https://git.kernel.org/tip/7aa7035e413d35e766d5c5339ac2fb825b5=
4d36a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:02 +01:00

arm64: vDSO: compat_gettimeofday: Add explicit includes

The reference to VDSO_CLOCKMODE_ARCHTIMER requires vdso/clocksource.h and
'struct old_timespec32' requires vdso/time32.h. Currently these headers
are included transitively, but those transitive inclusions are about to go
away.

Explicitly include the headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-4-e0607bf49=
dea@linutronix.de
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 7d1a116..2eb116d 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -7,6 +7,9 @@
=20
 #ifndef __ASSEMBLY__
=20
+#include <vdso/clocksource.h>
+#include <vdso/time32.h>
+
 #include <asm/barrier.h>
 #include <asm/unistd_compat_32.h>
 #include <asm/errno.h>

