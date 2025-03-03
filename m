Return-Path: <linux-tip-commits+bounces-3819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DDA4CBB3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD081893C81
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E223237A;
	Mon,  3 Mar 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0lAAmD3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4B5HvNfg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846821B9CF;
	Mon,  3 Mar 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029180; cv=none; b=jn1ukOSDBu0Bez+2QrFR/uPP9C7hSoB4ypYoJcRb8vHDQvFOJ+qD3PaYrNoXlSpdjbxm9BKKgMiWG49czxnyOO1zAYXdAwQ8Xi2MDnTp7cfw7XjglxpyUgXC2HWgfdjV0Tg8zEYthQevARqkO/eN1k1dOkuzwoZ7vpHtZ0to1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029180; c=relaxed/simple;
	bh=5XEbxlzqprqkO8nDJmjBtRaCaeq3XFM0oHHaRSRBRP4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n0pyRh+14RWuM3acMJHn+X4UZiCE5xY1HLiChnXwP2pNHFLf620d7mHrdG5nhVTVQtCYFsFMMSOBd+MoSZa6QmTxi5ibciq0gGxwAemgtKTtEpYjBJlrK8Qu4vt4QBXL1qGbVL+uf+r2hhMG1idSusDIabznzMo5DQzePkdowPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0lAAmD3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4B5HvNfg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5x9YPpdhK5jdu12ii/QtikAUJoJF6zm2y7cQkvJbUE=;
	b=m0lAAmD3GdnaPoK26MBxyoGuLbxo2ZOclM5OleFVBUVRQVYUijzXLd/XWGXUMje/1OKkjv
	hkxgCVDzXBm0hbAmfLyGw7MSsUgi5YvSP3QxDYY6f78WFvlQDxDsQS1WeWwPku4x8rOqBs
	lVIMhcyh51K4VRYflwdvfWm9QPrsafJojgvwZGUUYga/w+YGc8gBpBZwEfA4BTDYINmdha
	nFtDvoSivl4k00kLa225VtzohCPRpDZ/PsSUGqc6UCnF0J0BU/4ocjl60QFOU+/psG/wLg
	Yn1uu3Fb9OF0ruCgNEYK0ueT5EtujC57xe/uLzD91q/fRLZ82JIkjFoVV7+OZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5x9YPpdhK5jdu12ii/QtikAUJoJF6zm2y7cQkvJbUE=;
	b=4B5HvNfgBDPpPIyPZSck5Yt+oKZyVkw7rXUMQ0mCJgZhH05JRJig0aKyHzvBqwmk60uREh
	Dntbkmuo9OioqeBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__
 instead of ULONG_MAX
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-13-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-13-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917718.14745.11147449630805531673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     032e871686483ec1bac27ce73e7094692fc76268
Gitweb:        https://git.kernel.org/tip/032e871686483ec1bac27ce73e7094692fc=
76268
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:13 +01:00

selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX

According to limits.h(2) ULONG_MAX is only guaranteed to expand to an
expression, not a symbolic constant which can be evaluated by the
preprocessor.

Specifically the definition of ULONG_MAX from nolibc can not be evaluated
by the preprocessor. To provide compatibility with nolibc, check with
__SIZEOF_LONG__ instead, with is provided directly by the preprocessor
and therefore always a symbolic constant.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-13-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selfte=
sts/vDSO/parse_vdso.c
index 200c534..902b8f9 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -26,7 +26,7 @@
=20
 /* And here's the code. */
 #ifndef ELF_BITS
-# if ULONG_MAX > 0xffffffffUL
+# if __SIZEOF_LONG__ >=3D 8
 #  define ELF_BITS 64
 # else
 #  define ELF_BITS 32

