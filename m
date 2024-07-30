Return-Path: <linux-tip-commits+bounces-1886-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A9941CA1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E3286444
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECC1A5695;
	Tue, 30 Jul 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mY9zMUyh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x7EQsSD0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398801A3DCA;
	Tue, 30 Jul 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359201; cv=none; b=P8HZ/ig+cwiET7fm+biP1lePI1zncSd2zPahxwcVhyNq8mns0fUdteT1Wyy4ppnWBLzhEoxd/KpD4zfCakfSJnLoayVdrLjcpyqWLtVLKLSrGbeiKCMd1hPFOTUCMteXxNNqnE60yw6ogUEk5+aL+lbo4W17S88MG09uoZP/91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359201; c=relaxed/simple;
	bh=dsW1UlSH3W78AohLzhWISglm00cjdlBJNa4aUSCNeZk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=B8KFf+eGIIroDoZABbd4U4IHjn/UOsz0gjKqqKni3paobtckmGi9tBM4aEAY3vQn53vRVojEADyGjtCP/b+JerQEnPrpWJC00HpgOEEu6DbH++78cymEcVOGc85xaNi+7EiCUzUQtsHDKGeAC26ImipQjaqOnu1oycqNtfAWSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mY9zMUyh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x7EQsSD0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=41qZ6dAePFjMobfE6G66yYk17XUBvvoyDpRpuPbwpQY=;
	b=mY9zMUyhef9toe4WAU8eKV1auhEvWZkQdUizsUArS9ZV/t76/R3ht80hPy5vUwc4lL15CP
	fJ+2bRqrksLTEuN7l2asjtMC3R+qEnqlA1zcGTLtzB73hoV4TTZetN6Y30vAr5JVgoRYaz
	b7P47bhEf82ub+nJJdgmpC+z6tdKgCyqcpH5YLqxJGG7ZXosHndownyGvZTNyCBdABcSIy
	xMrYWicQiu7MjsJAXdoQpkywEf9so4yHZOXpvi+YcPwOGuZygp859/ErrHiOiWuRdBt6OJ
	QDMOevRaiHVTnGEcDn36FJgF4Pn6Y8yQIMQGwUtH+O4la4jecwOVm/tRVvgL+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=41qZ6dAePFjMobfE6G66yYk17XUBvvoyDpRpuPbwpQY=;
	b=x7EQsSD09n9wlyFpBJklLEatlR5xTEn71HRapU3I9Ymo8H4gEqax3JV2f+uK7QVEKc+6O/
	4li3nBk6U90BT4DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/posix_timers: Add SIG_IGN test
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919708.2215.8583429542972280603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     45c4225c3dcc7db2c0cdbf889cc7a9c72a53f742
Gitweb:        https://git.kernel.org/tip/45c4225c3dcc7db2c0cdbf889cc7a9c72a53f742
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:07 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix_timers: Add SIG_IGN test

Add a test case to validate correct behaviour vs. SIG_IGN.

The posix specification states:

  "Setting a signal action to SIG_IGN for a signal that is pending shall
   cause the pending signal to be discarded, whether or not it is blocked."

The kernel implements this in the signal handling code, but due to the way
how posix timers are handling SIG_IGN for periodic timers, the behaviour
after installing a real handler again is inconsistent and suprising.

The following sequence is expected to deliver a signal:

  install_handler(SIG);
  block_signal(SIG);
  timer_create(...);	 <- Should send SIG
  timer_settime(value=100ms, interval=100ms);
  sleep(1);		 <- Timer expires and queues signal, timer is not rearmed
  			    as that should happen in the signal delivery path
  ignore_signal(SIG);	 <- Discards queued signal
  install_handler(SIG);  <- Restore handler, should rearm but does not
  sleep(1);
  unblock_signal(SIG);	 <- Should deliver one signal with overrun count
  			    set in siginfo

This fails because nothing rearms the timer when the signal handler is
restored. Add a test for this case which fails until the signal and posix
timer code is fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 127 ++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 38db82c..8a6139a 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -6,8 +6,9 @@
  *
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
-
+#define _GNU_SOURCE
 #include <sys/time.h>
+#include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
 #include <string.h>
@@ -214,10 +215,129 @@ static void check_timer_distribution(void)
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
 }
 
+struct tmrsig {
+	int	signals;
+	int	overruns;
+};
+
+static void siginfo_handler(int sig, siginfo_t *si, void *uc)
+{
+	struct tmrsig *tsig = si ? si->si_ptr : NULL;
+
+	if (tsig) {
+		tsig->signals++;
+		tsig->overruns += si->si_overrun;
+	}
+}
+
+static void *ignore_thread(void *arg)
+{
+	unsigned int *tid = arg;
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	*tid = gettid();
+	sleep(100);
+
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+	return NULL;
+}
+
+static void check_sig_ign(int thread)
+{
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	unsigned int tid = 0;
+	struct sigaction sa;
+	struct sigevent sev;
+	pthread_t pthread;
+	timer_t timerid;
+	sigset_t set;
+
+	if (thread) {
+		if (pthread_create(&pthread, NULL, ignore_thread, &tid))
+			fatal_error(NULL, "pthread_create()");
+		sleep(1);
+	}
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+	if (thread) {
+		sev.sigev_notify = SIGEV_THREAD_ID;
+		sev._sigev_un._tid = tid;
+	}
+
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	sleep(1);
+
+	/* Set the signal to be ignored */
+	if (signal(SIGUSR1, SIG_IGN) == SIG_ERR)
+		fatal_error(NULL, "signal(SIG_IGN)");
+
+	sleep(1);
+
+	if (thread) {
+		/* Stop the thread first. No signal should be delivered to it */
+		if (pthread_cancel(pthread))
+			fatal_error(NULL, "pthread_cancel()");
+		if (pthread_join(pthread, NULL))
+			fatal_error(NULL, "pthread_join()");
+	}
+
+	/* Restore the handler */
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	sleep(1);
+
+	/* Unblock it, which should deliver the signal in the !thread case*/
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	if (!thread) {
+		ksft_test_result(tsig.signals == 1 && tsig.overruns == 29,
+				 "check_sig_ign SIGEV_SIGNAL\n");
+	} else {
+		ksft_test_result(tsig.signals == 0 && tsig.overruns == 0,
+				 "check_sig_ign SIGEV_THREAD_ID\n");
+	}
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(6);
+	ksft_set_plan(8);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -239,5 +359,8 @@ int main(int argc, char **argv)
 	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_timer_distribution();
 
+	check_sig_ign(0);
+	check_sig_ign(1);
+
 	ksft_finished();
 }

