Return-Path: <linux-tip-commits+bounces-7349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A3C5D725
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0206363F4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2B31C59F;
	Fri, 14 Nov 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3fxbYAu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyv7QHnE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5D31A7EF;
	Fri, 14 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127897; cv=none; b=L4G2EqkbIsQf8dyfNKe/hrz5CxmKoTZSbFuCxMzSe8ZZL1Ph64uqHTmTNYq3Bl3DcnqvYiamjgK27kuiJgMi4GTDcjWLR0oHkHSUjvMHDAY9QJyKRxfavVoy73h27fU64va3gj03CRhEmNdS0WgI31MB+8sRevo14klRKaPDR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127897; c=relaxed/simple;
	bh=GX44hqAf8YHafWFf0UA4S/dobVP17mRV+8bIV+3dFqY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gbEFzFmDp478WpvLKuPL3eFeFBFfa5uKPuDyJL+rdoSgwhsQugObphFie5qlPyNlnXVI0o+2MeYDXErzvlEvjUfiVZZF+4IP1jZiq1FK1Cmfa+OZAeaKrzx/PEYpwK9fO+TxAmNvvyWI21ItdEzUyAVfvQAwD71fGJZBoseVx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3fxbYAu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyv7QHnE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 13:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763127893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZuWlKwDaR258Kph1eRLynRDtvrd5gl4QGdskflnno0=;
	b=D3fxbYAukXn+yLp1aMSox8XFFyN+asxoEN+9ATnzDsxhsHpCKd8jEgip8ROoWaNYifWJHA
	jpGp3hj0jcL2l95KzDR/vX9NRQtAxjU6hADgYfP+Lv0WHmbiyxVYnuVYRl6u89FRgB/1wQ
	ejg5Iugjc/GMA5kx88L3B1q59AQQKBIjjO9RbnBhu0rU/8gUpCLr5gMWmN5fxqC+YUmz2z
	cg9l05jchE4uTmioGcaACPMc2USPvx/4zD2blDTOrvHq6v3S0J+c/mdmcVK+WPkvLnKdeZ
	k+A56g2dwsBG/jXrgVKblkRUGTEzz5/Dx62U9lX10OXH4U5yfMxUqg4p2YYSgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763127893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZuWlKwDaR258Kph1eRLynRDtvrd5gl4QGdskflnno0=;
	b=vyv7QHnE2imHkpuMru3IkjQqMJBA+O3nLgXRgfFSCNp5nB9P8oHl4UabQsT4thPz9uoCMT
	pKfiO0hGQyqxLeCQ==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Remove unused test_futex_mpol()
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251001220438.66227-1-andrealmeid@igalia.com>
References: <20251001220438.66227-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312789282.498.3212429582510856789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2d98144440f0101e6e432a748ec9f14a0f8be9e5
Gitweb:        https://git.kernel.org/tip/2d98144440f0101e6e432a748ec9f14a0f8=
be9e5
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 01 Oct 2025 19:04:38 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 14:39:36 +01:00

selftests/futex: Remove unused test_futex_mpol()

Commit ed323aeda5e09 ("selftest/futex: Compile also with libnuma <
2.0.16") removed the unused function test_futex_mpol() and commit
d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with
kselftest_harness.h") added it back by accident. Remove it again.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftes=
t_harness.h")
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251001220438.66227-1-andrealmeid@igalia.com
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f..969c73c 100644
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
 TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;

