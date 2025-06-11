Return-Path: <linux-tip-commits+bounces-5755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA86AD4F94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A193E189B4EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362932609CD;
	Wed, 11 Jun 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6P6rela";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vahlkV6J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83E25C834;
	Wed, 11 Jun 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633613; cv=none; b=kgalWnVJDk1OzisyTTb18kutJFDncB5NKVrhHX/APjGHsz7jgw39mOt307QsELZwFX9Tk8mM1RTkXoRs57LZwIGX3qdGLi6DpgsZ3a1pO0ug+3n+fM69ZokEjTqjJ1VDJxOgShghb9MTi8jF2jcpJkUeWSLpTc6qdhBB9KQwVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633613; c=relaxed/simple;
	bh=sipE6p1OXk1Fgu0D/lZJb/3RnMIAIpyjUe5h2pJaE9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=efeb6Tgqsnbj1nIxJstV4TKoxczWCZGW2PISXZHSP1yTkleK4xXFW1xDd4TL1kBUw5LtU/jo/4ApyPP0UNYD4+WMJjI0EqX3yP3mzMGa43G09WW2p9iBOQqMmnDjtHSdesNEFuI+CON7GtF3AYZywP3aOfhuWB11Sv95ofW7M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6P6rela; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vahlkV6J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:20:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749633609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnAnSP42eIzSVeNVs3HpQMmD5ob4lQ34ypodXdON5r4=;
	b=p6P6rela6Nx4xvii0x/qxj6UFop32g4SusiZD6SBsTk0ySq8fCM1NkAMLfQuLTvvxgK/O9
	Hots4kwp4lznun4CXb6MTOX2vvKq3pmaC+bNnxia36JmiWBw0E86ItcMYCHz1u6KptfhYg
	+i2vYFjXNL+LjCgpmDzSbqLF8CupVYmYxK7tAJjzro34lqZCa0Qs9uCNg4ktOJMLs9Yri/
	6nomp5EfO3Jnk5cN0bGyakO8A3PhHHo9eqRHKWGJxuMPBu7UrK8nKyAlK9OKUPrtluEEiX
	X8kBub4TwJfMfjGk7CCDMvTjaCKZvnff5bMAvmkfQ8ZB4VFs8eKZLUSBiKQzPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749633609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnAnSP42eIzSVeNVs3HpQMmD5ob4lQ34ypodXdON5r4=;
	b=vahlkV6JAGi/5yoZqcKndM+5qb1JHUyrh7IyWR4bj8iAEO0E2+HPJWXq/pj7ouNa9pMcx2
	0lk2c5u/r278DfAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] selftests/futex: Set the home_node in futex_numa_mpol
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528085521.1938355-3-bigeasy@linutronix.de>
References: <20250528085521.1938355-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963360854.406.9144333148355077318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d
Gitweb:        https://git.kernel.org/tip/0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 May 2025 10:55:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:58 +02:00

selftests/futex: Set the home_node in futex_numa_mpol

The test fails at the MPOL step if multiple nodes are available. The
reason is that mbind() sets the policy but the home_node, which is
retrieved by the futex code, is not set. This causes to retrieve the
current node and with multiple nodes it fails on one of the iterations.

Use numa_set_mempolicy_home_node() to set the expected node.
Use ksft_exit_fail_msg() to fail and exit in order not to confuse ktap.

Fixes: 3163369407baf ("selftests/futex: Add futex_numa_mpol")
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250528085521.1938355-3-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 8 +++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 564dbd0..a9ecfb2 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -210,6 +210,10 @@ int main(int argc, char *argv[])
 		ret = mbind(futex_ptr, mem_size, MPOL_BIND, &nodemask,
 			    sizeof(nodemask) * 8, 0);
 		if (ret == 0) {
+			ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
+			if (ret != 0)
+				ksft_exit_fail_msg("Failed to set home node: %m, %d\n", errno);
+
 			ksft_print_msg("Node %d test\n", i);
 			futex_numa->futex = 0;
 			futex_numa->numa = FUTEX_NO_NODE;
@@ -220,8 +224,8 @@ int main(int argc, char *argv[])
 			if (0)
 				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa != i) {
-				ksft_test_result_fail("Returned NUMA node is %d expected %d\n",
-						      futex_numa->numa, i);
+				ksft_exit_fail_msg("Returned NUMA node is %d expected %d\n",
+						   futex_numa->numa, i);
 			}
 		}
 	}

