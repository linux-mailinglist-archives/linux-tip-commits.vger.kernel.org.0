Return-Path: <linux-tip-commits+bounces-5753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4AAD4F92
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D233A5DFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8332A25C82F;
	Wed, 11 Jun 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2dCbvkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EIDxRWyn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3019257427;
	Wed, 11 Jun 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633611; cv=none; b=npz/giL5sff0azU9SZvo2NLTqmAYnCOBQur9gCUsbKSrTRy0ePSCfk+Htby8W8Nx2RnuAq8OF7ijVHy7jvTGFfG2D5H0XypR3tUjFVZZ33mTec+MiCmSC6shoRvU46+pO5HMEFmY7jR0tZtnrejCcEJP/CRoU6X5x9Un1O3Tquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633611; c=relaxed/simple;
	bh=FGjxhZUr3vbZ/JK8EerGbsKA6vW112c03IUA7S+0DQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mxq1/zS4GJqlL3n7bViIbLh/iBTSARGiopOGbKCQ+TPZKrdyfbR7XNCO7q2ZnUSFkHuYgB7ug6j2LzT5Rf7/E4w+oq78azO06n5Wl6XaF9x5UQBKOpMOTr/MirBGGAke3CR7ruqkZhskcCWQTXUwij/1bmIP/k1myV0TYTc7dXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2dCbvkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EIDxRWyn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:20:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749633607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYYFHqTnmME/NDzSKxly5S2zjP9rIeOoBOjLOwJi+N4=;
	b=H2dCbvkYq5JTYpwSdghsoo6F/dKuNzI94C4OiziaePLG55m3Cp7FrhIOYodFh3L2pMtmfv
	y035eYz3Fz05bmo3kZmkf8+ihWCt8dAVkFm1SCUjRPHcDKD+2ATA17H7t7gYMO91CfguVB
	cuuKiNguKgTFZn/ReL71/j8C62UTQhv2jHFpino6lOXnAHZ2Xuc3TRs8v1azV92VV2G414
	StF+9OjBHuK0i8a17w0f66EAJcUngH5FnhfgdFv+416uTSPhhfxDA8BCMp4vX1HtJLkCvS
	JxMQycaiw9+WqAO3MsnIhERrLQgbm9/hl3cXu/zybzgDnwC2R5enotiVX6xLMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749633607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYYFHqTnmME/NDzSKxly5S2zjP9rIeOoBOjLOwJi+N4=;
	b=EIDxRWynRwly63hofb3TbicLh3KtJR0ISytbcOFz139X1eXij1bZ1ibCl89ui3TjEy3lDs
	LNfmVDFANWdVv3Dw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Allow to resize the private local hash
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602110027.wfqbHgzb@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963360666.406.17688851529613883167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     cdd0f803c1f9b69785f5ff865864cfea11081c91
Gitweb:        https://git.kernel.org/tip/cdd0f803c1f9b69785f5ff865864cfea11081c91
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:59 +02:00

futex: Allow to resize the private local hash

On 2025-06-01 15:39:47 [+0800], Lai, Yi wrote:
> Hi Sebastian Andrzej Siewior,
Hi Yi,
> Greetings!
>
> I used Syzkaller and found that there is KASAN: null-ptr-deref Read in __futex_pivot_hash in linux-next next-20250527.
>
> After bisection and the first bad commit is:
> "
> bd54df5ea7ca futex: Allow to resize the private local hash
> "

Thank you for the report. Next time please trim your report. There is no
need to put your report in the middle of the patch.

The following fixes it:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250602110027.wfqbHgzb@linutronix.de
---
 kernel/futex/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b652d2f..33b3643 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1629,6 +1629,16 @@ again:
 		mm->futex_phash_new = NULL;
 
 		if (fph) {
+			if (cur && !cur->hash_mask) {
+				/*
+				 * If two threads simultaneously request the global
+				 * hash then the first one performs the switch,
+				 * the second one returns here.
+				 */
+				free = fph;
+				mm->futex_phash_new = new;
+				return -EBUSY;
+			}
 			if (cur && !new) {
 				/*
 				 * If we have an existing hash, but do not yet have

