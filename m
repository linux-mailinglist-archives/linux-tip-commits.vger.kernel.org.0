Return-Path: <linux-tip-commits+bounces-6229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4939B18E63
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74304AA31A0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0F1FDA9E;
	Sat,  2 Aug 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFUY+JVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nboov3eH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907B1FBEB9;
	Sat,  2 Aug 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754137781; cv=none; b=Z7kIzZpC2tynFMMtxpavMRsGZw/4P6u7pbuA2YVmhc+4akwoQ9AhCj/qoedbqsMsBQgYxBuZsnLhRzkYktOWS0BfVKUV5z4AZVFsiNhcMfXZjsBg0PqojMiycOlTPMC3giqNK4Dls63b6B0unPYxCkflnfNjTbOgPHiXll9gbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754137781; c=relaxed/simple;
	bh=ZeFBDVcpT29plE+duOFwQPD/AL6PklGbywXVjly3zrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s3booXIMMWRKda5WTJJiXC64swhRNg1XC5UEooVFIQey2bPdMCdi8n9AoQ94pNhZwG2qO6pDviVMim3pvvzTHRHqwz84/6xvN65drC453V6+ra4InNNfSRkm0MqScnKvymiBoRLsovPFEM+gFfUJKHR2t0sAn1uBJacTDiOaz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFUY+JVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nboov3eH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Aug 2025 12:29:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754137777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEfmFaJlG4CBe+h46p8wC/tfJYjWXpFLpSTd+ZuJqZg=;
	b=ZFUY+JVzyZZ/2k8Bm/I2Q1x1/ZBrrhC6TwAMiwaDEuM44/9IxWpctplXSIrEVWyTOmAuth
	F/9YcUv/fReDWybAcT3cqd/ztO37o0ZlqN1FKClzjUnETSFLmAByr6o2kBwDm8EtJYxFcb
	ejH+W6cugADUeve898cNGngKp6E6RbTk/q5Yzr2NqDsM3q/DVSqBTmCQClxi9cY27qeMVk
	m9ED8HwqLeNVsQNc7xJ2p1A0FZD3Z2AWWCHz3nc/qAPRy8jaqW9PisNOBGvB3fq3loSSiE
	iHsk5bcI94Of2LLinzg9YcM1yF3xCJDzntm5Xwd1tzaU/VSz/yBrZn09/ULSFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754137777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEfmFaJlG4CBe+h46p8wC/tfJYjWXpFLpSTd+ZuJqZg=;
	b=nboov3eHOHVQHAdluTXCfEiy84p0mlqFV3dq8/UuJEwRrVEj+wXclWffvy527qFoafG4Yw
	Z6ljqW1xeXu2bmAw==
From: "tip-bot2 for Roman Kisel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: smp/urgent] smp: Fix spelling in on_each_cpu_cond_mask()'s doc-comment
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250722161818.6139-1-romank@linux.microsoft.com>
References: <20250722161818.6139-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175413777609.1420.16907938407623485683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     83e6384374bac8a9da3411fae7f24376a7dbd2a3
Gitweb:        https://git.kernel.org/tip/83e6384374bac8a9da3411fae7f24376a7d=
bd2a3
Author:        Roman Kisel <romank@linux.microsoft.com>
AuthorDate:    Tue, 22 Jul 2025 09:18:18 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Aug 2025 14:24:50 +02:00

smp: Fix spelling in on_each_cpu_cond_mask()'s doc-comment

"boolean" is spelt as "blooean". Fix that.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250722161818.6139-1-romank@linux.microsof=
t.com

---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 4649fa4..56f83aa 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1018,7 +1018,7 @@ void __init smp_init(void)
  * @cond_func:	A callback function that is passed a cpu id and
  *		the info parameter. The function is called
  *		with preemption disabled. The function should
- *		return a blooean value indicating whether to IPI
+ *		return a boolean value indicating whether to IPI
  *		the specified CPU.
  * @func:	The function to run on all applicable CPUs.
  *		This must be fast and non-blocking.

