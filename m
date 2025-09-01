Return-Path: <linux-tip-commits+bounces-6398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AAB3E720
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92161630AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D723431F1;
	Mon,  1 Sep 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpJYd1dn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqLdGPt0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D2341ADE;
	Mon,  1 Sep 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736898; cv=none; b=Z1rApqjz70LUWTIn0NbyeHvpIGlWjEUa+DPnl6fxMbn/OZFOQxh7emOhTqmHy8lzVOWbsYn6+1YKxdrwTsEtvT6WQ0OxtO/RUaJQzh3h15gqVoCIvlIWyQR9OBL0GcIz+eJbqVHVu/xbDpDHG+N+DEQZRDxziIZgauSZJHRTIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736898; c=relaxed/simple;
	bh=TAoxOwZ9reTIdcUBgCMZEIvwU/EIMsWz72Uf4U59PUM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KSAsNepoiv/riYyTydVawl8fIftHSyPPr+dVc95YoLBnGJoGmYQlvjAbRQSX5cMQdNTUv8XbRcwXX0/Euv+bZ/TxBVnVloWH1njAKOsRJ6ME/E7OuMcWEpfl8WTSeL8ypSXhlVL2hCH8h8Rq2b3e6pC/G0/aitfEygsfDdMZb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpJYd1dn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqLdGPt0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Sep 2025 14:28:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756736894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXct0AilHHwLPvl5DiOAOrPEzdv4I737Merbehh09g=;
	b=gpJYd1dnQhX0ALEa+4zl1VjmN9ULSFokN0HB5Y0pquLEBydLd/y5qmWZa3JLIQU+3wgryC
	RyVDXlRVJvNYogLpaaon7nOWexZIj4+lCGh4vuka9rO2ybUglIncSTPA2xw/gZAAgjO66u
	lH94ZCJcXAkkBJnuFBilun7X8W1uakVGeKbzCA624lZG8nFe4tLWN9T5tvQHLYJvWoTtVo
	JL0URnP+YrNyPeh8vdhy3iDdZXuefvGArfHBvp9bi25ihtABIfQwpOT9tQ4VwgjLxOgN3E
	gL9NJJS8FbnVa7ykChwwtkvYX0cazyMSIREhr/1tuNjLJYKr28DoOjtnESlNSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756736894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXct0AilHHwLPvl5DiOAOrPEzdv4I737Merbehh09g=;
	b=LqLdGPt0VdJ7CRBbBKHTv5TWdbBH1+JqGUS+WazD3KtcgYCb8luUpaTqi0Ax/SfYMW08mA
	R2oqTsEm7Nt9I4CQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Fix some futex_numa_mpol subtests
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827130011.677600-3-bigeasy@linutronix.de>
References: <20250827130011.677600-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175673689351.1920.8476960305434687281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     d8e2f919997b14665e4509ef9a5278f291598d6e
Gitweb:        https://git.kernel.org/tip/d8e2f919997b14665e4509ef9a5278f2915=
98d6e
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 27 Aug 2025 15:00:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 16:12:54 +02:00

selftests/futex: Fix some futex_numa_mpol subtests

The "Memory out of range" subtest of futex_numa_mpol assumes that memory
access outside of the mmap'ed area is invalid. That may not be the case
depending on the actual memory layout of the test application. When that
subtest was run on an x86-64 system with latest upstream kernel, the test
passed as an error was returned from futex_wake(). On another PowerPC system,
the same subtest failed because futex_wake() returned 0.

  Bail out! futex2_wake(64, 0x86) should fail, but didn't

Looking further into the passed subtest on x86-64, it was found that an
-EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
because the node value test with FLAGS_NUMA set failed with a node value
of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
because the supposed node number wasn't valid. If that memory location
happens to have a very small value (e.g. 0), the test will pass and no
error will be returned.

Since this subtest is non-deterministic, drop it unless a guard page beyond
the mmap region is explicitly set.

The other problematic test is the "Memory too small" test. The futex_wake()
function returns the -EINVAL error code because the given futex address isn't
8-byte aligned, not because only 4 of the 8 bytes are valid and the other
4 bytes are not. So change the name of this subtest to "Mis-aligned futex" to
reflect the reality.

  [ bp: Massage commit message. ]

Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/20250827130011.677600-3-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2..802c15c 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -182,12 +182,10 @@ int main(int argc, char *argv[])
 	if (futex_numa->numa =3D=3D FUTEX_NO_NODE)
 		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
=20
-	ksft_print_msg("Memory too small\n");
+	/* FUTEX2_NUMA futex must be 8-byte aligned */
+	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, 1);
=20
-	ksft_print_msg("Memory out of range\n");
-	test_futex(futex_ptr + mem_size, 1);
-
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");

