Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF34278A8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJIKJA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhJIKI7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:08:59 -0400
Date:   Sat, 09 Oct 2021 10:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ue5e7PqWM9jNFNmx/e+0Dp4gQcfCsoVqBnyRTfu/Icg=;
        b=LRQ6tJnzLMZRmqCYjA66Rk5N9+MPxtgPjypJ9VADs/miduswNCiLn3nlyYWVJB99aDHB3U
        oK4kD6O0xkjuZdDenm4t1wVH7UEs0cZ9Cdlx5sLLvN07c6uRMLkZt8Wj2kwNoIJAfAe0A7
        pztBaGcxsnFFwlb4YGIOIHQx0PghbvnMUsUu+Rgzn1LQlVjuhA72kOChLIu8YzaswNuI5h
        WpC3r5WiegqLZTyq3ShdpNkqd9VJFzNI9oQWXsYXAU66g0WlnMDfmMhmQQA5+j2Qkz+bOt
        zHBRboj5EtVkXvrLbVNbH7nsQrTXcYqjfuU4X9uTN3qtivqW3fV+OH2wXbwEIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ue5e7PqWM9jNFNmx/e+0Dp4gQcfCsoVqBnyRTfu/Icg=;
        b=rU9I0smazEcH33eM/oIE121BBH0tHBq9KZTU5F4b1qte5nOsekHIRGjvMsbv5MQTHxLHDi
        wTJIF87Tjj6GfqCw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Test sys_futex_waitv() timeout
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-21-andrealmeid@collabora.com>
References: <20210923171111.300673-21-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402099.25758.177231461679917487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     02e56ccbaefcb1a78bd089a7b5beca754aca4db9
Gitweb:        https://git.kernel.org/tip/02e56ccbaefcb1a78bd089a7b5beca754ac=
a4db9
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:09 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:12 +02:00

selftests: futex: Test sys_futex_waitv() timeout

Test if the futex_waitv timeout is working as expected, using the
supported clockid options.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-21-andrealmeid@collabor=
a.com
---
 tools/testing/selftests/futex/functional/futex_wait_timeout.c | 21 ++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/=
tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6da..3651ce1 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -17,6 +17,7 @@
=20
 #include <pthread.h>
 #include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait-timeout"
@@ -96,6 +97,12 @@ int main(int argc, char *argv[])
 	struct timespec to;
 	pthread_t thread;
 	int c;
+	struct futex_waitv waitv =3D {
+			.uaddr =3D (uintptr_t)&f1,
+			.val =3D f1,
+			.flags =3D FUTEX_32,
+			.__reserved =3D 0
+		};
=20
 	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
 		switch (c) {
@@ -118,7 +125,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(9);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=3D%ldns\n", timeout_ns);
@@ -175,6 +182,18 @@ int main(int argc, char *argv[])
 	res =3D futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
=20
+	/* futex_waitv with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
+	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
+
+	/* futex_waitv with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
+
 	ksft_print_cnts();
 	return ret;
 }
