Return-Path: <linux-tip-commits+bounces-1278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3FE8CADB7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 13:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930111F23450
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A06EB6E;
	Tue, 21 May 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2koresz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvToPjsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB96CDC4;
	Tue, 21 May 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292624; cv=none; b=i3aGxXTE3Dq6WR+9oqDO6VY2p2ltqLaxxrSTfBVZyl5fmusfQto05uMAgMywap4Bwgt3gUAyPFT8Hnv1iSYDHJIgQvn6mVUWSkQTCw+HJXxxOMXH5mdRAi/3im0CXGeFxhjKyO9l7t2CYFE3N8hz/nI0x/UH5pgo/PAQYd1RYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292624; c=relaxed/simple;
	bh=Xrdr431T0DFBXM3LLa9LNptGoGbSvbG9e7q6cs2jaos=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fKuvlWQyIq+XhZuzbk9bn2czR4PL1cT3btqng+NowL2jIyrt25Txw0NGZrdjlYLWslxAn6wi4MWKGeCmbLSIyBoUwR+9Mj4fTWWwWhe9KUMN+QuFOdsPe20RjIZuUN9TPZcBAjc53owRvBMLkgILIT9Jx0CQpWb9tTkJtoNbCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2koresz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvToPjsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 11:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716292621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEI4SdcRYabaSTOLSIeu7XfK6qRDcKJ8S+m9FjIEDsE=;
	b=j2koresz79STAkDRiSELqUKw+gbjU3/99gHjPIdEEwn0uUfKhH+FSA5AVv3cBGxm+znhrr
	MbMpBsY3P1AY/jltgSWFtMyv0XQkSPewypgXD9l3MlxWl4O4lP01xhmoLyCY1OPN0Ic5TP
	H/JqsIuuRnvt0r79WnDwfM47dbsZugkePioerVIso/nq1dyN3CSZgF+V5bnLv5moAFDxj7
	lIf3yYIcyD0no87zGEPke2TcYHlQyXb+9Kyo+oVwiJ6fMrZfNHNR8oO/rmIC8+yULSUISn
	7Xb/7nuGXGHxLIEqeGuvkQ6SJke9zrs3qKN0tP/FrItIumGp/8PQ6HEmEEhkMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716292621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEI4SdcRYabaSTOLSIeu7XfK6qRDcKJ8S+m9FjIEDsE=;
	b=kvToPjsntBrKF4129XhctlOeddi12pjV5qcQrTcgNrR7WHECl+nSaCeMIlJKIVV2ckDabV
	q/EazoIrJ7d9OUDg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Use current_stack_pointer to avoid asm() in
 init_heap()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240520083011.135342-1-ubizjak@gmail.com>
References: <20240520083011.135342-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171629262087.10875.8849677586858232819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b855cc58fc93c175fd5bb868d5e3a45cb3e1a42b
Gitweb:        https://git.kernel.org/tip/b855cc58fc93c175fd5bb868d5e3a45cb3e1a42b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 20 May 2024 10:29:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 May 2024 13:36:36 +02:00

x86/boot: Use current_stack_pointer to avoid asm() in init_heap()

Use current_stack_pointer to avoid asm() in the calculation of
stack_end in init_heap(). The new code is more readable and
results in exactly the same object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240520083011.135342-1-ubizjak@gmail.com
---
 arch/x86/boot/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 9049f39..ac78f8c 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -119,9 +119,8 @@ static void init_heap(void)
 	char *stack_end;
 
 	if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
-		asm("leal %n1(%%esp),%0"
-		    : "=r" (stack_end) : "i" (STACK_SIZE));
-
+		stack_end = (char *)
+			(current_stack_pointer - STACK_SIZE);
 		heap_end = (char *)
 			((size_t)boot_params.hdr.heap_end_ptr + 0x200);
 		if (heap_end > stack_end)

