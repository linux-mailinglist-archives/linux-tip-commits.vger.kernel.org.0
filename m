Return-Path: <linux-tip-commits+bounces-6674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDBB813F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49546188F5C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FD2FE56B;
	Wed, 17 Sep 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YfC7R8eP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7vboPI1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84958235C17;
	Wed, 17 Sep 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131691; cv=none; b=s8udRp9impeRL6xTnWuo4kU28uzx7SbaYcKI8c+its24vhMxJfUp533qYfvBmCfGAGd3Kz7vOtDPSySbNt8UYENrc3VgAT8YpDScxg7Y0fdii7ZNbJloO4vUbRkOVK9W6fbQ4l7fhCpkP8lDgo96CEWSMjtELAE1QTlyJUCssbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131691; c=relaxed/simple;
	bh=VKdDEi0fCrvisga+dIYis/ZRXqv/OrOkdBwXvIY+8SM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mTTNrI3fAh8tHYKJOMuLyh2SLvBcq+baw0A/3fmjF1OaeNw/Bfc7NiJ9JgVR69OFG2pM/6WJCn6S0OBqxasn/ATFIHId2LTqjQuXPvQ8CYYSWZ0AV6fht4OHcyb/rflcyjTt9NSQikDNidvpWARvjwEQ2+LDXiSU161xhyDfvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YfC7R8eP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7vboPI1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 17:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758131687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78IuLmMXPv2/37gJnwgu4qjW8SYia3oQCtS1b35jDfc=;
	b=YfC7R8eP6hVW29yVy38i2GuMWjQcQCnE9NSIfkrDXlMGKT/qKbBT2DGFoxD6mUSySCACdq
	gukKKJPPU8jswnd2FMWbKemifUA7OKxcoTLknny9EXde3uLC/0INlFMnlIBHml04O1L+0Y
	g4apl4FybP0+efPXF34Iw7+NsbpNj5g4acTyvkQAl7PpKth6AZslvDvOWZUE39CTlsRALf
	a+paK/Xf1b//y2XNi5z7G5g72NY2NDjQyZ2ntH9sviQEs9JhQHXvTykJ96//wfmBRk0szU
	s52R25KVXAp94C0l7W0WXsvk5DrESM3TnHbHO098kG6WzKJewiUWJymFuEFkXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758131687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78IuLmMXPv2/37gJnwgu4qjW8SYia3oQCtS1b35jDfc=;
	b=z7vboPI1+3cUAjNNIkuKOFFKDKB/eGItrmmhsH9+EsnEGXmH+oa9b5QANbThIDLMiDv7TS
	4UhIVCC3Tvi1PHCA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftest/futex: Reintroduce "Memory out of
 range" numa_mpol's subtest
Cc: andrealmeid@igalia.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915212630.965328-3-bigeasy@linutronix.de>
References: <20250915212630.965328-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175813168636.709179.16966865855500249554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2951dddef0a87c20e83c77070bd5077290d9121f
Gitweb:        https://git.kernel.org/tip/2951dddef0a87c20e83c77070bd5077290d=
9121f
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Mon, 15 Sep 2025 23:26:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Sep 2025 19:48:44 +02:00

selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest

Commit d8e2f919997 ("selftests/futex: Fix some futex_numa_mpol
subtests") removed the "Memory out of range" subtest due to it being
dependent on the memory layout of the test process having an invalid
memory address just after the `*futex_ptr` allocated memory.

Reintroduce this test and make it deterministic, by allocation two
memory pages and marking the second one with PROT_NONE.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 8 ++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index dd7b05e..5f4e311 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -174,10 +174,13 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
-	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MA=
P_ANONYMOUS, 0, 0);
+	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr =3D=3D MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
=20
+	/* Create an invalid memory region for the "Memory out of range" test */
+	mprotect(futex_ptr + mem_size, mem_size, PROT_NONE);
+
 	futex_numa =3D futex_ptr;
=20
 	ksft_print_msg("Regular test\n");
@@ -192,6 +195,9 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, EINVAL);
=20
+	ksft_print_msg("Memory out of range\n");
+	test_futex(futex_ptr + mem_size, EFAULT);
+
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");

