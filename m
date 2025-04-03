Return-Path: <linux-tip-commits+bounces-4646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3AA7A3CC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5378118969D5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB12505D6;
	Thu,  3 Apr 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gh+TdMhu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1r88g4P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1024FC1B;
	Thu,  3 Apr 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687226; cv=none; b=IJdHsN1RIYbN5dssSQottl5MQlEU7dwTCD7XwEAb3+5+plAS/4xUZEg2jSGwcUbJYbeyaeMB7/wjext+E+FrNDzck2h030wG4aCXjBPw00Kdu+eEgDC68e59GAoNKL74oDYM9taAeo+pAP9l5rqDjR8L3+O1TKY1WamBhvAMV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687226; c=relaxed/simple;
	bh=ofF4Fp6jzzQLQONln1wWW5sDpudm/5qQ3U51lDJljjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pVP5J3qDOuUIX1WY03IWzfX93xot4CkYNzPU1xM8WCDV7k/hxcv0ynKucz90Q3PI8dXXUc997B63XS396dde1kzor5UhXhPuKSp8Z6G0PtY7Q3WBT6aaMU6bLuiyeQMIJJrprUuxJxoJABX69iCOJVT+mSbK76OU2mSyVaEDW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gh+TdMhu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1r88g4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GjZuZ2gh7IHS7QsL3YL4g1HGvoZKhfdeW8Plm08L+4=;
	b=gh+TdMhu9U1Z/ujx9+wKrUlAEG7bzdBBWmKOqj21ZNKhqNbExD9V5ldkMwfbJrEzT89yJx
	v35DxOHhtDrcAGcoLzEjlkKdwT5VQBsr5PIbIbTLxUv91qq+Nr2TiPZqd5GRcloNmUzh4e
	Q+dPezCT66F1mWcpolsv0X0dGBvq/bp2iu9Nq9+hqlICR4Q8YpJtotv73C9Q8j8d8EwTGB
	PvmDgEDvKAetaaTbg+GRRql+3IfAMuaCPb75QTEYxmKlxYZFBViaB8Yev1lNOkJBcegvqf
	QD868kADyqyXYlR/sXJFrQn/deKFP3TyX6nD+k5uBayrWVbzfcJi1kAsGS3R9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GjZuZ2gh7IHS7QsL3YL4g1HGvoZKhfdeW8Plm08L+4=;
	b=R1r88g4P5ockxSPb3d22UIkKWnRIBMl4ujz1D++QtRqnSFdiE/bqsIa8/+N2w+9h6Vmcwz
	yPCm9Nu2/zi+wGDw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Use a macro to initialize NMI descriptors
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-4-sohil.mehta@intel.com>
References: <20250327234629.3953536-4-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722263.30396.9811941615781877805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     4a8fba4be879251fa010d248c179efbd42ec667d
Gitweb:        https://git.kernel.org/tip/4a8fba4be879251fa010d248c179efbd42ec667d
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:23 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:01 +02:00

x86/nmi: Use a macro to initialize NMI descriptors

The NMI descriptors for each NMI type are stored in an array. However,
they are currently initialized using raw numbers, which makes it
difficult to understand the code.

Introduce a macro to initialize the NMI descriptors using the NMI type
enum values to make the code more readable.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-4-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 671d846..6a5dc35 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -49,27 +49,20 @@ struct nmi_desc {
 	struct list_head head;
 };
 
-static struct nmi_desc nmi_desc[NMI_MAX] = 
-{
-	{
-		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[0].lock),
-		.head = LIST_HEAD_INIT(nmi_desc[0].head),
-	},
-	{
-		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[1].lock),
-		.head = LIST_HEAD_INIT(nmi_desc[1].head),
-	},
-	{
-		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[2].lock),
-		.head = LIST_HEAD_INIT(nmi_desc[2].head),
-	},
-	{
-		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[3].lock),
-		.head = LIST_HEAD_INIT(nmi_desc[3].head),
-	},
+#define NMI_DESC_INIT(type) { \
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[type].lock), \
+	.head = LIST_HEAD_INIT(nmi_desc[type].head), \
+}
 
+static struct nmi_desc nmi_desc[NMI_MAX] = {
+	NMI_DESC_INIT(NMI_LOCAL),
+	NMI_DESC_INIT(NMI_UNKNOWN),
+	NMI_DESC_INIT(NMI_SERR),
+	NMI_DESC_INIT(NMI_IO_CHECK),
 };
 
+#define nmi_to_desc(type) (&nmi_desc[type])
+
 struct nmi_stats {
 	unsigned int normal;
 	unsigned int unknown;
@@ -107,8 +100,6 @@ static int __init setup_unknown_nmi_panic(char *str)
 }
 __setup("unknown_nmi_panic", setup_unknown_nmi_panic);
 
-#define nmi_to_desc(type) (&nmi_desc[type])
-
 static u64 nmi_longest_ns = 1 * NSEC_PER_MSEC;
 
 static int __init nmi_warning_debugfs(void)

