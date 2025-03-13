Return-Path: <linux-tip-commits+bounces-4178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B202A5F260
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0823F7AC0CD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB1266B40;
	Thu, 13 Mar 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0QpustUL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+0CrINsq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482612661BA;
	Thu, 13 Mar 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865486; cv=none; b=cnRD08pOkdQTKftzvhuQiSvyIZOSA9Qmr5pmsEu56lw/rVFRnFsg4He18NMMYysk7ZGNsXZ+LeHTosYnQQhVQ3dXg2Mkpl17FXUr4CVzS2r/fjXwDAHJlLiuvzaFiQ93O2ThjezOGFcw1cw7wfGpQucYVVrBI0jhCo/NoX+ex2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865486; c=relaxed/simple;
	bh=0UuLfETs+59rPjN0rcHLPYU/CZL6XyOzdYIcbkXrkg4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X3szFDesBztsnfEcKprdbpn2tuAmiV4Gs2uC59oiFRDwwk88lgD23cUR+x2GtjORoUgXkAAKKv+moIpN6IrSDxBjrbtjr/TPllVTCZCeiX+tvZVrQ3p/+Kku1DP3p5TeZdXv88XB/r29BuGkV1SBSKw8XFqpayx5FSsAlfKW6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0QpustUL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+0CrINsq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqK3kZyCHT0jvTPKaSP5MkWN9c+Y2ErD5GwaMRu/8VQ=;
	b=0QpustULOXQ3N2C6IS/ts1qt2742jQAdQ+thuSabR8XR9uEXSKx8QtzKrC1fLgTIgJoNHg
	kCJ5DOI1fONG7lVRQ7JuAM8fZR29Em6597awTF7HJAUF80bbk+hhFPXPG8hii+mwPAV726
	gSh52lb/6PXAzMRNz71WCqRZIAhWGxuEb7b/ucqXMwWPr7TF3ZkLZUs93sfxmQt8ghBC4w
	uJDKqB3JUgsrCQiFHW1WOJXIAp2p14KSyiq8YyMlxJPZfjO4EFicuF9ogOvJDf3/bYH3IO
	CDMJ4c0usk8kzOly66KREDsWh7P3rHHO/Zrzxev2xgK0ny09iIU7iyvD02bQJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqK3kZyCHT0jvTPKaSP5MkWN9c+Y2ErD5GwaMRu/8VQ=;
	b=+0CrINsqy0sbhVH+K+VqejJrmR5ZV6AMHrUZKCVOE7F0XBoYgWD5D6wnNDc09YJ34K/cBd
	50hoz3naXecQnoAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/posix-timers: Add a test for
 exact allocation mode
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <8734fl2tkx.ffs@tglx>
References: <8734fl2tkx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186547979.14745.7358143447479798419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8e63360d869913265e5e4b623dcd23feff9fd000
Gitweb:        https://git.kernel.org/tip/8e63360d869913265e5e4b623dcd23feff9fd000
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Mar 2025 09:11:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:18 +01:00

selftests/timers/posix-timers: Add a test for exact allocation mode

The exact timer ID allocation mode is used by CRIU to restore timers with a
given ID. Add a test case for it.

It's skipped on older kernels when the prctl() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/8734fl2tkx.ffs@tglx

---
 tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 9814b3a..f0eceb0 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -7,6 +7,7 @@
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
 #define _GNU_SOURCE
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <stdio.h>
@@ -599,14 +600,84 @@ static void check_overrun(int which, const char *name)
 			 "check_overrun %s\n", name);
 }
 
+#include <sys/syscall.h>
+
+static int do_timer_create(int *id)
+{
+	return syscall(__NR_timer_create, CLOCK_MONOTONIC, NULL, id);
+}
+
+static int do_timer_delete(int id)
+{
+	return syscall(__NR_timer_delete, id);
+}
+
+#ifndef PR_TIMER_CREATE_RESTORE_IDS
+# define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	 0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		 1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	 2
+#endif
+
+static void check_timer_create_exact(void)
+{
+	int id;
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON, 0, 0, 0)) {
+		switch (errno) {
+		case EINVAL:
+			ksft_test_result_skip("check timer create exact, not supported\n");
+			return;
+		default:
+			ksft_test_result_skip("check timer create exact, errno = %d\n", errno);
+			return;
+		}
+	}
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, 0, 0) != 1)
+		fatal_error(NULL, "prctl(GET) failed\n");
+
+	id = 8;
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF, 0, 0, 0))
+		fatal_error(NULL, "prctl(OFF)");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, 0, 0) != 0)
+		fatal_error(NULL, "prctl(GET) failed\n");
+
+	if (id != 8) {
+		ksft_test_result_fail("check timer create exact %d != 8\n", id);
+		return;
+	}
+
+	/* Validate that it went back to normal mode and allocates ID 9 */
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (id == 9)
+		ksft_test_result_pass("check timer create exact\n");
+	else
+		ksft_test_result_fail("check timer create exact. Disabling failed.\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(18);
+	ksft_set_plan(19);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
+	check_timer_create_exact();
+
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
 	check_itimer(ITIMER_REAL, "ITIMER_REAL");

