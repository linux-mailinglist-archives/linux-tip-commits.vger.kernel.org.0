Return-Path: <linux-tip-commits+bounces-6673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C1B813F4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A18B188483C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B622FB616;
	Wed, 17 Sep 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxU2kxMV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWo9065i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6942773CE;
	Wed, 17 Sep 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131690; cv=none; b=n4nTeWIYgQtAXYSNKYVwbiF/Wczj5tSHM9zSgSguGeek/l1j0iFiZculpQcjRymP4iNdmCvShtDIihZpkOCcNQNOxn9EXkvxLWMGfxQ8Ae0E3b32Wv+q0cjbH6Te5XBuorl7htt7q9i4KzaE0PShJoT9FgGWbAlEwioF58jM6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131690; c=relaxed/simple;
	bh=ki4cbZlEwHqcfCc4eFtfU3FULXGGN6ARprDgRpIJDzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dK/SUBejyp/0sbnhNrbOKeP0XTafoByQZc4xnGqYWPnVQPsObJLMemqHrqlHt2skjGcdgob5/JzuMPig8uPd18yncjPbRPERWN6vwc0ICPq5ajEn06kwI2r1k7sVA+rvF+HceLdItje6UMN5KYvL3WGUoHIc1qVzv3mHbgwI8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxU2kxMV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWo9065i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 17:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758131686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiH9h9m/nZiU67KSkxpDKTbEwbGBo+KaUi/u31OAjXg=;
	b=MxU2kxMVipri4q6SNoHUWPAA/TdCPCSJMeKBMVSZpruKxC9l/ngLZ8dB2YlJFjhdP6J7oN
	rmIXv3LLavSl/5jXdO8BvpAxez4YGwJUC+QZR1znsHLrlh8+YYATfAwt/auo0g1B65ETcG
	APwpPl1kVt8zs3jHMDYz7v5IPHA/qwCqg2rKCEy7DCgE4e5/yhtuCi/ZiIQGCWeYH3cjQS
	Tl24wxpbRM9y6k15hRA4nw9SPnU9Cu9AbKuugws+uqEMPph8dHTSLJPbzmuci+qNg0/B0a
	v4NvXdSMcafAgYB8ndNWbR/NVzeC3EQEqh2PRpDj6O1wFmklrfcwM00T4BMjvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758131686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiH9h9m/nZiU67KSkxpDKTbEwbGBo+KaUi/u31OAjXg=;
	b=AWo9065iaGqyYDT6AHhClXkZRRfp59Abq8hCrAeT8D56ul5kph3JPGV6gCpYjAeAiPzuzc
	UerFrju7m14TxwBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftest/futex: Compile also with libnuma < 2.0.16
Cc: kernel test robot <oliver.sang@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915212630.965328-4-bigeasy@linutronix.de>
References: <20250915212630.965328-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175813168497.709179.12265012142942557336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     ed323aeda5e09fa1ab95946673939c8c425c329c
Gitweb:        https://git.kernel.org/tip/ed323aeda5e09fa1ab95946673939c8c425=
c329c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 15 Sep 2025 23:26:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Sep 2025 19:48:45 +02:00

selftest/futex: Compile also with libnuma < 2.0.16

After using numa_set_mempolicy_home_node() the test fails to compile on
systems with libnuma library versioned lower than 2.0.16.

In order to allow lower library version add a pkg-config related check
and exclude that part of the code. Without the proper MPOL setup it
can't be tested.

Make a total number of tests two. The first one is the first batch and
the second is the MPOL related one. The goal is to let the user know if
it has been skipped due to library limitation.

Remove test_futex_mpol(), it was unused and it is now complained by the
compiler if the part is not compiled.

Fixes: 0ecb4232fc65e ("selftests/futex: Set the home_node in futex_numa_mpol")
Closes: https://lore.kernel.org/oe-lkp/202507150858.bedaf012-lkp@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/futex/functional/Makefile          |  5 +-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 21 +++----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index ddfa61d..bd50aec 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+PKG_CONFIG ?=3D pkg-config
+LIBNUMA_TEST =3D $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.16 =
> /dev/null 2>&1 && echo SUFFICIENT || echo NO")
+
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TIME=
_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TIME=
_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES) -DLIBNUMA_VER_$(LIBNUMA_TEST)=3D1
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index 5f4e311..722427f 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,11 +131,6 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int err_value)
-{
-	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
-}
-
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -148,7 +143,7 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct futex32_numa *futex_numa;
-	int mem_size, i;
+	int mem_size;
 	void *futex_ptr;
 	int c;
=20
@@ -171,7 +166,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
 	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, 0, 0);
@@ -211,8 +206,11 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
=20
+	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+
 	/* MPOL test. Does not work as expected */
-	for (i =3D 0; i < 4; i++) {
+#ifdef LIBNUMA_VER_SUFFICIENT
+	for (int i =3D 0; i < 4; i++) {
 		unsigned long nodemask;
 		int ret;
=20
@@ -231,15 +229,16 @@ int main(int argc, char *argv[])
 			ret =3D futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | =
FUTEX2_NUMA | FUTEX2_MPOL);
 			if (ret < 0)
 				ksft_test_result_fail("Failed to wake 0 with MPOL: %m\n");
-			if (0)
-				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa !=3D i) {
 				ksft_exit_fail_msg("Returned NUMA node is %d expected %d\n",
 						   futex_numa->numa, i);
 			}
 		}
 	}
-	ksft_test_result_pass("NUMA MPOL tests passed\n");
+	ksft_test_result_pass("futex2 MPOL hints test passed\n");
+#else
+	ksft_test_result_skip("futex2 MPOL hints test requires libnuma 2.0.16+\n");
+#endif
 	ksft_finished();
 	return 0;
 }

