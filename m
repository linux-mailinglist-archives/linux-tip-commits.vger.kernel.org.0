Return-Path: <linux-tip-commits+bounces-1885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA78941C9E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53024285027
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCB18A6CE;
	Tue, 30 Jul 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lURKqFip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDzVSIyH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AE3DAC1E;
	Tue, 30 Jul 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359200; cv=none; b=hl9klRvl5UrYNGqN9N1J3KeXv+soDXPMeEc3TACeSrI8BK9EKrEv2HrDTUWPhWmqZUrkRSxzpZMUM5OPVga8a9tX+ReQjZrWvTfAwXsNmjA4LLNA//rSXdBaqT9TimWHN7XMBBGgq/qg2U8NHkSYqOvUQM2ffe5r8chg30oooww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359200; c=relaxed/simple;
	bh=8ZJPgBt34EBbLK0XV67P7/X1HmZxSe4Izehwj3JaI4I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pZJ8c3tG6qPn9tRnGwtjSCFeiHWZBWTWW84upM9HLZbzJ/NEObFBHZXZdbe8gATwkIpGcRPVQy0Z23VKlJxEvUjgBD+RNKP+suggQadYdowuehggAmCgWsbDOC+a+3yqNmwpIlCn3k1JbrqeD4n7VPI9GMRjeDAUt1QXJ50KAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lURKqFip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDzVSIyH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nRoCeBf7egkFsiCHhjaVhL5QARQuyFUSX+vK4KBDK9c=;
	b=lURKqFipwZ4hBk9uJWNX4lIn0A2R2DR7O6R9FxzU07xLoM+JgCo0GiElXyvHNDHflX9Unh
	2BbE4XWDKXz62D+d3Ysi7Dg/cvOadvSUgVzuyUW29M/EbZo9OfpndBJb44SoSKKxWoKd/c
	4lkURIiXrt2TdOyhJT+tJq3ESUp6cYp6b46t2judtqxDlUsePfvZAJCYdRHCt5qmjQi2bp
	lBNKeNeFvjgsko9AkhAv0B2IkXb9/h+XZ6CPIhPm+7HJo3DobjYf22Apbjws4iAShzPo+P
	1OMfPc1kOCRJwX8XhxxVq6Gx8m3ch9Qx5xvhFhQT+w99rzpbk6tSpvRd9YBKGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nRoCeBf7egkFsiCHhjaVhL5QARQuyFUSX+vK4KBDK9c=;
	b=dDzVSIyHQuQ8p77VkGdbazG54aplm+M4xtXRr09IRc9dxPm5Y1CUt+qX1z3JshxhAA7rT1
	gGypNJengCoB94Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] selftests/timers/posix_timers: Validate signal rules
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919666.2215.6582465937669508664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e65bb03e442751ccf1631382516dcca5b3a20122
Gitweb:        https://git.kernel.org/tip/e65bb03e442751ccf1631382516dcca5b3a20122
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:09 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix_timers: Validate signal rules

Add a test case to validate correct behaviour vs. timer reprogramming and
deletion.

The handling of queued signals in case of timer reprogramming or deletion
is inconsistent at best.

POSIX does not really specify the behaviour for that:

 - "The effect of disarming or resetting a timer with pending expiration
   notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which
has been disarmed.

Add tests to validate that no unexpected signals are delivered. They fail
for now until the signal and posix timer code is updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 108 ++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 8a6139a..41b43d1 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -334,10 +334,114 @@ static void check_sig_ign(int thread)
 	}
 }
 
+static void check_rearm(void)
+{
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
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	/* Reprogram the timer to single shot */
+	its.it_value.tv_sec = 10;
+	its.it_value.tv_nsec = 0;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 0;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	ksft_test_result(!tsig.signals, "check_rearm\n");
+}
+
+static void check_delete(void)
+{
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
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	ksft_test_result(!tsig.signals, "check_delete\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(8);
+	ksft_set_plan(10);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -361,6 +465,8 @@ int main(int argc, char **argv)
 
 	check_sig_ign(0);
 	check_sig_ign(1);
+	check_rearm();
+	check_delete();
 
 	ksft_finished();
 }

