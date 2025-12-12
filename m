Return-Path: <linux-tip-commits+bounces-7637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A527CB871C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0A53006993
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA13311953;
	Fri, 12 Dec 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMJqC8d6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxXapCnR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39E30FC1D;
	Fri, 12 Dec 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531408; cv=none; b=dAHFK2Kt0OMJ4AbtOfJrB3Mc+2mehAZ4ojlkYQWvwvbjSx1tosbWT5Bduc5i35+XILgqdujAhGZx0JugC3xDO6YDnNdR+3fjW283pb+Baa3GO+MIGCDCoz0OXb4WW5KNCbiEIxA9pRXAqq5K0ysCHInzDORDfvKrzGMt2IOVJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531408; c=relaxed/simple;
	bh=FKfdzM8ilxJdlDGPG44Wp7dstwQahHls9u1JE4ggoJo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZrHAOkWdnqXe18Z06oG1tRVhOIUKuum20JCFklZqPImSO5wDz2D87YyIE0PFKijsZERdedbKWKPbtyBTLNzB86qG18PIClOumcNe0/zYYmupQzvXUA0XbnNxOpMAVe6uZ4MzyjnW0l/N964q2zWRsKucy8mribMA9emhKsq/R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMJqC8d6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxXapCnR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765531403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9dqu22VLzsNlPB2psoN9qDyqRnYIOsnS0h5hNBEqGY=;
	b=EMJqC8d655TFNpzKBgOD4CFYjmcsKlBcCxoPpPEwtv125PyWTNpRsYJ1bN5K0Jf96h06Df
	h2AS/VAfrd2ukxbIa85V98XW0nreWAtHxJtjMwBTnlC9OQTT1KNkWI0Z9pqMyaO5kO8OeT
	/yn7QXNYJKhzgDGaM1psE/D5z3qN/dwi2hsxzPae45LL2umXGaIRMy9i4H6NfXlqDgk+Iu
	OwgYvbZ8920SuONmMs8sTAlSefNF/yMtTmq7GRFEr3aYCJ716f3UB3AcQoatpvPrD98q7e
	GKHVVpTZbL2bDt3JiYY7/pR4nzmAmOuynEXRywCTmw0znyvHH7LITsYxkVfsSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765531403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9dqu22VLzsNlPB2psoN9qDyqRnYIOsnS0h5hNBEqGY=;
	b=UxXapCnRkXd/8ZFd5owy2zqL/fJcGE5JIAfxJwWqydcHtSH+bJ20oYT+MJXrADDm0+Jngu
	lbjS80KlVc/SEGDw==
From: "tip-bot2 for Tal Zussman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
 from <linux/mm_types.h>
Cc: Tal Zussman <tz2294@columbia.edu>, Ingo Molnar <mingo@kernel.org>,
 Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
References: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553140204.498.14555431732170666762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     581a8b7b1e1e2ac53d6c150e4b592ae69aeea2e4
Gitweb:        https://git.kernel.org/tip/581a8b7b1e1e2ac53d6c150e4b592ae69ae=
ea2e4
Author:        Tal Zussman <tz2294@columbia.edu>
AuthorDate:    Fri, 12 Dec 2025 04:08:08 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:18:21 +01:00

mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS from <linux/mm_types.h>

This has been unused since it was added 11 years ago in:

  d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes")

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://patch.msgid.link/20251212-tlb-trace-fix-v2-2-d322e0ad9b69@colum=
bia.edu
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f6de06..42af229 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1631,7 +1631,6 @@ enum tlb_flush_reason {
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
 	TLB_REMOTE_WRONG_CPU,
-	NR_TLB_FLUSH_REASONS,
 };
=20
 /**

