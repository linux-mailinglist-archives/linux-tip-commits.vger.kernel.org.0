Return-Path: <linux-tip-commits+bounces-7152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E49C28738
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19534F0D0D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2430E0ED;
	Sat,  1 Nov 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSvlIbxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIV/n4GA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6261303A12;
	Sat,  1 Nov 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026483; cv=none; b=Ad8GdkZd4DfIGOlOJVoRi5XNGfeZvvxFOm3Ke4w95/p9gdF2ju4Y/8ONei9V7y7N0z5HfrswnUAQO7zJrPff4NhLGL/Px2HQuXWQHt+mTEFMGD2fSZkGTHABZlfC0hvasTIXHRNHUoSc8eIHJiJb17TLMW9UpzSJDYv6L63c3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026483; c=relaxed/simple;
	bh=dHN4gaLegjoL3sQ5nIn9NnVM7vK+ObRVLE7zbbqPdPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KC54AnBoxxo/5lkw6lpoY0Ui+l5qh5SxIxOIm9TCuakS4z6yhNkkTYFwIg8faX2WYuLVFgzyb1crYkRZVcnelT1cDBP7lc18LBVU09EcInFePCb+ApFYUL+yzFyhGdn8klYj9jRgTFp9m9qYkOXZu2/GKb1da5hHCmrIiKXAVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSvlIbxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIV/n4GA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhVPGI1V0zy1zxWODLb2u/0vNf6WbwqofXhv2yF3il4=;
	b=aSvlIbxX08AgFgq1KaCS2gyrWVCCkccVHi8KxFG/tZBQayNEgCQcJSxQrvPkKyzjiTmU2y
	N1Q52OBKkQDCIfYk262HgoOFRifTdBc05FeVL/QU8Hc/2N35tbVgdqVoRAWdG/yJkRQvmY
	DVV/RvVmIpY8I4biOdWXzWNjNCvzF0aZt/IIfmIk6Ok/4X8498EzteSxjOGDrzAX6pbLEk
	DUROg5UYKl3XpFnvQlpmAnLC3GDIIRgqcQkDYXkHD+Cf+WqWmytISgUaDcAe4T0yAyFyrJ
	eRYTAqhLJ6xaZtHjU+nU2yYEqFZ5VYgPDutMzkSJpjkbLMbae4gYV0b9wnohEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhVPGI1V0zy1zxWODLb2u/0vNf6WbwqofXhv2yF3il4=;
	b=OIV/n4GAY62omxCfg7d3UqJY3LvkjVFc18hLZUUaLRVVSKnHQJJXD3JKCiDLnAoKKbJ1GB
	gzuxTdrgSml3wSAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datapage: Remove inclusion of gettimeofday.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-14-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-14-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647921.2601451.4001025635905055601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4d9faefd3894ae21800a566a8ceaa3defcbf9815
Gitweb:        https://git.kernel.org/tip/4d9faefd3894ae21800a566a8ceaa3defcb=
f9815
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:04 +01:00

vdso/datapage: Remove inclusion of gettimeofday.h

vdso/datapage.h is useful without pulling in the architecture-specific
gettimeofday() helpers.

Move the include to the only users which needs it.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-14-e0607bf4=
9dea@linutronix.de
---
 include/vdso/datapage.h | 11 -----------
 lib/vdso/gettimeofday.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 23c39b9..752856b 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -184,17 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
=20
-/*
- * The generic vDSO implementation requires that gettimeofday.h
- * provides:
- * - __arch_get_hw_counter(): to get the hw counter based on the
- *   clock_mode.
- * - gettimeofday_fallback(): fallback for gettimeofday.
- * - clock_gettime_fallback(): fallback for clock_gettime.
- * - clock_getres_fallback(): fallback for clock_getres.
- */
-#include <asm/vdso/gettimeofday.h>
-
 #else /* !__ASSEMBLY__ */
=20
 #ifdef CONFIG_VDSO_GETRANDOM
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 7b3fbae..9dddf6c 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -12,6 +12,17 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
=20
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
=20

