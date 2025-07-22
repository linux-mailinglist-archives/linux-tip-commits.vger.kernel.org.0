Return-Path: <linux-tip-commits+bounces-6156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F7B0D5FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C37A3B38C0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A92DCF43;
	Tue, 22 Jul 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0YorwOJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+zp30zk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE782DC35C;
	Tue, 22 Jul 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176570; cv=none; b=EWJMObk8BP45kd3qXCdoudbuwbIgbpH81HsHfu+JfS+GSqRnfRlGWxOR2LXCMDKrN/aVorVtNXQIeUyfrGDPtnGDiEuqel6AK7b1mw2UqZ2M0uc2KiDZhBPKSF7NSlfSjl3aZeOiRu4vlv8gicWaa2WJafDHt9j9WSX3BLOstwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176570; c=relaxed/simple;
	bh=TJ8CHomWAqVjyYt8ekRh1FF8v3ALHw+duXIkm4eCEm4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q+aKA4Id+gR+S41Qjz1EX2hJQeq3InYzmMyXXPzD/vpJQOaYGlbYRAO2ujAAImpYqlo9LMJD1/UaqzHDJBfG17nweCvfGMv4aSueKbCJXucWATsBg3vz+ig9eChGIK/sq1ZL3QDCY/w3+RiE2OnuSOJCaa2MUA214ScEJglKttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0YorwOJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+zp30zk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 09:29:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753176567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7syrHlzDvIKeDfoiiXzATQVHgetK8veEnenegbHWCo=;
	b=u0YorwOJTajbzhToTJI4BZBpYNBRXGhdtEMBVUrZo1nT0WBc2PZJDMXlVKpa853Xi3H97h
	c9X2jaV1NNAz6sM26mL+AO37pjRcgjpXUNmWUJbEiF5LO5qDSe3oaPd3thM7nr9OkzUZIA
	HTMjVFbmrcgdHxGfDYlVscK+Uvz9sHaWhh3WDEXpwPbx2JBEr/REUZ45VLxwnxclQeGMBT
	76RNkv2+AyIvYe2kS5zFZcBeofBejrtmgwi4v6VAaRebdB67s/E8Xqt78r5bbUwLw9Mvo0
	UAskINzZ8PAsCX7znMslNz2iJgx4i/o3cUzehuNZQKvzlkFtCW2PZLYS2ASUhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753176567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7syrHlzDvIKeDfoiiXzATQVHgetK8veEnenegbHWCo=;
	b=0+zp30zkitDJcbztEnFvHnYsBh5SPQ5wX04VZdc3vz4WGcPnBVNDjeXHNOFIQkHenfvxag
	9HxWfPd7XwlzS6DQ==
From: "tip-bot2 for Cynthia Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Define SYS_futex on 32-bit
 architectures with 64-bit time_t
Cc: Cynthia Huang <cynthia@andestech.com>,
 "Ben Zong-You Xie" <ben717@andestech.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710103630.3156130-1-ben717@andestech.com>
References: <20250710103630.3156130-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175317656648.1420.2526056310701166486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     04850819c65c8242072818655d4341e70ae998b5
Gitweb:        https://git.kernel.org/tip/04850819c65c8242072818655d4341e70ae=
998b5
Author:        Cynthia Huang <cynthia@andestech.com>
AuthorDate:    Thu, 10 Jul 2025 18:36:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 11:18:43 +02:00

selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t

The kernel does not provide sys_futex() on 32-bit architectures that do not
support 32-bit time representations, such as riscv32.

As a result, glibc cannot define SYS_futex, causing compilation failures in
tests that rely on this syscall. Define SYS_futex as SYS_futex_time64 in
such cases to ensure successful compilation and compatibility.

Signed-off-by: Cynthia Huang <cynthia@andestech.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/20250710103630.3156130-1-ben717@andestech.c=
om

---
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testin=
g/selftests/futex/include/futextest.h
index ddbcfc9..7a5fd1d 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
=20
+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't h=
ave
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex

