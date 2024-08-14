Return-Path: <linux-tip-commits+bounces-2052-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF095217B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41791F23810
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8651B86D5;
	Wed, 14 Aug 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlBAsvVb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ol90VH6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640B566A;
	Wed, 14 Aug 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657597; cv=none; b=axwU5IwxeZIOrutWLk64zFFPiYcmQxTfuWEzERphhe8PlEvdKx0Yz5QMUdqXXIhrNICO5R8fZB0F5oIVo2xoTIxZ74P17ylCOtoEDrf/z/FbZuCfst+Zzj3OSFpS+PeuZ+uoFpL1qQ8QMyFdbaeNcxQtT86J1YtSaDlQroJMVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657597; c=relaxed/simple;
	bh=YxdryRcEJKefgPC8rYa5ypCyZHo9kaVj8MjzTWEb208=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tmKM8Xe60jnHITbrHKEsh+bvvJbVTMkKURQ+opVcEzMmSM/Q58Xifgxtp38OWgYClEEY+d4h02md0hf8R+mW9QfdvEhPwzviKbhzWs+UpkgrHkrQL60R18bJhu1ll+7BtVOtZ/C9+W0pxnmAU5Pzit0GhYf/RAUkSJ8QDtbmiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlBAsvVb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ol90VH6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 17:46:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723657594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQpb0VZbIj2U4tAAJiGZCFArcqN/45kvDzDEvmVpSY=;
	b=KlBAsvVbndIxyOJ6bUroB2KpR6CtV+QLf6Rn9yN2cQDN/A71roIqKZCBTDRjcO5RLk3XPt
	//1HsWRc1g0LQAdZQFoki7i9CiF60wdcQfgmSLoqt9awBGfjdgeetLwSmwpIsN2cxwB1q+
	W6Wt0vXPEPDon1G4SGnGwjavb2rwrskEJSCWyJvOgj3CGa6GMCFNuui6AJkbpeIJ3PP+2w
	Mm20LU2CGAb4cmfrN3xF2BEmwSVksa4jKWUbLX/PPO7K3Mmnlfc6/G3w1IRYvPWMJuOgQs
	KmguBXRzv6B+D3jD0TrHduG15BnbxfsaoMN6HznPJhaxqH/Xa9s7wTFU6nEMjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723657594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQpb0VZbIj2U4tAAJiGZCFArcqN/45kvDzDEvmVpSY=;
	b=3ol90VH6jTQOUFWiZIBqQCgOCTifcdpzl1MWu6Jtt0xI6LWamKiihPlo6YOliK2DnMeNzE
	xfdN6YYU7kQyyRAw==
From: "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove duplicate check from build_cr3()
Cc: Yuntao Wang <yuntao.wang@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240814124645.51019-1-yuntao.wang@linux.dev>
References: <20240814124645.51019-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172365759351.2215.9195187445227042156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d4245fd4a62931aebd1c5e6b7b6f51b6ef7ad087
Gitweb:        https://git.kernel.org/tip/d4245fd4a62931aebd1c5e6b7b6f51b6ef7ad087
Author:        Yuntao Wang <yuntao.wang@linux.dev>
AuthorDate:    Wed, 14 Aug 2024 20:46:45 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 19:41:40 +02:00

x86/mm: Remove duplicate check from build_cr3()

There is already a check for 'asid > MAX_ASID_AVAILABLE' in kern_pcid(), so
it is unnecessary to perform this check in build_cr3() right before calling
kern_pcid().

Remove it.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240814124645.51019-1-yuntao.wang@linux.dev

---
 arch/x86/mm/tlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 09950fe..86593d1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -158,7 +158,6 @@ static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 	unsigned long cr3 = __sme_pa(pgd) | lam;
 
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 		cr3 |= kern_pcid(asid);
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);

