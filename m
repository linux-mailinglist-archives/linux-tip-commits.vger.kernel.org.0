Return-Path: <linux-tip-commits+bounces-6308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C204B3168D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BB1C81948
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB52E2F03;
	Fri, 22 Aug 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ox9gRR6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfmPYKM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5C2F90CE;
	Fri, 22 Aug 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862992; cv=none; b=CKbrqanKHEgqI7CMsc0y1KXvvrWvz/O+x2HlFhqkILBBavaKMOYB8tdGu4u9LYGVmH+x/cj6qawJhDZcMNS6eabI64TEiVCWySnZxjRd7Bl1zmsaLGfqQtbVYjqKa/k1xCet6/jXX097aokCFYpUkUnZByTp3tqNA0qOV7AZl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862992; c=relaxed/simple;
	bh=9KDYf46ZWLsl3S8W/O4bXY4k4aYsRvS1WZnYiRvMvK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O0MN8M37z75ljQ2dn83BcO/x4NtMHTn77NIhmuzxk5KIFoSwRqljxPB5ooVlAmsWAw3DBChQwxqje9qzcQ+fc94p47nofsGIN/2V/qhoCikAh81PjDNWHM0Tbua36tzLj3loCv2WqOl9MAEbBSt++dyv14BiGzXYN2mPflDa7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ox9gRR6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfmPYKM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 11:42:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755862983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQQZ46V5vtGrpOjUVpXYNmUqVMWUzOr792a1CLJw48=;
	b=ox9gRR6QS9TgOFot5q4TpZN2aqM/GxYkt1s8G22yv6BzyFjmfQBwBLKbQsnl4LevAMR2xI
	rQK334wvVlLd5hN0yApZx+MworB+Yhv1jyAGPBtw8RsgpRttY6KZURxt9oMcJedfKt4slz
	3HRQKdmwSfwGpxaQreBdX3fXHt41NyNqef8vbmtC14F8tz8FmGXH2I65G24zq7dNDHFPZM
	/OYD4rXQkTDOQHGoYDLxg9m2nDHoE6mYjF0SynzL9qKYytmIsUH97/07TC+kMYQnKLhna2
	WU9xuoiAEyyDLx2C2fyU+dsJZN4f4mwXAyAIo2jtUTBjL1FV/PO1UEa01bxzAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755862983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdQQZ46V5vtGrpOjUVpXYNmUqVMWUzOr792a1CLJw48=;
	b=nfmPYKM0oDFui/LQMWtCJhFSXfvFT49bRHzkT43fKvtbFezbpeoi639oBquo7L9ye0NHrV
	Ux+JcfQmlFoepIDQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry/fred: Push __KERNEL_CS directly
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250822071644.1405268-1-xin@zytor.com>
References: <20250822071644.1405268-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175586298002.1420.6153246374508716763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5be502174bf0f5d0aafaab57fa4512723d6d2973
Gitweb:        https://git.kernel.org/tip/5be502174bf0f5d0aafaab57fa4512723d6=
d2973
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 22 Aug 2025 00:16:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Aug 2025 13:12:50 +02:00

x86/entry/fred: Push __KERNEL_CS directly

Push __KERNEL_CS directly, rather than moving it into RAX and then
pushing RAX.

No functional changes.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250822071644.1405268-1-xin@zytor.com
---
 arch/x86/entry/entry_64_fred.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32..cb5ff2b 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -97,8 +97,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rdi			/* fred_ss handed in by the caller */
 	push %rbp
 	pushf
-	mov $__KERNEL_CS, %rax
-	push %rax
+	push $__KERNEL_CS
=20
 	/*
 	 * Unlike the IDT event delivery, FRED _always_ pushes an error code

