Return-Path: <linux-tip-commits+bounces-4929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F7BA8733B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC93A7A6A11
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D041F3FEE;
	Sun, 13 Apr 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnFtUrKG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCDKpfO5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F11F3BA3;
	Sun, 13 Apr 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570575; cv=none; b=N3jeE6wKDwNIpI3GRbSzMoPvut2rxaj9y5OFFn9R9pEx3eD9eRpf3Wvg6hfiVNtdzb2mqy31PC12kTDHEHX5UooDMCQ18SS9eye+AodvhgceA6NcKzmE2ffY005r8dfbXfRm+Hp30exrfpL5PLJdB5eDzNZMgMRsfmLw+CLTI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570575; c=relaxed/simple;
	bh=N7XaKvEYRtRQ6vKFbwUMDVQZ2C/X7vnfBY0wlAbHfMI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GXu1k02lJFzuNi6+yrs8xkkIwdTyYmoqo2TzrZVu6R/hNhVEcZiarStHwlrluzfNoM7MHzWEIH3XlJXt1RqiGcVfkWLUVpHLflftsiBXxxNCDQ6xmOYKwxn90uFM8LhfLwPyvsIMHgzEq2LqlMP8Nyr031jzVlPYUiwAhK0zwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnFtUrKG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCDKpfO5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A4vVMwRUDylAQfWrFY6KTNNtxeey8kEGh8AIDv9VI2I=;
	b=ZnFtUrKGVwbtiL963cjKEGpzl4vRrPZENPriAlEeKtnc3/1SQ4x2sqaai4Imz9l1kYxzQ2
	3nOzdSp9A9q+wNqdvNJSZ0k708eKdY9Tjt88v4qh5RwAK7QCG0BpUVe8O+esMQ+tM9kNko
	NWLKNtU3BIT5cYzsyAgBQfzaehb33CMI1HY8R26+MuVOxKwLCacN4Sof4qFJlQTzVVYLTp
	zgk/kBpLY2nnf0UyOb/Hn6GepanWmPQOWY6Tj0jQpBNB9W7OJICeAa4OcxT1jFZsknoRu6
	uqyN8bKV3C+YM5PAPuWYTzUChBNpyhDhOb1qLDyiGlFWU8EENd7KNaOp4EApCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A4vVMwRUDylAQfWrFY6KTNNtxeey8kEGh8AIDv9VI2I=;
	b=yCDKpfO56owZnAgPwfFwrRKtYC4eqMLdJU26e9ni4QvNAVJ6Y4/9r/DOonkaMw/4PmfqAB
	gYRsD4qvOnvZvvDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Rename 'rdmsrl_amd_safe()' to 'rdmsrq_amd_safe()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457057133.31282.16757526610954970512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     e2b8af0c693993e80415997f4842a372359b463e
Gitweb:        https://git.kernel.org/tip/e2b8af0c693993e80415997f4842a372359b463e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:19 +02:00

x86/msr: Rename 'rdmsrl_amd_safe()' to 'rdmsrq_amd_safe()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8937923..0aefa41 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -31,7 +31,7 @@
 
 u16 invlpgb_count_max __ro_after_init;
 
-static inline int rdmsrl_amd_safe(unsigned msr, u64 *p)
+static inline int rdmsrq_amd_safe(unsigned msr, u64 *p)
 {
 	u32 gprs[8] = { 0 };
 	int err;
@@ -636,7 +636,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 */
 	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
-		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
+		if (!rdmsrq_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
 			wrmsrl_amd_safe(0xc001100d, value);
 		}

