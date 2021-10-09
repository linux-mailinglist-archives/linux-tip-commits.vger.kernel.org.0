Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC84278AE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbhJIKJG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbhJIKJB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3BC061755;
        Sat,  9 Oct 2021 03:07:04 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wkUY0TfYQ7BXLB6nLTQglO5Wo6OEsOpDJApBAflki4=;
        b=ZC67GHE/rfHxlj+jXKDdLiJJZaU0DUCSZJG0TnUZnDBXscZK1IVhu2+keE5XWW+iMuPesk
        SQAXn3XeR1SBoKuLOLRYyrhsPizT4EaylDO/KzlfyVNw73hBaRd30b8B7ot7xxf1FqXkC8
        UFxKMTxtq07rKG5Jzc1z2kI1OBQ7/kaFE55YAdo8UUKbGVE7kR3he25VDxBGVfaHVMXaQ5
        RoWv89pXLWjx7kps1IaHLM5FePh0Wv9GpJFD2xt91+DACBfJFSwbSNk+SugQw/pK/PFLzk
        ntEzsDTqtLKIA9o1uHW+3HpHiP06qayqAtfdv7sO5tMQ2fDLJinS/Xiy9U/0TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wkUY0TfYQ7BXLB6nLTQglO5Wo6OEsOpDJApBAflki4=;
        b=uU71ipaD9C/ez63ZmcUxlhg7F0Gzm1/64yZcPeuRkLYj6+oEl3mM+Nj383jZOIEXmqXSf0
        7GIFolcw67oVpDBQ==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Test sys_futex_waitv() wouldblock
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-22-andrealmeid@collabora.com>
References: <20210923171111.300673-22-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402010.25758.2005094433485495424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9d57f7c79748920636f8293d2f01192d702fe390
Gitweb:        https://git.kernel.org/tip/9d57f7c79748920636f8293d2f01192d702=
fe390
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:10 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:12 +02:00

selftests: futex: Test sys_futex_waitv() wouldblock

Test if futex_waitv() returns -EWOULDBLOCK correctly when the expected
value is different from the actual value for a waiter.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-22-andrealmeid@collabor=
a.com
---
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c | 41 ++++++=
+++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c=
 b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390f..7d7a6a0 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <time.h>
 #include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait-wouldblock"
@@ -42,6 +43,12 @@ int main(int argc, char *argv[])
 	futex_t f1 =3D FUTEX_INITIALIZER;
 	int res, ret =3D RET_PASS;
 	int c;
+	struct futex_waitv waitv =3D {
+			.uaddr =3D (uintptr_t)&f1,
+			.val =3D f1+1,
+			.flags =3D FUTEX_32,
+			.__reserved =3D 0
+		};
=20
 	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
 		switch (c) {
@@ -61,18 +68,44 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
=20
 	info("Calling futex_wait on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
 	res =3D futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno !=3D EWOULDBLOCK) {
-		fail("futex_wait returned: %d %s\n",
-		     res ? errno : res, res ? strerror(errno) : "");
+		ksft_test_result_fail("futex_wait returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
 		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait\n");
 	}
=20
-	print_result(TEST_NAME, ret);
+	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
+		error("clock_gettime failed\n", errno);
+		return errno;
+	}
+
+	to.tv_nsec +=3D timeout_ns;
+
+	if (to.tv_nsec >=3D 1000000000) {
+		to.tv_sec++;
+		to.tv_nsec -=3D 1000000000;
+	}
+
+	info("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
+	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
+	if (!res || errno !=3D EWOULDBLOCK) {
+		ksft_test_result_pass("futex_waitv returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv\n");
+	}
+
+	ksft_print_cnts();
 	return ret;
 }
