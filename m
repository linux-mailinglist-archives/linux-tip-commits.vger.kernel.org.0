Return-Path: <linux-tip-commits+bounces-1887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F924941CA3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15FC1C23615
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAF1A56A3;
	Tue, 30 Jul 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+YUsJsL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVYVP9SX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62621A3DAF;
	Tue, 30 Jul 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359201; cv=none; b=HkDniWW46pzd46xwn83hSHmGwugAQa4FzuBk/6uyEF7ExhhaHoaSqazWEzk7vC8Moq/PLUlo6D6jFyzw6pcwUUnC6Ac1FVKn5XYV7MydfDwpGmemQdUhPEKYn+OnOcLL7XoJ9mcMZQEuWui4qWWOvcjfTadgKE4eQg2DhkiUfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359201; c=relaxed/simple;
	bh=sLw7BTDQMPZOtN+Fqqi4I+1boLhhFnu5YsZD2HnV5hU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SP1aNS2B6fNsnb9lDsfT+d1XThmcKZ8OhLWCXJwH2B3oTtH2Rq1vs1VX2T52AInvaYAba/RRJO2t5ek1gE9U1uu0pvZg1HiJDMB5hI9hYIFsms6DuAeBZstrhv+frDILkjQ61NuqD0ehzYAsysEU6Qn04zj26om2hnpICMJQADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+YUsJsL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVYVP9SX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f/+lcoxn8OcbGEny1gCkeUO062GvnLQFor7DsDJBs2Y=;
	b=R+YUsJsLjlNWAP7Z28D0mfz93f5rkq5bz5liZnSjcvHa7K33oBlgKsLUCnd48iETW4hVeE
	GJjVYx4MRZPMI6Vgu86hyNvhee/EgojltbIBHNP3U1bZ8QkHhjIwhMkc94g76y9Q2+XTnm
	iMYhEjh0l0bcXmp75ElfVqDZXisX0sTYB6r5jIx+plu9hBD6gk82a1E0hzU283fQrmrAVX
	M65oEF7wGW8I+PBnM+UhtNa5IWIlb6AE2NUOxC2IUpgDwBs1lvhaWBzhjtzObIV0lXZq3l
	EjknNiOJ3L4YBvzts7eU1SvoqZ+YxC+ETl6QNHmgCrGuqIcj2aWe9WSZzs0ubw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f/+lcoxn8OcbGEny1gCkeUO062GvnLQFor7DsDJBs2Y=;
	b=CVYVP9SXXW7pceHtMRQyGxgcdUq2Mjcg3fLfb+/ZywJmotU4Mu+s0xBXbpHNaiQHo4rSDD
	TgpTUzb1rbzdsfAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/posix-timers: Validate SIGEV_NONE
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919618.2215.3752821533607227878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2c2b56132bb74b6b801dcb82f57489ae1cf81a91
Gitweb:        https://git.kernel.org/tip/2c2b56132bb74b6b801dcb82f57489ae1cf81a91
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:10 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

selftests/timers/posix-timers: Validate SIGEV_NONE

Posix timers with a delivery mode of SIGEV_NONE deliver no signals but the
remaining expiry time must be readable via timer_gettime() for both one
shot and interval timers.

That's implemented correctly for regular posix timers but broken for posix
CPU timers.

Add a self test so the fixes can be verified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 53 +++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 41b43d1..097a132 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
+#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
@@ -20,6 +21,7 @@
 
 #define DELAY 2
 #define USECS_PER_SEC 1000000
+#define NSECS_PER_SEC 1000000000
 
 static void __fatal_error(const char *test, const char *name, const char *what)
 {
@@ -438,10 +440,57 @@ static void check_delete(void)
 	ksft_test_result(!tsig.signals, "check_delete\n");
 }
 
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+
+	diff = NSECS_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+static void check_sigev_none(int which, const char *name)
+{
+	struct timespec start, now;
+	struct itimerspec its;
+	struct sigevent sev;
+	timer_t timerid;
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_NONE;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_gettime(timerid, &its))
+		fatal_error(name, "timer_gettime()");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(its.it_value.tv_sec || its.it_value.tv_nsec,
+			 "check_sigev_none %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(10);
+	ksft_set_plan(12);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -467,6 +516,8 @@ int main(int argc, char **argv)
 	check_sig_ign(1);
 	check_rearm();
 	check_delete();
+	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 
 	ksft_finished();
 }

