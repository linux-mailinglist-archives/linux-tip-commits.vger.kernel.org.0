Return-Path: <linux-tip-commits+bounces-6516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6467B4A676
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B71B1887398
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D327B50C;
	Tue,  9 Sep 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SM9CZEDV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xw1AJbTW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6E27603A;
	Tue,  9 Sep 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408563; cv=none; b=ctQ8DHD7para6pZSlGru44mX4rbelJnCdShla3MoKEbZhGST1FOxhUus1caYHTt7a8yUlO+nSTh+HrtdTb2ZwEl2JsBZvpnO7nIY+xwc3OCu9vQcPd+kfv3mGCvaxioxQKmOL+NbmyjggA7bFhRySfH32gs5e1YEdoVQIfuAR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408563; c=relaxed/simple;
	bh=8vDbFJQLGyoEqzPuDU/FDXVqHEYn9d9W9Lsn4de3qPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tFDlXd0JBjI/pNjzuAea5j7uD7uHK3WBoH+Isx5mhiJ6e0nj8BC4TIEiXRHul5kNoydUedoaguNInFyeI+K3uPQBAM8C/W0I/xF/dngmOEqY/Os7+lVhG1fVVDoUkzJMqX/23MsQI7KdbgJpaxLzZdlxB3P5ZeZ0vRiLt+0/skk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SM9CZEDV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xw1AJbTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnj5IYGRMhpjOolXra7PcxTK1UE1UINbyuZ/aEzxsyg=;
	b=SM9CZEDVw/1p9/5F9nApIzmdOqdZCKHmX7rNPffiewSNt+/aJQjo4hZvieeYLgfnBZ3mIF
	xeO9ecD8OpjMmvtaVauJX/lkUto+jR84SknFO4UmPwPYeTl5QKhQODcRLid2mCMtH+KOst
	B2D5qwbOz5CXpm4iuzAlZsTrrXpw0qcAfmr9nit7qIKrGK0t/TidUb3AWe1xYr35t+eiQi
	JLC3ioK03ryQXq/wkBioFdUzCH3f0Y4EJ1xC5jNLPD/WgMi0Mx4a9AmvUiCcVE+5y2T1mw
	L9drzMJqScV/HGWS+auiPIXZ1lpdCKxMb6H6F488cSLBs/OPJFxYPGhRuLcJ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnj5IYGRMhpjOolXra7PcxTK1UE1UINbyuZ/aEzxsyg=;
	b=Xw1AJbTWsojaNVSCgRph570aLSWikWftNXJEZL6Dqcorh+GWoa6qAE6e+pkxZ7K4uYCPK5
	PQlzDHiIoVC6wYCg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Drop clock
 availability tests
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-4-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-4-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740855774.1920.13517692835036610736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     d7516f25a90c554d25847634884179d8be2782c7
Gitweb:        https://git.kernel.org/tip/d7516f25a90c554d25847634884179d8be2=
782c7
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:39 +02:00

selftests: vDSO: vdso_test_abi: Drop clock availability tests

The test uses the kselftest.h framework and declares in its testplan to
always execute 16 testcases. If any of the clockids were not available,
the testplan would not be satisfied anymore and the test would fail.
Apparently that never happened, so the clockids are always available.

Remove the pointless checks.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-4-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 24 +-------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index b989167..d236dd8 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -197,37 +197,13 @@ int main(int argc, char **argv)
=20
 	vdso_test_gettimeofday();
=20
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
 	vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
 	vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
 	vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
 	vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
 	vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
=20
 	vdso_test_time();
=20

