Return-Path: <linux-tip-commits+bounces-1884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F8941C9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C47F1C23738
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8411A3DDA;
	Tue, 30 Jul 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HMuWvFaH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9JzrmOBz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01E1A4B32;
	Tue, 30 Jul 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359199; cv=none; b=jzX9Mnt+26xWreTUiX18qb9p0TWefWg/c3cFB7EiLeodoJtlCiYc5i5v++xprMQZHUY9RKoEfoM9bTOh32W87h7Bafee3tm/X7owXCCi46q0hCc4ZXOu92P1SW1Nab5r1lYR4tUbNjGqDJM1sL/+hf0sjZl2D2olUfbXNbXEouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359199; c=relaxed/simple;
	bh=EEDYDMVhZP/KkVuxTCJBxXZHS3JepZUwgIr/939FfgY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HgCH8e88WJn1rnuZZi1tdPXsHfEM9zu6uUNFSJBYuuXVRTvn+eG/vTwku6D5bfQd5KrG/1KknX5TkLb6I03DZHLrP6m0HcrB8C3cgQhXyURU4n4sgM2QlcMdRaArpHiG+ZMJKLvuKX8kXw8gk5dSY40U8Or+ihGYiKei76jGCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HMuWvFaH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9JzrmOBz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4M6J6bFE9n5gT/tfFcaDOB1D0/yzPWtERb+OE3B/Si4=;
	b=HMuWvFaHzz97Q049RCOKb7321ZBEvIhseIv+ukA+fiODH2kiGwhwsNyLTbK4V0osFqWGLA
	VItGjE1EWFdQQE/u9zyGeCxPaEq3FvK9ZfGJAfAqlhFUFN5daH7fOC46Ko9qHPTiT8axb5
	EcSnJx9Q9hZWfAjDorxsbDpafNQeDMkiDQoPsi+bAqZLGp0ntnvHVCxXIlkm11y1HpnCDV
	kKceCTBbYxWHcji+mk6dYjmVToz1uQDmL1JJJ1L7FZwFfMXzt99SYyyCcUH1Npu2Q9Nixx
	1djKEFbsvSKb8tQOUWxoAc1/6sHJxMUGDR6I0UTn0LlOVr5Vut5X37GOWDQsoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4M6J6bFE9n5gT/tfFcaDOB1D0/yzPWtERb+OE3B/Si4=;
	b=9JzrmOBz2+pguHAw951JgrAO63RveKW7ZzSG9FUzhe4/ecAoV1PvI7+KCkvdlPqGztWlXW
	CGddgBz4bYqgi4Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] selftests/timers/posix-timers: Validate timer_gettime()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919574.2215.15779705659117719042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f924f868ed05d954d79db419e97ba11293110d52
Gitweb:        https://git.kernel.org/tip/f924f868ed05d954d79db419e97ba11293110d52
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:11 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix-timers: Validate timer_gettime()

timer_gettime() must return the correct expiry time for interval timers
even when the timer is not armed, which is the case when a signal is
pending but blocked.

Works correctly for regular posix timers, but not for posix CPU timers.

Add a selftest to validate the fixes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 58 +++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 097a132..4c993db 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -487,10 +487,63 @@ static void check_sigev_none(int which, const char *name)
 			 "check_sigev_none %s\n", name);
 }
 
+static void check_gettime(int which, const char *name)
+{
+	struct itimerspec its, prev;
+	struct timespec start, now;
+	struct sigevent sev;
+	timer_t timerid;
+	int wraps = 0;
+	sigset_t set;
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
+
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
+	if (timer_gettime(timerid, &prev))
+		fatal_error(name, "timer_gettime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+		if (timer_gettime(timerid, &its))
+			fatal_error(name, "timer_gettime()");
+		if (its.it_value.tv_nsec > prev.it_value.tv_nsec)
+			wraps++;
+		prev = its;
+
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(wraps > 1, "check_gettime %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(12);
+	ksft_set_plan(15);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -518,6 +571,9 @@ int main(int argc, char **argv)
 	check_delete();
 	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }

