Return-Path: <linux-tip-commits+bounces-6105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC88B03A69
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA507AD502
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776823D2AE;
	Mon, 14 Jul 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bk6jIRix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcJvPiU7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294423A989;
	Mon, 14 Jul 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484241; cv=none; b=lV6A0zLPwv2kLVkCRPA1yB1QeKYUXw2VJQih0psN01I8R0iAScpUMJiortJDwLv0E2kMsdbF+/EwSYw0Ba70xRe64TtrX+En6SB2ywFuggbY+uFuR9efwg3cGcfUHQ2UCR2PD5Xrl/JqSxALc7f0Px3iVjYHTMMaRI9bqELrq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484241; c=relaxed/simple;
	bh=RCl5K//CrKjlaiFKyyVbHFH3YQYfzeb8mIB5VD33neY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dymnKH8elIKYi120JcDs8Uum0SgTQ2QR/EWEYbEePQqWuBPtvVG5Xspt5K5hg7a86MAGedD+aVFhex4QKBUqTJ5Y1+zAKMOg4iobZfrK2tqP/Qol6s1qT0Vl270nmumyi7B+CYx1t6IsxnXsnUUWT6M4r433qjLuzqwig8wpWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bk6jIRix; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcJvPiU7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3Po7WUMsmdC6YgGYitx4gsZh3LQLzgpWE8E7hIUvBw=;
	b=Bk6jIRixt4L2LrP4a4otHp5gWGlnir5TnI2a8fEijI3/N2Bn0XBw7551SSaOxNmkjXP0JX
	3r+JZseb9MSBzAWuZDrS1+0z5OKiuXQwuXDEI98P54s+GeaNK08llif2dC58DLzb5OmDYU
	nGYaW6kWR0untVoVpJ6ViTCzo8E6xjZg0PuvdsUOvmu7Nf5mKsttnXYmrMaz5+9ri4OFdB
	uSfYlnyrw8K8uo0/1+ewHxHSmTt+vpv7oGSK9yF+ltQlw/3Mc6KSJWuqWn3Qcnbete3I5H
	b0rebHzcw1pK3j1f15Z455vv1PmHBKTRhTVFLb8CyobxdgFlEUVSg54xhvu8Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3Po7WUMsmdC6YgGYitx4gsZh3LQLzgpWE8E7hIUvBw=;
	b=kcJvPiU7qY4Pbl3X3hC2vVIrPt6fHxbqn/6PLcDMBHGgtBmNVW4pnBZsTxCS7mw6OnXQn1
	4l2eTHN2dUoraeAg==
From: "tip-bot2 for Li Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/smpboot: remove redundant CONFIG_SCHED_SMT
Cc: Thomas Gleixner <tglx@linutronix.de>, Li Chen <chenl311@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710105715.66594-3-me@linux.beauty>
References: <20250710105715.66594-3-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423723.406.17411572636082604157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     992de2b02509bed68f693ea5a68b07cd586197b7
Gitweb:        https://git.kernel.org/tip/992de2b02509bed68f693ea5a68b07cd586197b7
Author:        Li Chen <chenl311@chinatelecom.cn>
AuthorDate:    Thu, 10 Jul 2025 18:57:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:34 +02:00

x86/smpboot: remove redundant CONFIG_SCHED_SMT

On x86 CONFIG_SCHED_SMT is default y if SMP is enabled, so let's
simply drop CONFIG_SCHED_SMT.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250710105715.66594-3-me@linux.beauty
---
 arch/x86/kernel/smpboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e0adf75..30e6df2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -484,9 +484,7 @@ static void __init build_sched_topology(void)
 {
 	int i = 0;
 
-#ifdef CONFIG_SCHED_SMT
 	x86_topology[i++] = SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT);
-#endif
 #ifdef CONFIG_SCHED_CLUSTER
 	x86_topology[i++] = SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS);
 #endif

