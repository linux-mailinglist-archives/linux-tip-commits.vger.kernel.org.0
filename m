Return-Path: <linux-tip-commits+bounces-2835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B19C3C8A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C511C2186E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF6175D34;
	Mon, 11 Nov 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWVen3xI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgPGZ+aE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08015B554;
	Mon, 11 Nov 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322741; cv=none; b=e/tpm++xQkl5X7lNlu6EBPBkY0K0Z68scOz3G5o8S0fL7fNz8pgeg+oMy8Um8TkhtvJeJhmV+8jYQkjeQvrHVT8tWlIeD3Z0fJpGYG/nGP++vPkSVB5UlvJc25KhCxIl/lf9sPyGIYDLhyus1HYj8sUyzmJQZZR0dGBzbnAU+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322741; c=relaxed/simple;
	bh=gYumJkiS1MD/AvEpx5tEulI8oC7ndQvlswyxzaT8UWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i6Q9QjeIs/b6Ga61+3Ila5MoElp57152xaJQdm/J47U9QrsMINXdSZSh5bfMcXFfa+yghDBwLG/3b4j82uX3MlOCH36Bu8Pzg6QwftG1diqTB8ZecLbay6xuJRJA8Zz6oZDAykxpI/Q9vmHa/qvGgfdjf7499hYAHRoHWImrUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWVen3xI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgPGZ+aE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:58:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn1T8MMBzQlQW1mTloAcCszMEUh/BQ1C4cwI9MmHbvE=;
	b=CWVen3xIBYD6JB1pAiiTTWNrAx5L6Nm27dxWZxWF2ONjKpKI4YSVS2YPeLBLKONsBpd8WS
	uHSeKOZXG7GY6ensEmODcuXs/urFJDvTA/YcfuI4PpoRxKJLzXKdC8to0MfuwWuhKjlhNL
	G/FZ2sNY7+pelKalaT6bBFch06OlejODOtEmMncDxl2JI8TaAr53yXFrNh3YKBbzJ7laVf
	Omk2Xwa4TFs4+DUcB8D3jaj9XhERhqxcVk75LZzZSD6yRRrTg8wMJrpnUhohueGyO/kVZx
	l8kjs6/+5VUHkLbKtV9XcrcnLgHqaGxr1aPpZH31wvRfma+uLwi5wMVDn17XHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn1T8MMBzQlQW1mTloAcCszMEUh/BQ1C4cwI9MmHbvE=;
	b=EgPGZ+aEVvJgA/kdGN1oi0qgLcj5Bq5bNikdr6TDhD0CbZh18XhNjmdrfT7s0uGu8JQ8DN
	AyMviU0HRHRBywCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241106162449.sk6rDddk@linutronix.de>
References: <20241106162449.sk6rDddk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132273774.32228.16964492043666072918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     771d271b2b908cf660d6789bb4355ed553250edc
Gitweb:        https://git.kernel.org/tip/771d271b2b908cf660d6789bb4355ed553250edc
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Nov 2024 17:24:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:45 +01:00

sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.

Add the "Lazy" part to the comment for TIF_NEED_RESCHED_LAZY so it is
not the same as TIF_NEED_RESCHED.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241106162449.sk6rDddk@linutronix.de
---
 arch/x86/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 75bb390..a55c214 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,7 +87,7 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
 #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
 #define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */

