Return-Path: <linux-tip-commits+bounces-6515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33035B4A671
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E9718857A4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6862797B8;
	Tue,  9 Sep 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZ6QXh8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqhyh/hI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DA2773EC;
	Tue,  9 Sep 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408561; cv=none; b=IVk4KXDMZWZym5JjoyC8JA9oF3u4wracnDgGmJmuGEBLCNyGgndwBtF48/zKXhcHLleJgBZ+hZdqoRzobtFTfkOGfqy0N/XHBJLMniD6llIbqtdjR+YoyiArzdVlm4Cl6hc3UMquWxpBEEUcFIR1dK62oceqFnxHTugmYnmziKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408561; c=relaxed/simple;
	bh=yLs7zpLtBZ49nmTPUWu/M5/OEEet31P8yGOw2hdLe/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tAX1pVQhVylVi1lwsYhuRjP1Rr2FbEb8qDoOkhdrsPKFxev8G23nxrc0ZHSGQZFpI05LlHqH/DkBBi5LDVdtkjIV8eJP/nzKdMe57jHvK9F3z8IbnU5UAC7ErSF4CixBL5NxYjjj6NJBQss72fT2jvGSfgFxICSE4ArxBvYMZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZ6QXh8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqhyh/hI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldv8VvkEzc6ad6jmX+RADuc0etSXsP1OBggPLM39Oxo=;
	b=PZ6QXh8+6zdprnHga84Ux1rZMB1ZFpXh1sCF0jsQEJwGBi3bSCO5ouIkr4A+QsErWwdP2Z
	rOwajLebHejcqOtDI47D4DXFQcs+N+txoKnmqFODDfDrgILjHSrdOAm+tlxlYsuhGD5TGp
	BBZJDJPgN1gsteM604/KyGZXvsiYosf16DcgeVA72T/8J7Tfl6O2eiujK9TAp8+HvUtGs/
	NeG+PUA3rzL8Xcv4hC1U1ceuheHuJrPQFbKyLVXwBmnrF/qBfO3Stm2e7eGEEVo4qIb0jt
	Ockak3tD4I4GOuQKq4FW5xW0f4C4JHHJsMKTUijPiKQqt70rQY2P3kYGI2cMoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldv8VvkEzc6ad6jmX+RADuc0etSXsP1OBggPLM39Oxo=;
	b=fqhyh/hI0idaRbYEXd59MbDRPdK0y+1se5q4gJz0yOtqA6mFufUzi4LfGFpTkGSS5LQwsd
	8sRTksS0MqgqnpAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Use explicit
 indices for name array
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-5-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-5-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740855657.1920.16199757066882049899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     74b408ff06c39238edd66350cd0d4057787fc853
Gitweb:        https://git.kernel.org/tip/74b408ff06c39238edd66350cd0d4057787=
fc853
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:39 +02:00

selftests: vDSO: vdso_test_abi: Use explicit indices for name array

The array relies on the numeric values of the clock IDs.
When reading the code it is not obvious that the order is correct.

Make the code easier to read by using explicit indices.

While at it make the array static.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-5-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index d236dd8..a9a65f0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -31,19 +31,19 @@ typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, st=
ruct timespec *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
=20
-const char *vdso_clock_name[12] =3D {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
+static const char * const vdso_clock_name[] =3D {
+	[CLOCK_REALTIME]		=3D "CLOCK_REALTIME",
+	[CLOCK_MONOTONIC]		=3D "CLOCK_MONOTONIC",
+	[CLOCK_PROCESS_CPUTIME_ID]	=3D "CLOCK_PROCESS_CPUTIME_ID",
+	[CLOCK_THREAD_CPUTIME_ID]	=3D "CLOCK_THREAD_CPUTIME_ID",
+	[CLOCK_MONOTONIC_RAW]		=3D "CLOCK_MONOTONIC_RAW",
+	[CLOCK_REALTIME_COARSE]		=3D "CLOCK_REALTIME_COARSE",
+	[CLOCK_MONOTONIC_COARSE]	=3D "CLOCK_MONOTONIC_COARSE",
+	[CLOCK_BOOTTIME]		=3D "CLOCK_BOOTTIME",
+	[CLOCK_REALTIME_ALARM]		=3D "CLOCK_REALTIME_ALARM",
+	[CLOCK_BOOTTIME_ALARM]		=3D "CLOCK_BOOTTIME_ALARM",
+	[10 /* CLOCK_SGI_CYCLE */]	=3D "CLOCK_SGI_CYCLE",
+	[CLOCK_TAI]			=3D "CLOCK_TAI",
 };
=20
 static void vdso_test_gettimeofday(void)

