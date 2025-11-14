Return-Path: <linux-tip-commits+bounces-7360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306CC5F148
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C901A358CD0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 19:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22B31A041;
	Fri, 14 Nov 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Nr9jf0p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umMwfZ9F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592271EF36C;
	Fri, 14 Nov 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149151; cv=none; b=PUsx+2c9gR+l4MEZ0QiSK5NZuznUAjPwEcegEhWun85uZjmG9xvTnYI7J+VbmYsjN0Pe3nCwNwwwjBV546mcO9p//psCtaOaG7xG0RSiYDswahoaFpy56bvQQ4F5No/Mn+UypZLyYHBllJXM0EtyzbtqbsAauhDP1bOedoYZ6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149151; c=relaxed/simple;
	bh=n5QDWd9lYCJAfkRrMf6J5KvZfSvxqtScnjMCfIKc8Vs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GtRQJlhpq91+4byC1i/M6fDGmn1JW6JvDEHh1YQCCEoSaTCaEcuspzvaeHE1i5g7KsQsHAo/zCo/Qy29ujPPfDqRqbZJQla84SwvlZpoaxLGuySQ4UBUICyLvU4Jj+nCR737+O5MvGaxn5YTTQICI3c13R6MDXSJfVGjWeUHOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Nr9jf0p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umMwfZ9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 19:39:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763149148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRlNhXa8j8Y7z7jT83bNRJNcGE3b52LgvcJDHcHfFj8=;
	b=3Nr9jf0pHTYkYxiDROYxmklm9NHQX5dLQVAsnXZTbiRfOq7AQy0350eoF5kJ06Fn7RoW9k
	ITlg02B8L5OUCGZIZ5rwf019xLyWDit0aw8RwsaxYHp3PFshEpqYYpwbrN9JfLuLytwlyB
	mZVEP2vQJHDzYufPP8B0YXVmyq5azhxCLvPbZpkYmOJuGdOn23EDigLegLC/whxqTOXEqD
	su2g/AkqHdtJtcv2RzbXkMJoCE+WXcOET69ChNbZPo1oNP5y4yFg+TVNHXxYDPYTa2pnpQ
	uji3XBp+MKRksAKeYvYBg8wAvEMkqLu9y4yGS53g1p6SaNuNHOayZ9n3Rx97bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763149148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRlNhXa8j8Y7z7jT83bNRJNcGE3b52LgvcJDHcHfFj8=;
	b=umMwfZ9FRvXZqUSCeYKWWDi9TZ8MXKH79qxENepiiA6rVb9xnqRc+t79qmZDa/E37vFO5v
	ZAcTiOp5mMFajlCw==
From: "tip-bot2 for Wake Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers: Clean up kernel version check in
 posix_timers
Cc: Wake Liu <wakel@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251103114502.584940-1-wakel@google.com>
References: <20251103114502.584940-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176314914729.498.13806602046961614232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     05d89fe7e46a52bb5dde7ac3f07b383895fab528
Gitweb:        https://git.kernel.org/tip/05d89fe7e46a52bb5dde7ac3f07b383895f=
ab528
Author:        Wake Liu <wakel@google.com>
AuthorDate:    Mon, 03 Nov 2025 19:45:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 20:34:50 +01:00

selftests/timers: Clean up kernel version check in posix_timers

Several tests in the posix_timers selftest which test timer behavior
related to SIG_IGN fail on kernels older than 6.13. This is due to
a refactoring of signal handling in commit caf77435dd8a ("signal:
Handle ignored signals in do_sigaction(action !=3D SIG_IGN)").

A previous attempt to fix this by adding a kernel version check to each
of the nine affected tests was suboptimal, as it resulted in emitting
the same skip message nine times.

Following the suggestion from Thomas Gleixner, this is refactored to
perform a single version check in main(). To satisfy the kselftest
framework's requirement for the test count to match the declared plan,
the plan is now conditionally set to 10 (for older kernels) or 19.

While setting the plan conditionally may seem complex, it is the
better approach to avoid the alternatives: either running tests on
unsupported kernels that are known to fail, or emitting a noisy series
of nine identical skip messages. A single informational message is now
printed instead when the tests are skipped.

Signed-off-by: Wake Liu <wakel@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250807085042.1690931-1-wakel@google.com/
Link: https://patch.msgid.link/20251103114502.584940-1-wakel@google.com
---
 tools/testing/selftests/timers/posix_timers.c | 32 ++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/se=
lftests/timers/posix_timers.c
index f0eceb0..a563c43 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -18,6 +18,7 @@
 #include <time.h>
 #include <include/vdso/time64.h>
 #include <pthread.h>
+#include <stdbool.h>
=20
 #include "../kselftest.h"
=20
@@ -670,8 +671,14 @@ static void check_timer_create_exact(void)
=20
 int main(int argc, char **argv)
 {
+	bool run_sig_ign_tests =3D ksft_min_kernel_version(6, 13);
+
 	ksft_print_header();
-	ksft_set_plan(19);
+	if (run_sig_ign_tests) {
+		ksft_set_plan(19);
+	} else {
+		ksft_set_plan(10);
+	}
=20
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU exec=
ution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -695,15 +702,20 @@ int main(int argc, char **argv)
 	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_timer_distribution();
=20
-	check_sig_ign(0);
-	check_sig_ign(1);
-	check_rearm();
-	check_delete();
-	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
-	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
-	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
-	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
-	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	if (run_sig_ign_tests) {
+		check_sig_ign(0);
+		check_sig_ign(1);
+		check_rearm();
+		check_delete();
+		check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+		check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+		check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+		check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+		check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	} else {
+		ksft_print_msg("Skipping SIG_IGN tests on kernel < 6.13\n");
+	}
+
 	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");

