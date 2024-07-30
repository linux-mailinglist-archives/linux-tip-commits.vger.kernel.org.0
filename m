Return-Path: <linux-tip-commits+bounces-1883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F53941C99
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7B2837B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC541A3DD1;
	Tue, 30 Jul 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNcwf8MI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7ncehyK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649F188003;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359199; cv=none; b=czphPmC7sysk7+vBFb6Wa5CTk0UHO2vIfDbRX9ywygXw5IhvDNW83tWwMgBjfk55SUOsQypTsx0RY5uWI3pp3rid3MtoxC3cc3Lm8o5LrIyHrMRkBiuERNX2FsTB8HLr8aXx3mGKvGMTk1Nur9qHWMwzJ3Xeh4YacffAWASMiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359199; c=relaxed/simple;
	bh=RQ3JljVuSu4QnR6NdKUm59a6nvQrRgPYYGE8mh3QiEo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AfYkbWaGRLBNmwEwBdczCITMYKPBp4DVCd+YUpwQ+ikQfZYwCbnSk30o3JqYgP9VbQ9z6KWbJZ4h3xC5KWLV8rnTWAaBadT1FBAHpmyAWz17bnmzac2Q5RvuxkDLcov//9NOKqFd4knzy2HiOQDLCsbwzH/I9luFZNNlEoh8MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNcwf8MI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7ncehyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bmK1ZEshjxFv3IvNgvBBeJGXpZyS1PckYYOyNgKkEH0=;
	b=yNcwf8MISfcXQy3UZ1GCH+INb52ONNAMYdFNDEXff4xWsg4sA8k/1LrLWS5JHmPVvZLC9J
	JfFKO+s/zlgGhC7lcPd8pmk++q0u+4uaoU5Z0BORNSNJYS3LCf35ZxgEa4RDf8ilHa77oA
	KVCwjAnDmQN0LSfr6oBxZyp8wpsL15Kmzd4pqf5u5De3EWjR5wJjnBR6Ml6jbbB9OaVeFB
	/uDPhjBNgPkrrL0t+SpiMUNYHD+zC4sRkUnpApIFrYgvc5IWFadKo8AgOwwNRZqPx+u7v5
	sbWmjTi7DaYJl2rMa91fTxJRfKnkPYQeHGjpVtWSQ0VN+nf76mSXeHeeQkqP2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bmK1ZEshjxFv3IvNgvBBeJGXpZyS1PckYYOyNgKkEH0=;
	b=t7ncehyKuACDYQkdscthZHlm62PicfqNnCQZ35yrnwWOXHk2MuKfaJ30QO9RBZtXA/ngJm
	VsTqLO9kF5/cuUDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/posix-timers: Validate overrun
 after unblock
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919532.2215.16708603692605134961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     73339b82f86521eeadbb781d8d7e04813cbd0998
Gitweb:        https://git.kernel.org/tip/73339b82f86521eeadbb781d8d7e04813cbd0998
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:12 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix-timers: Validate overrun after unblock

When a timer signal is blocked and later unblocked then one signal should
be delivered with the correct number of overruns since the timer was queued.

Validate that behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 61 +++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 4c993db..16bd494 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -540,10 +540,66 @@ static void check_gettime(int which, const char *name)
 	ksft_test_result(wraps > 1, "check_gettime %s\n", name);
 }
 
+static void check_overrun(int which, const char *name)
+{
+	struct timespec start, now;
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(name, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(name, "timer_settime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	/* Unblock it, which should deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(tsig.signals == 1 && tsig.overruns == 9,
+			 "check_overrun %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(15);
+	ksft_set_plan(18);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -574,6 +630,9 @@ int main(int argc, char **argv)
 	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }

