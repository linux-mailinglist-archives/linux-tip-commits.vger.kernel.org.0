Return-Path: <linux-tip-commits+bounces-6688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0DDB8CD05
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6A03A4008
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64A2AE90;
	Sat, 20 Sep 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDMB4GHW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2iTcAllI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1363F9D2;
	Sat, 20 Sep 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385664; cv=none; b=hrl8IHAzO7K4jvPNiupjb0uNhDDSGP6HihefZVm2KKyvC/ElwqDA3dE1XT9Tzj7Zcfrf3askeLB+xqlmXHoVj6XgEL9VeZDCdMkj3K6J5GBPrnSGjThZiVjmPQhXpwNy81VW3Ou3PEps+XZlZAXOm4l/bymKuQz15UE54jTIZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385664; c=relaxed/simple;
	bh=3YWWuOMa0vb6Tv8e4NqClJud5/vc0XAVreYDFHKoSsY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RT1FEsxJFSLHGKrtkcUqVdiR25pXyWp3JhqoHZNjwyim95L7EkyrZ+0Wgrwlc4qrqBX97bJvItLtQK/554PDrb1BMGMYOpNcQW1fV8EJCSqK6zxF6qtTLnMBRXtfCGbyzJLjAQHL9cxoRoZJhI5RVkrL/0Uf/FeO0OZvbEUovPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDMB4GHW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2iTcAllI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI7MBNSu1kZm3PuA5AJ4IJXl97601OcumhqSBsfCRE=;
	b=iDMB4GHW/lbutsVxQ6/BHA+UhiupdXH0kdI9ejTOKqqLv/02kWKpBU/G4YiTMmGNSHH+k6
	QENqokikBzwAckTgczhdhgKi56Q5LTLorp7cnf/PQXy7pKGUk59PyTRPmaHEmKR0mrFxGd
	7ZU+aEfF/SlCm9Kh8t6n6w/bX1iSTeYB1jCkxFnmdbC+QUQoyKmERsRrANV7+9xA58WafS
	+qMcVjszUileGZsjiQJg6XSinkW2zYIBD7gngJ0xD8i0l/2yqd7o4Fi1JZglIhvnSLXBe9
	r9aZseZ0CKXTMM2YDNzImYEcP5M1G9iN6Xl51lITSUrap2zLAD2O9h6Iy6FFeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHI7MBNSu1kZm3PuA5AJ4IJXl97601OcumhqSBsfCRE=;
	b=2iTcAllILMx83xLWVFkGni0AO5/2vUCXHWsjGoWNikGtPstvFw+xNg/kYP8nyRlsZwUPC4
	sXInqShVXRlyErCw==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftest/futex: Fix spelling mistake "boundarie"
 -> "boundary"
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250919165711.557272-1-colin.i.king@gmail.com>
References: <20250919165711.557272-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838565865.709179.1382080094641929805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     4386f71623b77215c9502e60fc399e76ec337fec
Gitweb:        https://git.kernel.org/tip/4386f71623b77215c9502e60fc399e76ec3=
37fec
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Fri, 19 Sep 2025 17:57:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:23:13 +02:00

selftest/futex: Fix spelling mistake "boundarie" -> "boundary"

There is a spelling mistake in a test message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index afe5d95..d037a3f 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -180,7 +180,7 @@ TEST(futex_numa_mpol)
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
=20
-	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+	ksft_test_result_pass("futex2 memory boundary tests passed\n");
=20
 	/* MPOL test. Does not work as expected */
 #ifdef LIBNUMA_VER_SUFFICIENT

