Return-Path: <linux-tip-commits+bounces-1898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A69449C9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7631C23BB6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A918452B;
	Thu,  1 Aug 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lfh0OwS2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VpbdWoD1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746C170A32;
	Thu,  1 Aug 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509735; cv=none; b=stIWXchCiKOSrWhCj71vQWhlBW2L0U70x3UALh98mNqYgE+Snvwv9NSA6E1U3gT/xNs1lbEI2Xn0/+i82m/y7lnapzYJ77Nj3vEHJ0cf7hd3X/s519faf2zhs7SVzrqrVY1X9m/wtjxOmYjNll5fiimPYjXQufA06a/2BaPea78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509735; c=relaxed/simple;
	bh=ZZobJgT+CaJaB/NNWIwdaEI5UOD5gchQ5n7AeeUico8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=G+gSh3A8AqYvP9SYjJeuReVzOptfahqiystuw8zY42UrqAN+5umXwqOYz27Vp4VtXuNIU1Vv9peIEJH9uXyEcDCX2L5l+FYIGAyCfTUca96+7wDSnT11otAvKb4woeo3oyIbCO1SZbssMM00PVQRcEJjmttzqScto5+HZfu1mk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lfh0OwS2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VpbdWoD1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 10:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722509732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W38Fbe2n9MZ9NUDKtpaIjUl41BAuV1z/lZoC9Ts4srM=;
	b=Lfh0OwS2yRJf/qVcmr74wfZcR8PdE4rfjwP31Zb02JlEOevUXJnSZa97JkLnuQuAWp8vWx
	EhYIZE8gyELfqJaZGv3x95VkaUST8SaqJIny4wAGi3d0rJ5AidAjKaE8jSdCxJ7hDJ6rGO
	C/RQkziw+MpyiAnLAAIXT1KVHNHPYNsy7L5UDe4Mb3/iBk0eVbRDCGs4c10p9ECCwpItAD
	PIS++U5aaK/HontmyDazBB5Vx8sqlTWFiLoOQloPJDssMJfr28MM2IPr/lhWHMH6Mq+A/9
	e1YMRkX9dtHnGZlaEdY8J8zncK8wnidM7W/uc1wILx7tmaPnlkqdt39LEpIIDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722509732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W38Fbe2n9MZ9NUDKtpaIjUl41BAuV1z/lZoC9Ts4srM=;
	b=VpbdWoD10azTYVQym8OxyLcUp357laruds5DOvm3LJttZwIYAC/nqDCCtbOz9d5xWbXPx9
	MzeddbcBpt9BrIBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     49947e7aedfea2573bada0c95b85f6c2363bef9f
Gitweb:        https://git.kernel.org/tip/49947e7aedfea2573bada0c95b85f6c2363bef9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Aug 2024 12:42:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Aug 2024 12:48:23 +02:00

x86/mm: Fix pti_clone_entry_text() for i386

While x86_64 has PMD aligned text sections, i386 does not have this
luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
alignment.

This means that text on i386 can be page granular at the tail end,
which in turn means that the PTI text clones should consistently
account for this.

Make pti_clone_entry_text() consistent with pti_clone_kernel_text().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 48c5032..bfdf5f4 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -496,7 +496,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
 
 /*

