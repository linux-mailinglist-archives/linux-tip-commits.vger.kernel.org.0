Return-Path: <linux-tip-commits+bounces-1675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D86692DA5F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA645281C9B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2B83A18;
	Wed, 10 Jul 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9EM60y7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZHzAMfe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85966DF71;
	Wed, 10 Jul 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644352; cv=none; b=YJ+DOS/+MRR7FC9FNGVWkJQceW/aJfYr7/J58z0negBqoUqwwQbVFkfcmtqNS18BIW0h8eNWdQ6X9QegHu0kXMr580zh2J69C/p/v0LKtD4TxHVVubsV20V1qwPQwRNh4QhcYuoOZjWDEtchmhn3VGfW+oS5Nrk/QgchrqUkaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644352; c=relaxed/simple;
	bh=WF6rz6FxstIvVkxRFyZFhqahmpmSCvgcgWY/9/4OuK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mvPBMey6D36Vz+L2tcq4HwDLH/WARjIHrMGtOIcC6LntZurj/hh49mmy6MPAjN7v1odROkvoX/qHbzhhhUCt6Hs64YJMCMUKFEyhASgz8PFhKJt/pgkJWVjtL4U3KCRLByxJPvCyP7twvF6f9oP/qjQX7e7yEdhsdIx24M1wDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9EM60y7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZHzAMfe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 20:45:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720644348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5dvW73JAFWTp8SNNFygY39Pamp0WWVh+h87xoIn/Fg=;
	b=z9EM60y7y0Jcvx1uP/zAeQ3JWxeAQbSpYLO6lHf1iWzUaBATRRJjGFi1EX2EKHyHk1pGPQ
	pt1GCfCkXwC8217Wk9/TaQFj73El+BhE1Q5Tdx2uBfYF7O1BzQD9aR55vJyerjFYcFimWH
	9bIu9neXxenDLBrjrb+aRIJhPEUjIlj2/crNaiL1aoHmvoy67GpX/S+QIR+QUJ4Y8rfJRd
	u1Sx4lAknjJ9Kc36fW2n55WlgxUcpDg3eQdV84cKvzFFrFNjSAMcFbzH+50bXH295kPXnZ
	l9yyzqHmNB773m1tKEX1IGGNI5QX9kk/HpSoc7dV3xpNLoi4yTl9a3o0ODCbCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720644348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5dvW73JAFWTp8SNNFygY39Pamp0WWVh+h87xoIn/Fg=;
	b=oZHzAMfed8cBiygZel2mEB4X6DrBvNujtYsCwve8iPmj7Z1OHAbTvYN+CJkkrKE/qC1Eym
	eCfdClLiIBXUOFBw==
From: "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Add missing destroy_work_on_stack() call in
 smp_call_on_cpu()
Cc: Zqiang <qiang.zhang1211@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240704065213.13559-1-qiang.zhang1211@gmail.com>
References: <20240704065213.13559-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172064434817.2215.242727522457378260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     77aeb1b685f9db73d276bad4bb30d48505a6fd23
Gitweb:        https://git.kernel.org/tip/77aeb1b685f9db73d276bad4bb30d48505a6fd23
Author:        Zqiang <qiang.zhang1211@gmail.com>
AuthorDate:    Thu, 04 Jul 2024 14:52:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 22:40:39 +02:00

smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

For CONFIG_DEBUG_OBJECTS_WORK=y kernels sscs.work defined by
INIT_WORK_ONSTACK() is initialized by debug_object_init_on_stack() for
the debug check in __init_work() to work correctly.

But this lacks the counterpart to remove the tracked object from debug
objects again, which will cause a debug object warning once the stack is
freed.

Add the missing destroy_work_on_stack() invocation to cure that.

[ tglx: Massaged changelog ]

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240704065213.13559-1-qiang.zhang1211@gmail.com

---
 kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1848357..aaffecd 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1119,6 +1119,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }

