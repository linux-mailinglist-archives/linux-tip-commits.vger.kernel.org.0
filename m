Return-Path: <linux-tip-commits+bounces-3562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E630A3F5E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D35816329C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD020ADD5;
	Fri, 21 Feb 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEvPEqn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKDB2cjE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4E204C00;
	Fri, 21 Feb 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144412; cv=none; b=hgqsSnct4nyq8MKmbQe6GZGUQgz26VhVyDTEDzASTnxb7BJP7prrQTJ2b8AcO0yDc8Cr/YxUhs96FVbtAQc3q4TelI50yHwci+yrMY28isNL9AFttJTnFyYVFruWzVC1IEnFzHYAEBc+V5s4ern1/eSJSyMPr5jANFgCIz6lwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144412; c=relaxed/simple;
	bh=it0/j+zPyUWUVIq1cAQeuM8UK7ywV98Bb7rQyt9irU4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sEs5aSRS34YFzGinkEA4GsllN3GrIoDUm89GiZcuJ9stD0/hgw59ZVGD0LQnSYAsRdjQbPz4eym4pQj75RNxAuC/FPxPLkSXIMnzvt4UbLPRD/7jRgiytorl+aJtxYQURLH0oZg4jW0kRjsGW7100FkUI4D7nVm4/IVZH3U5EJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEvPEqn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKDB2cjE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:26:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740144408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWg+PGBaX79E7wcpk3tmblDDRfhfAU6XldaHRcqj9aE=;
	b=KEvPEqn1501vZjb8H1HAW1CR7HnjFtM6TdSrudAgHdLShGyHBVL9Ey1HFWweQi2Jp5pMIW
	i/2yThdBA8bdQ6UF5SnBSBrvqb+TnPjJXL/NdfaPqrqahg5VPwW5gUNfu+op2A7ycAMGQE
	0FiJOiITJ3yCLRCmu58G9LqYT9rwYDXNtfSivJOl1coDZ7yqvu+XPT6MJk3ce9FCkPiMXp
	T+Y2olX1Wd/hTXG6x66S4Q6ku0Cbh4duEoUbEMoA144DPisj2TfAdnQZfYAj5uDCbD02pc
	xN2UVrcW1vkpQanYSkQx4A5zpvQ+qkNFJ3VY/0D332I48HCTLyeakuYjlGcY5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740144408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWg+PGBaX79E7wcpk3tmblDDRfhfAU6XldaHRcqj9aE=;
	b=nKDB2cjEbd1X3qaZ6VSmZvpodykW3SUdGS/PnlWOYuP5NR//XIuXYge/7yhhSm/SlgVPNC
	foQftTgnPN26KOCw==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ
Cc: Michael Jeanson <mjeanson@efficios.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219205330.324770-1-mjeanson@efficios.com>
References: <20250219205330.324770-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014440780.10177.4977243319442703560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dc0a241ceaf3b7df6f1a7658b020c92682b75bfc
Gitweb:        https://git.kernel.org/tip/dc0a241ceaf3b7df6f1a7658b020c92682b75bfc
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Wed, 19 Feb 2025 15:53:26 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:21:02 +01:00

rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ

With CONFIG_DEBUG_RSEQ=y, at rseq registration the read-only fields are
copied from user-space, if this copy fails the syscall returns -EFAULT
and the registration should not be activated - but it erroneously is.

Move the activation of the registration after the copy of the fields to
fix this bug.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20250219205330.324770-1-mjeanson@efficios.com
---
 kernel/rseq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 442aba2..2cb1609 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -507,9 +507,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
-	current->rseq = rseq;
-	current->rseq_len = rseq_len;
-	current->rseq_sig = sig;
 #ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * Initialize the in-kernel rseq fields copy for validation of
@@ -522,6 +519,14 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EFAULT;
 #endif
 	/*
+	 * Activate the registration by setting the rseq area address, length
+	 * and signature in the task struct.
+	 */
+	current->rseq = rseq;
+	current->rseq_len = rseq_len;
+	current->rseq_sig = sig;
+
+	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.

