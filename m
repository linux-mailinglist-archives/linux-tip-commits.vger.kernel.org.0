Return-Path: <linux-tip-commits+bounces-6692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFEB8CD0E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1DF17C91A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0383F30277A;
	Sat, 20 Sep 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKk2t98O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrWGf9EI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8430102A;
	Sat, 20 Sep 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385667; cv=none; b=RWuSpYyyCRDWJtAIZ3maR8Gw6/RCODpDKaXamJYDMk7TTrGpkiFoCsTWczN3H20/JDxfwKxVB0UhPj+w/9mO0SHFSNSiKNLjl7qMD2K+UEt3F41xPe4CraA/pCSvcB5RfBWQWeLkkRtxHD6PJLyjmpoVviXg0yxQKtfiQOHoMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385667; c=relaxed/simple;
	bh=cMts44WCuLGGN+nlVcmhYKLEbxN/ti2xvIZ0ZVISiFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C+agq5MbbsN26cRvXNbhzueixxLFHD+jCI+5MtDZLyN40zCyHlfzLx1mAFwBinapuutd6JFzGbFOaM6LXzbpJdZTjAzmnuxLdYPxyleS8GkuLAbauRP19R4+f/OliIR5M0ZqhircKtS2U60j1oZpTlqIFeKOlZThNoIlRA46UKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKk2t98O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrWGf9EI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w07XWYUAD8o5pY2ELpvAeoBGBX1R0KTFR7rfKXmb9M=;
	b=cKk2t98Ok6vld1AK47xSDDrHmB/xPLYXxu4ukHyU3bICFdAmBhZShMB4/rlX9LExfeFIqB
	gNsgWQBRymn/G2DTAAdc/EuKmMcqZekDCtjWKI9QOr/pjsWYsCsFDUs/MgDaIYuASxNruz
	lOPHPF6NmSo8D53meDAgM06KynkDuwCemoCDjpgdf9NQ+Rko8V5ReiqzaFPHhj/RcfG9qx
	nVEs+OmjzfS5fOcOtZsYH3dR5GePYtCms5NlmvUXDyDEem34hnPxqUrbH9VqyURyuBBjdM
	G0KJK9DU+WVIy+hMlsaOw5FRbJHt8UfGNz3qcW955xN5N0RP8kBzFDx2yxFzZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w07XWYUAD8o5pY2ELpvAeoBGBX1R0KTFR7rfKXmb9M=;
	b=nrWGf9EINFwum9eeQrmcdj60WCO5goWOWw2FopmCx4teIaYLss8biea+A3/z1Rw16oRPhW
	bh8M9FRIFci7BWCw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_priv_hash with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-12-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-12-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566319.709179.3122439030790668890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     4ba629e6c6dc6eef1a6b96dc06c140e622a8f836
Gitweb:        https://git.kernel.org/tip/4ba629e6c6dc6eef1a6b96dc06c140e622a=
8f836
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:51 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:55 +02:00

selftests/futex: Refactor futex_priv_hash with kselftest_harness.h

To reduce the boilerplate code, refactor futex_priv_hash test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 48 +------
 tools/testing/selftests/futex/functional/run.sh            |  2 +-
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index 95f0160..3b7b585 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
=20
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
 #define MAX_THREADS	64
=20
@@ -128,45 +128,14 @@ static void futex_dummy_op(void)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret=
);
 }
=20
-static void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 static const char *test_msg_auto_create =3D "Automatic hash bucket init on t=
hread creation.\n";
 static const char *test_msg_auto_inc =3D "Automatic increase with more than =
16 CPUs\n";
=20
-int main(int argc, char *argv[])
+TEST(priv_hash)
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
 	int ret, retry =3D 20;
-	int c;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(21);
=20
 	ret =3D pthread_mutexattr_init(&mutex_attr_pi);
 	ret |=3D pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT=
);
@@ -279,7 +248,7 @@ retry_getslots:
 	ret =3D futex_hash_slots_set(0);
 	ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	if (ret !=3D 0)
-		goto out;
+		return;
=20
 	futex_hash_slots_set_must_fail(4);
 	futex_hash_slots_set_must_fail(8);
@@ -288,17 +257,14 @@ retry_getslots:
 	futex_hash_slots_set_must_fail(6);
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
-	if (ret !=3D 0) {
+	if (ret !=3D 0)
 		ksft_exit_fail_msg("pthread_barrier_init failed: %m\n");
-		return 1;
-	}
+
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
 	ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
-
-out:
-	ksft_finished();
-	return 0;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 4a7b0ef..f725531 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -60,7 +60,7 @@ echo
 ./futex_waitv
=20
 echo
-./futex_priv_hash $COLOR
+./futex_priv_hash
=20
 echo
 ./futex_numa_mpol $COLOR

