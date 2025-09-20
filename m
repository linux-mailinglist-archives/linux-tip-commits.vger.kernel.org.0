Return-Path: <linux-tip-commits+bounces-6691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54BB8CD11
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BA43AD960
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E1302161;
	Sat, 20 Sep 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="widAuED5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMKKnq7+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806172FFDEB;
	Sat, 20 Sep 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385667; cv=none; b=Io3K3DN8myCxCld4EW90a84148ofrBMKw1nK4+Yli7TwPQASxDGBZxOLShSGFprEHRsIqxd/PUaY3E2e5mzyn63wfwz0MW40VOdbV9qzQKNkxS0C4LAxVAGmqAQeHYtd/aXgH8jE0SI/w/B48KdpggU0l/1KmGeXG/5L/Ben5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385667; c=relaxed/simple;
	bh=0iynM+w7BZ6Glv0J8zaWrxdk0W/L+554PJNEKoqXeTM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rzXxYZB1uONwq9fDvxwCrTpp3ocaCL1MGXzlCefNsvbwROc6YElxtYpy/ufykNq41xH2W3nEdCYSN6MC+IZw2GtdJabHmkGRd1N32Gx3XvKVCDf+BxMF2cD2eSf1CMZg1kPb00zBNFyiNff4x7PjYZTq0ordSa4eRIisMNlh3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=widAuED5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMKKnq7+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEw8Y1Dd3mNG7MfnmZ14fBNKe9EKRTfOU1Uk5UmZt1A=;
	b=widAuED56bTQFizZpHsbn+W2p3d/oipleQ7jJV/2t+TPjGJ7boKvq7nCw/VLvBOJST+w6h
	CLPPYvvg/t2AAECUAt98Es8l0obm7+2eMKyqf1/kARImJhOBAt9PRarB2nHVnhpAAuJewT
	7IT7yom8l6WtkmjFCzZJIAcGWRj2NfmlpbY0vH91r7uqUTsxiyQsKkePZXpNoh7wbxStA8
	FGgmPyKR+MFWQxHxcLtdaCfrlr7AdzrlgNNdrVfgn/2+KyT2hmQkT8TqRMSdYCyZbKUp51
	sV8Rl1jisXxxLtuy13nuT29jxIv9yI5elfHHYNHbpqCV7wBHSFUu9sF0a08QVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEw8Y1Dd3mNG7MfnmZ14fBNKe9EKRTfOU1Uk5UmZt1A=;
	b=iMKKnq7+li+eH5FPZCGnuHOflmF/cm3nAcglDloepIKjlzSBO/eo3pHyZesBMW4jUOiMTx
	3EGNE70x9fcDBFAw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_numa_mpol with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-13-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-13-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566211.709179.4103621629573303470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     d35ca2f642726a2c8a85c5b864fd05f59f3965af
Gitweb:        https://git.kernel.org/tip/d35ca2f642726a2c8a85c5b864fd05f59f3=
965af
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:52 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:55 +02:00

selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h

To reduce the boilerplate code, refactor futex_numa_mpol test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 41 +------
 tools/testing/selftests/futex/functional/run.sh            | 15 +---
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index 722427f..afe5d95 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -16,9 +16,9 @@
 #include <linux/futex.h>
 #include <sys/mman.h>
=20
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
+#include "../../kselftest_harness.h"
=20
 #define MAX_THREADS	64
=20
@@ -131,42 +131,16 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
 }
=20
-static void usage(char *prog)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
 }
=20
-int main(int argc, char *argv[])
+TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;
-	int mem_size;
 	void *futex_ptr;
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
-	ksft_set_plan(2);
+	int mem_size;
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
 	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, 0, 0);
@@ -239,6 +213,7 @@ int main(int argc, char *argv[])
 #else
 	ksft_test_result_skip("futex2 MPOL hints test requires libnuma 2.0.16+\n");
 #endif
-	ksft_finished();
-	return 0;
+	munmap(futex_ptr, mem_size * 2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index f725531..e88545c 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -18,19 +18,6 @@
 #
 ############################################################################=
###
=20
-# Test for a color capable console
-if [ -z "$USE_COLOR" ]; then
-    tput setf 7 || tput setaf 7
-    if [ $? -eq 0 ]; then
-        USE_COLOR=3D1
-        tput sgr0
-    fi
-fi
-if [ "$USE_COLOR" -eq 1 ]; then
-    COLOR=3D"-c"
-fi
-
-
 echo
 ./futex_requeue_pi
=20
@@ -63,4 +50,4 @@ echo
 ./futex_priv_hash
=20
 echo
-./futex_numa_mpol $COLOR
+./futex_numa_mpol

