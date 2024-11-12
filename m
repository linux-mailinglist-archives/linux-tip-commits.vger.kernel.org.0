Return-Path: <linux-tip-commits+bounces-2840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCC9C52CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE60283CC7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7C20E325;
	Tue, 12 Nov 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CoAMNLyY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwerm+/t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870B21265F;
	Tue, 12 Nov 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406111; cv=none; b=C9JWgGQioXtcQFUQN+F8IFyBa2sn3thVxwAOQX2WSAPOIm2CPaK2Ait3EcDBMM1Us+L2v5TRlXaqneM/6WtLwg3j8NTp/66553HPye4zMTxW41dl3r4UtOGz83evKFs0POn09oAbmRpRg0q+WPxMhbMz9CKz1z1fouJ8RtCE2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406111; c=relaxed/simple;
	bh=eOvW33M25Z/+/ou1W1/nKPe9Wb+ISSW+MPtowkHRPQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bk4mzNjTU+cBIC+PtzMUs3FJJzIOZTnuK480HlEmcasr9nt4u/ZWjXU3qXmXTwWOI63SvOJhXXJJ79E4JNBWZzLm6NGwRX4nDl9SAN5m3GzmJnm7C1JoSwfB4q0UVgkoh/Cz6v+9oEniw7gxhruEdFK+McGoT4tF4xuysECMaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CoAMNLyY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwerm+/t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Nov 2024 10:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731406101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obk/P0CJERFNQhhdHKL29Zwh8an4ADnCOHPvwVd0Pew=;
	b=CoAMNLyYUgws4/AeNxVjJwguzrfMQw5Hy5uZrcIFVI8apaFjtE2ZmMvGfe/mGYCcqCkXe5
	PQrYXWtmzgoQmjiftjVBgxNSkzwMrBZxqEu7KOqDNFd0niPcky//H3ib8xfutzjZxAqO2t
	wu1V27IaCFB52xaWXmw5O4pWnS1VKFSDjPseqaYii7dW6xN/YsViGf1k0yXPnzq92R+9Ju
	PxAJHaslj5mY1qhDf5NNnTfcrZMyhb4y5ClFP/Xc1cR4bl5VUfVGqfzp1B9hVhSgMPCrwI
	SjO7tdZRl0PaIIewZoVN8dX+Ro4mmb+zefyFkDi7J+kTLM9A5ZfFMGAWP9UPvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731406101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obk/P0CJERFNQhhdHKL29Zwh8an4ADnCOHPvwVd0Pew=;
	b=fwerm+/tgPhyckdBdwxtJhFaINNAuNPjPc1T+W9RyjltlirJQMZqfU2wl+QaK7ctdDs5VU
	E5Uv/appRXu5voDg==
From: "tip-bot2 for Shivank Garg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove redundant CONFIG_NUMA guard around
 numa_add_cpu()
Cc: Shivank Garg <shivankg@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241112072346.428623-1-shivankg@amd.com>
References: <20241112072346.428623-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173140610082.32228.17396412581814258248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f74642d81c24d9e69745cd0b75e1bddc81827606
Gitweb:        https://git.kernel.org/tip/f74642d81c24d9e69745cd0b75e1bddc81827606
Author:        Shivank Garg <shivankg@amd.com>
AuthorDate:    Tue, 12 Nov 2024 07:23:47 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Nov 2024 11:00:50 +01:00

x86/cpu: Remove redundant CONFIG_NUMA guard around numa_add_cpu()

Remove unnecessary CONFIG_NUMA #ifdef around numa_add_cpu() since the
function is already properly handled in <asm/numa.h> for both NUMA and
non-NUMA configurations. For !CONFIG_NUMA builds, numa_add_cpu() is
defined as an empty function.

Simplify the code without any functionality change.

Testing: Build CONFIG_NUMA=n

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241112072346.428623-1-shivankg@amd.com
---
 arch/x86/kernel/cpu/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 07a34d7..59dc735 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1902,9 +1902,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-#ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
-#endif
 }
 
 /*

