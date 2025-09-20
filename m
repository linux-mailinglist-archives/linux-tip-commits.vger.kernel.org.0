Return-Path: <linux-tip-commits+bounces-6703-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F207DB8CD44
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B389D4E1724
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216330AADA;
	Sat, 20 Sep 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwhxwLuS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SG2yufjK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C02309EE9;
	Sat, 20 Sep 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385680; cv=none; b=lLLYScqtda1iuR8gpIAqb0xyk7z6WJd2O+7jiLuywT60a0kkvZND/7j1qAXr0e11nX/b2ZvDh4CXj36+BjmyoX0WpVSmqRqKpsLKRjtsDgjzW2hFIPBNfNWKFBOBtl05oDgQs54ybGNe8n9d0bwZxwqL+JP3T+Zv4P0++Nm1He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385680; c=relaxed/simple;
	bh=Uy8ZGJvSGIC07YSqWR1nDGgiI0/gNUWMNHVvdzqxKWY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IWKRBvcupQRkMpGn/wcmIJhcoKi8fZf9o9A23LK+TG3/e+VKbxMB+vBXPke4P9eAMAuL6YtaTi6U1D52winJ+3EPrWIn+QbpT47HQ8kjqYho8oeM7/hYnu3QsXOXLeYZsrjwzRE6WJo+bi13N2jek/U+iuds9yD8IL8AZnz79es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwhxwLuS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SG2yufjK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ja2uFlsmJ72DAq4wuqLw6qn9XLef/aylt61YV4fDGYk=;
	b=VwhxwLuSk/p17lTjIolcvWgpmkYHNNgrlDssqgpkyPkpUdApCpQqzxD8dA4yJ7xzuuiQ7I
	C9w85qBtcCHW0aaJUbjswy+VBjxtpG1tJ7dFs1a3OzdsARdtp4kqFgLA/QQ70qDBb+0qnu
	tYM5fuXMX79LR2KQx4KyjDLiIaHuwN3cBHiK+jmXomM0aXzGeVqWfmwibHHxuO2y6Ip/Mw
	hP0XEJ+ykaJQjeqsDTve5F5EzCvMumppIrREQcpal07ZY/ICRNYXFRXyMoRRr9mnNuJDSy
	mUR64RE8qm/FCBY3IgogsiolJD5w2oRK+YkP2fWgUfB5ZAnoToVtGulC3bTZJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ja2uFlsmJ72DAq4wuqLw6qn9XLef/aylt61YV4fDGYk=;
	b=SG2yufjKSAniEBYQ1bAuAuATVGk2znPNyEGJnNj2GolmKUhzWD5BinRs/1ywO6keadTrhD
	y0yw0wd5aJt09nCA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests: kselftest: Create ksft_print_dbg_msg()
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-1-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-1-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838567551.709179.5619760179104074372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     f2662ec26b26adb71783fa5e5ee75aff6f18a940
Gitweb:        https://git.kernel.org/tip/f2662ec26b26adb71783fa5e5ee75aff6f1=
8a940
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:40 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:53 +02:00

selftests: kselftest: Create ksft_print_dbg_msg()

Create ksft_print_dbg_msg() so testers can enable extra debug messages
when running a test with the flag -d.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/kselftest.h         | 14 ++++++++++++++
 tools/testing/selftests/kselftest_harness.h | 13 +++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/ks=
elftest.h
index c3b6d26..8deeb4b 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -54,6 +54,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
@@ -104,6 +105,7 @@ struct ksft_count {
=20
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
+static bool ksft_debug_enabled;
=20
 static inline unsigned int ksft_test_num(void)
 {
@@ -175,6 +177,18 @@ static inline __printf(1, 2) void ksft_print_msg(const c=
har *msg, ...)
 	va_end(args);
 }
=20
+static inline void ksft_print_dbg_msg(const char *msg, ...)
+{
+	va_list args;
+
+	if (!ksft_debug_enabled)
+		return;
+
+	va_start(args, msg);
+	ksft_print_msg(msg, args);
+	va_end(args);
+}
+
 static inline void ksft_perror(const char *msg)
 {
 	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/self=
tests/kselftest_harness.h
index 2925e47..ffefd27 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1091,7 +1091,7 @@ static int test_harness_argv_check(int argc, char **arg=
v)
 {
 	int opt;
=20
-	while ((opt =3D getopt(argc, argv, "hlF:f:V:v:t:T:r:")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) !=3D -1) {
 		switch (opt) {
 		case 'f':
 		case 'F':
@@ -1104,12 +1104,16 @@ static int test_harness_argv_check(int argc, char **a=
rgv)
 		case 'l':
 			test_harness_list_tests();
 			return KSFT_SKIP;
+		case 'd':
+			ksft_debug_enabled =3D true;
+			break;
 		case 'h':
 		default:
 			fprintf(stderr,
-				"Usage: %s [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]\n"
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
 				"\t-h       print help\n"
 				"\t-l       list all tests\n"
+				"\t-d       enable debug prints\n"
 				"\n"
 				"\t-t name  include test\n"
 				"\t-T name  exclude test\n"
@@ -1142,8 +1146,9 @@ static bool test_enabled(int argc, char **argv,
 	int opt;
=20
 	optind =3D 1;
-	while ((opt =3D getopt(argc, argv, "F:f:V:v:t:T:r:")) !=3D -1) {
-		has_positive |=3D islower(opt);
+	while ((opt =3D getopt(argc, argv, "dF:f:V:v:t:T:r:")) !=3D -1) {
+		if (opt !=3D 'd')
+			has_positive |=3D islower(opt);
=20
 		switch (tolower(opt)) {
 		case 't':

