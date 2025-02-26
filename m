Return-Path: <linux-tip-commits+bounces-3671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52407A45EB9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFB1895286
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CB21D3DF;
	Wed, 26 Feb 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ailYhp/Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hj5SEDUJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B41ADC8F;
	Wed, 26 Feb 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572107; cv=none; b=kXHxXwYdfZTfqZwdhe1KfQVrGUGCBs3Q5yg4JNlonPv6SsTp+A0Tm+LQ8LNFZCkB4wCCgRZuIXAFRr021d7Fr9cyy0sYazkEfhbViJGWFTOVa1Z8Le6GyAF4zcqACXvEISs8zd929VGKA7dqSzvPy+zjqwQV5i/TsG37w2bDOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572107; c=relaxed/simple;
	bh=mu3YDVA+AO9GLfTE0BhOq2l5m8771mTKqvvCBkISbVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XAqSzZZv9G7y3jmsgw/sewsOqF70FRZ683FwtC2WgPrWG0zmFEdi7J3qtO2W7d6ig9foB9OcjixXoPtRIVzUTyVF3vNx54EJo6MwciVPUD7VA48jkSmXqrOoaYzm5ZGfvj98doLSckL8ABPuDd4F/8bkMt3GNyvOML36zj/mhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ailYhp/Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hj5SEDUJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnP/aY9xzZsOQ7GNtZri+d6TUNr95rm7ASh57E4z3xE=;
	b=ailYhp/Qwjx0f87bLUdnieQD4M9Q2Uv17UZZq2TB21H37fgzTviUj3ddQI6Ay5nLWoAm8G
	w0ppgy+Aa+p8gp77MmLgTzdwwnH/JvWF9TZiNNX+icsdN/c7DNOaQSn581WUcDx+71JaG9
	0oIwMymXnK/reIdvnDKH8t5RiPX/mLzntrE9z0wZHldQ4/t1OySaJsBz52FJScQWcy1q/j
	HT7W5d2F5aUYttQ/5ofhHeViRA9CaEkry1wnG2Vy5diMiAf8D/hs5U/Ax/8tOeeijXtQKP
	mLnn7V+e+48NWWmT67eQCEw3Gp588ZZHDaP9xrePL4qnwgmYrQv2T2zV8uynkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnP/aY9xzZsOQ7GNtZri+d6TUNr95rm7ASh57E4z3xE=;
	b=Hj5SEDUJ4H8+eprbLnZ/1rNR6Yv2FCZvqfPoH5tHrQGjSxrqYqJ1zxM75YS97bpLPqk2rZ
	S5BvJr1knzTVk6AQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/xstate: Clarify supported xstates
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-9-chang.seok.bae@intel.com>
References: <20250226010731.2456-9-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210391.10177.17934401290205249689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     fa826c1f2cc92db44c207d323d2568e3f04c1257
Gitweb:        https://git.kernel.org/tip/fa826c1f2cc92db44c207d323d2568e3f04c1257
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:30 +01:00

selftests/x86/xstate: Clarify supported xstates

The established xstate test code is designed to be generic, but certain
xstates require special handling and cannot be tested without additional
adjustments.

Clarify which xstates are currently supported, and enforce testing only
for them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-9-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/xstate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index fd8451e..8757779 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -15,6 +15,24 @@
 #include "helpers.h"
 #include "xstate.h"
 
+/*
+ * The userspace xstate test suite is designed to be generic and operates
+ * with randomized xstate data. However, some states require special handling:
+ *
+ * - PKRU and XTILECFG need specific adjustments, such as modifying
+ *   randomization behavior or using fixed values.
+ * - But, PKRU already has a dedicated test suite in /tools/selftests/mm.
+ * - Legacy states (FP and SSE) are excluded, as they are not considered
+ *   part of extended states (xstates) and their usage is already deeply
+ *   integrated into user-space libraries.
+ */
+#define XFEATURE_MASK_TEST_SUPPORTED	\
+	((1 << XFEATURE_YMM) |		\
+	 (1 << XFEATURE_OPMASK)	|	\
+	 (1 << XFEATURE_ZMM_Hi256) |	\
+	 (1 << XFEATURE_Hi16_ZMM) |	\
+	 (1 << XFEATURE_XTILEDATA))
+
 static inline uint64_t xgetbv(uint32_t index)
 {
 	uint32_t eax, edx;
@@ -435,6 +453,12 @@ void test_xstate(uint32_t feature_num)
 	unsigned long features;
 	long rc;
 
+	if (!(XFEATURE_MASK_TEST_SUPPORTED & (1 << feature_num))) {
+		ksft_print_msg("The xstate test does not fully support the component %u, yet.\n",
+			       feature_num);
+		return;
+	}
+
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
 	if (rc || !(features & (1 << feature_num))) {
 		ksft_print_msg("The kernel does not support feature number: %u\n", feature_num);

