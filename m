Return-Path: <linux-tip-commits+bounces-1705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B5933EB1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Jul 2024 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CFC2819B6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Jul 2024 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE666180A6C;
	Wed, 17 Jul 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzEysB4f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ftlcGRt/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7F224FA;
	Wed, 17 Jul 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227127; cv=none; b=iD2+95jUGpVLUkijuaNR/Pk7WDtDvs9yUit+5kWHNtfdKTXK0acVwh3GYclhiGCjIvZmN+FnDi+uHS1nl0S2EVABek+eUxSEhK7xYTmEQzYwjrwS4MwYQcQutcnOPl/6MdRpdnSn4+Qf55mJ95qyOEyuFFqdLt7dASNgE15R7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227127; c=relaxed/simple;
	bh=y2CTKHy4tmRqu3SrAKRukfH66rNOE92bst2s2ctN81s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=swrDwvm+02TGnHW151FsqeK7GfujVfa4WBgYkk6qEHO+uL0TzEUxJerxfzWl3r4YBOEb3BeU3w9N9ZGVlnX3mBPegyfDDF25gW/xy3PD9o0TYK3G2y+GPDLuZGWDJIqjtRJszgU4LMSGHnnomasubR4wgDxnRXLIONTuK5bSWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzEysB4f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ftlcGRt/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Jul 2024 14:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721227124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHN+HqITtT+RDl0xQQ+zmqZ3Q+mKU2FbR5ytBp2EUgA=;
	b=hzEysB4fYeE/28lB03axPaPDkIDCFmJVvW6OIoVusPK9SKi9T2y3lwFEL0g4aaEHkBw1h0
	qJpnr1gq9TV50cPz9mAB+vHOkfqyHaR9B40ihNzvNU1c5QrWyF3Zullug3AZ32y+qvoWP6
	xeweKppNzRYbilL9lA89VWcVwzUR+Ei2vrxrdLsBHW8PAebrpYoHzmwr0OuJ1e5GfbCdh+
	nJcA56+5ReB8vUmwcxz/mjH/ZKgX6cFHUKaGyrH5PvvBMW63nbGmpZnCu+mTaACVUULEoe
	NT3uoqHoADLU3mwt3m9US/JiOPBrtB/nGBo0gmi6i6jpeDqtJsvSE8pmvreMRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721227124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHN+HqITtT+RDl0xQQ+zmqZ3Q+mKU2FbR5ytBp2EUgA=;
	b=ftlcGRt/rNj4FeLOw3l4eTcYWzw9gAptZm5cxmrDRZkBXKsWxf0LfnsQCsOTVLkn8gTvOL
	qBRqpzbMiKT8nVDg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce the
 read64_nonatomic macro to x86_32 with cx8
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240605181424.3228-1-ubizjak@gmail.com>
References: <20240605181424.3228-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172122712402.2215.3878920766724866170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6e30a7c98a9fda2f894e970e9cd637657f39c59d
Gitweb:        https://git.kernel.org/tip/6e30a7c98a9fda2f894e970e9cd637657f39c59d
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Jun 2024 20:13:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Jul 2024 16:28:11 +02:00

locking/atomic/x86: Introduce the read64_nonatomic macro to x86_32 with cx8

As described in commit:

  e73c4e34a0e9 ("locking/atomic/x86: Introduce arch_atomic64_read_nonatomic() to x86_32")

the value preload before the CMPXCHG loop does not need to be atomic.

Introduce the read64_nonatomic assembly macro to load the value from a
atomic_t location in a faster non-atomic way and use it in
atomic64_cx8_32.S.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240605181424.3228-1-ubizjak@gmail.com
---
 arch/x86/lib/atomic64_cx8_32.S |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 90afb48..b2eff07 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -16,6 +16,11 @@
 	cmpxchg8b (\reg)
 .endm
 
+.macro read64_nonatomic reg
+	movl (\reg), %eax
+	movl 4(\reg), %edx
+.endm
+
 SYM_FUNC_START(atomic64_read_cx8)
 	read64 %ecx
 	RET
@@ -51,7 +56,7 @@ SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	movl %edx, %edi
 	movl %ecx, %ebp
 
-	read64 %ecx
+	read64_nonatomic %ecx
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx
@@ -79,7 +84,7 @@ addsub_return sub sub sbb
 SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	pushl %ebx
 
-	read64 %esi
+	read64_nonatomic %esi
 1:
 	movl %eax, %ebx
 	movl %edx, %ecx

