Return-Path: <linux-tip-commits+bounces-1888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C9941CA8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36418B23A38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A51A56B1;
	Tue, 30 Jul 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QoOEndaI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3WVuPaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4418C907;
	Tue, 30 Jul 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359201; cv=none; b=s2qnXjWV7tFp3EhQY66bH6MklyfeOC3eGny9ls8Xz2zbGiTDflPaIGtvdqB/iAcj2d6D96YydgWJNaGG+vzzkbNlsJKD5XIAzK5kj5TvTrkxKHjMmT975YcTLl3aMXMsIDofXEwGdtdVOvXook+yJLNplcV/z5RjFp5rQWytdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359201; c=relaxed/simple;
	bh=VpNcHbhJMVkQzK37gufq1qJOirGgZDBUxMIfqM1WMJk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SsC77sFUy5ElDRri37nS5VOH/ACUY7tFmaqOJmEkWFbFTvr+lxpM7GCpR+8rPn1Aog/JIzONVKI8222yf3HAS05lkz1/oqWoWTLbqOum2onBR7PeO/9iOzt7bht2068cBde++rLKMb4wpieG359oQ2puNU3o6/0BnskA7nSeH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QoOEndaI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3WVuPaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1GSNgRge/ShNllYXBvKwjEQdJwmkvEYVSVbbURbu02k=;
	b=QoOEndaITTFtsNVorfpCqJV0hF1/WDFOjwJukwdq+Vrhl/zZ29uCUuslI9NnQZTE11ZM8M
	2Fnrg1VM6gNW+MgI3rGdGlrcuVovKfV9RiRZSSm9yHU3Kzj1iXNCN66uqdT08Pxwa1WDfi
	9ZFBHw52C/DhmQtxxjcizVBFt0H48ZBws7kmkJHTN9qozn3fehnQaw64WOJDr3QTE8tflB
	JpKCAvdDxGmkjAFXdScsHHLjudnH35jhCQ2ptPtBUybT7tjKU1iEkqrWR6qiiZkpbLo7AS
	zZVH5do9HYwdVj/eJ0c3Su3IcDt5pD8RRyXwC83RCUEIYx64iKrpAOJBSKvKdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1GSNgRge/ShNllYXBvKwjEQdJwmkvEYVSVbbURbu02k=;
	b=b3WVuPaVOAIQNADjy8/N9yk7Kawo32E+mQX3wOTtSH1hkOMP5hjrPdN93vXtyECiUWw86+
	chWkJT57b8Iu7hBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] selftests/timers/posix_timers: Simplify error handling
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919756.2215.8366740488070916839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0af02a8e356fc6d3b1eebb32fae7d35625127835
Gitweb:        https://git.kernel.org/tip/0af02a8e356fc6d3b1eebb32fae7d35625127835
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:06 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix_timers: Simplify error handling

No point in returning to main() on fatal errors. Just exit right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c | 151 +++++------------
 1 file changed, 52 insertions(+), 99 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 07c81c0..38db82c 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -10,6 +10,7 @@
 #include <sys/time.h>
 #include <stdio.h>
 #include <signal.h>
+#include <string.h>
 #include <unistd.h>
 #include <time.h>
 #include <pthread.h>
@@ -19,6 +20,20 @@
 #define DELAY 2
 #define USECS_PER_SEC 1000000
 
+static void __fatal_error(const char *test, const char *name, const char *what)
+{
+	char buf[64];
+
+	strerror_r(errno, buf, sizeof(buf));
+
+	if (name && strlen(name))
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	else
+		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+}
+
+#define fatal_error(name, what)	__fatal_error(__func__, name, what)
+
 static volatile int done;
 
 /* Busy loop in userspace to elapse ITIMER_VIRTUAL */
@@ -74,24 +89,13 @@ static int check_diff(struct timeval start, struct timeval end)
 	return 0;
 }
 
-static int check_itimer(int which)
+static void check_itimer(int which, const char *name)
 {
-	const char *name;
-	int err;
 	struct timeval start, end;
 	struct itimerval val = {
 		.it_value.tv_sec = DELAY,
 	};
 
-	if (which == ITIMER_VIRTUAL)
-		name = "ITIMER_VIRTUAL";
-	else if (which == ITIMER_PROF)
-		name = "ITIMER_PROF";
-	else if (which == ITIMER_REAL)
-		name = "ITIMER_REAL";
-	else
-		return -1;
-
 	done = 0;
 
 	if (which == ITIMER_VIRTUAL)
@@ -101,17 +105,11 @@ static int check_itimer(int which)
 	else if (which == ITIMER_REAL)
 		signal(SIGALRM, sig_handler);
 
-	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
-	err = setitimer(which, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (setitimer(which, &val, NULL) < 0)
+		fatal_error(name, "setitimer()");
 
 	if (which == ITIMER_VIRTUAL)
 		user_loop();
@@ -120,68 +118,41 @@ static int check_itimer(int which)
 	else if (which == ITIMER_REAL)
 		idle_loop();
 
-	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
 	ksft_test_result(check_diff(start, end) == 0, "%s\n", name);
-
-	return 0;
 }
 
-static int check_timer_create(int which)
+static void check_timer_create(int which, const char *name)
 {
-	const char *type;
-	int err;
-	timer_t id;
 	struct timeval start, end;
 	struct itimerspec val = {
 		.it_value.tv_sec = DELAY,
 	};
-
-	if (which == CLOCK_THREAD_CPUTIME_ID) {
-		type = "thread";
-	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
-		type = "process";
-	} else {
-		ksft_print_msg("Unknown timer_create() type %d\n", which);
-		return -1;
-	}
+	timer_t id;
 
 	done = 0;
-	err = timer_create(which, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	signal(SIGALRM, sig_handler);
 
-	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (timer_create(which, NULL, &id) < 0)
+		fatal_error(name, "timer_create()");
 
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (signal(SIGALRM, sig_handler) == SIG_ERR)
+		fatal_error(name, "signal()");
+
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
+
+	if (timer_settime(id, 0, &val, NULL) < 0)
+		fatal_error(name, "timer_settime()");
 
 	user_loop();
 
-	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
 	ksft_test_result(check_diff(start, end) == 0,
-			 "timer_create() per %s\n", type);
-
-	return 0;
+			 "timer_create() per %s\n", name);
 }
 
 static pthread_t ctd_thread;
@@ -209,15 +180,14 @@ static void *ctd_thread_func(void *arg)
 
 	ctd_count = 100;
 	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
-		return "Can't create timer\n";
+		fatal_error(NULL, "timer_create()");
 	if (timer_settime(id, 0, &val, NULL))
-		return "Can't set timer\n";
-
+		fatal_error(NULL, "timer_settime()");
 	while (ctd_count > 0 && !ctd_failed)
 		;
 
 	if (timer_delete(id))
-		return "Can't delete timer\n";
+		fatal_error(NULL, "timer_delete()");
 
 	return NULL;
 }
@@ -225,19 +195,16 @@ static void *ctd_thread_func(void *arg)
 /*
  * Test that only the running thread receives the timer signal.
  */
-static int check_timer_distribution(void)
+static void check_timer_distribution(void)
 {
-	const char *errmsg;
-
-	signal(SIGALRM, ctd_sighandler);
+	if (signal(SIGALRM, ctd_sighandler) == SIG_ERR)
+		fatal_error(NULL, "signal()");
 
-	errmsg = "Can't create thread\n";
 	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
-		goto err;
+		fatal_error(NULL, "pthread_create()");
 
-	errmsg = "Can't join thread\n";
-	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
-		goto err;
+	if (pthread_join(ctd_thread, NULL))
+		fatal_error(NULL, "pthread_join()");
 
 	if (!ctd_failed)
 		ksft_test_result_pass("check signal distribution\n");
@@ -245,10 +212,6 @@ static int check_timer_distribution(void)
 		ksft_test_result_fail("check signal distribution\n");
 	else
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
-	return 0;
-err:
-	ksft_print_msg("%s", errmsg);
-	return -1;
 }
 
 int main(int argc, char **argv)
@@ -259,17 +222,10 @@ int main(int argc, char **argv)
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
-	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_PROF) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_REAL) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		ksft_exit_fail();
+	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
+	check_itimer(ITIMER_PROF, "ITIMER_PROF");
+	check_itimer(ITIMER_REAL, "ITIMER_REAL");
+	check_timer_create(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -280,11 +236,8 @@ int main(int argc, char **argv)
 	 * to ensure true parallelism. So test only one thread until we
 	 * find a better solution.
 	 */
-	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_distribution() < 0)
-		ksft_exit_fail();
+	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_timer_distribution();
 
 	ksft_finished();
 }

