Return-Path: <linux-tip-commits+bounces-7359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1AC5F13F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF734C007
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3A2DAFDF;
	Fri, 14 Nov 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5vOGa/i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="040VLkWn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8837261B;
	Fri, 14 Nov 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149150; cv=none; b=RQQa/XzCnzLZit9dTsNPnJhKAttNBqXik9217m5Ddd4NsTbhsk3parmhvMWNGIgqhfM6/pvVbE/zB47u/AUUgc0cfmhyz6lSTPDLQuLz4pzOpYVsyykFmpjP3wMCbdkRNZDjFlPT9rpExkbcVZdEsQEI9D3HQFHudyqpjlKppwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149150; c=relaxed/simple;
	bh=CqG7cjvKjYESDWDU/V6ajQG+FvZ3u5oaaROdrC2xA/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gql0JMfB4h2P8jXprA/iySmBsTarQm7aDaz0ZM621LxuHQpuFiboGJEWfE0M4NHk0KA06nHBLCJPXV+1f2BwpfW1CUTP7BxPFt7jOx/n/N4x7y56NKfcuScYnfhH046TNFWA+qlR8G36lNzSjhmnECWJAabkn7A7jJehwIfZH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5vOGa/i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=040VLkWn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 19:39:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763149147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm/uWWnyb2VRnjxeoGN/L2qIYWueJhnrMTz1IxuTG7M=;
	b=X5vOGa/iFa3teNdKCqX+06KIhooukTIQOrrZaz06O+aHofu/KMEoCL/Q/WJhUE46Jfl2xG
	S1bnYuj8LRGebWTad7HvJsDtSxp46ZYqYeyVl7I2QtuWlZNeuolH9yCAIFg0u8WHT5f9Ic
	8nY3V2ZUD679pjNsTTA3o3vSfuVaNpEoffb6EoFQm3ER+zIcA39AHIWHGA25K20wIHt+iN
	Ti5a44Jq3Qb8KG79+kX2DwrVy8MnAgOqgT0UNZ0kN9YXRKm7/dHczdalWNO5EnvJd7UAz4
	MQdzSAkq+gHDs4hE747O5yIKOZ9XH8GWtxw2qSRqHlpvYnRLq15BWuLLpwVOLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763149147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm/uWWnyb2VRnjxeoGN/L2qIYWueJhnrMTz1IxuTG7M=;
	b=040VLkWnYc7RjKMLZQWqCyghFLpZCOb1JaEYQGhLF6Nt5WR4LrDvmfqNYzjUJz3HON8pWO
	yi1SVExVA66+I8Dg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/nanosleep: Add tests for return
 of remaining time
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20251106-nanosleep-rtmp-selftest-v1-1-f9212fb295fe@linutronix.de>
References: <20251106-nanosleep-rtmp-selftest-v1-1-f9212fb295fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176314914597.498.8498539686845528677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     308bc2e33885df9288d3f1ed946a2b212e37db62
Gitweb:        https://git.kernel.org/tip/308bc2e33885df9288d3f1ed946a2b212e3=
7db62
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 06 Nov 2025 16:15:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 20:34:50 +01:00

selftests/timers/nanosleep: Add tests for return of remaining time

If interrupted by a signal clock_nanosleep() returns the remaining time
into the structure pointed to by the rmtp parameter. So far this
functionality was not tested by the timer selftests.

Extend the nanosleep selftest to cover this feature.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251106-nanosleep-rtmp-selftest-v1-1-f9212fb2=
95fe@linutronix.de
---
 tools/testing/selftests/timers/nanosleep.c | 55 +++++++++++++++++++++-
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selft=
ests/timers/nanosleep.c
index 252c630..10badae 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -116,6 +116,56 @@ int nanosleep_test(int clockid, long long ns)
 	return 0;
 }
=20
+static void dummy_event_handler(int val)
+{
+	/* No action needed */
+}
+
+static int nanosleep_test_remaining(int clockid)
+{
+	struct timespec rqtp =3D {}, rmtp =3D {};
+	struct itimerspec itimer =3D {};
+	struct sigaction sa =3D {};
+	timer_t timer;
+	int ret;
+
+	sa.sa_handler =3D dummy_event_handler;
+	ret =3D sigaction(SIGALRM, &sa, NULL);
+	if (ret)
+		return -1;
+
+	ret =3D timer_create(clockid, NULL, &timer);
+	if (ret)
+		return -1;
+
+	itimer.it_value.tv_nsec =3D NSEC_PER_SEC / 4;
+	ret =3D timer_settime(timer, 0, &itimer, NULL);
+	if (ret)
+		return -1;
+
+	rqtp.tv_nsec =3D NSEC_PER_SEC / 2;
+	ret =3D clock_nanosleep(clockid, 0, &rqtp, &rmtp);
+	if (ret !=3D EINTR)
+		return -1;
+
+	ret =3D timer_delete(timer);
+	if (ret)
+		return -1;
+
+	sa.sa_handler =3D SIG_DFL;
+	ret =3D sigaction(SIGALRM, &sa, NULL);
+	if (ret)
+		return -1;
+
+	if (!in_order((struct timespec) {}, rmtp))
+		return -1;
+
+	if (!in_order(rmtp, rqtp))
+		return -1;
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	long long length;
@@ -150,6 +200,11 @@ int main(int argc, char **argv)
 			}
 			length *=3D 100;
 		}
+		ret =3D nanosleep_test_remaining(clockid);
+		if (ret < 0) {
+			ksft_test_result_fail("%-31s\n", clockstring(clockid));
+			ksft_exit_fail();
+		}
 		ksft_test_result_pass("%-31s\n", clockstring(clockid));
 next:
 		ret =3D 0;

