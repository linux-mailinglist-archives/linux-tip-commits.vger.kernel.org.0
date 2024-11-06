Return-Path: <linux-tip-commits+bounces-2762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E19BE4A4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EE31C23524
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126D01DED62;
	Wed,  6 Nov 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GuHWfBX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVhmptKm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A31DE4F9;
	Wed,  6 Nov 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890070; cv=none; b=q/5ruAC08SSBHU4JHBnzOz6YZBMHFUNkvx0S0tVe0AOAP6fwz5chwzwLeZEDzJq6rnJe4rCtw2MSzlWMt/9FY7HITL0e3xuo/axSE8ycSh2DcnGwS/1LFMggxTMPsJMD2FRMzhxx+hZdO4p8HTKTgjpLvbRu2V5rpPgMc9mh/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890070; c=relaxed/simple;
	bh=jImEuzHBvr0L/upFph/rre6xu4WVPYuu/HgIobneUYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YvSBt6P9mHyc+ESICHD4xOFXFFmm22RHAnyQ5ggYCYn0C1FUS4nfAdVYQPz7NtNc8DhAUvtQZXLWpZMkS5ruMC3pGxsgReq0W5qNkybV6ocnCOd8tiLCMx932te96763xNyrPoZv2cp+rqeLilzJnvQKWDmRB7V5YS/zEoNiYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GuHWfBX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVhmptKm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwmQPQ2dbuM1wgkVuHG9hstZdLw9nfiuyLSAwF4kavk=;
	b=GuHWfBX2fQ8RSZTqgIcS9TMSnFRM3aDe83od1LQb+lqKLxi8a7b4sJEAmhu3k+uoIdCX/c
	2+Yqti0UrscPZrDlgIrGiyKMZTruF1RX5ASQBNpPXuj8Aq7KodS7X7iR3PTGon3rOpOWfD
	Rrr43OEpYx72GwMZ2XyhDj+dMEZp1E8CPkN7AWqG2Se2BiszycKo6sd7imaqVIDFz5JX+o
	V9juyz6lyRvhYCc7/hGv896YU1WSJgp/dJSgy7seN6Ip1yMR6WgchrTF+B6+t6GyXDsiJU
	LtSdrlJpDyG7pVCHj2F6V2klIiBbSuT7V38+Kxnd42XJvwjVQMG7oYzGlxSDEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwmQPQ2dbuM1wgkVuHG9hstZdLw9nfiuyLSAwF4kavk=;
	b=bVhmptKmHVuYh7wrlalMKVYg1mf6SIq39Nhf2wEn96Q1S9E0Cvk3mmvVzn7Nk1MkfBIT6P
	SFLugtF/3lgeNYAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Use ALT_OUTPUT_SP() for
 __alternative_atomic64()
Cc: Uros Bizjak <ubizjak@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241103160954.3329-1-ubizjak@gmail.com>
References: <20241103160954.3329-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006563.32228.13896147526722814370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8b64db9733c2e4d30fd068d0b9dcef7b4424b035
Gitweb:        https://git.kernel.org/tip/8b64db9733c2e4d30fd068d0b9dcef7b4424b035
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 03 Nov 2024 17:09:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:34 +01:00

locking/atomic/x86: Use ALT_OUTPUT_SP() for __alternative_atomic64()

CONFIG_X86_CMPXCHG64 variant of x86_32 __alternative_atomic64()
macro uses CALL instruction inside asm statement. Use
ALT_OUTPUT_SP() macro to add required dependence on %esp register.

Fixes: 819165fb34b9 ("x86: Adjust asm constraints in atomic64 wrappers")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241103160954.3329-1-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic64_32.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 1f650b4..6c6e9b9 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -51,7 +51,8 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #ifdef CONFIG_X86_CMPXCHG64
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
-		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
+		     : ALT_OUTPUT_SP(out) \
+		     : [func] "i" (atomic64_##g##_cx8), ## in)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
 #else

