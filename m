Return-Path: <linux-tip-commits+bounces-6395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24806B3E71A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9717DACE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308E34164E;
	Mon,  1 Sep 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uu8ef1LB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nyLkk+oE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F262340D94;
	Mon,  1 Sep 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736895; cv=none; b=aFqKQ7VGQ8ayod87TEt1RjHiK7Gyxj+cnbfE3kj9TQEnTMIvWnySkTFRKGF4ixwIWkBxYISFJ6NBNEnRXFOw6cWVbgUTyTNA4amEtRXHtaxDbkDt/QTHSJtp9utnDfk2s7+k7f1wP6aTyKlUEfqsQB+twH+tNrGEjad3uXGw/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736895; c=relaxed/simple;
	bh=xqMlFxYoV1s3mw2QAz/F5yAu/vAD9+0kVbNtBgynCF8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IzGeearC8An6PreJytp+uCRhWU4cu2HP98NjJgYT/8Z+X4jK1lhMN79EfuXA4JgGfgaTjqXu8l9EPPpKnukiUxUF994uauRVpcrxP2p7qjiRE8Bka3BDfH2k/23gYRiFyBlCqobvYIZbG+muB2GlPbJcKD05JZQNwguo3B2kmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uu8ef1LB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nyLkk+oE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Sep 2025 14:28:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756736891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QpWB6jPNwc2gpFpoc1NM9kYgcVr+ajJ+IvJUIpI1FE=;
	b=Uu8ef1LB1GtHZ09/ZJlevvsiWAl4SveuGctzW6AF7j5NsncAjaAn6zYSbl23UEYV5LgIUL
	c+2/UOUtTAgC5VkDBZY955N0DfYWFyReLP6i8fizfybdISSsUCh3YgtNreMDmJyu+apgLo
	uMP2It9ZKGbymAFkMjQfLMicJ8SnY0FQBK5842EzGV8LuM6d4w20xOrBQ4/HPh2StZrlkA
	hVELOuSw+r8rHzM9P08su/1AL7lqxeV35Jm6FxpxCR4lHaE3FMqWZKa51A+nQg2kAEOflt
	9FVwt4TXo+jny8BRLwgsYMWlYyQMFtDayarmLOZhNUmy3cXHwD4+colBdbYdvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756736891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QpWB6jPNwc2gpFpoc1NM9kYgcVr+ajJ+IvJUIpI1FE=;
	b=nyLkk+oEb97i82bSicaPjT6QN7/YU+BLVxeZlTUApWllz8piteK9nq/v+Bo4gLhguTpQBQ
	oXvHK4JxZm5I7TAQ==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix futex_wait() for 32bit ARM
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, andrealmeid@igalia.com,
 Anders Roxell <anders.roxell@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827130011.677600-6-bigeasy@linutronix.de>
References: <20250827130011.677600-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175673688994.1920.3268727903650888597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     237bfb76c90b184f57bb18fe35ff366c19393dc8
Gitweb:        https://git.kernel.org/tip/237bfb76c90b184f57bb18fe35ff366c193=
93dc8
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Wed, 27 Aug 2025 15:00:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 16:26:55 +02:00

selftests/futex: Fix futex_wait() for 32bit ARM

On 32bit ARM systems gcc-12 will use 32bit timestamps while gcc-13 and later
will use 64bit timestamps.  The problem is that SYS_futex will continue
pointing at the 32bit system call.  This makes the futex_wait test fail like
this:

  waiter failed errno 110
  not ok 1 futex_wake private returned: 0 Success
  waiter failed errno 110
  not ok 2 futex_wake shared (page anon) returned: 0 Success
  waiter failed errno 110
  not ok 3 futex_wake shared (file backed) returned: 0 Success

Instead of compiling differently depending on the gcc version, use the
-D_FILE_OFFSET_BITS=3D64 -D_TIME_BITS=3D64 options to ensure that 64bit times=
tamps
are used.  Then use ifdefs to make SYS_futex point to the 64bit system call.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Link: https://lore.kernel.org/20250827130011.677600-6-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/Makefile |  2 +-
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 8cfb87f..ddfa61d 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TIME=
_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testin=
g/selftests/futex/include/futextest.h
index 7a5fd1d..3d48e97 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -58,6 +58,17 @@ typedef volatile u_int32_t futex_t;
 #define SYS_futex SYS_futex_time64
 #endif
=20
+/*
+ * On 32bit systems if we use "-D_FILE_OFFSET_BITS=3D64 -D_TIME_BITS=3D64" o=
r if
+ * we are using a newer compiler then the size of the timestamps will be 64b=
it,
+ * however, the SYS_futex will still point to the 32bit futex system call.
+ */
+#if __SIZEOF_POINTER__ =3D=3D 4 && defined(SYS_futex_time64) && \
+	defined(_TIME_BITS) && _TIME_BITS =3D=3D 64
+# undef SYS_futex
+# define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex

